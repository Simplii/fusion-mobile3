package net.fusioncomm.android.notifications

import android.Manifest
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.app.ServiceCompat
import kotlinx.coroutines.Job
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import net.fusioncomm.android.FMCore
import net.fusioncomm.android.FMUtils
import net.fusioncomm.android.MainActivity
import net.fusioncomm.android.R
import net.fusioncomm.android.compatibility.Compatibility
import net.fusioncomm.android.services.FusionCallService
import net.fusioncomm.android.telecom.CallsManager
import org.linphone.core.Call
import org.linphone.core.Core
import org.linphone.core.CoreListenerStub


class Notifiable(val notificationId: Int) {
    var answered: Boolean = false
    var remoteAddress: String? = null
    var uuid: String? = null

//    TODO: Chat Notification to be able to replay from notification
//    val messages: ArrayList<NotifiableMessage> = arrayListOf()
//
//    var isGroup: Boolean = false
//    var groupTitle: String? = null
//    var localIdentity: String? = null
//    var myself: String? = null
}


// class NotifiableMessage(
//        TODO: Chat Notification
//        var message: String,
//        val sender: String,
//        val time: Long,
//        val senderAvatar: Bitmap? = null,
//        var filePath: Uri? = null,
//        var fileMime: String? = null,
//        val isOutgoing: Boolean = false,
//        val isReaction: Boolean = false,
//        val reactionToMessageId: String? = null,
//        val reactionFrom: String? = null
//)

class NotificationsManager(private val context: Context, private val callsManager: CallsManager) {


    private val callNotificationsMap: HashMap<String, Notifiable> = HashMap()
    private val notificationManager: NotificationManagerCompat by lazy {
        NotificationManagerCompat.from(context)
    }
    private val scope = MainScope()
    private var job: Job? = null

    companion object {
        private val debugTag = "MDBM NotificationManager"
        val activeNotification : HashMap<Int, Notification> = HashMap()
        var contacts : HashMap<String, Contact> = HashMap()
        val callServiceStartId: HashMap<Int,Int> = HashMap()
        var callService: FusionCallService? = null
        var incomingNotification: Boolean = false
        const val INTENT_NOTIF_ID = "NOTIFICATION_ID"
        const val INTENT_REPLY_NOTIF_ACTION = "fusion.REPLY_ACTION"
        const val INTENT_HANGUP_CALL_NOTIF_ACTION = "fusion.HANGUP_CALL_ACTION"
        const val INTENT_UNHOLD_CALL_NOTIF_ACTION = "fusion.UNHOLD_CALL_ACTION"
        const val INTENT_ANSWER_CALL_NOTIF_ACTION = "fusion.ANSWER_CALL_ACTION"
        const val INTENT_MARK_AS_READ_ACTION = "fusion.MARK_AS_READ_ACTION"
        const val INTENT_REMOTE_ADDRESS = "REMOTE_ADDRESS"
        const val INTENT_CALL_UUID = "CALL_UUID"
//        private const val MISSED_CALL_TAG = "Missed call"
//        TODO: Chat Notifications
//        const val INTENT_LOCAL_IDENTITY = "LOCAL_IDENTITY"
//        const val CHAT_TAG = "Chat"
//        const val CHAT_NOTIFICATIONS_GROUP = "CHAT_NOTIF_GROUP"
//        const val KEY_TEXT_REPLY = "key_text_reply"

        fun onCallServiceStart (service: FusionCallService, startId: Int, notificationId: Int) {
            callService = service
            Log.d(debugTag, " service with notif id $notificationId")
            callServiceStartId[notificationId] = startId
        }
    }

    init {
        Compatibility.createNotificationChannels(context, notificationManager)

        val manager = context.getSystemService(NotificationManager::class.java) as NotificationManager
        for (notification in manager.activeNotifications) {
            if (notification.tag.isNullOrEmpty()) {
                Log.d(debugTag,
                    "Found existing call? notification [${notification.id}], cancelling it"
                )
                manager.cancel(notification.id)
            }
//            TODO: Chat Notifications
//            else if (notification.tag == CHAT_TAG) {
//                Log.d( debugTag,
//                    "[Notifications Manager] Found existing chat notification [${notification.id}]"
//                )
//                previousChatNotifications.add(notification.id)
//            }
        }

    }

