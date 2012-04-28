//
//  CunddITunesPlaylistController.m
//  Menu
//
//  Created by Daniel Corn on 31.03.10.
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

#import "CunddITunesPlaylistController.h"

@implementation CunddITunesPlaylistController

NSString * const kCunddUserDefaultsKeyForPlaylistArray = @"kCunddUserDefaultsKeyForPlaylistArray";
- (id) init {
    if ([super init]) {
        // Initializing the library
        self.library = [[CunddITunesLibrary alloc]init];
        [self.library retain];
        [self retain];
    }
    return self;
}

// Reading the data
#pragma mark reading the data

-(id) outlineView : (NSOutlineView *) outlineView child : (NSInteger) index ofItem : (id) item {
    item = [self getRootItemIfItemIsNil : item];
    if (self.ifDebug)NSLog(@"child of item %@ with type %s", [item name], object_getClassName(item));
    [item objectAtIndex : index];
    return [item objectAtIndex : index];
}

-(BOOL) outlineView : (NSOutlineView *) outlineView isItemExpandable : (id) item {
    item = [self getRootItemIfItemIsNil : item];
    if (self.ifDebug)NSLog(@"isItemExpandable get item %@", item);
    return [item isItemExpandable];
}

-(NSInteger) outlineView : (NSOutlineView *) outlineView numberOfChildrenOfItem : (id) item {
	if(_outlineView == nil) [self initOutlineView:outlineView];
    item = [self getRootItemIfItemIsNil : item];

    //	NSLog(@"%@",[item children]);
    //	NSLog(@"numberOfChildrenOfItem get item %@",[item valueForKey:@"name"]);
    [item count];
    //	NSLog(@"numberOfChildrenOfItem get item count %i",[item count]);
    return [item count];
}

-(id) outlineView : (NSOutlineView *) outlineView objectValueForTableColumn : (NSTableColumn *) tableColumn byItem : (id) item {
    item = [self getRootItemIfItemIsNil : item];
    NSString *columnIdentifier = [tableColumn identifier];
    if (self.ifDebug)NSLog(@"objectValueForTableColumn %@ item %@", columnIdentifier, item);
    return [item valueForKey : columnIdentifier];
}

-(id) getRootItemIfItemIsNil : (id) item {
    if (item == nil) {
        item = [self getRootItem];
    }
    [item retain];
    return item;
}

-(id) getRootItem {
    return self.library.playlistRoot;
}


// Writing data
#pragma mark writing data

-(void) outlineView : (NSOutlineView *) outlineView setObjectValue : (id) object forTableColumn : (NSTableColumn *) tableColumn byItem : (id) item {
}


// Delegate methods
#pragma mark delegate methods

-(void) outlineViewSelectionDidChange : (NSNotification *) notification {
	if(self.ifDebug)NSLog(@"PlaylistController outlineViewSelectionDidChange %@",self.tracklist);
	if(tracklist == nil){
		NSException* myException = [NSException
									exceptionWithName:@"MissingTracklist"
									reason:@"No tracklist specified"
									userInfo:nil];
		@throw myException;
	}
	
	[self updateSelectionInUserDefaults];
	id caller = [notification object];
	CunddITunesPlaylist * selectedItem = [caller itemAtRow : [caller selectedRow]];
	NSArray * tracklistTemp = [selectedItem getTracksFromCunddITunesLibrary:self.library fromSender:self];
	
	[self.tracklist setTracklistWithArray: tracklistTemp];
	return;
}

-(void)initOutlineView:(NSOutlineView *)outlineView{
	_outlineView = outlineView;

	// Load the last selected playlist
	// @TODO: rows to select doesn't exist at this time
	/*
	NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
	NSNumber * defaultPlaylist = [userDefaults valueForKey:kCunddUserDefaultsKeyForPlaylistArray];
	if(defaultPlaylist){
		[_outlineView selectRowIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(4, 0)] byExtendingSelection:NO];
		NSLog(@"set defaultPlaylist");
	}
	// */
	return;
}

-(void)updateSelectionInUserDefaults{
	NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
	NSNumber * valueToStore = [NSNumber numberWithInt:[[_outlineView selectedRowIndexes] firstIndex]];
	[userDefaults setObject:valueToStore forKey:kCunddUserDefaultsKeyForPlaylistArray];
	return;
}

-(void) updateTracklistWithArray:(NSArray *)aArray{
	[self.tracklist setTracklistWithArray:aArray];
}


-(BOOL)ifDebug{
	if([[CunddConfig valueForKeyPath : @"Debug.CunddITunes.PlaylistController"]boolValue] == 0){
		return NO;
	} else {
		return YES;
	}
}


@synthesize library, tracklist;
@end
