//
//  CunddDiveMasterIB.h
//  Dive
//
//  Created by Daniel Corn on 11.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddDiveMaster.h"
#import "Cundd.h"

@interface CunddDiveMasterIB : CunddObject {
	CunddDiveMaster * master;
	
	
	IBOutlet CunddDiveVideoChainCollectionController * vcCollectionController;
	
	
	BOOL canReopen;
}

/*!
 @method     
 @abstract   Switches to fullscreen
 @discussion Switches to fullscreen
 */
-(IBAction)toggleFullscreen:(id)sender;


/*!
    @method     
    @abstract   Opens the window if it is closed
    @discussion Opens the window if it is closed
*/
-(IBAction)reopen:(id)sender;

@property (retain) CunddDiveMaster * master;
@property (assign) CunddDiveVideoChainCollectionController * vcCollectionController;
@property (assign) BOOL canReopen;
@end