    fun onCoreReady() {
        FMCore.core.addListener(listener)
    }


    private val listener: CoreListenerStub = object : CoreListenerStub() {
        override fun onCallStateChanged(
            core: Core,
            call: Call,
            state: Call.State,
            message: String
        ) {
            Log.d(debugTag," Call state changed [$state]")
            when (call.state) {
                Call.State.OutgoingInit -> {
                    Log.d(debugTag, "outgoingInit")
                }
                Call.State.IncomingEarlyMedia, Call.State.IncomingReceived -> {
                    if(!FMCore.core.isInBackground) return
                    if(call.callLog.callId != null){
                        callsManager.incomingCall(
                            call.callLog.callId,
                            FMUtils.getPhoneNumber(call.remoteAddress),
                            FMUtils.getDisplayName(call.remoteAddress)
                        )
                    }
                    Log.d(debugTag, "incoming received")

                    /*
                    FIXME:: for now we are waiting for the notification info to display fusion
                     contact info, this is an ugly work around, planning to get the contact info
                     from the device instead
                     */
                    stopUpdates()
                    job = scope.launch {
                        var t = true;
                        var tries = 0
                        var notificationSent = false
                        while(t && tries < 1000) {
                            Log.d(debugTag, "waiting for notification info...")
                            delay(50)
                            tries += 50
                            t = !incomingNotification
                            if(!t){
                                incomingNotification = false
                                displayIncomingCallNotification(call)
                                notificationSent = true
                            }
                        }
                        if(tries == 1000 && !notificationSent){
                            Log.d(debugTag, "waited for 1 sec never got the notification info force display the incoming notification")
                            displayIncomingCallNotification(call)
                        }
                    }
                }

                Call.State.End, Call.State.Error -> dismissCallNotification(call)
                Call.State.Released -> {
//                    if (LinphoneUtils.isCallLogMissed(call.callLog)) {
//                        displayMissedCallNotification(call.remoteAddress)
//                    }
                    Log.d(debugTag, "Call released, show missed call notification if call was abandoned")
                }
                Call.State.OutgoingProgress, Call.State.OutgoingRinging -> {
                    displayCallNotification(call)
                }
                else -> displayCallNotification(call)
            }
        }

        override fun onLastCallEnded(core: Core) {
            super.onLastCallEnded(core)
            Log.d(debugTag, "$callService")
            callService?.stopForeground(Service.STOP_FOREGROUND_REMOVE)

        }
    }

    private fun stopUpdates() {
        job?.cancel()
        job = null
    }

    fun destroy() {
        Log.d(
            debugTag,
            "Getting destroyed, clearing foreground Service & call notifications"
        )

        if (callNotificationsMap.size > 0) {
            Log.d( debugTag,"Clearing call notifications")
            for (notifiable in callNotificationsMap.values) {
                notificationManager.cancel(notifiable.notificationId)
            }
        }
//        if (callService != null) {
//            callServiceStartId.forEach {it
//                callService?.stopForeground(it.value)
//            }
//        }
        FMCore.core.removeListener(listener)
    }

    private fun getNotificationIdForCall(call: Call): Int {
        return call.callLog.startDate.toInt()
    }

    private fun getNotifiableForCall(call: Call, uuid: String): Notifiable {
        var notifiable: Notifiable? = callNotificationsMap[uuid]
        if (notifiable == null) {
            notifiable = Notifiable(getNotificationIdForCall(call))
            notifiable.remoteAddress = call.remoteAddress.asStringUriOnly()
            notifiable.uuid = uuid
            callNotificationsMap[uuid] = notifiable
        }
        return notifiable
    }

