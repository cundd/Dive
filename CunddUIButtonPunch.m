//
//  CunddPunchButton.m
//  Dive
//
//  Created by Daniel Corn on 19.05.10.
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
