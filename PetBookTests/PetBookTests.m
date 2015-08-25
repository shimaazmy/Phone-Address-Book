
#import <XCTest/XCTest.h>
#import "CouchModel.h"
#import <OCMock/OCMock.h>
#import "PetBook-Swift.h"

@interface PetBookTests : XCTestCase


@end

@implementation PetBookTests

//- (void)testShowAlert {
//    
//    CBLDatabase *db = [[CBLDatabase alloc] init];
//    
//    AddContactViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddContactViewController"];
//    [vc view];
//    
//    id mock = OCMPartialMock(vc);
//    
//    [[mock expect] showAlert:mock title:@"Failed " message:@"Please enter first name"];
//    
////    [[mock expect] addContact:[OCMArg any] lName:[OCMArg any] mobile:[OCMArg any] database:[OCMArg any]];
//    
//    [mock addNewContact];
//    
//    [mock verify];
//}

- (void)testLiveQuery {
    
    CouchModel* model = [[CouchModel alloc] init];
    CBLLiveQuery* query = [model retrieveData];
    XCTAssertNotNil(query);
}

- (void)testCreateView {
    CouchModel* model = [[CouchModel alloc] init];
    CBLView* view = [model createView];
    XCTAssertNotNil(view);
}

- (void)testCreateDataBase {
    CouchModel* model = [[CouchModel alloc] init];
  BOOL result = [model createDatabase];
    XCTAssertTrue(result);

}

- (void)testImportContacts {
    RHAddressBook *ab = [[RHAddressBook alloc] init];
    CouchModel* model = [[CouchModel alloc] init];
    RHPerson* person = [ ab newPersonInDefaultSource];
    NSString* name = @"shimaa";
    person.firstName = name;
    person.lastName = @"azmy";
    NSLog(@"shimaa,,,, %@", person.name);
    CBLManager* manager = [CBLManager sharedInstance];
    NSError* error;
    CBLDatabase* database = [manager databaseNamed:@"test" error: &error];
    ContactModel* contact = [model importPerson:person database:database error:nil];
    XCTAssertNotNil(contact);
    NSLog(@"shimaa,,,, %@", contact.contactName);
    XCTAssertEqual(contact.contactName, person.name);
}


@end
