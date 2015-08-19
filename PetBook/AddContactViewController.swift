//
//  AddContactViewController.swift
//  PetBook
//
//  Created by Shimaa Azmy on 8/18/15.
//  Copyright (c) 2015 Evan Dekhayser. All rights reserved.
//

import UIKit
import RHAddressBook

class AddContactViewController: UIViewController {
    
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var mail: UITextField!
    let ab = RHAddressBook()
    var instanceOfCouchModel: CouchModel = CouchModel()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addNewContact() {
        
        addContact(firstName.text!, lName: lastName.text!, mobile: phone.text!, database: instanceOfCouchModel.database)
        
    }
    func addContact(fname:String,lName:String, mobile:String, database: CBLDatabase) -> ContactModel {
        var newContact = ContactModel(forNewDocumentInDatabase: database)
        newContact.contactName = fname + lName
        newContact.contactPhone = mobile
        println(newContact.contactName)
        newContact.save(nil)
        return newContact
        
    }
    
}
