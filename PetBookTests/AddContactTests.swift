//
//  AddContactTests.swift
//  PetBook
//
//  Created by Shimaa Azmy on 8/24/15.
//  Copyright (c) 2015 Evan Dekhayser. All rights reserved.
//

import UIKit
import XCTest


class AddContactMock: AddContactViewController {
    var alertWasShown = false
    override func showAlert(delegate: UIViewController, title: String, message: String) {
        alertWasShown = true
    }

}

class AddContactTests: XCTestCase {
//    func testAddContact() {
////        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddContactViewController") as! AddContactViewController
////        _ = vc.view
////        
////        vc.firstName.text = "first"
////        vc.addNewContact()
//        
////        var firstName: UITextField
////        firstName.text = vc.firstName.text
//        let vc = AddContactMock()
//        vc.firstName.text = ""
//        vc.addNewContact()
//        XCTAssertTrue(vc.alertWasShown)
//    }
    
  
}
