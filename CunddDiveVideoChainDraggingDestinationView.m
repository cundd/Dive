//
//  CunddDiveVideoChainDraggingDestinationView.m
//  Dive
//
//  Created by Daniel Corn on 22.04.10.
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
// */



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
