//
//  CunddUISegmentedControlAppMIDIMapCreatorRecord.m
//  CunddMIDI
//
//  Created by Daniel Corn on 24.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddUISegmentedControlAppMIDIMapCreatorRecord.h"


@implementation CunddUISegmentedControlAppMIDIMapCreatorRecord
NSString * const kCunddUIButtonAppMIDIMapCreatorRecordTitle_clearDefaults = @"Clear defaults";

-(void) mouseDown:(NSEvent *)theEvent{
	[super mouseDown:theEvent];
	
	if([theEvent modifierFlags] & NSAlternateKeyMask){
		[self.mapCreator clearDefaults];
	} else 
		if(self.mapCreator.recording){
			NSLog(@"Stop rec");
			//[self setState:NSOnState];
			[self.mapCreator stopRecording];
		} else {
			NSLog(@"Start rec");
			//[self setState:NSOnState];
			[self.mapCreator startRecording];
		}
}



-(CunddAppMIDIMapCreator *) mapCreator{
	if(!mapCreator){
		[self setMapCreator:[CunddAppMIDIMapCreator sharedInstance]];
	}
	return mapCreator;
}
@synthesize mapCreator;
@end
