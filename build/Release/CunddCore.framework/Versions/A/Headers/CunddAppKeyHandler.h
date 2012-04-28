//
//  CunddAppKeyHandler.h
//  Dive
//
//  Created by Daniel Corn on 07.05.10.
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
