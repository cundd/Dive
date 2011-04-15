//
//  CunddAppRegistry.h
//  Dive
//
//  Created by Daniel Corn on 12.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddObject.h"

@interface CunddAppRegistry : CunddObject {
	NSMutableDictionary * _registeredObjects;
}


/*!
    @method     
    @abstract   Returns the default registry
    @discussion Returns the default registry
*/
+(CunddAppRegistry *)defaultRegistry;


/*!
    @method     
    @abstract   Return the object with the given key
    @discussion Return the object with the given key
*/
+(id)registry:(NSString *)key;
/*!
    @method     
    @abstract   Return the object with the given key
    @discussion Return the object with the given key
*/
+(id)registryForKey:(NSString *)key;
/*!
    @method     
    @abstract   Return the object with the given key
    @discussion Return the object with the given key
*/
-(id)registryForKey:(NSString *)key;

/*!
    @method     
    @abstract   Return the object with the given key
    @discussion Return the object with the given key
*/
+(void)registry:(id)value at:(NSString *)key;
/*!
    @method     
    @abstract   Return the object with the given key
    @discussion Return the object with the given key
*/
+(void)registerValue:(id)value at:(NSString *)key;
/*!
    @method     
    @abstract   Return the object with the given key
    @discussion Return the object with the given key
*/
-(void)registry:(id)value at:(NSString *)key;


/*!
    @method     
    @abstract   Registers the given value at the key in the collection with the given name
    @discussion Registers the given value at the key in the collection with the given name
*/
+(id) collectionRegistry:(id)value at:(NSString *)collectionName withKey:(NSString *)theKey;

/*!
    @method     
    @abstract   Registers the given value in the collection with the given name
    @discussion Registers the given value in the collection with the given name
*/
+(id) collectionRegistry:(id)value at:(NSString *)collectionName;

/*!
    @method     
    @abstract   Returns the object with the given key in the collection with the given name
    @discussion Returns the object with the given key in the collection with the given name
*/
+(id) collectionRegistry:(NSString *)collectionName withKey:(NSString *)theKey;

/*!
    @method     
    @abstract   Returns the collection with the given name
    @discussion Returns the collection with the given name
*/
+(id) collectionRegistry:(NSString *)collectionName;
@end
