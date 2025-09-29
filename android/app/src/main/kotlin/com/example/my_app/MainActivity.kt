package com.example.mysleepapp

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.util.Log

class MainActivity: FlutterActivity() {
    private val CHANNEL = "sleep_channel"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // register bridge
        NativeBridge.register(flutterEngine.dartExecutor)

        // Also set MethodChannel to receive commands from Dart (subscribe/unsubscribe)
        val mc = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        mc.setMethodCallHandler { call, result ->
            when (call.method) {
                "subscribeSleep" -> {
                    Log.d("MainActivity", "subscribeSleep called from Dart")
                    SleepManager.subscribe(this)
                    result.success(true)
                }
                "unsubscribeSleep" -> {
                    SleepManager.unsubscribe(this)
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }
    }
}
