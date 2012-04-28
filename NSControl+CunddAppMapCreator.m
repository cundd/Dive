//
//  NSControl+CunddAppMapCreator.m
//  Dive
//
//  Created by Daniel Corn on 21.06.10.
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

#import "NSControl+CunddAppMapCreator.h"


@implementation NSControl (CunddAppMapCreator)
/*
+(void)load{
	[self swapMouseDownMethod];
}
// */

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
