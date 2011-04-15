//
//  Dice_AppDelegate.m
//
//  Created by Daniel Corn on 31.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "Dice_AppDelegate.h"

@implementation Dice_AppDelegate
- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
	if([[[CunddDiveQuitPanel alloc] init] autorelease]){
		return NSTerminateNow;
	} else {
		return NSTerminateCancel;
	}
	/* */
}
@end
