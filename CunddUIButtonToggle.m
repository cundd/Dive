//
//  CunddUIButtonToggle.m
//  Dive
//
//  Created by Daniel Corn on 25.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddUIButtonToggle.h"


@implementation CunddUIButtonToggle
-(void) mouseDown:(NSEvent *)theEvent{
	id tempValue;
	
	state = (CunddUIButtonState)++state;
	
	if(state == CunddUIButtonStateMax){
		state == (CunddUIButtonState)0;
	}
	
	
	// Send the action regarding the current state
	SEL actionSelector = NSSelectorFromString([NSString stringWithFormat:@"performSetState%i:",state]);
	[self sendAction:actionSelector to:[[self cell] target]];
	
	
	
	/* The mouseDown method allways sets the value to oldValue. If oldValue isn't set it is the first time 
	 the button is clicked. At this time oldValue will be set to newValue.
	 */
	if(!oldValue){
		self.oldValue = self.newValue;
	}
	
	tempValue = [self.oldValue copy];
	self.oldValue = [self.controller valueForKeyPath:[self controllerKeyPath]];
	[self.controller setValue:tempValue forKeyPath:[self controllerKeyPath]];
	[tempValue release];
	[super mouseDown:theEvent];
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
@synthesize state,controller,oldValue;
@end
