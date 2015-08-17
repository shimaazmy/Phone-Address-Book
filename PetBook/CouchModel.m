//
//  CouchModel.m
//  PetBook
//
//  Created by Shimaa Azmy on 8/9/15.
//  Copyright (c) 2015 Evan Dekhayser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CouchModel.h"
#import "PetBook-Swift.h"
#import <RHAddressBook/AddressBook.h>


@implementation CouchModel


//creates the manager object
- (BOOL) createTheManager {
    
    // create a shared instance of CBLManager
    _manager = [CBLManager sharedInstance];
    if (!_manager) {
        NSLog (@"Cannot create shared instance of CBLManager");
        return NO;
    }
    
    NSLog (@"Manager created");
    
    return YES;
    
}
// creates the database
- (BOOL)createTheDatabase {
    
    NSError *error;
    NSString *dbname = @"contacts";
    if (![CBLManager isValidDatabaseName: dbname]) {
        NSLog (@"Bad database name");
        return NO;
    }
    _database = [_manager databaseNamed: dbname error: &error];
    if (!_database) {
        NSLog (@"Cannot create database. Error message: %@", error.localizedDescription);
        return NO;
    }
    return YES;
}
-(void)storeData
{
    NSError *error;
    for(int i = 0 ; i<_contacts.count ; i++){
        CBLDocument* doc = [_database createDocument] ;
        ContactModel* contact= [ContactModel modelForDocument: doc];
        contact.contactName = [[_contacts objectAtIndex:i] name];
        contact.contactImage = [[_contacts objectAtIndex:i] originalImageData];
        RHMultiValue *phones = [[_contacts objectAtIndex:i] phoneNumbers];
        NSString *phoneNumber = (NSString*) [phones valueAtIndex:0];
        contact.contactPhone = phoneNumber;
        BOOL ok = [contact save: &error];
        if(ok){
            NSLog(@"name########### %@" , contact.contactName);
            NSLog(@"successssssssssss????FF:F??::??");
        }
    }
}
-(CBLLiveQuery*)retriveData
{
    NSError *error;
    CBLView* view = [_database viewNamed: @"byDate"];
    [view setMapBlock: MAPBLOCK({
        id date = [doc objectForKey: @"contactName"];
        if (date) emit(date, doc);
    }) version: @"2.1"];
    
    CBLLiveQuery *liveQuery = [[_database viewNamed: @"byDate"] createQuery].asLiveQuery;
    [liveQuery run:&error];
    NSLog(@"ddddddddddd %lu" , liveQuery.rows.count);
    return liveQuery;
}

-(id) init
{
    self = [super init];
    if(self){
        _contacts = [NSArray array];
        RHAddressBook *ab = [[RHAddressBook alloc] init];
        _contacts = [ab people];
        [self createTheManager];
        [self createTheDatabase];
        [self storeData];
    }
    
    return self;
}
@end
