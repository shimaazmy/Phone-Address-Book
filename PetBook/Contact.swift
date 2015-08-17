//
//  Contact.swift
//  PetBook
//
//  Created by Shimaa Azmy on 8/2/15.
//  Copyright (c) 2015 Evan Dekhayser. All rights reserved.
//

import UIKit

struct Contact {
    let contactName: String
    let contactPhone: String
    let contactImageData: NSData
}

extension Contact: ContactTableViewCellModelProtocol {
    var name: String {
        return contactName
    }
    var phoneNumber: String {
        return contactPhone
    }
    var contactImage: UIImage {
        return UIImage(data: contactImageData)!
    }
}