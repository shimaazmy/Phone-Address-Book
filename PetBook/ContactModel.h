//
//  ContactModel.h
//  PetBook
//
//  Created by Shimaa Azmy on 8/11/15.
//  Copyright (c) 2015 Evan Dekhayser. All rights reserved.
//

#import <CouchbaseLite/CouchbaseLite.h>

@interface ContactModel : CBLModel
@property NSString* contactName;
@property NSString* contactPhone;
@property NSData* contactImage;

@end
