//
//  CunddDiveMasterQCPatchController.h
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
	// */
	
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
