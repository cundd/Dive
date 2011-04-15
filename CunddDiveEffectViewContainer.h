//
//  CunddDiveEffectViewContainer.h
//  Dive
//
//  Created by Daniel Corn on 05.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CunddDiveEffectViewContainer : NSView {
	IBOutlet NSView * slot1;
	IBOutlet NSView * slot2;
	IBOutlet NSView * slot3;
}

@property (retain) NSView *slot1,*slot2,*slot3;
@end
