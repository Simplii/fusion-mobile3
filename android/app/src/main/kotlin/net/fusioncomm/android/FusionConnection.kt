package net.fusioncomm.android

import android.telecom.CallAudioState
import android.telecom.Connection

class FusionConnection : Connection() {
    override fun onShowIncomingCallUi() {
        super.onShowIncomingCallUi()
    }

    override fun onCallAudioStateChanged(state: CallAudioState?) {
        super.onCallAudioStateChanged(state)
    }

    override fun onHold() {
        super.onHold()
    }

    override fun onUnhold() {
        super.onUnhold()
    }

    override fun onAnswer() {
        super.onAnswer()
    }

    override fun onReject() {
        super.onReject()
    }

    override fun onDisconnect() {
        super.onDisconnect()
    }
}