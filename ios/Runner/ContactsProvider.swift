//
//  ContactsProvider.swift
//  Runner
//
//  Created by Zaid on 10/13/23.
//
import Flutter
import Foundation
import Contacts

@available(iOS 13.0.0, *)
class ContactsProvider: NSObject {
    private let contactsChannel: FlutterMethodChannel!
    private let contactsStore : CNContactStore
    
    public init(channel: FlutterMethodChannel) {
        print("contacts provider init")
        contactsStore = CNContactStore()
        contactsChannel = channel
        super.init()
        
        contactsChannel.setMethodCallHandler({
              (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            // This method is invoked on the UI thread.
            if(call.method == "getContacts"){
                Task.init{
                   return await self.getContacts(result: result)
                }
                
            }
          })
    }
    
    private func getContacts(result:FlutterResult) async {
        print("IOS get contacts")
        let contactStore = CNContactStore()
        let keys = [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactPostalAddressesKey,
            CNContactSocialProfilesKey,
            CNContactImageDataKey,
            CNContactJobTitleKey,
            CNContactOrganizationNameKey,
//            CNContactNoteKey
        ] as [CNKeyDescriptor]
        
        let fetchRequest : CNContactFetchRequest = CNContactFetchRequest(keysToFetch: keys)
        var contactsToSend:[Any] = []
        do {
            
            try contactStore.enumerateContacts(with: fetchRequest, usingBlock: {
                contact, result in
                
                var contactToSend: [String:Any] = [:]
                
                //                print(contact.note) needs extra permission
                
                contactToSend["firstName"] = contact.givenName
                contactToSend["lastName"] = contact.familyName
                contactToSend["jobtitle"] = contact.jobTitle
                contactToSend["company"] = contact.organizationName
                
                if(contact.imageData != nil){
                    contactToSend["imageData"] = contact.imageData
                }
                contactToSend["id"] = contact.identifier
                
                contactToSend["phoneNumbers"] = contactPhoneNumbers(contact: contact)
                contactToSend["emails"] = contactEmails(contact: contact)
                contactToSend["addresses"] = contactAddresses(contact: contact)
                contactToSend["socials"] = contactSocials(contact: contact)
//                contact.socialProfiles.forEach { profile in
//                    print("profile ",profile.label ?? "",profile.value.urlString)
//                }
                contactsToSend.append(contactToSend)
            })
        } catch {
            print("error")
        }
        return result(contactsToSend)
    }
    
    func contactPhoneNumbers (contact:CNContact) -> [[String:Any]] {
        var contactPhoneNumbers: [[String:Any]] = []
        contact.phoneNumbers.forEach { phoneNumber in
            var phoneNumberObj : [String:Any] = [:]
            phoneNumberObj["type"] = "other"
            phoneNumberObj["smsCapable"] = false
            
            if(phoneNumber.label != nil){
                if(phoneNumber.label == CNLabelPhoneNumberMobile){
                    phoneNumberObj["smsCapable"] = true
                    phoneNumberObj["type"] = "mobile"
                } else if(phoneNumber.label == CNLabelPhoneNumberMain || phoneNumber.label == CNLabelHome) {
                    phoneNumberObj["type"] = "phone"
                } else if (phoneNumber.label == CNLabelWork) {
                    phoneNumberObj["type"] = "work"
                }
            }
            phoneNumberObj["number"] = phoneNumber.value.stringValue
            if(!phoneNumberObj.isEmpty){
                contactPhoneNumbers.append(phoneNumberObj)
            }
        }
        return contactPhoneNumbers
    }
    
    func contactEmails (contact:CNContact) -> [[String:Any]] {
        var contactEmails: [[String:Any]] = []
        contact.emailAddresses.forEach { emailAddress in
            var emailObj : [String:Any] = [:]
            emailObj["id"] = emailAddress.identifier
            emailObj["type"] = "other"
            if(emailAddress.label != nil){
                if(emailAddress.label == CNLabelEmailiCloud){
                    emailObj["type"] = "personal"
                } else if(emailAddress.label == CNLabelWork) {
                    emailObj["type"] = "work"
                }
            }
            emailObj["email"] = emailAddress.value
            if(!emailObj.isEmpty){
                contactEmails.append(emailObj)
            }
        }
        return contactEmails
    }
    
    func contactAddresses (contact:CNContact) -> [[String:Any]] {
        var contactAddresses: [[String:Any]] = []
        contact.postalAddresses.forEach { address in
            var addressObj : [String:Any] = [:]
            
            addressObj["id"] = address.identifier
            addressObj["type"] = "other"
            
            if(address.label != nil){
                if(address.label == CNLabelHome){
                    addressObj["type"] = "home"
                } else if(address.label == CNLabelWork) {
                    addressObj["type"] = "work"
                }
            }
            
            addressObj["address"] = address.value.street
            addressObj["address2"] = ""
            addressObj["city"] = address.value.city
            addressObj["state"] = address.value.state
            addressObj["zip"] = address.value.postalCode
            addressObj["country"] = address.value.country
            addressObj["name"] = ""
            addressObj["zip-2"] = ""
            
            if(!addressObj.isEmpty){
                contactAddresses.append(addressObj)
            }
        }
        return contactAddresses
    }
    
    func contactSocials (contact:CNContact) -> [[String:Any]] {
        var contactSocials: [[String:Any]] = []
        contact.socialProfiles.forEach { profile in
            var profileObj : [String:Any] = [:]
            print("MDBM profile \(profile)")
//            profileObj["id"] = profile.identifier
//            profileObj["type"] = "other"
            if(profile.label != nil){
//                if(emailAddress.label == CNLabelEmailiCloud){
//                    profileObj["type"] = "personal"
//                } else if(emailAddress.label == CNLabelWork) {
//                    profileObj["type"] = "work"
//                }
            }
//            profileObj["email"] = emailAddress.value
            if(!profileObj.isEmpty){
                contactSocials.append(profileObj)
            }
        }
        // need to add website here too
        // contact.urlAddresses
        return contactSocials
    }
}
