package net.fusioncomm.android
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.media.AudioManager
import android.os.Build
import android.util.Log
import android.widget.Toast
import com.tekartik.sqflite.SqflitePlugin;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.util.ViewUtils.getActivity

class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        var channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "net.fusioncomm.android/calling");
        channel.setMethodCallHandler { call, result ->
            val argument = call.arguments() as Map<String, String>;
            if (call.method == "setSpeaker") {
                Log.d("TAG", "setspeaker");
                Toast.makeText(this, "asdf", Toast.LENGTH_LONG).show();

                val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
                audioManager.mode = AudioManager.MODE_IN_COMMUNICATION
                audioManager.isSpeakerphoneOn = true
            } else if (call.method == "setEarpiece") {
                Toast.makeText(this, "eairpiece", Toast.LENGTH_LONG).show();

                val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
                audioManager.mode = AudioManager.MODE_IN_COMMUNICATION
                audioManager.isSpeakerphoneOn = true
            }
        }
/*
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            Log.d("btpermission2", "2");
            requestMultiplePermissions.launch(arrayOf(
                //Manifest.permission.BLUETOOTH_SCAN,
                Manifest.permission.BLUETOOTH_CONNECT))
        }
        else{
            Log.d("btpermission1", "1");
            val enableBtIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
            requestBluetooth.launch(enableBtIntent)
        }

        var requestBluetooth = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
            if (result.resultCode == RESULT_OK) {
                Log.d("bluetooth permission", "granted")
            }else{
                Log.d("bluetooth permission", "denied")
            }
        }

        val requestMultiplePermissions =
            registerForActivityResult(ActivityResultContracts.RequestMultiplePermissions()) { permissions ->
                permissions.entries.forEach {
                    Log.d("test006", "${it.key} = ${it.value}")
                }
            }*/
    }

}