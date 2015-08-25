import UIKit
import RHAddressBook

class AddContactViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    let ab = RHAddressBook()
    var instanceOfCouchModel: CouchModel = CouchModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addNewContact() {
        
        if firstName.text == "" {
            showAlert(self, title: "Failed ", message: "Please enter first name")
        } else if lastName.text == "" {
            showAlert(self, title: "Failed ", message: "Please enter last name")
        } else if phone.text == "" {
            showAlert(self, title: "Failed ", message: "Please enter a mobile Number")
        } else {
        addContact(firstName.text!, lName: lastName.text!, mobile: phone.text!, database: instanceOfCouchModel.database)
        self.navigationController!.popViewControllerAnimated(true)
        }
    }
    
    func showAlert(delegate: UIViewController, title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            delegate.dismissViewControllerAnimated(true, completion: nil)
        }))
        delegate.presentViewController(alert, animated: true, completion: nil)
    }

    
//    func addContact(fname:String,lName:String, mobile:String, database: CBLDatabase) -> ContactModel {
//        var newContact = ContactModel(forNewDocumentInDatabase: database)
//        newContact.contactName = fname + lName
//        newContact.contactPhone = mobile
//        println(newContact.contactName)
//        newContact.save(nil)
//        return newContact
//        
//    }
    
    func addContact(fname:String,lName:String, mobile:String, database: CBLDatabase) -> Bool {
        var newContact = ContactModel(forNewDocumentInDatabase: database)
        newContact.contactName = fname + lName
        newContact.contactPhone = mobile
        println(newContact.contactName)
        if !(newContact.save(nil)) {
            return false
        }
        return true
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

}
