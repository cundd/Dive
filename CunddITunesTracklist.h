//
//  CunddITunesTracklist.h
//  Menu
//
//  Created by Daniel Corn on 12.04.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddITunesTrack.h"
#import <AppKit/NSTableView.h>

/*!
 @class CunddITunesTracklist
 @discussion The class functions as data-object for a bound array-controller to fill a tableview.
 */
@interface CunddITunesTracklist : NSObject <NSTableViewDataSource, NSTableViewDelegate>
{
	NSArray * tracklist;
	IBOutlet NSTableView * tableView;
}

/*!
    @method     
    @discussion Sets the tracklist-property to the given array.
*/
-(void) setTracklistWithArray : (NSArray *) array;

-(BOOL)ifDebug;

@property(retain) NSArray * tracklist;
@property(retain) NSTableView * tableView;

@end
