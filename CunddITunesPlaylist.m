//
//  Playlist.m
//  Menu
//
//  Created by Daniel Corn on 31.03.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddITunesPlaylist.h"

static int playlistCounter;
static BOOL debug = FALSE;

@implementation CunddITunesPlaylist

+ (CunddITunesPlaylist *) playlistWithDictionary : (NSDictionary *) dictionary {
    return [[self alloc]initWithDictionary : dictionary];
}

-(CunddITunesPlaylist *) initWithDictionary : (NSDictionary *) dictionary {
    if (!playlistCounter) {
        playlistCounter = 0;
    }
    playlistCounter++;

    self.name = [dictionary objectForKey : @"Name"];
    self.playlistId = [dictionary objectForKey : @"Playlist ID"];
    self.parentPersistentId = [dictionary objectForKey : @"Parent Persistent ID"];
    self.playlistPersistentId = [dictionary objectForKey : @"Playlist Persistent ID"];
    self.folder = [dictionary objectForKey : @"Folder"];
    self.playlistItems = [dictionary objectForKey : @"Playlist Items"];
    self.playlistLocalId = [NSNumber numberWithInt : playlistCounter];
    self.children = [NSMutableArray array];

    [self retain];
    return self;
}

+(CunddITunesPlaylist *) rootPlaylistWithChildrenArray : (NSMutableArray *) newChildren {
    return [[self alloc]initRootPlaylistWithChildrenArray : newChildren];
}

-(CunddITunesPlaylist *) initRootPlaylistWithChildrenArray : (NSMutableArray *) newChildren {
    if ([self initRootPlaylistWithoutChildren]) {
        self.children = newChildren;
        [newChildren retain];
    }

    [self retain];
    return self;
}

+(CunddITunesPlaylist *) rootPlaylistWithoutChildren {
    return [[self alloc]initRootPlaylistWithoutChildren];
}

-(CunddITunesPlaylist *) initRootPlaylistWithoutChildren {
    if (!playlistCounter) {
        playlistCounter = 0;
    }
    playlistCounter++;

    self.name = [NSString stringWithString : @"Root"];
    self.playlistId = [NSNumber numberWithInt : 1];
    self.playlistPersistentId = [NSString stringWithString : @"1"];
    self.folder = TRUE;
    self.playlistLocalId = [NSNumber numberWithInt : playlistCounter];
    self.children = [NSMutableArray array];
    return self;
}

-(BOOL) isFolder {
    return self.folder;
}

-(BOOL) isItemExpandable {
    return [self isFolder];
}

-(NSInteger) count {
    return [self.children count];
}

-(id) objectAtIndex : (NSUInteger) index {
    return [self.children objectAtIndex : index];
}

-(void) addObject : (id) object {
    if (debug)NSLog(@"addOb.before to %@", [self name]);

    [object retain];
    [self.children addObject : object];

    if (debug)NSLog(@"addOb.after %@ %@", self.children, object);
    return;
}


-(NSArray *) getTracksFromCunddITunesLibrary: (id) library {
	return [self getTracksFromCunddITunesLibrary:library fromSender:nil];
}

-(NSArray *) getTracksFromCunddITunesLibrary:(id)library fromSender:(id)sender{
	if (self.tracklist == nil) { // Init the tracklist-property if it is empty
		void (^fillTracklist)(void);
		fillTracklist = ^{
			NSString * trackId;
			NSMutableArray * newTracklistTemp = [NSMutableArray array];
			//NSMutableArray * newTracklist = [NSMutableArray array];
			for (NSDictionary * track in self.playlistItems) {
				trackId = [NSString stringWithFormat : @"%@", [track valueForKey : @"Track ID"]];
				
				// Do the same as: [newTracklistTemp addObject:[library getTrackWithId:trackId]];
				SEL method = @selector(getTrackWithId:);
				id newObject;
				if([library respondsToSelector:method]){
					newObject = [library performSelector:method withObject:trackId];
					[newTracklistTemp addObject:newObject];
				}
				 /* */
			}
			
			
			void (^setTracklist)(void);
			setTracklist = ^{
				self.tracklist = [NSArray arrayWithArray:newTracklistTemp];				[[NSNotificationCenter defaultCenter] postNotificationName:[CunddConfig stringForKeyPath:@"Constants.CunddITunes.Notifications.PlaylistGetTracksFromCunddITunesLibraryFirstTime"] object:self];
				
				// Inform the sender that the data is ready
				SEL method = @selector(updateTracklistWithArray:);
				if([sender respondsToSelector:method]){
					[sender performSelector:method withObject:self.tracklist];
				}
			};
			
			dispatch_sync(dispatch_get_main_queue(),setTracklist);
		};
		
		/*
		NSOperationQueue * queue = [[NSOperationQueue alloc] init];
		[queue addOperationWithBlock:fillTracklist];
		/* */
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), fillTracklist);
		
		
		/*
		//NSInvocationOperation * operation = [[NSInvocationOperation alloc] init]
		NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:fillTracklist];
		//[queue addOperation:operation];
		[queue addOperationWithBlock:fillTracklist];
		//[operation release];
		
		/*
        for (NSDictionary * track in self.playlistItems) {
            trackId = [NSString stringWithFormat : @"%@", [track valueForKey : @"Track ID"]];

            [newTracklist addObject:[library getTrackWithId:trackId]];
            //if(debug)NSLog(@"trackId = %@",trackId);
            //		if(debug)NSLog(@"[trackLibrary valueForKey:trackId] = %@",[trackLibrary valueForKey:trackId]);
        }
		/* */

		//self.tracklist = [NSArray arrayWithArray : newTracklist];
    }
    if (debug)NSLog(@"the Tracklist %@", self.tracklist);
    return self.tracklist;
}

//-(NSArray *) getTracksFromTracksArray:(NSMutableArray *)tracksarray{
//	NSMutableArray * tracklist = [NSMutableArray array];
//	NSString * trackId;
//	
//	for(NSDictionary * track in self.playlistItems){
//		trackId = [NSString stringWithFormat:@"%@",[track valueForKey:@"Track ID"]];
//		//if(debug)NSLog(@"trackId = %@",trackId);
//		//		if(debug)NSLog(@"[trackLibrary valueForKey:trackId] = %@",[trackLibrary valueForKey:trackId]);
//		[tracklist addObject:[trackLibrary valueForKey:trackId]];
//	}
//	if(debug)NSLog(@"the Tracklist %@",tracklist);
//	return tracklist;
//}
@synthesize name, playlistPersistentId, parentPersistentId, playlistId, playlistLocalId, folder, playlistItems, children, tracklist;

@end
