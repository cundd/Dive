//
//  CunddToolsProcessor.m
//  Dive
//
//  Created by Daniel Corn on 26.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddToolProcessorAbstract.h"




@implementation CunddToolProcessorAbstract

NSUInteger const kCunddToolProcessorStandardFrameRate = 50;

#pragma mark Processing methods
-(BOOL) processWithArguments:(NSDictionary *)arguments{
	if(!_timer) return NO;
	return [self processAtTime:[_timer timeInterval] arguments:arguments];
}
-(BOOL) processAtTime:(NSTimeInterval)time arguments:(NSDictionary *)arguments{
	/* This is the place for the actual processing */
	return NO;
}

#pragma mark Timer methods
-(BOOL) startTimer{
	NSTimeInterval timeInterval;
	if(!self.frameRate){
		self.frameRate = [NSNumber numberWithInt:kCunddToolProcessorStandardFrameRate];
	}
	
	timeInterval = (NSTimeInterval) 1.0 / [self.frameRate intValue];
	_timer = [[NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(_process:) userInfo:nil repeats:YES] retain];
	if(!_timer) return NO;
	
	[[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSEventTrackingRunLoopMode];
	
	if(!_timer){
		return NO;
	} else {
		return YES;
	}
}
-(BOOL) stopTimer{
	if([_timer isValid]){
		[_timer invalidate];
	}
	return [_timer isValid];
}
-(BOOL) resetTimer{
	if([self stopTimer]){
		return [self startTimer];
	} else {
		return NO;
	}
}


#pragma mark Object methods
+(id) processorWithFrameRate:(NSNumber *)theFrameRate{
	return [[[self alloc] initWithFrameRate:theFrameRate] autorelease];
}


-(id) initWithFrameRate:(NSNumber *)theFrameRate{
	self = [self init];
	if (self != nil) {
		frameRate = theFrameRate;
	}
	return self;
}


- (id) init{
	self = [super init];
	if (self != nil) {
		value = [[NSNumber numberWithInt:0] copy];
	}
	return self;
}


-(void) dealloc{
	[value release];
	[_timer release];
//	[frameRate release];
	
	[super dealloc];
}

@synthesize value,frameRate;
@end


@interface CunddToolProcessorAbstract (Private)
-(void)_process:(NSTimer *)timer;
@end
