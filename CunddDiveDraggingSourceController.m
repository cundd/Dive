//
//  CunddDiveDragAndDropController.m
//  Menu
//
//  Created by Daniel Corn on 16.04.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveDraggingSourceController.h"


@implementation CunddDiveDraggingSourceController
/*!
    @method     
    @abstract   Enable dragging out of app.
    @discussion Checks if tracklistController is specified und enables dragging out of the application.
*/

-(void) awakeFromNib{
	if(!tracklist){
		NSException* myException = [NSException
									exceptionWithName:@"MissingTracklistController"
									reason:@"No tracklist-controller specified"
									userInfo:nil];
		@throw myException;
	}
	[[self.tracklist tableView] setDraggingSourceOperationMask:NSDragOperationEvery forLocal:NO];
	return;
}

- (BOOL)tableView:(NSTableView *)tv writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard*)pboard
{
	BOOL result;
	
	CunddITunesTrack * track = [[self arrangedObjects] objectAtIndex:[rowIndexes firstIndex]];
	NSString * cunddDraggingType = [CunddConfig valueForKeyPath:@"Constants.CunddDive.kCunddDraggingType"];
	
	[pboard declareTypes:[NSArray arrayWithObject:cunddDraggingType] owner:self];
	
	//BOOL result = [pboard setString:[track valueForKey:@"Location"] forType:cunddDraggingType];
	if([track isKindOfClass:[CunddITunesTrack class]]){
		result = [pboard setPropertyList:track.trackinfo forType:cunddDraggingType];
	} else {
		result = NO;
	}
	
	
	return result;
}

/*
- (NSDragOperation)tableView:(NSTableView*)tv validateDrop:(id <NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)op
{
    // Add code here to validate the drop
    NSLog(@"validate Drop");
    return NSDragOperationEvery;
}
- (BOOL)tableView:(NSTableView *)aTableView acceptDrop:(id <NSDraggingInfo>)info
			  row:(NSInteger)row dropOperation:(NSTableViewDropOperation)operation
{
    NSPasteboard* pboard = [info draggingPasteboard];
    NSData* rowData = [pboard dataForType:MyPrivateTableViewDataType];
    NSIndexSet* rowIndexes = [NSKeyedUnarchiver unarchiveObjectWithData:rowData];
    NSInteger dragRow = [rowIndexes firstIndex];
	
    // Move the specified row to its new location...
}
 /* */
@synthesize tracklist;//,useSpecialDragType;
@end
