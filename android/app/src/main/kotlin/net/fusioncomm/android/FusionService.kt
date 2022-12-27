package net.fusioncomm.android

import android.app.Service
import android.content.Intent
import android.os.IBinder
import android.util.Log
import org.linphone.core.tools.service.CoreManager


class FusionService: Service() {

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    override fun onTaskRemoved(rootIntent: Intent?) {
        Log.d("fusionService","onTaskRemoved called")
        val core = CoreManager.instance().core
        core.currentCall?.terminate()
        super.onTaskRemoved(rootIntent)
        //stop service
        this.stopSelf()
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d("fusionService","destroyed")
    }
}