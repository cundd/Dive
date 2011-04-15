//
//  CunddToolBlockProcessor.m
//  Dive
//
//  Created by Daniel Corn on 26.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddToolBlockProcessor.h"


@implementation CunddToolBlockProcessor
+(id) processorWithBlock:(CunddToolBlockProcessorBlock)theBlock{
	return [[[self alloc] initWithBlock:theBlock] autorelease];
}
-(id) initWithBlock:(CunddToolBlockProcessorBlock)theBlock{
	if([self init]){
		block = theBlock;
	}
	return self;
}

-(BOOL) processAtTime:(NSTimeInterval)time arguments:(NSDictionary *)arguments{
	float result = block(time,arguments);
	
	if(!result) return NO;
	
	self.value = [[NSNumber numberWithFloat:result] retain];
	return YES;
}
@end
