//
//  CunddDiveScreenIndicatorView.h
//
//  Created by Daniel Corn on 17.07.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddDiveVideoChainQCPatchController.h"

@interface CunddDiveScreenIndicatorView : NSView{
	NSView * screenIndicatorView;
	CunddDiveVideoChainQCPatchController * vcQcPatchController;
}

@property (retain) IBOutlet CunddDiveVideoChainQCPatchController * vcQcPatchController;
@property (retain) IBOutlet NSView * screenIndicatorView;
@end
