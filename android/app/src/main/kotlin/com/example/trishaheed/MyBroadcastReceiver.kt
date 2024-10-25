package com.example.trishaheed
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.widget.Toast

class MyBroadcastReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val action = intent.action
        if (action == Intent.ACTION_BOOT_COMPLETED) {
            // Handle boot completed action here
            Toast.makeText(context, "Boot Completed", Toast.LENGTH_SHORT).show()
        } else if (action == Intent.ACTION_MY_PACKAGE_REPLACED) {
            // Handle package replaced action here
            Toast.makeText(context, "Package Replaced", Toast.LENGTH_SHORT).show()
        }
    }
}
