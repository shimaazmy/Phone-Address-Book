//
//  CouchModel.h
//  PetBook
//
//  Created by Shimaa Azmy on 8/9/15.
//  Copyright (c) 2015 Evan Dekhayser. All rights reserved.
//
#import <CouchbaseLite/CouchbaseLite.h>
#import "ContactModel.h"

@interface CouchModel :NSObject
// shared manager
@property (strong, nonatomic) CBLManager *manager;

// the database
@property (strong, nonatomic) CBLDatabase *database;
@property NSArray* contacts;
-(CBLLiveQuery*)retriveData;

@end

