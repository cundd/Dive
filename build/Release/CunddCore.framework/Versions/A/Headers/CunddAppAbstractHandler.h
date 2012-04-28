//
//  CunddAppAbstractHandler.h
//  Dive
//
//  Created by Daniel Corn on 18.06.10.
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


@interface CunddAppAbstractHandler : CunddObject {
	NSDictionary * map;
}

extern NSString * const kCunddAppKeyHandlerPath;
extern NSString * const kCunddAppMIDIHandlerPath;


/*!
 @method     
 @abstract   Returns the default handler-instance
 @discussion Returns the default handler-instance
 */
+(id)defaultHandler;


/*!
 @method     
 @abstract   Post a notification if one is assigned to the event.
 @discussion Post a notification if one is assigned to the event.
 */
+(NSEvent *)handleEvent:(NSEvent *)aEvent;


/*!
 @method     
 @abstract   Post a notification if one is assigned to the event.
 @discussion Post a notification if one is assigned to the event.
 */
-(NSEvent *)_handleEvent:(NSEvent *)aEvent;


/*!
    @method     
    @abstract   Returns if the given key could have been mapped and posts a notification if YES.
    @discussion Returns if the given key could have been mapped and posts a notification if YES.
*/
-(BOOL)handleMapKey:(id)theMapKey withObject:(id)theObject;


/*!
    @method     
    @abstract   Returns the key to search in the map dictionary.
    @discussion Returns the key to search in the map dictionary. This method is called every time a event is recognized and the key is extracted from the event regarding to the type of handler.
*/
-(id)getKeyFromCurrentEvent:(NSEvent *)aEvent;


/*!
    @method     
    @abstract   Return the correct path for default values.
    @discussion Return the correct path for default values.
*/
-(NSString *)defaultsPath;


/*!
 @method     
 @abstract   Reads the user-defaults
 @discussion Reads the user-defaults
 */
-(void)readUserDefaults;


@property (retain) NSDictionary * map;
@end
