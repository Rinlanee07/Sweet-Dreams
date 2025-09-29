package com.example.mysleepapp

import android.content.Context
import android.util.Log
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.dart.DartExecutor

object NativeBridge {
    private const val CHANNEL = "sleep_channel"
    private var methodChannel: MethodChannel? = null

    fun register(dartExecutor: DartExecutor) {
        methodChannel = MethodChannel(dartExecutor.binaryMessenger, CHANNEL)
        // Optionally handle calls from Dart to native here
        methodChannel?.setMethodCallHandler { call, result ->
            when (call.method) {
                "subscribeSleep" -> {
                    // need a context — handled in MainActivity where register is called
                    result.success(null)
                }
                "unsubscribeSleep" -> {
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    fun setMethodChannel(channel: MethodChannel) {
        this.methodChannel = channel
    }

    fun sendSleepEvent(context: Context, jsonPayload: String) {
        try {
            if (methodChannel != null) {
                methodChannel?.invokeMethod("onSleepEvent", jsonPayload)
            } else {
                Log.w("NativeBridge", "MethodChannel not initialized — saving event fallback")
                // fallback: could write to shared prefs or DB for Flutter to read on resume
            }
        } catch (e: Exception) {
            Log.e("NativeBridge", "Error sending sleep event to Flutter", e)
        }
    }
}
