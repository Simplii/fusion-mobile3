package net.fusioncomm.android

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.media.AudioDeviceInfo
import android.media.AudioManager
import android.os.Build
import android.os.Bundle
import android.util.JsonWriter
import android.util.Log
import android.widget.Toast
import com.tekartik.sqflite.SqflitePlugin;

import com.google.gson.Gson


import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.util.ViewUtils.getActivity
import org.linphone.core.*
import org.linphone.core.CoreListenerStub
import java.math.BigInteger
import java.security.MessageDigest

class MainActivity : FlutterFragmentActivity() {
    private lateinit var core: Core
    private lateinit var channel: MethodChannel
    private var username: String = ""
    private var password: String = ""
    private var domain: String = ""
    private var server: String = "mobile-proxy.fusioncomm.net"
    private var uuidCalls: MutableMap<String, Call> = mutableMapOf();

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState);
        setupCore();
    }

    private val coreListener = object : CoreListenerStub() {
        override fun onAccountRegistrationStateChanged(
            core: Core,
            account: Account,
            state: RegistrationState,
            message: String
        ) {
            if (state == RegistrationState.Failed || state == RegistrationState.Cleared) {
                channel.invokeMethod(
                    "lnRegistrationFailed",
                    mapOf(Pair("registrationState", "failed"))
                )
            } else if (state == RegistrationState.Ok) {
                channel.invokeMethod(
                    "lnRegistrationSucceeded",
                    mapOf(Pair("registrationState", "success"))
                )
            }
        }

        override fun onAudioDeviceChanged(core: Core, audioDevice: AudioDevice) {
        }

        override fun onAudioDevicesListUpdated(core: Core) {
            // This callback will be triggered when the available devices list has changed,
            // for example after a bluetooth headset has been connected/disconnected.
            sendDevices()
        }

        override fun onCallStateChanged(
            core: Core,
            call: Call,
            state: Call.State?,
            message: String
        ) {
            val uuid = findUuidByCall(call)
            print("call state changed")
            print(uuid)
            print(state)
            print(call)
            when (state) {
                Call.State.Idle -> {
                    channel.invokeMethod(
                        "lnIdle",
                        mapOf(Pair("uuid", uuid))
                    )
                }
                Call.State.IncomingReceived -> {
                    channel.invokeMethod(
                        "lnIncomingReceived",
                        mapOf(
                            Pair("uuid", uuid),
                            Pair("callId", call.callLog?.callId),
                            Pair("remoteContact", call.remoteContact),
                            Pair("remoteAddress", call.remoteAddressAsString),
                            Pair("displayName", call.remoteAddress.displayName)
                        )
                    )
                }
                Call.State.PushIncomingReceived -> {
                    channel.invokeMethod(
                        "lnPushIncomingReceived",
                        mapOf(Pair("uuid", uuid))
                    )
                }
                Call.State.OutgoingInit -> {
                    // wait until .outgoingProgress to notify dart because the callid
                    // doesn't seem to be available during .OutgoingInit
                }
                Call.State.OutgoingProgress -> {
                    uuidCalls[uuid] = call
                    channel.invokeMethod(
                        "lnOutgoingInit",
                        mapOf(
                            Pair("uuid", uuid),
                            Pair("callId", call.callLog.callId),
                            Pair("remoteAddress", call.remoteAddressAsString)
                        )
                    )
                    channel.invokeMethod(
                        "lnOutgoingProgress",
                        mapOf(Pair("uuid", uuid))
                    )
                }
                Call.State.OutgoingRinging -> {
                    channel.invokeMethod(
                        "lnOutgoingRinging",
                        mapOf(Pair("uuid", uuid))
                    )
                }
                Call.State.OutgoingEarlyMedia -> {
                    channel.invokeMethod(
                        "lnOutgoingEarlyMedia",
                        mapOf(Pair("uuid", uuid))
                    )
                }
                Call.State.Connected -> {
                    channel.invokeMethod(
                        "lnConnected",
                        mapOf(Pair("uuid", uuid))
                    )
                }
                Call.State.StreamsRunning -> {
                    channel.invokeMethod(
                        "lnStreamsRunning",
                        mapOf(Pair("uuid", uuid))
                    )
                }
                Call.State.Pausing -> {
                    channel.invokeMethod(
                        "lnPausing",
                        mapOf(Pair("uuid", uuid))
                    )
                }
                Call.State.Paused -> {
                    channel.invokeMethod(
                        "lnPaused",
                        mapOf(Pair("uuid", uuid))
                    )
                }
                Call.State.Resuming -> {
                    channel.invokeMethod(
                        "lnResuming",
                        mapOf(Pair("uuid", uuid))
                    )
                }
                Call.State.Referred -> {
                    channel.invokeMethod(
                        "lnReferred",
                        mapOf(Pair("uuid", uuid))
                    )
                }
                Call.State.Error -> {
                    channel.invokeMethod(
                        "lnError",
                        mapOf(Pair("uuid", uuid))
                    )
                }
                Call.State.End -> {
                    channel.invokeMethod(
                        "lnEnd",
                        mapOf(Pair("uuid", uuid))
                    )
                }
                Call.State.PausedByRemote -> {
                    channel.invokeMethod(
                        "lnPausedByRemote",
                        mapOf(Pair("uuid", uuid))
                    )
                }
                Call.State.UpdatedByRemote -> {
                    channel.invokeMethod(
                        "lnUpdatedByRemote",
                        mapOf(Pair("uuid", uuid))
                    )
                }
                Call.State.IncomingEarlyMedia -> {
                    channel.invokeMethod(
                        "lnIncomingEarlyMedia",
                        mapOf(Pair("uuid", uuid))
                    )
                }
                Call.State.Updating -> {
                    channel.invokeMethod(
                        "lnUpdating",
                        mapOf(Pair("uuid", uuid))
                    )
                }
                Call.State.Released -> {
                    channel.invokeMethod(
                        "lnReleased",
                        mapOf(Pair("uuid", uuid))
                    )
                }
                Call.State.EarlyUpdatedByRemote -> {
                    channel.invokeMethod(
                        "lnEarlyUpdatedByRemote",
                        mapOf(Pair("uuid", uuid))
                    )
                }
                Call.State.EarlyUpdating -> {
                    channel.invokeMethod(
                        "lnEarlyUpdating",
                        mapOf(Pair("uuid", uuid))
                    )
                }
            }
        }

    }

    private fun setupCore() {
        val factory = Factory.instance()
        factory.setDebugMode(true, "Hello fusion")
        core = factory.createCore(null, null, this)
        core.enableIpv6(false)
        core.stunServer = "turn:services.fusioncomm.net"
        core.natPolicy?.stunServerUsername = "fuser"
        core.addAuthInfo(
            factory.createAuthInfo(
                "fuser", "fuser", "fpassword", null, null, null
            )
        )
        core.natPolicy?.enableTurn(true)
//        core.enableEchoLimiter(true)
//        core.enableEchoCancellation(true)

        if (core.hasBuiltinEchoCanceller()) {
            print("Device has built in echo canceler, disabling software echo canceler");
            core.enableEchoCancellation(false);
        }
        else {
            print("Device has no echo canceler, enabling software echo canceler");
            core.enableEchoCancellation(true);
        }

        core.natPolicy?.stunServer = "services.fusioncomm.net"
        core.remoteRingbackTone = "android.resource://net.fusioncomm.android/" + R.raw.outgoing
        core.ring = "android.resource://net.fusioncomm.android/" + R.raw.inbound;

    }

    private fun register() {
        val transportType = TransportType.Tcp
        val authInfo =
            Factory.instance().createAuthInfo(username, null, password, null, null, domain, null)
        val accountParams = core.createAccountParams()
        val identity = Factory.instance().createAddress("sip:$username@$domain")
        accountParams.identityAddress = identity

        val address = Factory.instance().createAddress("sip:mobile-proxy.fusioncomm.net:5060")
        address?.transport = transportType
        accountParams.serverAddress = address
        accountParams.registerEnabled = true
        accountParams.setRoutesAddresses(arrayOf(address))
        accountParams.avpfMode = AVPFMode.Disabled
        accountParams.dialEscapePlusEnabled = false
        accountParams.publishEnabled = false
        accountParams.identityAddress = core.createAddress("sip:" + username + "@" + domain)

        print("register")
        print(address)

        val account = core.createAccount(accountParams)

        core.addAuthInfo(authInfo)
        core.addAccount(account)
        core.loadConfigFromXml("android.resource://net.fusioncomm.net/" + R.raw.fusion_config)

        var proxyConfig = core.defaultProxyConfig
        if (proxyConfig == null) {
            proxyConfig = core.createProxyConfig()
        }

        var newProxyConfig = createProxyConfig(
            proxyConfig,
            "sip:" + username + "@" + domain,
            authInfo
        )
        print("proxyconfig")
        print(newProxyConfig)
        core.addProxyConfig(newProxyConfig)
        core.defaultProxyConfig = newProxyConfig
        core.defaultAccount = account
        core.addListener(coreListener)
        account.addListener { _, state, message ->
        }
        core.start()
        sendDevices()
    }

    private fun sendDevices() {
        var devicesList: Array<Array<String>> = arrayOf()
        for (device in core.extendedAudioDevices) {
            devicesList = devicesList.plus(
                arrayOf(device.deviceName, device.id, device.type.name)
            )
        }

        var gson = Gson();
        channel.invokeMethod(
            "lnNewDevicesList",
            mapOf(Pair("devicesList", gson.toJson(devicesList)),
                Pair("echoLimiterEnabled", core.echoLimiterEnabled()),
                Pair("echoCancellationEnabled", core.echoCancellationEnabled()),
                Pair("echoCancellationFilterName", core.echoCancellerFilterName),
                Pair("defaultInput", core.defaultInputAudioDevice.id),
                Pair("defaultOutput", core.defaultOutputAudioDevice.id)))
    }

    private fun createProxyConfig(
        proxyConfig: ProxyConfig,
        aor: String,
        authInfo: AuthInfo
    ): ProxyConfig {
        var address = core.createAddress(aor)
        proxyConfig.identityAddress = address
        proxyConfig.serverAddr = "<sip:mobile-proxy.fusioncomm.net:5060;transport=tcp>"
        proxyConfig.setRoute("<sip:mobile-proxy.fusioncomm.net:5060;transport=tcp>")
        proxyConfig.realm = authInfo.realm
        proxyConfig.enableRegister(true)
        proxyConfig.avpfMode = AVPFMode.Disabled
        proxyConfig.enablePublish(false)
        proxyConfig.dialEscapePlus = false
        return proxyConfig
    }


    private fun unregister() {
        val account = core.defaultAccount
        account ?: return
        val params = account.params
        val clonedParams = params.clone()

        clonedParams.registerEnabled = false

        account.params = clonedParams
    }

    private fun findUuidByCall(call: Call): String {
        if (call.callLog.callId == null) {
            return ""
        } else {
            val callId = call.callLog.callId
            val md = MessageDigest.getInstance("MD5")
            val md5 = BigInteger(1, md.digest(callId.toByteArray()))
                .toString(16)
                .padStart(32, '0')
            var numbers: Array<String> = arrayOf<String>()

            for (i in 0..15) {
                numbers = numbers.plusElement(md5[i].toInt().toString(16))
            }

            var r = ""
            r = numbers[0] + numbers[1] + numbers[2] + numbers[3] + "-"
            r += numbers[4] + numbers[5] + "-"
            r += numbers[6] + numbers[7] + "-"
            r += numbers[8] + numbers[9] + "-"
            r += numbers[10] + numbers[11] + numbers[12] + numbers[13] + numbers[14] + numbers[15]

            uuidCalls.put(r, call)
            return r
        }
    }


    private fun outgoingCall(destination: String) {
        val remoteSipUri = destination
        val remoteAddress = core.interpretUrl(remoteSipUri)
        val params = core.createCallParams(null)
        if (remoteAddress != null && params != null) {
            params.mediaEncryption = MediaEncryption.None
            params.enableVideo(false)
            core.inviteAddressWithParams(remoteAddress, params)
        }
    }


    private fun findCallByUuid(uuid: String): Call? {
        return uuidCalls.get(uuid)
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        channel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "net.fusioncomm.android/calling"
        );
        channel.setMethodCallHandler { call, result ->
            print("gotflmethod")
            print(call.method);
            print(call.arguments)
            if (call.method == "setSpeaker") {
                Log.d("TAG", "setspeaker");
                val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
                audioManager.mode = AudioManager.MODE_IN_COMMUNICATION

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                    var devices = audioManager.availableCommunicationDevices
                    Log.d("TAG", "searchspeakerddeivce");
                    for (device in devices) {
                        if (device.type == AudioDeviceInfo.TYPE_BUILTIN_SPEAKER) {
                            Log.d("TAG", "setspeakernew");
                            audioManager.setCommunicationDevice(device);
                        }
                    }
                } else {
                    Log.d("TAG", "setspeakerold");
                    audioManager.isSpeakerphoneOn = true
                }
            } else if (call.method == "setEarpiece") {
                val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
                audioManager.mode = AudioManager.MODE_IN_COMMUNICATION
                audioManager.isSpeakerphoneOn = false
            } else if (call.method == "lpAnswer") {
                var args = call.arguments as List<Any>
                var lpCall = findCallByUuid(args[0] as String)
                print("answering...")
                if (lpCall != null) {
                    lpCall.accept()
                }
            } else if (call.method == "lpSendDtmf") {
                var args = call.arguments as List<Any>
                var lpCall = findCallByUuid(args[0] as String)
                if (lpCall != null) {
                    lpCall.sendDtmfs(args[1] as String)
                }
            } else if (call.method == "lpSetHold") {
                var args = call.arguments as List<Any>
                var lpCall = findCallByUuid(args[0] as String)
                if (lpCall != null) {
                    if (args[1] as Boolean == false) {
                        lpCall.resume()
                    } else {
                        lpCall.pause()
                    }
                }
            } else if (call.method == "lpSetEchoCancellationEnabled") {
                var args = call.arguments as List<Any>
                core.enableEchoCancellation(args[0] as Boolean)
                sendDevices()
            } else if (call.method == "lpCalibrateEcho") {
                core.startEchoCancellerCalibration()
            } else if (call.method == "lpTestEcho") {
                core.startEchoTester(10)
            } else if (call.method == "lpStopTestEcho") {
                core.stopEchoTester()
                sendDevices()
            } else if (call.method == "lpSetEchoLimiterEnabled") {
                var args = call.arguments as List<Any>
                core.enableEchoLimiter(args[0] as Boolean)
                sendDevices()
            } else if (call.method == "lpSetDefaultInput") {
                var args = call.arguments as List<Any>
                Log.d("setinput", "gonna set default input")
                for (audioDevice in core.extendedAudioDevices) {
                    Log.d("setinput", "checking audio device" + audioDevice.id)
                    Log.d("setinput", "checking against" + args[0])
                    if (audioDevice.id == args[0]) {
                        Log.d("setinput", "found the default input")
                        core.defaultInputAudioDevice = audioDevice;
                        for  (call in core.calls) {
                            Log.d("setinput", "setting the default input for a call")
                            call.inputAudioDevice = audioDevice
                            Log.d("setinput", audioDevice.id)
                        }
                    }
                }
                sendDevices()
            } else if (call.method == "lpSetDefaultOutput") {
                var args = call.arguments as List<Any>
                for (audioDevice in core.extendedAudioDevices) {
                                        Log.d("setou8tput", "out checking audio device" + audioDevice.id)
                    Log.d("output", "out checking against" + args[0])

                    if (audioDevice.id == args[0]) {
                        core.defaultOutputAudioDevice = audioDevice;
                        for  (call in core.calls) {
                                                        Log.d("setinput", "setting the default input for a call")

                            call.outputAudioDevice = audioDevice
                        }
                    }
                }
                sendDevices()
            } else if (call.method == "lpSetSpeaker") {
                var args = call.arguments as List<Any>
                var enableSpeaker = args[0] as Boolean

                for (audioDevice in core.audioDevices) {
                    if (!enableSpeaker && audioDevice.type == AudioDevice.Type.Earpiece) {
                        core.currentCall?.outputAudioDevice = audioDevice
                    } else if (enableSpeaker && audioDevice.type == AudioDevice.Type.Speaker) {
                        core.currentCall?.outputAudioDevice = audioDevice
                    }
                }
                sendDevices()
            } else if (call.method == "lpMuteCall") {
                var args = call.arguments as List<Any>
                var lpCall = findCallByUuid(args[0] as String)
                if (lpCall != null) {
                    lpCall.microphoneMuted = true
                }
            } else if (call.method == "lpUnmuteCall") {
                var args = call.arguments as List<Any>
                var lpCall = findCallByUuid(args[0] as String)
                if (lpCall != null) {
                    lpCall.microphoneMuted = false
                }
            } else if (call.method == "lpRefer") {
                var args = call.arguments as List<Any>
                var lpCall = findCallByUuid(args[0] as String)
                if (lpCall != null) {
                    lpCall.transfer(args[1] as String)
                }
            } else if (call.method == "lpStartCall") {
                var args = call.arguments as List<Any>
                outgoingCall(args[0] as String)
            } else if (call.method == "lpEndCall") {
                var args = call.arguments as List<Any>
                var lpCall = findCallByUuid(args[0] as String)
                if (lpCall != null) {
                    lpCall.terminate()
                }
            } else if (call.method == "lpRegister") {
                var args = call.arguments as List<Any>
                username = args[0] as String
                password = args[1] as String
                domain = args[2] as String
                register()
            } else if (call.method == "lpUnregister") {
                unregister()
            }
        }
    }
}