//
//  CunddDiveDraggingTargetController.m
//  Menu
//
//  Created by Daniel Corn on 19.04.10.
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
	[newPath fill];
	return;
}
@end
