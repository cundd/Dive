//
//  CunddITunesPlaylistController.h
//  Menu
//
//  Created by Daniel Corn on 31.03.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
//#import "CunddITunes.h"
#import "CunddITunesLibrary.h"
#import "CunddITunesTracklist.h"

extern NSString * const kCunddUserDefaultsKeyForPlaylistArray;

@interface CunddITunesPlaylistController : NSObject <NSOutlineViewDataSource, NSOutlineViewDelegate>
{
	CunddITunesLibrary * library;
	IBOutlet CunddITunesTracklist * tracklist;
@private
	NSOutlineView * _outlineView;
}

-(id) getRootItem;
-(id) getRootItemIfItemIsNil : (id) item;
-(void)initOutlineView:(NSOutlineView *)outlineView;
-(void)updateSelectionInUserDefaults;
-(BOOL)ifDebug;

/*!
    @method     
    @abstract   Invokes the tracklist's -setTracklistWithArray method
    @discussion Invokes the tracklist's -setTracklistWithArray method
*/
-(void)updateTracklistWithArray:(NSArray *)aArray;

@property(retain) CunddITunesLibrary * library;
@property(retain) CunddITunesTracklist * tracklist;
@end
