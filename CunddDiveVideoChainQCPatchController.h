//
//  CunddDiveVideoChainQCPatchController.h
//  Dive
//
//  Created by Daniel Corn on 23.04.10.
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
