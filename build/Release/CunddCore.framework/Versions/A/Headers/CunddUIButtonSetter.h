//
//  CunddSetButton.h
//  Dive
//
//  Created by Daniel Corn on 20.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CunddUIButtonSetter : NSButton {
	IBOutlet id controller;
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
@property (readonly) id newValue;
@end
