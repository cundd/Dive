//
//  CunddUIButtonToggle.m
//  Dive
//
//  Created by Daniel Corn on 25.05.10.
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
