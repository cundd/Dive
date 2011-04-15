//
//  CunddPunchButton.h
//  Dive
//
//  Created by Daniel Corn on 19.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddUIButtonSetter.h"


@interface CunddUIButtonPunch : CunddUIButtonSetter {
	NSValue * oldValue;
}

/*!
    @method     
    @abstract   Returns a boolean if the new value will be set when the Return-key is hit
    @discussion Returns a boolean if the new value will be set when the Return-key is hit
*/
-(BOOL)keepWhenPressReturn;
@property (retain) NSValue * oldValue;
@end
