#import <CouchbaseLite/CouchbaseLite.h>

@interface ContactModel : CBLModel
@property NSString* contactName;
@property NSString* contactPhone;
@property NSData* contactImage;

@end
