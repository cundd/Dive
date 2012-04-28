//
//  CunddITunesLibrary.h
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
#import "CunddITunesTrack.h"
#import "CunddITunesPlaylist.h"
#import "CunddConfig.h"

@interface CunddITunesLibrary : NSObject
{
    NSMutableArray *tracks;
    NSMutableDictionary *trackDictionary;
    CunddITunesPlaylist *playlistRoot;
    NSMutableDictionary *originalLibrary;
    @private
    NSString *libraryPath;
}

-(void) readTracksFromLibrary;
-(void) readPlaylistsFromLibrary;
-(BOOL) checkIfLibraryExistsAtPath : (NSString *) path;
-(void) createParentChildStructureWithPlaylists : (NSArray *) playlistsTemp;
-(NSInteger) count;
-(NSDictionary *) getTracksAsDictionary;
-(CunddITunesTrack *) getTrackWithId : (NSString *) trackId;
-(CunddITunesTrack *) getTrackAt : (NSInteger) trackIndex;
-(BOOL)ifDebug;
@property(retain) NSMutableDictionary *originalLibrary, *trackDictionary;
@property(retain) NSMutableArray *tracks;
@property(retain) CunddITunesPlaylist *playlistRoot;
@property(retain) NSString *libraryPath;

@end
