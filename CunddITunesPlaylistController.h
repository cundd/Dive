//
//  CunddITunesPlaylistController.h
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
