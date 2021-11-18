package net.fusioncomm.android

import android.os.Build
import android.telecom.*
import android.util.Log
import android.widget.Toast

class FusionConnectionService: ConnectionService() {
    override fun onCreateIncomingConnection(connectionManagerPhoneAccount: PhoneAccountHandle?, request: ConnectionRequest?): Connection {
        val bundle = request!!.extras
        val uuid = bundle.getString("uuid")
        val callerName = bundle.getString("callerName")
        val callerNumber = bundle.getString("callerNumber")
        val callId = bundle.getString("callId")

        var conn = FusionConnection()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N_MR1) {
            conn?.connectionProperties = Connection.PROPERTY_SELF_MANAGED
        }

        conn?.setCallerDisplayName(callerName, TelecomManager.PRESENTATION_ALLOWED)
        conn?.setAddress(request.address, TelecomManager.PRESENTATION_ALLOWED)
        conn?.setInitializing()
        conn?.setActive()
        return conn!!
    }

    override fun onCreateIncomingConnectionFailed(connectionManagerPhoneAccount: PhoneAccountHandle?, request: ConnectionRequest?) {
        super.onCreateIncomingConnectionFailed(connectionManagerPhoneAccount, request)
        Log.e("onCreateIncomingFailed:",request.toString())
        Toast.makeText(applicationContext,"onCreateIncomingConnectionFailed",Toast.LENGTH_LONG).show();
    }

    override fun onCreateOutgoingConnectionFailed(connectionManagerPhoneAccount: PhoneAccountHandle?, request: ConnectionRequest?) {
        super.onCreateOutgoingConnectionFailed(connectionManagerPhoneAccount, request)
        Log.e("onCreateOutgoingFailed:",request.toString())
        Toast.makeText(applicationContext,"onCreateOutgoingConnectionFailed",Toast.LENGTH_LONG).show();
    }

    override fun onCreateOutgoingConnection(connectionManagerPhoneAccount: PhoneAccountHandle?, request: ConnectionRequest?): Connection {
        val bundle = request!!.extras
        val uuid = bundle.getString("uuid")
        val callerName = bundle.getString("callerName")
        val callerNumber = bundle.getString("callerNumber")
        val callId = bundle.getString("callId")

        val conn = FusionConnection()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N_MR1) {
            conn?.connectionProperties = Connection.PROPERTY_SELF_MANAGED
        }
        conn?.setCallerDisplayName(callerName, TelecomManager.PRESENTATION_ALLOWED)
        conn?.setAddress(request.address, TelecomManager.PRESENTATION_ALLOWED)
        conn?.setInitializing()
        conn?.setActive()
        return conn!!
    }
}