//
//  CunddITunesTracklistDelegate.m
//  Dive
//
//  Created by Daniel Corn on 06.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddITunesTracklistDelegate.h"


@implementation CunddITunesTracklistDelegate
-(BOOL) tableView:(NSTableView *)tableView shouldTypeSelectForEvent:(NSEvent *)event withCurrentSearchString:(NSString *)searchString{
	NSLog(@"keyDown");
	return YES;
}
-(void) loadTrack:(NSButton *)sender{
	NSLog(@"Load track %@",sender);
	if(sender = loadVc1Button){
		
	}
	/*
	CunddITunesTrack * track = [[self.draggingSourceController selectedObjects] objectAtIndex:0];
	self.cunddDiveVideoChainCollectionController = [[NSApp delegate] cunddDiveVideoChainCollectionController];
	//[self.draggingSourceController.patch loadTrack:track];
	/* */
}

@synthesize draggingSourceController, cunddDiveVideoChainCollectionController,loadVc1Button,loadVc2Button,loadVc3Button;
@end
