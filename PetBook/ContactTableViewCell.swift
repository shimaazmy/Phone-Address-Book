import UIKit

protocol ContactTableViewCellModelProtocol {
    var name: String { get }
    var phoneNumber: String { get }
    var contactImage: UIImage { get }
}

class ContactTableViewCell: UITableViewCell  {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var contactImage: UIImageView!
}

extension ContactTableViewCell {
    func configure(model: ContactTableViewCellModelProtocol) {
        name.text = model.name
        phoneNumber.text = model.phoneNumber
        contactImage.image = model.contactImage
    }
}

struct ContactTableViewCellModel: ContactTableViewCellModelProtocol {
    let name: String
    let phoneNumber: String
    let contactImage: UIImage
    
    init(name: String, phoneNumber: String, contactImage: UIImage) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.contactImage = contactImage
    }
}