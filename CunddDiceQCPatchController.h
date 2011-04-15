//
//  CunddDiceQCPatchController.h
//
//  Created by Daniel Corn on 26.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddDiceSettings.h"
#import "CunddDiveQCPatchController.h"
#import "CunddDiceQCView.h"

@interface CunddDiceQCPatchController : CunddDiveQCPatchController {
	IBOutlet CunddDiceSettings * patch;
	IBOutlet NSView * targetView;
}

@property (retain) CunddDiceSettings * patch;
@property (retain) NSView * targetView;
@end
