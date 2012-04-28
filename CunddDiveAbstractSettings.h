//
//  CunddDiveAbstractSettings.h
//  Dive
//
//  Created by Daniel Corn on 11.05.10.
//
//    Copyright © 2010-2012 Corn Daniel
//
//    This file is part of Dive.
//
//    Dive is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    Foobar is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
//
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
