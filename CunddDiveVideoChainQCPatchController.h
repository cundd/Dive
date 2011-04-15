//
//  CunddDiveVideoChainQCPatchController.h
//  Dive
//
//  Created by Daniel Corn on 23.04.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddDiveVideoChainSettings.h"
#import "CunddDiveEffectViewContainer.h"
#import <Quartz/Quartz.h>
#import "CunddDiveVideoChainQCView.h"
//#import "CunddDiveQCPatchController.h"



@interface CunddDiveVideoChainQCPatchController : CunddObject {
	IBOutlet CunddDiveEffectViewContainer * effectViewContainer;
	IBOutlet CunddDiveVideoChainSettings * patch;
	IBOutlet NSView * targetView;
	QCComposition * qcComposition;
	CunddDiveVideoChainQCView * view;
@private
	BOOL _qcCompositionDidClearInputsOnce;
	NSUInteger _qcCompositionDidClearCounter;
	NSUInteger _qcCompositionDidClearMax;
}

/*!
 @method     
 @abstract   
 @discussion On startup the QCComposition seems to clear all input-values, this method checks if the current observed change would delete (null) a settings-property and returns NO if the change is part of the startup-clear-routine.
 */
-(BOOL)_qcCompositionDidClear;



-(id)setup;

/*!
    @method     
    @abstract   Synchronize the argsPsl1-input in the QCView
    @discussion Synchronize the argsPsl1-input in the QCView.
*/
-(void)refreshArgsPsl1;
/*!
    @method     
    @abstract   Synchronize the argsPsl2-input in the QCView
    @discussion Synchronize the argsPsl2-input in the QCView.
*/
-(void)refreshArgsPsl2;
/*!
    @method     
    @abstract   Synchronize the argsPsl3-input in the QCView
    @discussion Synchronize the argsPsl3-input in the QCView.
*/
-(void)refreshArgsPsl3;




/*!
    @method     
    @abstract   Tell the controller to refresh all port-data
    @discussion Tell the controller to refresh all port-data
*/
-(void)refreshAllPorts;


/*!
    @method     
    @abstract   Tell the controller to refresh the data of the effects
    @discussion Tell the controller to refresh the data of the effects
*/
-(void)refreshAllEffectIndexes;


/*!
    @method     
    @abstract   Tell the controller to refresh the movie-location port
    @discussion Tell the controller to refresh the movie-location port
*/
-(void)refreshMovieLocation;

@property (retain) CunddDiveEffectViewContainer * effectViewContainer;
@property (retain) CunddDiveVideoChainSettings * patch;
@property (retain) NSView * targetView;
@property (retain) CunddDiveVideoChainQCView * view;
@property (retain) QCComposition * qcComposition;
//@property (retain) id content;
@end
