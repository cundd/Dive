//
//  CunddDiveScreenIndicatorController.m
//
//  Created by Daniel Corn on 17.07.10.
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

#import "CunddDiveScreenIndicatorController.h"

@implementation CunddDiveScreenIndicatorController
-(void) awakeFromNib{
	NSButtonType theType = NSToggleButton;
	[[self.back cell]		setType:theType];
	[[self.top cell]		setType:theType];
	[[self.bottom cell]		setType:theType];
	[[self.front cell]		setType:theType];
	[[self.left cell]		setType:theType];
	[[self.right cell]		setType:theType];
	
	[self setAllOff];
}

- (IBAction)performClick:(NSButton *)sender {
	CunddDiveScreen newScreen;
	
	[self setAllOff];
	[sender setState:NSOnState];
	
	newScreen = [self determineStateFromSender:sender];
	self.view.vcQcPatchController.patch.screen = [NSNumber numberWithInt:newScreen];
}

-(CunddDiveScreen) determineStateFromSender:(id)sender{
	CunddDiveScreen newScreen;
	
	if(sender == self.back){
		newScreen = CunddDiveScreenBack;
	} else 
	if(sender == self.top){
		newScreen = CunddDiveScreenTop;
	} else 
	if(sender == self.bottom){
		newScreen = CunddDiveScreenBottom;
	} else 
	if(sender == self.front){
		newScreen = CunddDiveScreenFront;
	} else 
	if(sender == self.left){
		newScreen = CunddDiveScreenLeft;
	} else 
	if(sender == self.right){
		newScreen = CunddDiveScreenRight;
	}
	return newScreen;
}

-(void) setAllOff{
	[[self.back cell]		setState:NSOffState];
	[[self.top cell]		setState:NSOffState];
	[[self.bottom cell]		setState:NSOffState];
	[[self.front cell]		setState:NSOffState];
	[[self.left cell]		setState:NSOffState];
	[[self.right cell]		setState:NSOffState];
}

@synthesize back,top,bottom,front,left,right,view;
@end

