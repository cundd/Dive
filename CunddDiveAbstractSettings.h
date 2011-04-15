//
//  CunddDiveAbstractSettings.h
//  Dive
//
//  Created by Daniel Corn on 11.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Cundd.h"

@interface CunddDiveAbstractSettings : CunddObject {
	NSNumber * index;
	NSString * userDefaultsKey;
}

/*!
 @method     
 @abstract   Set the properties from a given dictionary
 @discussion Set the properties from a given dictionary.
 */
-(void)setPropertiesFromDictionary:(NSDictionary *)dictionary;


/*!
 @method     
 @abstract   Retrieves the settings from the user defaults
 @discussion Retrieves the settings from the user defaults.
 */
-(void)setPropertiesFromUserDefaults;


/*!
 @method     
 @abstract   Update the user-defaults-entries
 @discussion Update the user-defaults-entries.
 */
-(void)updateUserDefaults;


/*!
 @method     
 @abstract   Check if the propertyKey is handled in the user defaults key
 @discussion Check if the propertyKey is handled in the user defaults key
 */
-(BOOL)isUserDefaultsValidProperty:(NSString *)propertyKey;


/*!
 @method     
 @abstract   Check if the propertyKey is the key of an ivar
 @discussion Check if the propertyKey is the key of an ivar
 */
-(BOOL)isValidInstanceProperty:(NSString *)propertyKey;


/*!
 @method     
 @abstract   Check if the propertyKey is the key of an ivar and is handled in the user defaults key
 @discussion Check if the propertyKey is the key of an ivar and is handled in the user defaults key
 */
-(BOOL)isValidInstanceAndUserDefaultsProperty:(NSString *)propertyKey;


/*!
 @method     
 @abstract   Reads the user-defaults-key
 @discussion Reads the user-defaults-key for the vcSettings from the config.plist.
 */
-(void)getUserDefaultsKey;

@property (retain) NSNumber * index;
@property (retain,readonly) NSString * userDefaultsKey;
@end
