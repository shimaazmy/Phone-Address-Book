//
//  AddContact.swift
//  PetBook
//
//  Created by Shimaa Azmy on 8/17/15.
//  Copyright (c) 2015 Evan Dekhayser. All rights reserved.
//

import UIKit
import AddressBook
import RHAddressBook

class AddContact: UIViewController {


    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var mail: UITextField!
     let ab = RHAddressBook()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func AddContact() {
        var newContact = ab.newPersonInDefaultSource()

        newContact.firstName = firstName.text
        newContact.lastName = lastName.text
        if ab.addPerson(newContact)
        {
            println("successssssss#####")
            println(newContact.name)
        }
        newContact.save()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
