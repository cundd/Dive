//
//  CunddDiveVCUnload.m
//
//  Created by Daniel Corn on 20.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveVCUnload.h"

@implementation CunddDiveVCUnload
/*
-(void) mouseDown:(NSEvent *)theEvent{
	// [super mouseDown:theEvent];
	if(self.qcPatchController){
		[self.qcPatchController.view stop:self];
	}
	
	[super mouseDown:theEvent];
	
	// Call -mouseUp
	[self mouseUp:theEvent];
}
/* */

-(id) newValue{
	return @"unloaded";
}
-(NSString *) controllerKeyPath{
	return @"patch.movieLocation";
}

@synthesize qcPatchController;
@end
