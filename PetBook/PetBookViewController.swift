//
//  PetBookViewController.swift
//  PetBook
//
//  Created by Niv Yahel on 2015-03-16.
//  Copyright (c) 2015 Evan Dekhayser. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI


class PetBookViewController: UIViewController {
  var pets = [
    Pet(firstName: "Cheesy", lastName: "Cat", phoneNumber: "2015552398", imageName: "contact_Cheesy.jpg"),
    Pet(firstName: "Freckles", lastName: "Dog", phoneNumber: "3331560987", imageName: "contact_Freckles.jpg"),
    Pet(firstName: "Maxi", lastName: "Dog", phoneNumber: "5438880123", imageName: "contact_Maxi.jpg"),
    Pet(firstName: "Shippo", lastName: "Dog", phoneNumber: "7124779080", imageName: "contact_Shippo.jpg")
  ]

    /////////========= return a reference to the current address book ========
    
    let addressBookRef: ABAddressBook = ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()
    
    //=========== end ==========================

  @IBAction func tappedAddPetToContacts(petButton: UIButton) {
    
    //============ this to take a permission to access the phone addressbook ============
    let authorizationStatus = ABAddressBookGetAuthorizationStatus()
    
    switch authorizationStatus {
    case .Denied, .Restricted:
        //1
        println("Denied")
        displayCantAddContactAlert()
    case .Authorized:
        //2
        println("Authorized")
        addPetToContacts(petButton)
    case .NotDetermined:
        //3
        println("Not Determined")
        promptForAddressBookRequestAccess(petButton)
        
        /////to go to second view controller
    }
    
    //=========== end of permission =====================================================

  }
    //============ ask the user to access his phone addressbook ===================
    func promptForAddressBookRequestAccess(petButton: UIButton) {
        var err: Unmanaged<CFError>? = nil
        
        ABAddressBookRequestAccessWithCompletion(addressBookRef) {
            (granted: Bool, error: CFError!) in
            dispatch_async(dispatch_get_main_queue()) {
                if !granted {
                    println("Just denied")
                    self.displayCantAddContactAlert()
                } else {
                    println("Just authorized")
                    self.addPetToContacts(petButton)
                }
            }
        }
    }
    //============= end of asking ==================================================
   
    ///==== to allow the app to the setting ========================================
    //this method need to take a look again ?????
    func openSettings() {
        let url = NSURL(string: UIApplicationOpenSettingsURLString)
        UIApplication.sharedApplication().openURL(url!)
    }
    //====== end of the allowing ===================================================
    
    //====== to tell the user that he can not add the contact if he do not allow accessing the addressbook sure or not==================================================================
    
    func displayCantAddContactAlert() {
        let cantAddContactAlert = UIAlertController(title: "Cannot Add Contact",
            message: "You must give the app permission to add the contact first.",
            preferredStyle: .Alert)
        cantAddContactAlert.addAction(UIAlertAction(title: "Change Settings",
            style: .Default,
            handler: { action in
                self.openSettings()
        }))
        cantAddContactAlert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        presentViewController(cantAddContactAlert, animated: true, completion: nil)
    }
    //==================== ending of sure to be denied  ============================
    
    //===================== create a record withe data of new contact ==============
    func makeAndAddPetRecord(pet: Pet) -> ABRecordRef {
        let petRecord: ABRecordRef = ABPersonCreate().takeRetainedValue()
        ABRecordSetValue(petRecord, kABPersonFirstNameProperty, pet.firstName, nil)
        ABRecordSetValue(petRecord, kABPersonLastNameProperty, pet.lastName, nil)
        ABPersonSetImageData(petRecord, pet.imageData, nil)
        /////
        let phoneNumbers: ABMutableMultiValue =
        ABMultiValueCreateMutable(ABPropertyType(kABMultiStringPropertyType)).takeRetainedValue()
        ABMultiValueAddValueAndLabel(phoneNumbers, pet.phoneNumber, kABPersonPhoneMainLabel, nil)
        /////
        ABAddressBookAddRecord(addressBookRef, petRecord, nil)
        saveAddressBookChanges()
        
        return petRecord
    }
    
