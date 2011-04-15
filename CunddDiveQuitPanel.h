//
//  CunddDiveQuitPanel.h
//  Dive
//
//  Created by Daniel Corn on 20.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Cundd.h"


@interface CunddDiveQuitPanel : CunddObject {
	IBOutlet NSWindow * panel;
	BOOL terminate;
}
-(IBAction)ok:(id)sender;
-(IBAction)cancel:(id)sender;

@end
