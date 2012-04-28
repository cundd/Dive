//
//  CunddDiveVideoChainSettings.h
//  Dive
//
//  Created by Daniel Corn on 22.04.10.
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
//#import "CunddDiveAbstractSettings.h"
#import "CunddDiveEffect.h"
#import "CunddDiveEffectViewContainer.h"
#import "CunddITunes.h"


typedef enum{
	CunddDiveEdgeModeFold = 1,
	CunddDiveEdgeModeClip = 2,
	CunddDiveEdgeModeWarp = 4
} CunddDiveEdgeMode;

/*!
    @class
    @abstract    Object to save the settings of a video-chain
    @discussion  The class of an object to save the settings of a video-chain. All properties are stored in the mutable dictionary propertyValues, to provide flexibility in definition of settings.
*/
@interface CunddDiveVideoChainSettings : CunddObject {
	IBOutlet	NSString * movieLocation;
	IBOutlet 	NSNumber * speed;
	IBOutlet 	NSNumber * selectionDuration;
	IBOutlet 	NSNumber * loop;
	IBOutlet 	NSNumber * selectionStart;
	IBOutlet 	NSNumber * alpha;
	IBOutlet 	NSArray * psl;
	
	NSNumber * screen;
	NSNumber * width;
	NSNumber * height;
	NSNumber * x;
	NSNumber * y;
	CunddDiveEdgeMode mode;
	NSNumber * stack_level;
	
	CunddDiveEffectViewContainer * effectViewContainer;
	
	NSNumber * index;
	NSString * userDefaultsKey;
	
/*	NSNumber * indexPsl1;
	NSNumber * indexPsl2;
	NSNumber * indexPsl3;*/
	
/*	NSArray * argsPsl1;
	NSArray * argsPsl2;
	NSArray * argsPsl3;*/
	CunddDiveEffect * pslObject1;
	CunddDiveEffect * pslObject2;
	CunddDiveEffect * pslObject3;
	
	CunddITunesTrack * track;
}


/*!
    @method     
    @abstract   Returns an instance with a given CunddDiveVideoChain
    @discussion Returns an instance with a given CunddDiveVideoChain that identifies the Nib's File's Owner.
*/
//+(CunddDiveVideoChainSettings *)settingsWithVC:(CunddDiveVideoChain *)aVC;
/*!
    @method     
    @abstract   Returns an instance with a given CunddDiveVideoChain
    @discussion Returns an instance with a given CunddDiveVideoChain that identifies the Nib's File's Owner.
*/
//-(CunddDiveVideoChainSettings *)initWithVC:(CunddDiveVideoChain *)aVC;



/*!
    @method     
    @abstract   Returns an instance with a given effect-view-container
    @discussion Returns an instance with a given effect-view-container
*/
+(CunddDiveVideoChainSettings *)settingsWithEffectViewContainer:(NSView *)aView;
/*!
    @method     
    @abstract   Returns an instance with a given effect-view-container
    @discussion Returns an instance with a given effect-view-container
*/
-(CunddDiveVideoChainSettings *)initWithEffectViewContainer:(NSView *)aView;


/*!
    @method     
    @abstract   Set the properties from a given track
    @discussion Set the properties from a given track.
*/
-(void)setPropertiesFromTrack:(CunddITunesTrack *)aTrack;

/*!
    @method     
    @abstract   Set the properties from a given track
    @discussion Set the properties from a given track.
*/
-(void)loadTrack:(CunddITunesTrack *)aTrack;


/*!
 @method     
 @abstract   Set the properties from a given dictionary
 @discussion Set the properties from a given dictionary.
 */
-(void)setPropertiesFromDictionary:(NSDictionary *)dictionary;


/*!
 @method     
 @abstract   Retrieves the settings from the user defaults
 @discussion Retrieves the settings from the user defaults.
 */
-(void)setPropertiesFromUserDefaults;


/*!
 @method     
 @abstract   Update the user-defaults-entries
 @discussion Update the user-defaults-entries.
 */
-(void)updateUserDefaults;


/*!
 @method     
 @abstract   Check if the propertyKey is handled in the user defaults key
 @discussion Check if the propertyKey is handled in the user defaults key
 */
-(BOOL)isUserDefaultsValidProperty:(NSString *)propertyKey;


/*!
 @method     
 @abstract   Check if the propertyKey is the key of an ivar
 @discussion Check if the propertyKey is the key of an ivar
 */
-(BOOL)isValidInstanceProperty:(NSString *)propertyKey;


/*!
 @method     
 @abstract   Check if the propertyKey is the key of an ivar and is handled in the user defaults key
 @discussion Check if the propertyKey is the key of an ivar and is handled in the user defaults key
 */
-(BOOL)isValidInstanceAndUserDefaultsProperty:(NSString *)propertyKey;


/*!
 @method     
 @abstract   Reads the user-defaults-key
 @discussion Reads the user-defaults-key for the vcSettings from the config.plist.
 */
-(void)getUserDefaultsKey;


/*!
    @method     
    @abstract   Returns the prepared movie location
    @discussion Returns the prepared movie location either 
*/
-(NSString *)preparedMovieLocation:(NSString *)theLocation;


@property (retain) NSNumber * index;
@property (retain,readonly) NSString * userDefaultsKey;


@property (retain) CunddDiveEffectViewContainer * effectViewContainer;

@property (nonatomic, retain) NSString * movieLocation;
@property (nonatomic, retain) NSNumber * speed,*selectionDuration,*loop,*selectionStart,*alpha,* indexPsl1,*indexPsl2,*indexPsl3;
@property (nonatomic, retain) NSArray * psl,*argsPsl1,*argsPsl2,*argsPsl3;


@property (retain) CunddDiveEffect *pslObject1,*pslObject2,*pslObject3;

@property (retain,readonly) CunddDiveEffect *psl1,*psl2,*psl3;


@property (retain) NSNumber * screen;
@property (retain) NSNumber * width;
@property (retain) NSNumber * height;
@property (retain) NSNumber * x;
@property (retain) NSNumber * y;
@property (assign,readonly) CunddDiveEdgeMode mode;
@property (retain) NSNumber	* stack_level;

@property (retain) CunddITunesTrack * track;

@end