    ///////////////  save///
    
    func saveAddressBookChanges() {
        if ABAddressBookHasUnsavedChanges(addressBookRef){
            var err: Unmanaged<CFErrorRef>? = nil
            let savedToAddressBook = ABAddressBookSave(addressBookRef, &err)
            if savedToAddressBook {
                println("Successully saved changes.")
            } else {
                println("Couldn't save changes.")
            }
        } else {
            println("No changes occurred.")
        }
    }
    
////////////end 
    
    /////////////
    func addPetToContacts(petButton: UIButton) {
        let pet = pets[petButton.tag]
        if let petRecordIfExists: ABRecordRef = getPetRecord(pet) {
            displayContactExistsAlert(petRecordIfExists)
            return
        }
        let petRecord: ABRecordRef = makeAndAddPetRecord(pet)
        let contactAddedAlert = UIAlertController(title: "\(pet.firstName) was successfully added.",
            message: nil, preferredStyle: .Alert)
        contactAddedAlert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        presentViewController(contactAddedAlert, animated: true, completion: nil)
    }

    /////////
    //=========== get the contacts from the phone address book ============
    
    var nameArray = [String]()
    var phoneArray = [String]()
    var imageArray = [NSData]()
    func getPetRecord(pet: Pet) -> ABRecordRef? {
        let allContacts = ABAddressBookCopyArrayOfAllPeople(addressBookRef).takeRetainedValue() as Array
        var petContact: ABRecordRef?
        ////////////
        for record:ABRecordRef in allContacts {
            var name = ABRecordCopyCompositeName(record).takeUnretainedValue()
             //println(name)
            nameArray.append(name as String)
            
            let data = ABPersonCopyImageData(record)
                        var phones : ABMultiValueRef = ABRecordCopyValue(record,kABPersonPhoneProperty).takeUnretainedValue() as ABMultiValueRef
            
            for(var numberIndex : CFIndex = 0; numberIndex < ABMultiValueGetCount(phones); numberIndex++)
            {
                let phoneUnmaganed = ABMultiValueCopyValueAtIndex(phones, numberIndex)
                
                
                let phoneNumber : NSString = phoneUnmaganed.takeUnretainedValue() as! NSString
                
                let locLabel : CFStringRef = (ABMultiValueCopyLabelAtIndex(phones, numberIndex) != nil) ? ABMultiValueCopyLabelAtIndex(phones, numberIndex).takeUnretainedValue() as CFStringRef : ""
                
                var cfStr:CFTypeRef = locLabel
                var nsTypeString = cfStr as! NSString
                var swiftString:String = nsTypeString as String
                
                let customLabel = String (stringInterpolationSegment: ABAddressBookCopyLocalizedLabel(locLabel))
               
            }
        }

        /////////
        for record in allContacts {
            let currentContact: ABRecordRef = record
            let currentContactName = ABRecordCopyCompositeName(currentContact).takeRetainedValue() as String
            let petName = pet.description
            if (currentContactName == petName) {
                println("found \(petName).")
                petContact = currentContact
            }
        }
        return petContact
    }
    //// end of getting ========
    
    //////// display alert dialog of duplication ================
    func displayContactExistsAlert(petRecord: ABRecordRef) {
        let petFirstName = ABRecordCopyValue(petRecord, kABPersonFirstNameProperty).takeRetainedValue() as? String ?? "That pet"
        let contactExistsAlert = UIAlertController(title: "\(petFirstName) has already been added.",
            message: nil, preferredStyle: .Alert)
        ///// display contacts ===
        contactExistsAlert.addAction(UIAlertAction(title: "Show Contact", style: .Default, handler: { action in
            let personViewController = ABPersonViewController()
            personViewController.displayedPerson = petRecord
            self.navigationController?.pushViewController(personViewController, animated: true)
        }))
        ////
        contactExistsAlert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        presentViewController(contactExistsAlert, animated: true, completion: nil)
    }
    
    /////////////// ending of display =====================
}
