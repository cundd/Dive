//
//  CunddAppAbstractHandler.m
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

#import "CunddAppAbstractHandler.h"


@implementation CunddAppAbstractHandler

NSString * const kCunddAppKeyHandlerPath = @"CunddApp.CunddAppKeyHandler";
NSString * const kCunddAppMIDIHandlerPath = @"CunddApp.CunddAppMIDIHandler";

+(id)defaultHandler{
    static id defaultHandlerInstance = NULL;
	
    @synchronized(self) {
        if (defaultHandlerInstance == NULL)
            defaultHandlerInstance = [[[self alloc] init] autorelease];
    }
    return defaultHandlerInstance;
}

/*
+(BOOL) performKeyEquivalent:(NSEvent *)theEvent{
	if([self handleEvent:theEvent]){
		return YES;
	} else {
		return NO;
	}
}
// */

+(NSEvent *) handleEvent:(NSEvent *)aEvent{
	return [[self defaultHandler] _handleEvent:aEvent];
}


-(NSEvent *) _handleEvent:(NSEvent *)aEvent{
	[self debug:@"HandleEvent: %@ with modifierFlags: %@" o:aEvent o:[NSNumber numberWithInt:[aEvent modifierFlags]]];
	
	id theMapKey = [self getKeyFromCurrentEvent:aEvent];
	if([self handleMapKey:theMapKey withObject:aEvent]){
		return aEvent;
	}
	
	return nil;
}

-(BOOL) handleMapKey:(id)theMapKey withObject:(id)theObject{
	[self debug:@"Search for key %@" o:theMapKey];

	// Lookup the map if the is an notification name for the given key
	NSString * notificationName = [self.map objectForKey:theMapKey];
	
	// If a notification name was found post the notification and return YES
	if(notificationName){
		[self debug:@"CunddAppKeyHandler postNotification: %@" o:notificationName];
		
		if(!theObject) theObject = self;
		
		[[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:theObject];
		return YES;
	}
	return NO;
}


-(NSString *)defaultsPath{
	/* Return the correct path. For example kCunddAppMIDIHandlerPath oder kCunddAppKeyHandlerPath */
	[self throw:@"-defaultsPath not overwritten"];
	return @"";
}

-(id) getKeyFromCurrentEvent:(NSEvent *)aEvent{
	/* Return the key which will be searched in the map */
	/* EXAMPLE:
	 * NSString * key = [aEvent charactersIgnoringModifiers];
	 * if([aEvent modifierFlags] & NSCommandKeyMask){
	 *	key = [NSString stringWithFormat:@"cmd%@",key];
	 * }
	 */
	[self throw:@"-getKeyFromCurrentEvent not overwritten"];	
	return @"";
}


-(void) readUserDefaults{
	// Load userDefaults
	NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
	NSMutableDictionary * appDefaults = [CunddConfig valueForKeyPath:[NSString stringWithFormat:@"Defaults.%@.map",[self defaultsPath]]];
	
	[userDefaults registerDefaults:
		[NSDictionary dictionaryWithObject:appDefaults forKey:[NSString stringWithFormat:@"%@.map",[self defaultsPath]]]
	 ];
	
	self.map = [userDefaults dictionaryForKey:[NSString stringWithFormat:@"%@.map",[self defaultsPath]]];
}
-(NSDictionary *) map{
	if(!map){
		[self readUserDefaults];
	}
	return map;
}

-(id) autorelease{
	return self;
}
-(NSUInteger) retainCount{
	return NSUIntegerMax;
}

@synthesize map;

@end
