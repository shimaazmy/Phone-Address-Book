
//
//  DisplayDataViewController.swift
//  PetBook
//
//  Created by Shimaa Azmy on 8/1/15.
//  Copyright (c) 2015 Evan Dekhayser. All rights reserved.
//

import UIKit

class DisplayDataViewController: UIViewController {

    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var phoneLable: UILabel!
    
     let defaultImage: UIImage = UIImage(named:"rose.jpg")!
    
    var contact: ContactModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewWithContact(contact)
    }
    
    func configureViewWithContact(contact: ContactModel) {
        nameLable.text = contact.contactName
        phoneLable.text = contact.contactPhone
        if contact.contactImage != nil{
            contactImage.image = UIImage(data:contact.contactImage)
        }
        else{
            contactImage.image = defaultImage
        }
    }

}

