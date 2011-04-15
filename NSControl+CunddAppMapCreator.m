//
//  NSControl+CunddAppMapCreator.m
//  Dive
//
//  Created by Daniel Corn on 21.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "NSControl+CunddAppMapCreator.h"


@implementation NSControl (CunddAppMapCreator)
/*
+(void)load{
	[self swapMouseDownMethod];
}
/* */

+(void)swapMouseDownMethod{
	/* Information and thanks to: http://blog.jayway.com/2010/05/25/rewriting-a-public-cocoa-touch-api/ 
	 * http://www.cocoadev.com/index.pl?MethodSwizzling
	 */
	Method originalMouseDown	= class_getInstanceMethod(self, @selector(mouseDown:));
	Method newMouseDown			= class_getInstanceMethod(self, @selector(recordingMouseDown:));
	method_exchangeImplementations(originalMouseDown, newMouseDown);
}

-(void) recordingMouseDown:(NSEvent *)theEvent{
	NSString * recording = [CunddAppRegistry registry:kCunddAppMapCreatorRecording];
	// Check if recording mode is on
	if(recording){
		if([recording intValue] == 1){
			CunddAppAbstractMapCreator * mapCreator = [CunddAppRegistry registry:kCunddAppMapCreatorCurrent];
			
			// Check if the control is able to stop the recording
			if([self isKindOfClass:[CunddUIButtonAppMapCreatorRecord class]]){
				NSLog(@"CunddUIButtonAppMapCreatorRecord");
				[self recordingMouseDown:theEvent]; // The original -mouseDown
				// [mapCreator stopRecording];
			} else 
			if([mapCreator recordControl:self withEvent:theEvent]){ // Record this control
				return;
			}
		}
	}
}

@end
