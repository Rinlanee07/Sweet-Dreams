import 'package:flutter/services.dart';
import 'dart:convert';

class SleepService {
  static const MethodChannel _channel = MethodChannel('sleep_channel');

  static void init() {
    // register handler to receive native -> flutter calls
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onSleepEvent') {
        final payload = call.arguments;
        // payload is JSON string
        final data = jsonDecode(payload as String);
        // handle: parse and persist to DB / update UI
        print('Received sleep event: $data');
        // TODO: call repository to save session
      }
      return null;
    });
  }

  static Future<bool> subscribeSleep() async {
    try {
      final res = await _channel.invokeMethod('subscribeSleep');
      return res == true;
    } catch (e) {
      print('subscribeSleep error: $e');
      return false;
    }
  }

  static Future<bool> unsubscribeSleep() async {
    try {
      final res = await _channel.invokeMethod('unsubscribeSleep');
      return res == true;
    } catch (e) {
      print('unsubscribeSleep error: $e');
      return false;
    }
  }
}
