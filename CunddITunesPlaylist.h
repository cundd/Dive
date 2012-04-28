//
//  Playlist.h
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
//#import "CunddITunesLibrary.h"
#import "Cundd.h"


@interface CunddITunesPlaylist : NSObject
{
    NSString * name;
    NSNumber * playlistId;
    NSNumber * playlistLocalId;
    NSString * playlistPersistentId;
    NSString * parentPersistentId;
    bool folder;
    NSMutableArray * children;
    @private
    NSMutableArray * playlistItems;
    NSArray * tracklist;

}

+(CunddITunesPlaylist *) playlistWithDictionary : (NSDictionary *) dictionary;
-(CunddITunesPlaylist *) initWithDictionary : (NSDictionary *) dictionary;
+(CunddITunesPlaylist *) rootPlaylistWithChildrenArray : (NSMutableArray *) newChildren;
-(CunddITunesPlaylist *) initRootPlaylistWithChildrenArray : (NSMutableArray *) newChildren;
+(CunddITunesPlaylist *) rootPlaylistWithoutChildren;
-(CunddITunesPlaylist *) initRootPlaylistWithoutChildren;
-(NSInteger) count;
-(id) objectAtIndex : (NSUInteger) index;
-(void) addObject : (id) object;
-(BOOL) isItemExpandable;
-(BOOL) isFolder;
/*!
    @method     
    @abstract   Returns the tracklist
    @discussion Returns the tracklist read from the given library
*/
-(NSArray *) getTracksFromCunddITunesLibrary: (id) library;
/*!
 @method     
 @abstract   Returns the tracklist and tell the sender to refresh its data
 @discussion Returns the tracklist and tell the sender (most likely CunddITunesPlaylistController) to refresh its data
 */
-(NSArray *) getTracksFromCunddITunesLibrary: (id) library fromSender:(id)sender;
//-(NSArray *)getTracksFromTracksArray:(NSMutableArray *)tracksarray;


@property(retain) NSString *name, *playlistPersistentId, *parentPersistentId;
@property(retain) NSNumber *playlistId, *playlistLocalId;
@property(assign) bool folder;
@property(retain) NSMutableArray *playlistItems, *children;
@property(retain) NSArray *tracklist;
@end
