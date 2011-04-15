/*
 *  Cundd.h
 *  Menu
 *
 *  Created by Daniel Corn on 02.04.10.
 *  Copyright 2010 cundd. All rights reserved.
 *
 */

#import "CunddObject.h"
#import "CunddView.h"
#import "CunddViewController.h"
#import "CunddColorConverter.h"

@interface Cundd : NSObject {
	
}
/*!
    @method     
    @abstract   Terminates the application.
    @discussion Calls -terminate: on NSApp with nil as the argument.
*/
+(void) die;

/*!
    @method     
    @abstract   Outputs the message and terminates the application.
    @discussion Outputs the message and terminates the application.
*/

+(void) die:(NSString *)msg;

/*!
    @method     
    @abstract   Outputs the message and terminates the application.
    @discussion Outputs the message and terminates the application. msg is expected to be a format string.
*/
+(void) die:(NSString *)msg o:(id)aObject;


/*!
    @method     
    @abstract   Throws an exception with the given name.
    @discussion Throws an exception with the given name.
*/
+(void) throw:(NSString *)exceptionName;

/*!
    @method     
    @abstract   Throws an exception with the given name and reason.
    @discussion Throws an exception with the given name and reason.
*/
+(void) throw:(NSString *)exceptionName reason:(NSString *)aReason;
@end