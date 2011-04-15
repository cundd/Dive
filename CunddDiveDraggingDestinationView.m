//
//  CunddDiveDraggingTargetController.m
//  Menu
//
//  Created by Daniel Corn on 19.04.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveDraggingDestinationView.h"


@implementation CunddDiveDraggingDestinationView
-(void) awakeFromNib{
	NSString * cunddDraggingType = [CunddConfig valueForKeyPath:@"Constants.CunddDive.kCunddDraggingType"];
	if([CunddConfig isTrue:@"Defaults.CunddDive.CunddDiveDraggingDestinationView.AcceptDropFromFinder"]){
		[self registerForDraggedTypes:[NSArray arrayWithObjects:cunddDraggingType,NSFilenamesPboardType,nil]];
	} else {
		[self registerForDraggedTypes:[NSArray arrayWithObject:cunddDraggingType]];
	}
	return;
}


- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
	NSPasteboard *pboard = [sender draggingPasteboard];
	NSString * cunddDraggingType = [CunddConfig valueForKeyPath:@"Constants.CunddDive.kCunddDraggingType"];
	if([[pboard types]containsObject:cunddDraggingType]){
		return NSDragOperationGeneric;
	} else 
	if([CunddConfig isTrue:@"Defaults.CunddDive.CunddDiveDraggingDestinationView.AcceptDropFromFinder"] && [[pboard types]containsObject:NSFilenamesPboardType]){
		return NSDragOperationEvery;
	}
	return NSDragOperationNone;
}


-(BOOL)performDragOperation:(id <NSDraggingInfo>)sender{
	NSPasteboard * pboard = [sender draggingPasteboard];
	NSString * filePath;
	NSString * cunddDraggingType = [CunddConfig valueForKeyPath:@"Constants.CunddDive.kCunddDraggingType"];
	
	if([[pboard types] containsObject:cunddDraggingType]){
		filePath = [pboard stringForType:cunddDraggingType];
		return YES;
	} else 
	if([CunddConfig isTrue:@"Defaults.CunddDive.CunddDiveDraggingDestinationView.AcceptDropFromFinder"] && [[pboard types]containsObject:NSFilenamesPboardType]){
		filePath = [pboard stringForType:NSFilenamesPboardType];
		return YES;
	}
	return NO;
}


-(void) drawRect:(NSRect)dirtyRect{
	[[NSColor blackColor]setFill];
	
	NSBezierPath * newPath = [NSBezierPath bezierPathWithRect:dirtyRect];
	newPath.fill;
	return;
}
@end
