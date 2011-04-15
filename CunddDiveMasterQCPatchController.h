//
//  CunddDiveMasterQCPatchController.h
//
//  Created by Daniel Corn on 11.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddDiveQCPatchController.h"
#import "CunddDiveMasterSettings.h"
#import "CunddDiveVideoChainCollectionController.h"
#import "CunddDiveMasterQCView.h"

@interface CunddDiveMasterQCPatchController : CunddDiveQCPatchController {
	IBOutlet CunddDiveMasterSettings * patch;
	IBOutlet NSView * targetView;
	CunddDiveVideoChainCollectionController * vcCollectionController;
	
	NSMutableArray * _videoChains;
	NSMutableArray * _outputVideoChainStreams;
	
	IBOutlet NSTextField * text;
	
	IBOutlet NSImageView * outputView;
	
	
	
	/*
	// Data per VC
	NSImage * image;
	NSNumber * screen;
	NSNumber * width;
	NSNumber * height;
	NSNumber * x;
	NSNumber * y;
	NSNumber * alpha;
	NSNumber * mode;
	/* */
	
}

/*!
 @method     
 @abstract   Finish the init script when the VideoChains are ready
 @discussion Finish the init script when the VideoChains are ready
 */
-(void)finishInitialisationAndSetVcCollectionController:(CunddDiveVideoChainCollectionController *)theCollectionController;


/*!
    @method     
    @abstract   Add observers to the given VC
    @discussion Add observers to the given VC
*/
-(void)registerVideoChain:(CunddDiveVideoChain *)aVc;

@property (retain) CunddDiveMasterSettings * patch;
@property (retain) CunddDiveVideoChainCollectionController * vcCollectionController;
@property (retain) NSTextField * text;
@property (retain) NSImageView * outputView;
@property (retain) NSView * targetView;
@end
