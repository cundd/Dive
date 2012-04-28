//
//  CunddITunesLibrary.m
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

#import "CunddITunesLibrary.h"


@implementation CunddITunesLibrary
+(CunddITunesLibrary *) sharedCunddITunesLibrary {
    static CunddITunesLibrary *sharedCunddITunesLibraryInstance = NULL;

    @synchronized(self) {
        if (sharedCunddITunesLibraryInstance == NULL)
            sharedCunddITunesLibraryInstance = [[self alloc] init];
    }
    return (sharedCunddITunesLibraryInstance);
}

-(id) init {
    if ([super init]) {
		if(self.ifDebug) NSLog(@"Before reading the lib");
		self.libraryPath = [NSHomeDirectory() stringByAppendingString : @"/Music/iTunes/iTunes Music Library.xml"];
		if ([self checkIfLibraryExistsAtPath : self.libraryPath]) {
			self.originalLibrary = [NSMutableDictionary dictionaryWithContentsOfFile : self.libraryPath];
			if(self.ifDebug)NSLog(@"After reading the lib");
			self.tracks = [NSMutableArray array];
			self.trackDictionary = [NSMutableDictionary dictionary];
			[self readTracksFromLibrary];
			[self readPlaylistsFromLibrary];
        }
    }

    [self retain];
    return self;
}

-(void) readPlaylistsFromLibrary {
    NSMutableArray * playlistsTemp = [NSMutableArray array];
    for (NSDictionary * playlist in [self.originalLibrary objectForKey : @"Playlists"]) {
        [playlistsTemp addObject : [CunddITunesPlaylist playlistWithDictionary : playlist]];
    }
    [self createParentChildStructureWithPlaylists : playlistsTemp];
    //	[playlistsTemp release];
    return;
}

-(void) readTracksFromLibrary {
    for (NSDictionary * track in [[self.originalLibrary objectForKey : @"Tracks"] allValues]) {
        [self.tracks addObject : [CunddITunesTrack trackWithDictionary : track]];
        [self.trackDictionary setObject : [CunddITunesTrack trackWithDictionary : track] forKey : [NSString stringWithFormat : @"%@", [track objectForKey : @"Track ID"]]];
    }
	
	CunddITunesTrack * liveVideoTrack = [CunddITunesTrack liveVideoTrack];
	[self.tracks addObject:liveVideoTrack];
	[self.trackDictionary setObject:liveVideoTrack forKey:[liveVideoTrack valueForKey:@"Track ID"]];
    return;
}

-(BOOL) checkIfLibraryExistsAtPath : (NSString *) path {
	NSFileManager *manager = [NSFileManager defaultManager];
	if ([manager fileExistsAtPath : path]) {
		if(self.ifDebug)NSLog(@"Library was found @ %@", path);
		return TRUE;
	} else {
		if(self.ifDebug)NSLog(@"Library couldn't be found @ %@", path);
		return FALSE;
	}
}

-(void) createParentChildStructureWithPlaylists : (NSArray *) playlistsTemp {
    NSMutableDictionary * expandablePlaylists = [NSMutableDictionary dictionary];

    // Die root-Playlist initialisieren
    self.playlistRoot = [CunddITunesPlaylist rootPlaylistWithoutChildren]; //:[NSMutableArray arrayWithArray:[expandablePlaylists allValues]]];

    // Alle Playlists in einem Dictionary speichern
    // Die keys sind die Persistent-IDs
    for (CunddITunesPlaylist * currentPlaylist in playlistsTemp) {
        if ([currentPlaylist isFolder])
            [expandablePlaylists setObject : currentPlaylist forKey : currentPlaylist.playlistPersistentId];
    }

    // Durch alle Playlists gehen und sie ineinander verschachteln
	for (CunddITunesPlaylist * currentPlaylist in playlistsTemp) {
		if (currentPlaylist.parentPersistentId != nil) {
			if(self.ifDebug)NSLog(@"currentPlaylist.parentPersistentId=%@", currentPlaylist.parentPersistentId);
            CunddITunesPlaylist * parentPlaylist = [expandablePlaylists objectForKey : currentPlaylist.parentPersistentId];
            if (parentPlaylist) {
                [parentPlaylist addObject : currentPlaylist];
            }
        } else {
            [self.playlistRoot addObject : currentPlaylist];
        }
    }

    /*
    self.playlistRoot.children = [NSMutableArray array];
    [self.playlistRoot addObject:@"child 1"];
    [self.playlistRoot addObject:@"child 2"];
    [self.playlistRoot addObject:@"child 3"];
    [self.playlistRoot.children addObject:@"child 4"];
     */
	if(self.ifDebug)NSLog(@"%@", self.playlistRoot.children);

    // Durch alle Erst-Level-Playlists gehen und sie in der Root-Playlist speichern
    // Eine Erst-Level-Playlist hat keine parentPersistentId
    [expandablePlaylists retain];
    //	NSLog(@"%@",expandablePlaylists);
    //	for(NSString * firstLevelNodeKey in expandablePlaylists){
    //		CunddITunesPlaylist * firstLevelNode = [expandablePlaylists objectForKey:firstLevelNodeKey];
    //		NSLog(@"firstLevelNode=%@",firstLevelNode.name);
    //		NSLog(@"firstLevelNode class=%s",object_getClassName(firstLevelNode));
    //		if([firstLevelNode parentPersistentId] == nil){
    //			NSLog(@"add");
    //			[self.playlistRoot addObject:firstLevelNode];
    //		}
    //	}
	if(self.ifDebug)NSLog(@"self.playlistRoot=%@", self.playlistRoot);
	if(self.ifDebug)NSLog(@"self.playlistRoot.count= %i", [self.playlistRoot count]);
	if(self.ifDebug)NSLog(@"self.playlistRoot.children= %@", self.playlistRoot.children);
	if(self.ifDebug)printf("\n");


    //[expandablePlaylists release];
    [expandablePlaylists retain];
    [self.playlistRoot retain];
    /*
    NSLog(@"%@",expandablePlaylists);
    for(CunddITunesPlaylist * currentPlaylist in expandablePlaylists){
            NSLog(@"%@",(currentPlaylist));
    }
    NSLog(@"expandablePlaylists: %@",expandablePlaylists);
    // */
    return;
}

-(NSInteger) count {
    return [self.playlistRoot count];
}

-(NSDictionary *) getTracksAsDictionary {
    return [originalLibrary objectForKey : @"Tracks"];
}

-(CunddITunesTrack *) getTrackWithId : (NSString *) trackId {
    if (self.ifDebug)NSLog(@"%@", trackId);
    if (self.ifDebug)NSLog(@"%@", [self.trackDictionary objectForKey : trackId]);
    return [self.trackDictionary objectForKey : trackId];
}

-(CunddITunesTrack *) getTrackAt : (NSInteger) trackIndex {
    return [self.tracks objectAtIndex : trackIndex];
}


-(BOOL)ifDebug{
	if([[CunddConfig valueForKeyPath : @"Debug.CunddITunes.Library"]boolValue] == 0){
		return NO;
	} else {
		return YES;
	}
}

@synthesize originalLibrary, tracks, playlistRoot, libraryPath, trackDictionary;
@end
