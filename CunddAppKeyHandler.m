//
//  CunddAppKeyHandler.m
//  Dive
//
//  Created by Daniel Corn on 07.05.10.
//  Copyright 2010 cundd. All rights reserved.
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
