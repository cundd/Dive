//
//  CunddDiveMaster.h
//
//  Created by Daniel Corn on 11.05.10.
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
#import "CunddDiveMasterEffect.h"
#import "CunddDiveMasterQCPatchController.h"
#import "CunddDiveVideoChainCollectionController.h"

@interface CunddDiveMaster : CunddObject {
	NSNumber * index;
    IBOutlet CunddDiveMasterEffect *maEffect;
    IBOutlet CunddDiveMasterQCPatchController *maQCPatchController;
	IBOutlet NSWindow * window;
	IBOutlet NSView * qcContainer;
	CunddDiveVideoChainCollectionController * vcCollectionController;
	NSWindow * fullscreenWindow;
	
	IBOutlet NSView * _oldContentView;
}


/*!
    @method     
    @abstract   Returns a new master.
    @discussion Returns a new master.
*/
+(CunddDiveMaster *)master;


/*!
    @method     
    @abstract   Returns a new instance with the properties set to the given objects
    @discussion Returns a new instance with the properties set to the given objects
*/
+(CunddDiveMaster *)masterWithEffect:(CunddDiveMasterEffect *)aEffect qCPatchController:(CunddDiveMasterQCPatchController *)aQCPatchController andVcCollectionController:(CunddDiveVideoChainCollectionController *)aVcCollectionController;
/*!
    @method     
    @abstract   Returns a new instance with the properties set to the given objects
    @discussion Returns a new instance with the properties set to the given objects
*/
-(CunddDiveMaster *)initWithEffect:(CunddDiveMasterEffect *)aEffect qCPatchController:(CunddDiveMasterQCPatchController *)aQCPatchController andVcCollectionController:(CunddDiveVideoChainCollectionController *)aVcCollectionController;
/*!
    @method     
    @abstract   Returns a new instance with the properties set to the given objects
    @discussion Returns a new instance with the properties set to the given objects
*/


+(CunddDiveMaster *)masterWithVcCollectionController:(CunddDiveVideoChainCollectionController *)aVcCollectionController;
/*!
    @method     
    @abstract   Returns a new instance with the properties set to the given objects
    @discussion Returns a new instance with the properties set to the given objects
*/
-(CunddDiveMaster *)initWithVcCollectionController:(CunddDiveVideoChainCollectionController *)aVcCollectionController;


/*!
    @method     
    @abstract   Inform the master that there is a new VC
    @discussion Inform the master that there is a new VC
*/
-(void)registerVideoChain:(CunddDiveVideoChain *)aVc;


/*!
    @method     
    @abstract   Registers itself within the master entry of the app registry.
    @discussion Registers itself within the master entry of the app registry.
*/
-(void)registerSelf;


/*!
    @method     
    @abstract   Additional initialization methods
    @discussion Additional initialization methods
*/
-(void)setup;


/*!
    @method     
    @abstract   Switches to fullscreen
    @discussion Switches to fullscreen
*/
-(IBAction)toggleFullscreen:(id)sender;

@property (retain) NSView * _oldContentView;
@property (retain) NSView * qcContainer;
@property (retain) NSWindow * fullscreenWindow;
@property (retain) NSWindow * window;
@property (retain) CunddDiveMasterEffect *maEffect;
@property (retain) CunddDiveMasterQCPatchController *maQCPatchController;
@property (retain) CunddDiveVideoChainCollectionController * vcCollectionController;
@property (retain,readonly) NSString * name;
@end
