//
//  CunddSetButton.m
//  Dive
//
//  Created by Daniel Corn on 20.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddUIButtonSetter.h"


@implementation CunddUIButtonSetter
-(void) mouseDown:(NSEvent *)theEvent{
	if(!controller){
		NSLog(@"CunddSetButton: No controller set");
		return;
	}
	
	[self.controller setValue:[self newValue] forKeyPath:[self controllerKeyPath]];
	
	// Draw the click-animation
	[super mouseDown:theEvent];
	
	// Call -mouseUp
	[self mouseUp:theEvent];
}


-(NSValue *) newValue{
	NSException* myException = [NSException
								exceptionWithName:@"newValueNotSet"
								reason:@"The method -newValue hasn't been overwritten"
								userInfo:nil];
	@throw myException;
}


-(NSString *) controllerKeyPath{
	NSException* myException = [NSException
								exceptionWithName:@"controllerKeyPathNotSet"
								reason:@"The method -controllerKeyPath hasn't been overwritten"
								userInfo:nil];
	@throw myException;
}

@synthesize controller;
@end
