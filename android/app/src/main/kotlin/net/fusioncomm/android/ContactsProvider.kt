package net.fusioncomm.android

import android.annotation.SuppressLint
import android.content.ContentResolver
import android.content.ContentUris
import android.content.Context
import android.content.res.AssetFileDescriptor
import android.database.Cursor
import android.net.Uri
import android.os.AsyncTask
import android.os.Build
import android.provider.ContactsContract
import android.telephony.PhoneNumberUtils
import android.util.Log
import com.google.gson.Gson
import io.flutter.plugin.common.MethodChannel
import java.io.IOException
import java.io.InputStream
import java.util.Locale


class ContactsProvider constructor(contactsChannel: MethodChannel, context: Context) {
    private val contentResolver:ContentResolver = context.contentResolver
    init {
        contactsChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getContacts" -> {
//                    val contacts: List<Map<String,Any>> = getContacts()
//                    Log.d("MDBM", "testy ${contacts[200]["id"]} ${contacts[200]["name"]}")
//                    result.success(gson.toJson(contacts))
    //                contactsChannel.invokeMethod("CONTACTS_LOADED", gson.toJson(contacts))
                }
                "syncContacts" -> {
                    Log.d("MDBM", "start sync")
                    ContactsThread(contactsChannel, contentResolver).start()
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

//    @SuppressLint("Range")
//    fun getContacts() : List<Map<String,Any>>{
//        var cursor:Cursor? = contentResolver.query(
//            ContactsContract.Contacts.CONTENT_URI,
//            null,
//            null,
//            null,
//            null
//        )
//        val contacts:MutableList<Map<String,Any>> = mutableListOf()
//
//        if(cursor != null && cursor.count > 0){
//            while (cursor.moveToNext()){
//                val contactId: String = cursor.getString(
//                        cursor.getColumnIndex(
//                                ContactsContract.Contacts._ID
//                        )
//                )
//                val phoneNumbersArray = getContactPhoneNumbers(contactId)
//                if(phoneNumbersArray.isEmpty()){
//                    continue
//                }
//                val (firstName, lastName, name) = getContactStructuredName(contactId)
//                val (company, jobTitle) = getCompanyInfo(contactId)
//                val image: ByteArray? = getDisplayPhoto(
//                        cursor.getLong(
//                                cursor.getColumnIndex(
//                                        ContactsContract.Contacts._ID
//                                )
//                        )
//                )
//                val emailsArray = getContactEmails(contactId)
//                val addressesArray = getContactAddresses(contactId)
//
//                contacts.add(
//                    mapOf<String,Any>(
//                        Pair("id",contactId),
//                        Pair("name", name),
//                        Pair("firstName", firstName),
//                        Pair("lastName", lastName),
//                        Pair("phoneNumbers", phoneNumbersArray),
//                        Pair("emails", emailsArray),
//                        Pair("addresses", addressesArray),
//                        Pair("imageData", image ?: ""),
//                        Pair("company", company),
//                        Pair("jobTitle", jobTitle)
//                    )
//                )
//            }
//            cursor.close()
//        }
//        return contacts;
//    }
//
//    @SuppressLint("Range")
//    fun getContactPhoneNumbers (contactId:String): Array<Map<String,Any>> {
//        val phoneNumbers:MutableList<Map<String,Any>> = mutableListOf()
//
//        val contactPhoneCursor:Cursor? = contentResolver.query(
//            ContactsContract.CommonDataKinds.Phone.CONTENT_URI,
//            null,
//            ContactsContract.CommonDataKinds.Phone.CONTACT_ID + "=" + contactId,
//            null,
//            null
//        )
//        if(contactPhoneCursor != null && contactPhoneCursor.count > 0){
//            while (contactPhoneCursor.moveToNext()){
//                val phoneNumber:String = contactPhoneCursor.getString(
//                        contactPhoneCursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER
//                        )
//                )
//
//                val phoneType:Int = contactPhoneCursor.getInt(
//                        contactPhoneCursor.getColumnIndex(
//                                ContactsContract.CommonDataKinds.Phone.TYPE
//                        )
//                )
//
//                phoneNumbers.add(
//                    mapOf(
//                        Pair("type", getPhoneNumberType(phoneType)),
//                        Pair("number", PhoneNumberUtils.formatNumberToE164(phoneNumber, Locale.getDefault().country)),
//                        Pair("smsCapable", getPhoneNumberType(phoneType) == "mobile"),
//                    )
//                )
//            }
//            contactPhoneCursor.close()
//        }
//        return phoneNumbers.toTypedArray();
//    }
//
//    @SuppressLint("Range")
//    fun getContactStructuredName (contactId:String): Triple<String, String, String> {
//        var firstName = ""
//        var lastName = ""
//        var name = ""
//        val displayNameCol: String =
//                if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB)
//                    ContactsContract.Contacts.DISPLAY_NAME_PRIMARY
//                else ContactsContract.Contacts.DISPLAY_NAME
//
//        val selection = ContactsContract.Data.MIMETYPE + " = ? AND " +
//                ContactsContract.CommonDataKinds.StructuredName.CONTACT_ID + " = ?"
//
//        val selectionArgs = arrayOf(
//                ContactsContract.CommonDataKinds.StructuredName.CONTENT_ITEM_TYPE,
//                contactId
//        )
//
//        val structuredNameCursor:Cursor? = contentResolver.query(
//                ContactsContract.Data.CONTENT_URI,
//                null,
//                selection,
//                selectionArgs,
//                null
//        )
//        if(structuredNameCursor != null && structuredNameCursor.count > 0){
//            while (structuredNameCursor.moveToNext()){
//                val given:String? = structuredNameCursor.getString(
//                        structuredNameCursor.getColumnIndex(
//                                ContactsContract.CommonDataKinds.StructuredName.GIVEN_NAME
//                        )
//                )
//                val family:String? = structuredNameCursor.getString(
//                        structuredNameCursor.getColumnIndex(
//                                ContactsContract.CommonDataKinds.StructuredName.FAMILY_NAME
//                        )
//                )
//                val company:String? = structuredNameCursor.getString(
//                        structuredNameCursor.getColumnIndex(
//                                ContactsContract.CommonDataKinds.Organization.COMPANY
//                        )
//                )
//                val display:String? = structuredNameCursor.getString(
//                        structuredNameCursor.getColumnIndex(displayNameCol)
//                )
//                firstName = given ?: ""
//                lastName = family ?: ""
//                name = display ?: ""
//                Log.d("MDBM", "ccc $company")
//                if(firstName.isEmpty() && name.isNotEmpty()){
//                    firstName = name.split(" ")[0]
//                }
//                if(lastName.isEmpty() && name.isNotEmpty() && name.split(" ").count() == 2){
//                    lastName = name.split(" ")[1]
//                }
//
//            }
//            structuredNameCursor.close()
//        }
//        return Triple(firstName,lastName,name);
//    }
//
//    @SuppressLint("Range")
//    fun getContactEmails (contactId:String): Array<Map<String,Any>> {
//        //something wrong here
//        val phoneEmails:MutableList<Map<String,Any>> = mutableListOf()
//
//        val contactEmailCursor:Cursor? = contentResolver.query(
//            ContactsContract.CommonDataKinds.Email.CONTENT_URI,
//            null,
//            ContactsContract.CommonDataKinds.Email.CONTACT_ID + "=" + contactId,
//            null,
//            null
//        )
//        if(contactEmailCursor != null && contactEmailCursor.count > 0){
//            while (contactEmailCursor.moveToNext()){
//                val email:String = contactEmailCursor.getString(
//                        contactEmailCursor.getColumnIndex(
//                                ContactsContract.CommonDataKinds.Email.ADDRESS
//                        )
//                )
//                val emailType:Int = contactEmailCursor.getInt(
//                        contactEmailCursor.getColumnIndex(
//                                ContactsContract.CommonDataKinds.Email.TYPE
//                        )
//                )
//                val emailId:String = contactEmailCursor.getString(
//                        contactEmailCursor.getColumnIndex(
//                                ContactsContract.CommonDataKinds.Email._ID
//                        )
//                )
//                getContactAddresses(contactId)
//                phoneEmails.add(
//                    mapOf(
//                        Pair("type", getEmailType(emailType)),
//                        Pair("email", email),
//                        Pair("id", emailId)
//                    )
//                )
//            }
//            contactEmailCursor.close()
//        }
//        return phoneEmails.toTypedArray();
//    }
//
//    @SuppressLint("Range")
//    fun getContactAddresses (contactId:String): Array<Map<String,Any>> {
//        val addresses:MutableList<Map<String,Any>> = mutableListOf()
//        val addressesCursor:Cursor? = contentResolver.query(
//            ContactsContract.CommonDataKinds.StructuredPostal.CONTENT_URI,
//            null,
//            ContactsContract.CommonDataKinds.StructuredPostal.CONTACT_ID + "=" + contactId,
//            null,
//            null
//        )
//        if(addressesCursor != null && addressesCursor.count > 0){
//            while (addressesCursor.moveToNext()){
//                val formattedAddress:String = addressesCursor.getString(
//                        addressesCursor.getColumnIndex(
//                                ContactsContract.CommonDataKinds.StructuredPostal.FORMATTED_ADDRESS
//                        )
//                )
//                val street:String? = addressesCursor.getString(
//                        addressesCursor.getColumnIndex(
//                                ContactsContract.CommonDataKinds.StructuredPostal.STREET
//                        )
//                )
//                val city:String? = addressesCursor.getString(
//                        addressesCursor.getColumnIndex(
//                                ContactsContract.CommonDataKinds.StructuredPostal.CITY
//                        )
//                )
//                val state:String? = addressesCursor.getString(
//                        addressesCursor.getColumnIndex(
//                                ContactsContract.CommonDataKinds.StructuredPostal.REGION
//                        )
//                )
//                val zip:String? = addressesCursor.getString(
//                        addressesCursor.getColumnIndex(
//                                ContactsContract.CommonDataKinds.StructuredPostal.POSTCODE
//                        )
//                )
//                val country:String? = addressesCursor.getString(
//                        addressesCursor.getColumnIndex(
//                                ContactsContract.CommonDataKinds.StructuredPostal.COUNTRY
//                        )
//                )
//                val addressType:Int = addressesCursor.getInt(
//                        addressesCursor.getColumnIndex(
//                                ContactsContract.CommonDataKinds.StructuredPostal.TYPE
//                        )
//                )
//
//
//                addresses.add(
//                    mapOf(
//                        Pair("address1", street ?: ""),
//                        Pair("address2", ""),
//                        Pair("city", city ?: ""),
//                        Pair("state", state ?: ""),
//                        Pair("zip", zip ?: ""),
//                        Pair("country", country ?: ""),
//                        Pair("type", addressType),
//                        Pair("formattedAddress", formattedAddress)
//                    )
//                )
//
//            }
//            addressesCursor.close()
//        }
//        return addresses.toTypedArray();
//    }
//
////    private fun getProfileImage(contactId: Long): ByteArray? {
////        val contactUri = ContentUris.withAppendedId(
////                ContactsContract.Contacts.CONTENT_URI,
////                contactId
////        )
////        val photoUri = Uri.withAppendedPath(
////                contactUri,
////                ContactsContract.Contacts.Photo.CONTENT_DIRECTORY
////        )
////        val cursor: Cursor = contentResolver.query(
////                photoUri,
////                arrayOf<String>(ContactsContract.Contacts.Photo.PHOTO),
////                null,
////                null,
////                null
////        ) ?: return null
////        cursor.use { cursor ->
////            if (cursor.moveToFirst()) {
////                val data = cursor.getBlob(0)
////                if (data != null) {
////                    return data
////                }
////            }
////        }
////        return null
////    }
//
//    private fun getDisplayPhoto(contactId: Long): ByteArray? {
//        val contactUri = ContentUris.withAppendedId(ContactsContract.Contacts.CONTENT_URI, contactId)
//        val displayPhotoUri = Uri.withAppendedPath(contactUri, ContactsContract.Contacts.Photo.DISPLAY_PHOTO)
//        return try {
//            val fd: AssetFileDescriptor? = contentResolver.openAssetFileDescriptor(displayPhotoUri, "r")
//            val st:InputStream? = fd?.createInputStream()
//            st?.readBytes()
//        } catch (e: IOException) {
//            null
//        }
//    }
//    @SuppressLint("Range")
//    private fun getCompanyInfo(contactId: String): Pair<String, String>  {
//        val selection = ContactsContract.Data.MIMETYPE + " = ? AND " +
//                ContactsContract.CommonDataKinds.Organization.CONTACT_ID + " = ?"
//
//        val selectionArgs = arrayOf(
//                ContactsContract.CommonDataKinds.Organization.CONTENT_ITEM_TYPE,
//                contactId
//        )
//        var companyName = ""
//        var jobTitle = ""
//        val contactCompanyCursor:Cursor? = contentResolver.query(
//                ContactsContract.Data.CONTENT_URI,
//                null,
//                selection,
//                selectionArgs,
//                null
//        )
//        if(contactCompanyCursor != null && contactCompanyCursor.count > 0){
//            while (contactCompanyCursor.moveToNext()){
//                val company:String? = contactCompanyCursor.getString(
//                        contactCompanyCursor.getColumnIndex(
//                                ContactsContract.CommonDataKinds.Organization.COMPANY
//                        )
//                )
//                val title:String? = contactCompanyCursor.getString(
//                        contactCompanyCursor.getColumnIndex(
//                                ContactsContract.CommonDataKinds.Organization.TITLE
//                        )
//                )
//                companyName = company ?: ""
//                jobTitle = title ?: ""
//            }
//            contactCompanyCursor.close()
//        }
//        return Pair(companyName,jobTitle);
//    }
//
//    private fun getPhoneNumberType (phoneType:Int):String {
//        var phoneNumberType = "other"
//        if(phoneType == ContactsContract.CommonDataKinds.Phone.TYPE_HOME){
//            phoneNumberType = "phone"
//        }
//        if(phoneType == ContactsContract.CommonDataKinds.Phone.TYPE_WORK){
//            phoneNumberType = "work"
//        }
//        if(phoneType == ContactsContract.CommonDataKinds.Phone.TYPE_MOBILE){
//            phoneNumberType = "mobile"
//        }
//        if(phoneType == ContactsContract.CommonDataKinds.Phone.TYPE_MAIN){
//            phoneNumberType = "phone"
//        }
//        return phoneNumberType
//    }
//
//    private fun getEmailType (phoneType:Int):String {
//        var emailType = "personal"
//        if(phoneType == ContactsContract.CommonDataKinds.Email.TYPE_WORK){
//            emailType = "work"
//        }
//        return emailType
//    }
}