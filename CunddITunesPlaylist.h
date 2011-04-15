//
//  Playlist.h
//  Menu
//
//  Created by Daniel Corn on 31.03.10.
//  Copyright 2010 cundd. All rights reserved.
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
