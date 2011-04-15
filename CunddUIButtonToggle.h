//
//  CunddUIButtonToggle.h
//  Dive
//
//  Created by Daniel Corn on 25.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddUIButtonPunch.h"

typedef enum{
	CunddUIButtonStateOn,
	CunddUIButtonStateOff,
	CunddUIButtonStateMax
}CunddUIButtonState;



@interface CunddUIButtonToggle : NSButton {
	CunddUIButtonState state;
	IBOutlet id controller;
	id oldValue;
}


/*!
 @method     
 @abstract   Returns the value that should be set
 @discussion Returns the value that should be set
 */
-(id)newValue;

/*!
 @method     
 @abstract   Returns the key path of the controller to be set
 @discussion Returns the key path of the controller to be set
 */
-(NSString *)controllerKeyPath;

@property (retain) id controller;
@property (retain) id oldValue;
@property (readonly) id newValue;
@property (assign) CunddUIButtonState state;
@end
