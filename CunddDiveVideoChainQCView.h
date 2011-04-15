//
//  CunddDiveVideoChainQCView.h
//  Dive
//
//  Created by Daniel Corn on 17.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddDiveQCView.h"
#import <Quartz/Quartz.h>

@interface CunddDiveVideoChainQCView : CunddDiveQCView {
	NSUInteger index;
}

/*!
 @method     
 @abstract   Returns a new instance with the given path to the composition
 @discussion Returns a new instance with the given path to the composition
 */
+(CunddDiveVideoChainQCView *) qcViewWithView:(NSView *)aView andFilePath:(NSString *)thePath;
@property (assign) NSUInteger index;
@end
