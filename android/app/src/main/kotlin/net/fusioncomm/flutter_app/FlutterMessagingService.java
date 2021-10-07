/*package net.fusioncomm.flutter_app;

import android.content.Intent;
import androidx.annotation.NonNull;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;
import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

public class FlutterMessagingService  extends FirebaseMessagingService {

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        if (remoteMessage.getData().containsKey("hostname")) {
            //Intent intent = getPackageManager().getLaunchIntentForPackage(getPackageName());
            Intent intent = new Intent(this, MainActvity.class);
            startActivity(intent);
        } else
            super.onMessageReceived(remoteMessage);
    }
}
*/