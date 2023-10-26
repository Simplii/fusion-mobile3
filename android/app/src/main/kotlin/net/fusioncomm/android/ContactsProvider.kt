package net.fusioncomm.android

import android.content.ContentResolver
import android.content.Context
import io.flutter.plugin.common.MethodChannel


class ContactsProvider constructor(contactsChannel: MethodChannel, context: Context) {
    private val contentResolver:ContentResolver = context.contentResolver
    init {
        contactsChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "syncContacts" -> {
                    ContactsThread(contactsChannel, contentResolver).start()
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}