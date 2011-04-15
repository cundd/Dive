//
//  CunddDiveVideoChainCollection.h
//  Dive
//
//  Created by Daniel Corn on 22.04.10.
//  Copyright 2010 cundd. All rights reserved.
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
