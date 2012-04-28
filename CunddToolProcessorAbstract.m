//
//  CunddToolsProcessor.m
//  Dive
//
//  Created by Daniel Corn on 26.06.10.
//
//    Copyright © 2010-2012 Corn Daniel
//
//    This file is part of Dive.
//
//    Dive is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    Foobar is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
//
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
