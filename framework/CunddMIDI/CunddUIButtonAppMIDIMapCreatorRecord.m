//
//  CunddUIButtonAppMIDIMapCreator.m
//  CunddMIDI
//
//  Created by Daniel Corn on 22.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddUIButtonAppMIDIMapCreatorRecord.h"


@implementation CunddUIButtonAppMIDIMapCreatorRecord

NSString * const kCunddUIButtonAppMIDIMapCreatorRecordTitle_clearDefaults = @"Clear defaults";

-(void) mouseDown:(NSEvent *)theEvent{
	[super mouseDown:theEvent];
	
	if([theEvent modifierFlags] & NSAlternateKeyMask){
		[self.mapCreator clearDefaults];
	} else 
	if(self.mapCreator.recording){
		NSLog(@"Stop rec");
		[self setTitle:@"Start recording"];
		//[self setState:NSOnState];
		[self.mapCreator stopRecording];
	} else {
		NSLog(@"Start rec");
		[self setTitle:@"Stop recording"];
		//[self setState:NSOnState];
		[self.mapCreator startRecording];
	}
}


-(void)mouseEntered:(NSEvent *)theEvent{
	if([theEvent modifierFlags] & NSAlternateKeyMask){
				_oldTitle = [self title];
		[self setTitle:kCunddUIButtonAppMIDIMapCreatorRecordTitle_clearDefaults];
	}
	[super mouseEntered:theEvent];
}

-(void)mouseExited:(NSEvent *)theEvent{
	if([self title] == kCunddUIButtonAppMIDIMapCreatorRecordTitle_clearDefaults){
		[self setTitle:_oldTitle];
	}
	[super mouseExited:theEvent];
}

-(CunddAppMIDIMapCreator *) mapCreator{
	if(!mapCreator){
		[self setMapCreator:[CunddAppMIDIMapCreator sharedInstance]];
	}
	return mapCreator;
}
@synthesize mapCreator;
@end
