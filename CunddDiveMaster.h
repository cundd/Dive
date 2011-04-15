//
//  CunddDiveMaster.h
//
//  Created by Daniel Corn on 11.05.10.
//  Copyright 2010 cundd. All rights reserved.
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
