//
//  CunddDiveScreenIndicatorController.m
//
//  Created by Daniel Corn on 17.07.10.
//  Copyright 2010 cundd. All rights reserved.
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

