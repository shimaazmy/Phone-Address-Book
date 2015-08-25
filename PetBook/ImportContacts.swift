//
//  ImportContacts.swift
//  PetBook
//
//  Created by Shimaa Azmy on 8/23/15.
//  Copyright (c) 2015 Evan Dekhayser. All rights reserved.
//

import UIKit
import RHAddressBook

class ImportContacts {
    
    func importContactsFromAddressBook()-> NSArray {
        let ab = RHAddressBook()
        let contacts = ab.people()
        return contacts
    }
}

