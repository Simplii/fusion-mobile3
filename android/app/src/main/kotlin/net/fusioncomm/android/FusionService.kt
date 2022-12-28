package net.fusioncomm.android

import android.app.Service
import android.content.Intent
import android.os.IBinder
import android.util.Log
import io.flutter.plugin.common.MethodChannel
import org.linphone.core.tools.service.CoreManager


class FusionService: Service() {

    companion object {
       var serviceStarted: Boolean = false
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    override fun onCreate() {
        serviceStarted = true
        super.onCreate()
    }
    override fun onTaskRemoved(rootIntent: Intent?) {
        Log.d("fusionService","onTaskRemoved called")
        val core = CoreManager.instance().core
        for ( call in core.calls){
            call.terminate()
        }
        super.onTaskRemoved(rootIntent)
        //stop service
        this.stopSelf()
        serviceStarted = false
    }

    override fun onDestroy() {
        serviceStarted = false
        super.onDestroy()
        Log.d("fusionService","destroyed")
    }
}