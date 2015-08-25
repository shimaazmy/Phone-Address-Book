import UIKit
import XCTest
import OCMock

class importContacts: XCTestCase {
    
    var db: CBLDatabase!
    override func setUp() {
        //self.continueAfterFailure = false
        super.setUp()
        var error: NSError?
        db = CBLManager.sharedInstance().databaseNamed("test", error: &error)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testImportContacts() {
        let vc = AddContactViewController()
        var fName:String = "ddd"
        var lName:String = "sss"
        var phone:String = "5555"
        var add: Bool = vc.addContact(fName, lName: lName, mobile: phone, database: db)
        XCTAssertTrue(add, "true")
    }
    
//    func testAny() {
//        let vc = AddContactViewController()
//        let selector: Selector = "addContact:fname:lName:mobile:database:"
//        var mock = OCMockObject.partialMockForObject(vc).stub().andReturn(true)
//        
//        
//        mock.andCall(selector, onObject: mock)
//        
//        
//        
//        
//        
//        (mock.stub().andReturn(true) as? AddContactViewController)?.addContact("", lName: "", mobile: "", database: db)
//        
//        let result = (mock as? AddContactViewController)?.addContact("", lName: "", mobile: "", database: db)
//        
//        XCTAssertTrue(result!, "")
//    }
////    id mock = [OCMockObject mockForClass:NSString.class]
////        [[[mock stub] andReturn:@"mocktest"] lowercaseString];
//    
//
    
}
