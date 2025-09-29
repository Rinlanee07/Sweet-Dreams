import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // เริ่มฟัง MethodChannel ก่อน runApp
  await SleepService.init();
  runApp(const MyApp());
}

/// Simple model for a SleepSession summary
class SleepSession {
  final String id;
  final DateTime start;
  final DateTime end;
  final int durationMin;
  final String source;
  final int? confidence;

  SleepSession({
    required this.id,
    required this.start,
    required this.end,
    required this.durationMin,
    required this.source,
    this.confidence,
  });

  factory SleepSession.fromMap(Map<String, dynamic> m) {
    final startMs = m['start'] as int;
    final endMs = m['end'] as int;
    final durationMin = ((endMs - startMs) / 60000).round();
    return SleepSession(
      id: m['id']?.toString() ?? UniqueKey().toString(),
      start: DateTime.fromMillisecondsSinceEpoch(startMs),
      end: DateTime.fromMillisecondsSinceEpoch(endMs),
      durationMin: durationMin,
      source: m['source']?.toString() ?? 'google_sleep_api',
      confidence: m['confidence'] is int ? m['confidence'] as int : null,
    );
  }
}

/// SleepService: MethodChannel wrapper
class SleepService {
  static const MethodChannel _channel = MethodChannel('sleep_channel');

  // internal stream-like callback registration
  static Function(Map<String, dynamic>)? onNativeSleepData;

