//
//  CunddDiveVideoChainDraggingDestinationView.m
//  Dive
//
//  Created by Daniel Corn on 22.04.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveVideoChainDraggingDestinationView.h"


@implementation CunddDiveVideoChainDraggingDestinationView
-(void) awakeFromNib{
	[super awakeFromNib];
	NSLog(@"CunddDiveVideoChainDraggingDestinationView awakeFromNib");
}
/*
-(void) viewDidMoveToWindow{
	NSLog(@"viewDidMoveToWindow");
	NSTrackingRectTag trTag = [self addTrackingRect:[self bounds]
							owner:self
						 userData:nil
					 assumeInside:NO];
}
/* */



#pragma mark Drag & Drop
/*
-(NSDragOperation) draggingEntered:(id <NSDraggingInfo>)sender{
	NSLog(@"Drag entered");
	return NSDragOperationEvery;
}
-(NSDragOperation) draggingUpdated:(id <NSDraggingInfo>)sender{
	NSLog(@"Drag updated");
	return NSDragOperationEvery;
}

-(BOOL) prepareForDragOperation:(id <NSDraggingInfo>)sender{
	NSLog(@"prepare for drag");
	return YES;
}
 */


-(BOOL) performDragOperation:(id <NSDraggingInfo>)sender{
//	[super performDragOperation:sender];
	
	if(!self.vcController){
		@throw [NSException exceptionWithName:@"vcSettings is not defined" reason:@"vcSettings is not defined" userInfo:nil];
		[NSApp terminate:nil];
	}
	
	NSPasteboard * pboard = [sender draggingPasteboard];
	NSString * cunddDraggingType = [CunddConfig valueForKeyPath:@"Constants.CunddDive.kCunddDraggingType"];
	
	if([[pboard types] containsObject:cunddDraggingType]){
		NSDictionary * trackinfo = [pboard propertyListForType:cunddDraggingType];
		[self.vcController.patch loadTrack:[CunddITunesTrack trackWithDictionary:trackinfo]];
		return YES;
	} else
	if([CunddConfig isTrue:@"Defaults.CunddDive.CunddDiveDraggingDestinationView.AcceptDropFromFinder"] && [[pboard types]containsObject:NSFilenamesPboardType]){
		NSArray *fileArray = [pboard propertyListForType:@"NSFilenamesPboardType"];
		NSString * location = [fileArray objectAtIndex:0];
		
		[self.vcController.patch loadTrack:[CunddITunesTrack emptyTrackWithMovieLocation:location]];
		// [self.vcController setValue:location forKey:@"movieLocation"];
		return YES;
	}
	return NO;
}

@synthesize vcController;
@end
