package net.fusioncomm.android

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import org.linphone.core.tools.service.CoreManager

class VolumeReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent) {
        // this will stop ringer if VOLUP/VOLDOWN key pressed
        if (intent.action.equals("android.media.VOLUME_CHANGED_ACTION")) {
            val core: CoreManager = CoreManager.instance()
            if(core != null){
                core.stopRinging()
            }
            MainActivity.channel.invokeMethod("stopRinger",true);
        }
    }
}