//
//  CunddITunesTrack.h
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
#import "Cundd.h"


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

/*!
 @method     
 @abstract   Returns a track which stands for a live video capture device.
 @discussion Returns a track which stands for a live video capture device.
 */
+(CunddITunesTrack *)liveVideoTrack;


@property(retain) NSDictionary *trackinfo;
//@property(retain,readonly) NSDictionary *trackinfo;


@end
