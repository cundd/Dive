//
//  CunddDiveVideoChain.h
//  Dive
//
//  Created by Daniel Corn on 26.04.10.
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
#import <CunddCore/Cundd.h>
#import <CunddCore/CunddApp.h>
#import "CunddDiveVideoChainDraggingDestinationView.h"
#import "CunddDiveVideoChainQCPatchController.h"
#import "CunddDiveVideoChainSettings.h"
#import <Quartz/Quartz.h>
#import "CunddDiveQCView.h"

/*!
    @class
    @abstract    Class to create the whole environment for a Video Chain
    @discussion  The class creates all the instances and views a Video Chain needs. It also manages the connections between them and the main application.
*/
@interface CunddDiveVideoChain : CunddObject {
	IBOutlet NSView	* targetView;
//	IBOutlet CunddDiveVideoChainSettings * vcSettings;
	IBOutlet CunddDiveVideoChainDraggingDestinationView * vcView;
	IBOutlet CunddDiveVideoChainQCPatchController * vcQCPatchController;
	IBOutlet CunddDiveQCView * previewView;
	NSViewController * vcViewController;
	NSNumber * index;
	
	NSDictionary * settingsDictionary;
	
	NSArray * _keysOfSettings;
	
	// Output
	//NSImage * outputImage;
	
}

/*!
    @method     
    @abstract   Create new instance with given targetView
    @discussion Create new instance with given targetView
*/
+(id)vcWithTargetView:(NSView *)newTargetView;

/*!
 @method     
 @abstract   Create new instance with given targetView
 @discussion Create new instance with given targetView
 */
-(id)initWithTargetView:(NSView *)newTargetView;


/*!
    @method     
    @abstract   Tell the settings-object to save its preferences
    @discussion Tell the settings-object to save its preferences.
*/
- (IBAction) saveAction:(id)sender;

/*!
    @method     
    @abstract   Tell the vcQCPatchController to refresh the port-data
    @discussion Tell the vcQCPatchController to refresh the port-data
*/
-(void)refreshAllPorts;


/*!
    @method     
    @abstract   Load a new track into the VC
    @discussion Load a new track into the VC
*/
-(BOOL)loadTrack:(CunddITunesTrack *)aTrack;


/*!
    @method     
    @abstract   Load a new track into the VC
    @discussion Retrieve the current selected track in the track-list an load it into the VC
*/
//-(BOOL)loadTrack;


/*!
    @method     
    @abstract   Refresh the index of every effect
    @discussion Refresh the index of every effect
*/
-(void)refreshAllEffectIndexes;


/*!
    @method     
    @abstract   Returns the settings to be passed to the master as a dictionary
    @discussion Returns the settings to be passed to the master as a dictionary (without the image)
*/
-(NSDictionary *)settingsDictionary;


/*!
 @method     
 @abstract   Pauses the playback of the contained video view
 @discussion Pauses the playback of the contained video view
 */
-(IBAction)pause:(id)sender;

/*!
 @method     
 @abstract   Starts the playback of the contained video view
 @discussion Starts the playback of the contained video view
 */
-(IBAction)play:(id)sender;

/*!
 @method     
 @abstract   Starts/pauses the playback
 @discussion Starts/pauses the playback
 */
-(IBAction)togglePlayback:(id)sender;


/*!
    @method     
    @abstract   Observes changes of the subviews
    @discussion Observes changes of the subviews
*/
-(void)vcViewDidResize:(NSNotification *)notif;


@property (retain) NSView * targetView;
@property (retain) CunddDiveVideoChainDraggingDestinationView * vcView;
@property (retain) CunddDiveVideoChainQCPatchController * vcQCPatchController;
@property (retain) NSViewController * vcViewController;
@property (retain) CunddDiveQCView * previewView;
@property (retain) NSNumber * index;
//@property (retain) CunddDiveVideoChainSettings * vcSettings;

@property (assign,readonly) NSImage * outputImage;
@property (retain) NSDictionary * settingsDictionary;
@end
