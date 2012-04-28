//
//  CunddDiveVideoChainCollection.h
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
#import "CunddDiveVideoChainSettings.h"
#import "CunddDiveVideoChain.h"
#import "CunddDiveDraggingSourceController.h"


@interface CunddDiveVideoChainCollectionController : NSArrayController {
	NSNumber * vcCount;
	IBOutlet NSView * targetView0;
	IBOutlet NSView * targetView1;
	IBOutlet NSView * targetView2;
	IBOutlet NSView * targetView3;
	IBOutlet NSView * targetView4;
	IBOutlet NSView * targetView5;
	IBOutlet CunddDiveDraggingSourceController * draggingSourceController;
}

/*!
    @method     
    @abstract   Returns the object at a given index
    @discussion The method returns the object of the content-array at the given index.
*/
-(CunddDiveVideoChain *)objectAtIndex:(NSUInteger)index;

/*!
    @method     
    @abstract   Sends the save-action to all objects in the content
    @discussion Sends the save-action to all objects in the content.
*/
- (IBAction) saveAction:(id)sender;


/*!
    @method     
    @abstract   Tells all VCs to refresh the port-data
    @discussion Tells all VCs to refresh the port-data
*/
-(void)handleEffectArgumentChange:(NSNotification *)notif;

/*!
    @method     
    @abstract   Tells all VCs to refresh the effect-data
    @discussion Tells all VCs to refresh the effect-data
*/
-(void)handleEffectChoice:(NSNotification *)notif;

/*!
    @method     
    @abstract   Tells a VC to load a track
    @discussion Tells a VC to load a track
*/
-(void)handleLoadTrack:(NSNotification *)notif;


/*!
    @method     
    @abstract   Returns the number of attached VCs
    @discussion Calls -count on the content-property
*/
-(NSUInteger)count;


-(void)playVideoInMainPreview;

@property (retain) NSNumber * vcCount;
@property (retain) NSView *targetView0,*targetView1,*targetView2,*targetView3,*targetView4,*targetView5;
@property (retain) CunddDiveDraggingSourceController * draggingSourceController;
@end
