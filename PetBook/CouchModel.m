#import <Foundation/Foundation.h>
#import "CouchModel.h"
#import <RHAddressBook/AddressBook.h>


@implementation CouchModel

-(BOOL)createDatabase {
    NSError *error;
    NSString *dbname = @"contacts";
    _manager = [CBLManager sharedInstance];
    _database = [_manager databaseNamed: dbname error: &error];
    if (!_database) {
        NSLog (@"Cannot create database. Error message: %@", error.localizedDescription);
        return NO;
    }
    return YES;
}

- (nullable ContactModel *)importPerson:(RHPerson *)person
                               database:(CBLDatabase *)database
                                  error:(NSError **)error {
    ContactModel *contact = [ContactModel modelForNewDocumentInDatabase:database];
    contact.contactName = person.name;
    contact.contactImage = person.originalImageData;
    RHMultiValue *phones = person.phoneNumbers;
    NSString *phoneNumber = (NSString*) [phones valueAtIndex:0];
    contact.contactPhone = phoneNumber;
    
    if ([contact save:error]) {
        return contact;
    } else {
        return nil;
    }
}

-(void)fillModelObject: (NSArray *)contacts {
    for(int i = 0 ; i < contacts.count ; i++){
        [self importPerson:[contacts objectAtIndex:i] database:_database error:NULL];
    }
}

-(CBLView *)createView {
    CBLView* view = [_database viewNamed: @"byDate"];
    [view setMapBlock: MAPBLOCK({
        id date = [doc objectForKey: @"contactName"];
        if (date) emit(date, doc);
    }) version: @"2.1"];
    return view;
}

-(CBLLiveQuery *)retrieveData {
    NSError *error;
    CBLLiveQuery *liveQuery = [[_database viewNamed: @"byDate"] createQuery].asLiveQuery;
    [liveQuery run:&error];
    return liveQuery;
}

-(id) init {
    self = [super init];
    if(self) {
        [self createDatabase];
        [self createView];
    }
    return self;
}
@end
