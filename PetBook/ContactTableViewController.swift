//
//  ContactTableViewController.swift
//  PetBook
//
//  Created by Shimaa Azmy on 8/9/15.
//  Copyright (c) 2015 Evan Dekhayser. All rights reserved.
//

import UIKit
import AddressBook
import RHAddressBook

class ContactTableViewController: UITableViewController {
    let ab = RHAddressBook()
    var contacts: [RHPerson] = []
    let defaultImage: UIImage = UIImage(named:"rose.jpg")!
    var liveQuery : CBLLiveQuery!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contacts = ab.people() as! [RHPerson]
        var instanceOfCouchModel: CouchModel = CouchModel()
        liveQuery = instanceOfCouchModel.retriveData()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(liveQuery.rows?.count)
        return Int(liveQuery.rows?.count ?? 0)
    }
    func contactAtIndex(index: Int) -> ContactModel? {
        if let row = liveQuery.rows?.rowAtIndex(UInt(index)), doc = row.document {
            return ContactModel(forDocument: doc)
        } else {
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ContactTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ContactTableViewCell
        
        if let contact = contactAtIndex(indexPath.row) {
            cell.name?.text = contact.contactName
            cell.phoneNumber?.text = contact.contactPhone
            if contact.contactImage != nil
            {
                cell.contactImage.image = UIImage(data: contact.contactImage)
            }
            else{
                cell.contactImage.image = defaultImage
            }
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "show" {
            let viewController = segue.destinationViewController as! DisplayDataViewController
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(cell)
                if let index = indexPath?.row {
                    let contact = contactAtIndex(index)
                    viewController.contact = contact
                }
            }
        }
    }
}
