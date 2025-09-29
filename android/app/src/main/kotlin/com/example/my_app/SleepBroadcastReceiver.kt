package com.example.mysleepapp

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import com.google.android.gms.location.SleepClassifyEvent
import com.google.android.gms.location.SleepSegmentEvent
import org.json.JSONArray
import org.json.JSONObject

class SleepBroadcastReceiver : BroadcastReceiver() {
    private val TAG = "SleepBroadcastReceiver"

    override fun onReceive(context: Context, intent: Intent) {
        try {
            // SleepSegmentEvent
            if (SleepSegmentEvent.hasEvents(intent)) {
                val events = SleepSegmentEvent.extractEvents(intent)
                val arr = JSONArray()
                for (event in events) {
                    val obj = JSONObject()
                    obj.put("type", "segment")
                    obj.put("status", event.status)
                    obj.put("start", event.startTimeMillis)
                    obj.put("end", event.endTimeMillis)
                    arr.put(obj)

                    // If the event is STATUS_SUCCESSFUL or STATUS_MISSING_DATA, it contains start/end
                }
                val payload = JSONObject()
                payload.put("events", arr)
                NativeBridge.sendSleepEvent(context, payload.toString())
            }

            // SleepClassifyEvent (optional: periodic classification e.g., every 10 minutes)
            if (SleepClassifyEvent.hasEvents(intent)) {
                val events = SleepClassifyEvent.extractEvents(intent)
                val arr = JSONArray()
                for (event in events) {
                    val obj = JSONObject()
                    obj.put("type", "classify")
                    obj.put("timestamp", event.timestampMillis)
                    obj.put("confidence", event.confidence)
                    obj.put("light", event.light)
                    obj.put("motion", event.motion)
                    arr.put(obj)
                }
                val payload = JSONObject()
                payload.put("classifyEvents", arr)
                NativeBridge.sendSleepEvent(context, payload.toString())
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error processing sleep intent", e)
        }
    }
}
