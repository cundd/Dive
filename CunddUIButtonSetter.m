//
//  CunddSetButton.m
//  Dive
//
//  Created by Daniel Corn on 20.05.10.
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
