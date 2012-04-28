//
//  CunddAppKeyHandler.m
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

#import "CunddAppKeyHandler.h"


@implementation CunddAppKeyHandler
+(CunddAppKeyHandler *)defaultHandler{
    static CunddAppKeyHandler *defaultHandlerInstance = NULL;
	
    @synchronized(self) {
        if (defaultHandlerInstance == NULL)
            defaultHandlerInstance = [[self alloc] init];
    }
    return (defaultHandlerInstance);
}


+(BOOL) performKeyEquivalent:(NSEvent *)theEvent{
	if([self handleEvent:theEvent]){
		return YES;
	} else {
		return NO;
	}
}


+(NSEvent *) handleEvent:(NSEvent *)aEvent{
	return [[self defaultHandler] handleEvent:aEvent];
}


-(NSEvent *) handleEvent:(NSEvent *)aEvent{
	[self debug:@"HandleEvent: %@ with modifierFlags: %@" o:aEvent o:[NSNumber numberWithInt:[aEvent modifierFlags]]];
	
	NSString * key = [aEvent charactersIgnoringModifiers];
	if([aEvent modifierFlags] & NSCommandKeyMask){
		key = [NSString stringWithFormat:@"cmd%@",key];
	}
	NSString * notificationName = [self.keyToNotificationMap objectForKey:key];
	
	
	[self debug:@"Search for key %@" o:key];
	if(notificationName){
		[self debug:@"CunddAppKeyHandler postNotification: %@" o:notificationName];
		[[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:aEvent];
		return aEvent;
	}
	
	return nil;
}


-(NSString *) userDefaultsKey{
	if(!userDefaultsKey){
		userDefaultsKey = [CunddConfig stringForKeyPath:@"Constants.CunddApp.CunddAppKeyHandler.kUserDefaultsKey"];
	}
	return userDefaultsKey;
}


-(void) readUserDefaults{
	// Load userDefaults
	NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
	
	NSMutableDictionary * appDefaults = [CunddConfig valueForKeyPath:@"Defaults.CunddApp.CunddAppKeyHandler.DefaultKeyToNotificationMap"];
	[userDefaults registerDefaults:
	 [NSDictionary dictionaryWithObject:appDefaults forKey:self.userDefaultsKey]
	 ];
	
	self.keyToNotificationMap = [userDefaults dictionaryForKey:self.userDefaultsKey];
}
-(NSDictionary *) keyToNotificationMap{
	if(!keyToNotificationMap){
		[self readUserDefaults];
	}
	return keyToNotificationMap;
}

@synthesize keyToNotificationMap,userDefaultsKey;
@end
