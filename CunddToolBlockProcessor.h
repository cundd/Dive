//
//  CunddToolBlockProcessor.h
//  Dive
//
//  Created by Daniel Corn on 26.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddToolProcessorAbstract.h"

typedef float (^CunddToolBlockProcessorBlock)(NSTimeInterval time,NSDictionary * arguments);

@interface CunddToolBlockProcessor : CunddToolProcessorAbstract {
	CunddToolBlockProcessorBlock block;
}


/*!
    @method     
    @abstract   Returns a new instance with the given block.
    @discussion Returns a new instance with the given block and the standard framerate.
*/
+(id)processorWithBlock:(CunddToolBlockProcessorBlock)theBlock;


/*!
    @method     
    @abstract   Returns a new instance with the given block.
    @discussion Returns a new instance with the given block and the standard framerate.
*/
-(id)initWithBlock:(CunddToolBlockProcessorBlock)theBlock;
@end
