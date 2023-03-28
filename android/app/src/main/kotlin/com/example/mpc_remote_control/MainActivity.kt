package com.example.mpc_remote_control


import android.content.Intent
import android.os.Build
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.core.app.ServiceCompat.stopForeground
import androidx.core.content.ContextCompat
import com.dexterous.flutterlocalnotifications.ForegroundService
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onDestroy() {
        stopService(Intent(this, ForegroundService::class.java))
        super.onDestroy()
    }
}
