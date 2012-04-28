//
//  CunddObject.h
//  Dive
//
//  Created by Daniel Corn on 23.04.10.
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
#import "CunddConfig.h"

/*!
    @class
    @abstract    The Cundd-base-class
    @discussion  The class provides basic-features for the Cundd-environment.
*/
@interface CunddObject : NSObject {

@private
	BOOL _cunddObject_debug;
	BOOL _cunddObject_debug_determined;
}


/*!
    @method     
    @abstract   Check if the debug-value for this class is set to TRUE in the config-file
    @discussion Check if the debug-value for this class is set to TRUE in the config-file
*/
-(BOOL)ifDebug;


/*!
 @method     
 @abstract   Calls NSLog if the ifDebug-method returns true
 @discussion Calls NSLog if the ifDebug-method returns true
 */
-(void)debug:(NSString *)msg o:(id)object o:(id)object2;


/*!
 @method     
 @abstract   Calls NSLog if the ifDebug-method returns true
 @discussion Calls NSLog if the ifDebug-method returns true
 */
-(void)debug:(NSString *)msg o:(id)object;
//-(void)debug:(NSString *)msg o:(id)object, ... NS_REQUIRES_NIL_TERMINATION;


/*!
 @method     
 @abstract   Calls NSLog if the ifDebug-method returns true
 @discussion Calls NSLog if the ifDebug-method returns true
 */
-(void)debug:(NSString *)msg;

/*!
    @method     
    @abstract   Returns the properties of the class as an array
    @discussion Returns the properties of the class as an array. Thanks to oxigen @ http://stackoverflow.com/users/91674/oxigen
*/
-(NSArray *)cundd_getPropertyList;


/*!
    @method     
    @abstract   Terminates the app
    @discussion Terminates the app
*/
-(void)die;
/*!
    @method     
    @abstract   Terminates the app after printing a message in the Console
    @discussion Terminates the app after printing a message in the Console
*/
-(void)die:(NSString *)msg;
/*!
    @method     
    @abstract   Terminates the app after printing a message in the Console
    @discussion Terminates the app after printing a message in the Console
*/
-(void)die:(NSString *)msg o:(id)aObject;


/*!
    @method     
    @abstract   Throws an exception with a given name
    @discussion Throws an exception with a given name
*/
-(void)throw:(NSString *)exceptionName;


/*!
    @method     
    @abstract   Throws an exception with a given name and reason
    @discussion Throws an exception with a given name and reason
*/
-(void)throw:(NSString *)exceptionName reason:(NSString *)aReason;
@end