  /// Initialize listener
  static Future<void> init() async {
    // setMethodCallHandler to receive "onSleepEvent" calls from native
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onSleepEvent') {
        final payload = call.arguments;
        if (payload != null) {
          try {
            final decoded = jsonDecode(payload as String);
            // forward to app
            if (onNativeSleepData != null) {
              onNativeSleepData!(decoded as Map<String, dynamic>);
            }
          } catch (e) {
            debugPrint('SleepService: Failed to decode payload: $e');
          }
        }
      }
      return null;
    });
  }

  /// Request native to subscribe Sleep API
  static Future<bool> subscribeSleep() async {
    try {
      final res = await _channel.invokeMethod('subscribeSleep');
      return res == true;
    } catch (e) {
      debugPrint('SleepService.subscribeSleep error: $e');
      return false;
    }
  }

  /// Request native to unsubscribe
  static Future<bool> unsubscribeSleep() async {
    try {
      final res = await _channel.invokeMethod('unsubscribeSleep');
      return res == true;
    } catch (e) {
      debugPrint('SleepService.unsubscribeSleep error: $e');
      return false;
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<SleepSession> _sessions = [];
  bool _subscribed = false;
  String _permissionStatus = 'unknown';

  @override
  void initState() {
    super.initState();
    // register callback to receive parsed native payload
    SleepService.onNativeSleepData = _handleNativeSleepPayload;
    _checkPermissionStatus();
  }

  Future<void> _checkPermissionStatus() async {
    final status = await Permission.activityRecognition.status;
    setState(() {
      _permissionStatus = status.isGranted
          ? 'granted'
          : status.isDenied
          ? 'denied'
          : status.toString();
    });
  }

  Future<void> _requestPermission() async {
    final status = await Permission.activityRecognition.request();
    setState(() {
      _permissionStatus = status.isGranted
          ? 'granted'
          : status.isDenied
          ? 'denied'
          : status.toString();
    });
    if (status.isPermanentlyDenied) {
      // Open app settings so user can enable manually
      await openAppSettings();
    }
  }

  /// Parse native payload and create SleepSession(s)
  void _handleNativeSleepPayload(Map<String, dynamic> payload) {
    // The native side may send different shapes.
    // We handle common shapes: { "events": [ { "start":..., "end":..., "status":... }, ... ] }
    // or { "classifyEvents": [ ... ] }
    // For simplicity here: for each segment event we create a SleepSession and add to list.
    final List<SleepSession> parsed = [];

    try {
      if (payload.containsKey('events') && payload['events'] is List) {
        final List events = payload['events'] as List;
        for (final e in events) {
          if (e is Map<String, dynamic>) {
            if (e.containsKey('start') && e.containsKey('end')) {
              final m = {
                'start': e['start'],
                'end': e['end'],
                'source': 'google_sleep_api',
                'confidence': e['status'] is int ? e['status'] : null,
              };
              parsed.add(SleepSession.fromMap(m));
            }
          } else if (e is Map) {
            // if JSON decoding returned Map<dynamic,dynamic>
            final start = e['start'] ?? e['startTimeMillis'];
            final end = e['end'] ?? e['endTimeMillis'];
            if (start != null && end != null) {
              final m = {
                'start': start,
                'end': end,
                'source': 'google_sleep_api',
              };
              parsed.add(SleepSession.fromMap(Map<String, dynamic>.from(m)));
            }
          }
        }
      } else if (payload.containsKey('classifyEvents') &&
          payload['classifyEvents'] is List) {
        // classify events: we can aggregate into small sessions or store as classify items.
        // For this demo, simply create per-classify pseudo-session (very short).
        final List events = payload['classifyEvents'] as List;
        for (final e in events) {
          final timestamp = e['timestamp'] ?? e['timestampMillis'];
          if (timestamp != null) {
            final start = timestamp as int;
            final end = start + 30 * 1000; // example 30s window
            final m = {
              'start': start,
              'end': end,
              'source': 'google_sleep_api_classify',
              'confidence': e['confidence'] is int ? e['confidence'] : null,
            };
            parsed.add(SleepSession.fromMap(Map<String, dynamic>.from(m)));
          }
        }
      } else {
        debugPrint('Unhandled payload shape: $payload');
      }
    } catch (err) {
      debugPrint('Error parsing payload: $err');
    }

    // Add parsed sessions to UI list (deduplicate by start+end)
    setState(() {
      for (final s in parsed) {
        final exists = _sessions.any(
          (x) => x.start == s.start && x.end == s.end && x.source == s.source,
        );
        if (!exists) _sessions.insert(0, s); // newest first
      }
    });
  }

  Future<void> _onSubscribePressed() async {
    // check permission first
    final status = await Permission.activityRecognition.status;
    if (!status.isGranted) {
      await _requestPermission();
      final newStatus = await Permission.activityRecognition.status;
      if (!newStatus.isGranted) {
        // user denied
        _showSnack(
          'Permission ACTIVITY_RECOGNITION required to subscribe Sleep API.',
        );
        return;
      }
    }

    final ok = await SleepService.subscribeSleep();
    setState(() {
      _subscribed = ok;
    });
    _showSnack(ok ? 'Subscribed to Sleep API' : 'Failed to subscribe');
  }

  Future<void> _onUnsubscribePressed() async {
    final ok = await SleepService.unsubscribeSleep();
    setState(() {
      _subscribed = !ok ? _subscribed : false;
    });
    _showSnack(ok ? 'Unsubscribed' : 'Failed to unsubscribe');
  }

  void _showSnack(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Widget _buildSessionTile(SleepSession s) {
    final start = s.start;
    final end = s.end;
    final subtitle =
        '${_formatDate(start)} → ${_formatDate(end)} • ${s.durationMin} min';
    '${_formatDate(start)} → ${_formatDate(end)} • ${s.durationMin} min';
    final conf = s.confidence != null ? ' • confidence ${s.confidence}' : '';
    return ListTile(
      title: Text('${s.source}'),
      subtitle: Text('$subtitle$conf'),
      trailing: IconButton(
        icon: const Icon(Icons.copy),
        onPressed: () {
          // copy JSON
          final json = jsonEncode({
            'id': s.id,
            'start': s.start.millisecondsSinceEpoch,
            'end': s.end.millisecondsSinceEpoch,
            'durationMin': s.durationMin,
            'source': s.source,
            'confidence': s.confidence,
          });
          Clipboard.setData(ClipboardData(text: json));
          _showSnack('Session JSON copied to clipboard');
        },
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.year}-${_two(dt.month)}-${_two(dt.day)} ${_two(dt.hour)}:${_two(dt.minute)}';
  }

  String _two(int v) => v.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleep API Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sleep API Demo (Android)'),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Notes'),
                    content: const Text(
                      '1) This demo expects native Sleep API integration (PendingIntent -> BroadcastReceiver) to send JSON via MethodChannel\n'
                      '2) Test on real Android device with Google Play Services\n'
                      '3) Ensure ACTIVITY_RECOGNITION permission granted',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: _onSubscribePressed,
                      child: Text(
                        _subscribed ? 'Subscribed' : 'Subscribe Sleep API',
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _onUnsubscribePressed,
                      child: const Text('Unsubscribe'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _checkPermissionStatus,
                      child: const Text('Check Permission'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Permission: $_permissionStatus',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: _sessions.isEmpty
                    ? const Center(
                        child: Text(
                          'No sessions yet.\nWait for native Sleep events or subscribe to API.',
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.separated(
                        itemCount: _sessions.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (_, i) => _buildSessionTile(_sessions[i]),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