    fun displayIncomingCallNotification(call: Call) {
        val uuid =  callsManager.findUuidByCall(call)
        val notifiable = getNotifiableForCall(call, uuid)
        try {
            val showLockScreenNotification = android.provider.Settings.Secure.getInt(
                context.contentResolver,
                "lock_screen_show_notifications",
                0
            )
            Log.d(
                debugTag,"Are notifications allowed on lock screen? ${showLockScreenNotification != 0} ($showLockScreenNotification)"
            )
        } catch (e: Exception) {
            Log.d(
                debugTag,"Failed to get android.provider.Settings.Secure.getInt(lock_screen_show_notifications): $e"
            )
        }

        val incomingCallIntent = Intent(context, MainActivity::class.java)
        incomingCallIntent.putExtra(INTENT_CALL_UUID, uuid)
        Log.d(debugTag, "incmoing rec ${notifiable.notificationId}" )

        incomingCallIntent.addFlags(
            Intent.FLAG_ACTIVITY_NEW_TASK or
                Intent.FLAG_ACTIVITY_NO_USER_ACTION or
                Intent.FLAG_FROM_BACKGROUND
        )


        val pendingIntent: PendingIntent = PendingIntent.getActivity(
            context,
            0,
            incomingCallIntent,
            PendingIntent.FLAG_CANCEL_CURRENT or
                    PendingIntent.FLAG_IMMUTABLE
        )

        val notification = Compatibility.createIncomingCallNotification(
            context ,
            call,
            notifiable,
            pendingIntent,
            this,
        )

        with(NotificationManagerCompat.from(context)) {
            if (ActivityCompat.checkSelfPermission(
                    context,
                    Manifest.permission.POST_NOTIFICATIONS
            ) != PackageManager.PERMISSION_GRANTED) {
                Log.e(debugTag, "missing POST_NOTIFICATIONS")
                return
            } else if (ActivityCompat.checkSelfPermission(
                    context,
                    Manifest.permission.READ_PHONE_STATE
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                Log.e(debugTag, "missing READ_PHONE_STATE")
                return
            }
            if(!callsManager.telecomManager.isInManagedCall){
                notify(notifiable.notificationId, notification!!)
                activeNotification[notifiable.notificationId] = notification
                Log.d(debugTag, "notified")
            }
            Log.d(debugTag, "skipping call notification... ${callsManager.telecomManager.isInManagedCall}")
        }
    }

    fun displayCallNotification(call: Call) {
        val uuid =  callsManager.findUuidByCall(call)
        val notifiable = getNotifiableForCall(call, uuid)
        val callNotificationIntent = Intent(context, MainActivity::class.java)
        callNotificationIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        val pendingIntent = PendingIntent.getActivity(
            context,
            FMCore.core.callsNb,
            callNotificationIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val notification = Compatibility.createCallNotification(
            context,
            call,
            notifiable,
            pendingIntent,
            this,
        )

        with(NotificationManagerCompat.from(context)) {
            // notificationId is a unique int for each notification that you must define.
            Log.d(debugTag, "notify")
            if (ActivityCompat.checkSelfPermission(
                    context,
                    Manifest.permission.POST_NOTIFICATIONS
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                // TODO: Consider calling
                //    ActivityCompat#requestPermissions
                Log.w(debugTag, "missing POST_NOTIFICATIONS permission")
                return
            }
            notify(notifiable.notificationId, notification)
            activeNotification[notifiable.notificationId] = notification
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R &&
                call.state == Call.State.Connected) {
                    Log.d(debugTag, "call Connected")
                    // start the FusionCall service snd if its running, make sure to keep it running
                    val intent = Intent(context, FusionCallService::class.java)
                    intent.putExtra(INTENT_NOTIF_ID, notifiable.notificationId)
                    context.startService(intent)

                    // then startForground to make it work harder and keep the mic active at all time
                    callService?.startForeground(
                       notifiable.notificationId,
                       notification,
                       if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                           ServiceInfo.FOREGROUND_SERVICE_TYPE_MICROPHONE or ServiceInfo.FOREGROUND_SERVICE_TYPE_PHONE_CALL
                       } else {
                           0
                       },
                    )

            }

            Log.d(debugTag, "notified ongoing")
        }
        Log.d(debugTag,"Notifying call notification [${notifiable.notificationId}]")

    }

    private fun dismissCallNotification(call: Call) {
        Log.d(debugTag, "dismiss call")
        val uuid =  callsManager.findUuidByCall(call)

        val notifiable: Notifiable? = callNotificationsMap[uuid]
        if (notifiable != null) {
            callNotificationsMap.remove(uuid)
            activeNotification.remove(notifiable.notificationId)
            val callerNumber: String = FMUtils.getPhoneNumber(call.remoteAddress)
            contacts.remove(callerNumber)
            //stop stopForeground service by its notification id
            Log.d(debugTag, "remining calls whe dissmissed ${callServiceStartId} $callService $callServiceStartId ${notifiable.notificationId}")
            notificationManager.cancel(notifiable.notificationId)
            callService?.stopSelf(callServiceStartId[notifiable.notificationId]!!)
        } else {
            Log.d(debugTag,"No notification found for call ${call.callLog.callId}")
        }
    }

    fun getCallDeclinePendingIntent(notifiable: Notifiable): PendingIntent {
        val hangupIntent = Intent(context, NotificationsBroadcastReceiver::class.java)
        hangupIntent.action = INTENT_HANGUP_CALL_NOTIF_ACTION
        hangupIntent.putExtra(INTENT_NOTIF_ID, notifiable.notificationId)
        hangupIntent.putExtra(INTENT_REMOTE_ADDRESS, notifiable.remoteAddress)
        hangupIntent.putExtra(INTENT_CALL_UUID, notifiable.uuid)

        return PendingIntent.getBroadcast(
            context,
            notifiable.notificationId,
            hangupIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
    }

    fun getUnholdCallPendingIntent (notifiable: Notifiable): PendingIntent {
        val hangupIntent = Intent(context, NotificationsBroadcastReceiver::class.java)
        hangupIntent.action = INTENT_UNHOLD_CALL_NOTIF_ACTION
        hangupIntent.putExtra(INTENT_NOTIF_ID, notifiable.notificationId)
        hangupIntent.putExtra(INTENT_REMOTE_ADDRESS, notifiable.remoteAddress)
        hangupIntent.putExtra(INTENT_CALL_UUID, notifiable.uuid)

        return PendingIntent.getBroadcast(
            context,
            notifiable.notificationId,
            hangupIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
    }
    fun getCallAnswerPendingIntent(notifiable: Notifiable): PendingIntent {
        val answerIntent = Intent(context, NotificationsBroadcastReceiver::class.java)
        answerIntent.action = INTENT_ANSWER_CALL_NOTIF_ACTION
        answerIntent.putExtra(INTENT_NOTIF_ID, notifiable.notificationId)
        answerIntent.putExtra(INTENT_REMOTE_ADDRESS, notifiable.remoteAddress)
        answerIntent.putExtra(INTENT_CALL_UUID, notifiable.uuid)

        return PendingIntent.getBroadcast(
            context,
            notifiable.notificationId,
            answerIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
    }

    fun getCallAnswerAction(notifiable: Notifiable): NotificationCompat.Action {
        return NotificationCompat.Action.Builder(
            R.drawable.app_icon_background,
            "Answer",
            getCallAnswerPendingIntent(notifiable)
        ).build()
    }

    fun getCallDeclineAction(notifiable: Notifiable, endCall: Boolean = false): NotificationCompat.Action {
        val title = if (endCall) "Hang up" else "Decline"
        return NotificationCompat.Action.Builder(
            R.drawable.app_icon_background,
            title,
            getCallDeclinePendingIntent(notifiable)
        )
            .setShowsUserInterface(false)
            .build()
    }

}

data class Contact (
    val name: String,
    val number: String,
    val avatar: String,
)