//
//  CunddAppKeyHandler.h
//  Dive
//
//  Created by Daniel Corn on 07.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddObject.h"


@interface CunddAppKeyHandler : CunddObject {
	NSDictionary * keyToNotificationMap;
	NSString * userDefaultsKey;
}
/*!
 @method     
 @abstract   Returns the default handler-instance
 @discussion Returns the default handler-instance
 */
+(CunddAppKeyHandler *)defaultHandler;


/*!
    @method     
    @abstract   Tries to preform an application wide key equivalent
    @discussion Tries to preform an application wide key equivalent
*/
+(BOOL) performKeyEquivalent:(NSEvent *)theEvent;


/*!
    @method     
    @abstract   Post a notification if one is assigned to the event's char property
    @discussion Post a notification if one is assigned to the event's char property
*/
+(NSEvent *)handleEvent:(NSEvent *)aEvent;


/*!
    @method     
    @abstract   Post a notification if one is assigned to the event's char property
    @discussion Post a notification if one is assigned to the event's char property
*/
-(NSEvent *)handleEvent:(NSEvent *)aEvent;

/*!
    @method     
    @abstract   Reads the user-defaults
    @discussion Reads the user-defaults
*/
-(void)readUserDefaults;

@property (retain) NSDictionary * keyToNotificationMap;
@property (retain,readonly) NSString * userDefaultsKey;
@end
