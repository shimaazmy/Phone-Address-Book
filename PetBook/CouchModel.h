#import <CouchbaseLite/CouchbaseLite.h>
#import "ContactModel.h"
#import <RHAddressBook/AddressBook.h>

@interface CouchModel :NSObject

@property CBLManager *manager;
@property CBLDatabase *database;
-(CBLLiveQuery*)retrieveData;
-(CBLView *)createView;
-(BOOL)createDatabase;
-(void)fillModelObject:(NSArray *)contacts;
- (nullable ContactModel *)importPerson:(RHPerson *)person
                               database:(CBLDatabase *)database
                                  error:(NSError **)error;
@end

