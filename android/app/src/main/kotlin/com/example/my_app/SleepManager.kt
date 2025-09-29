package com.example.mysleepapp

import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.util.Log
import com.google.android.gms.location.ActivityRecognition
import com.google.android.gms.location.SleepSegmentRequest
import com.google.android.gms.tasks.OnFailureListener
import com.google.android.gms.tasks.OnSuccessListener

object SleepManager {
    private const val TAG = "SleepManager"
    private const val PENDING_INTENT_REQUEST_CODE = 1001

    fun subscribe(context: Context) {
        val client = ActivityRecognition.getClient(context)
        val intent = Intent(context, SleepBroadcastReceiver::class.java).apply {
            action = "com.example.mysleepapp.SLEEP_EVENT"
        }

        // PendingIntent flags differ by API level — use FLAG_MUTABLE for newer Android if you need to read extras
        val pendingIntent = PendingIntent.getBroadcast(
            context,
            PENDING_INTENT_REQUEST_CODE,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE
        )

        val request = SleepSegmentRequest.getDefaultSleepSegmentRequest()

        client.requestSleepSegmentUpdates(pendingIntent, request)
            .addOnSuccessListener {
                Log.d(TAG, "Subscribed to Sleep API successfully")
            }
            .addOnFailureListener { e ->
                Log.w(TAG, "Failed to subscribe to Sleep API: $e")
            }
    }

    fun unsubscribe(context: Context) {
        val client = ActivityRecognition.getClient(context)
        val intent = Intent(context, SleepBroadcastReceiver::class.java).apply {
            action = "com.example.mysleepapp.SLEEP_EVENT"
        }
        val pendingIntent = PendingIntent.getBroadcast(
            context,
            PENDING_INTENT_REQUEST_CODE,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE
        )

        client.removeSleepSegmentUpdates(pendingIntent)
            .addOnSuccessListener {
                Log.d(TAG, "Unsubscribed from Sleep API")
            }
            .addOnFailureListener { e ->
                Log.w(TAG, "Failed to unsubscribe: $e")
            }
    }
}
