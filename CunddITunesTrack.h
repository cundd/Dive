//
//  CunddITunesTrack.h
//  Menu
//
//  Created by Daniel Corn on 31.03.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Cundd.h";


@interface CunddITunesTrack : NSObject
{
    NSDictionary *trackinfo;
}

+(CunddITunesTrack *)trackWithDictionary:(NSDictionary *)track;
-(CunddITunesTrack *)initWithDictionary:(NSDictionary *)track;
-(id)applyFormatterToValue:(id)value forKey:(NSString *)key;
-(NSString *)prepareKey:(NSString *)key;
-(BOOL)ifDebug;

/*!
    @method     
    @abstract   Returns an empty track
    @discussion Returns an empty track
*/
+(CunddITunesTrack *) emptyTrack;

/*!
    @method     
    @abstract   Returns an empty track with only the movie location set
    @discussion Returns an empty track with only the movie location set
*/
+(CunddITunesTrack *)emptyTrackWithMovieLocation:(NSString *)theLocation;


@property(retain) NSDictionary *trackinfo;
//@property(retain,readonly) NSDictionary *trackinfo;


@end
