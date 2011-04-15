//
//  CunddPunchButton.m
//  Dive
//
//  Created by Daniel Corn on 19.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddUIButtonPunch.h"


@implementation CunddUIButtonPunch
-(void) mouseDown:(NSEvent *)theEvent{
	if(!controller)return;
	
	self.oldValue = [self.controller valueForKeyPath:[self controllerKeyPath]];
	
	[self.controller setValue:[self newValue] forKeyPath:[self controllerKeyPath]];
	
	[[self cell]setState:NSOnState];
	[self updateCell:[self cell]];
	
	// Draw the click-animation
	[super mouseDown:theEvent];
	
	if([self keepWhenPressReturn]){
		
	}
	
	// Call -mouseUp
	[self mouseUp:theEvent];
}


-(void) mouseUp:(NSEvent *)theEvent{
	if(!controller)return;
	
	[self.controller setValue:[self oldValue] forKeyPath:[self controllerKeyPath]];
	//[super mouseUp:theEvent];
}
-(void) keyDown:(NSEvent *)theEvent{
	NSLog(@"%@",theEvent);
}

-(BOOL) keepWhenPressReturn{
	return YES;
}
@synthesize oldValue;
@end
