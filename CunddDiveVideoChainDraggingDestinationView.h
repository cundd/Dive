//
//  CunddDiveVideoChainDraggingDestinationView.h
//  Dive
//
//  Created by Daniel Corn on 22.04.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddDiveDraggingDestinationView.h"
#import "CunddDiveVideoChainQCPatchController.h"
#import "CunddITunes.h"


@interface CunddDiveVideoChainDraggingDestinationView : CunddDiveDraggingDestinationView {
	IBOutlet CunddDiveVideoChainQCPatchController * vcController;
}

@property (retain) CunddDiveVideoChainQCPatchController * vcController;
@end
