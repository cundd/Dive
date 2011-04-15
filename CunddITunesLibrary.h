//
//  CunddITunesLibrary.h
//  Menu
//
//  Created by Daniel Corn on 31.03.10.
//  Copyright 2010 cundd. All rights reserved.
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
