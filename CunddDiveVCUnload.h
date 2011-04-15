//
//  CunddDiveVCUnload.h
//
//  Created by Daniel Corn on 20.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddUIButtonSetter.h"
#import "CunddDiveVideoChainQCPatchController.h"

@interface CunddDiveVCUnload : CunddUIButtonSetter {
	CunddDiveVideoChainQCPatchController * qcPatchController;
}

@property (retain) IBOutlet CunddDiveVideoChainQCPatchController * qcPatchController;
@end
