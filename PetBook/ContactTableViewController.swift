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
    var liveQuery: CBLLiveQuery!
    var error : NSError!
    var instanceOfCouchModel: CouchModel = CouchModel()
    let addressBookRef: ABAddressBook = ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        
        println("rows count: \(liveQuery.rows?.count)")
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        liveQuery = instanceOfCouchModel.retriveData()
        liveQuery.addObserver(self, forKeyPath: "rows", options: .allZeros, context: nil)
        let authorizationStatus = ABAddressBookGetAuthorizationStatus()
        switch authorizationStatus {
        case .Denied, .Restricted:
            //1
            println("Denied")
        case .Authorized:
            //2
            println("Authorized")
        case .NotDetermined:
            //3
            println("Not Determined")
            promptForAddressBookRequestAccess()
        }
    }
    func promptForAddressBookRequestAccess() {
        var err: Unmanaged<CFError>? = nil
        
        ABAddressBookRequestAccessWithCompletion(addressBookRef) {
            (granted: Bool, error: CFError!) in
            dispatch_async(dispatch_get_main_queue()) {
                if !granted {
                    println("Just denied")
                    self.displayCantAddContactAlert()
                } else {
                    println("Just authorized")
                }
            }
        }
    }
    
    func displayCantAddContactAlert() {
        let cantAddContactAlert = UIAlertController(title: "Cannot Add Contact",
            message: "You must give the app permission to add the contact first.",
            preferredStyle: .Alert)
        cantAddContactAlert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        presentViewController(cantAddContactAlert, animated: true, completion: nil)
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(liveQuery.rows?.count ?? 0)
    }
    func contactAtIndex(index: Int) -> ContactModel? {
        if let row = liveQuery.rows?.rowAtIndex(UInt(index)), doc = row.document {
            return ContactModel(forDocument: doc)
        } else {
            return nil
        }
    }
    @IBAction func importContacts() {
        instanceOfCouchModel.storeData()
        
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
