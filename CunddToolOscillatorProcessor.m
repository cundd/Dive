//
//  CunddToolOscillatorProcessor.m
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

#import "CunddToolOscillatorProcessor.h"


@implementation CunddToolOscillatorProcessor
- (id) init
{
	self = [super init];
	if (self != nil) {
		_oldValue = [NSNumber numberWithInt:0];
		phase = [NSNumber numberWithInt:0];
		amplitude = [NSNumber numberWithInt:0];
		offset = [NSNumber numberWithInt:0];
	}
	return self;
}

-(BOOL) processAtTime:(NSTimeInterval)time arguments:(NSDictionary *)arguments{
	_time = time;
	switch(self.type){
		case CunddToolOscillatorProcessorSin:
			[self sin];
			break;
			
		case CunddToolOscillatorProcessorCos:
			[self cos];
			break;
			
		case CunddToolOscillatorProcessorTriangle:
			[self triangle];
			break;
			
		case CunddToolOscillatorProcessorSquare:
			[self square];
			break;
			
		case CunddToolOscillatorProcessorSawToothUp:
			[self sawToothUp];
			break;
			
		case CunddToolOscillatorProcessorSawToothDown:
			[self sawToothDown];
			break;
			
		default:
			return NO;
	}
	return YES;
}

-(void)sin{
	double x = (double)_time * [self.phase doubleValue];
	double res = sin(x);
	
	res = res * [self.amplitude doubleValue] + [offset doubleValue];
	
	self.value = [[NSNumber numberWithDouble:res] retain];
}
-(void)cos{
	double x = (double)_time * [self.phase doubleValue];
	double res = cos(x);
	
	res = res * [self.amplitude doubleValue] + [offset doubleValue];
	
	self.value = [[NSNumber numberWithDouble:res] retain];
}
-(void)triangle{
	double x = (double)_time * [self.phase doubleValue];
	const double xConst = 1 / [self.phase doubleValue];
	double res;
	
	if(_oldValue == nil) _oldValue = [[NSNumber numberWithInt:0] retain];
	if(_customNumber == nil) _customNumber = [[NSNumber numberWithBool:YES] retain];
	
	if([_customNumber boolValue] == YES && res < (float)1.0){
		res = x + xConst;
//	} else if([_customNumber boolValue] == NO && ){
		_customNumber = [NSNumber numberWithBool:NO];
		res = x - xConst;
	} else {
		
	}
	
	res = res * [self.amplitude doubleValue] + [offset doubleValue];
	self.value = [[NSNumber numberWithDouble:res] retain];
}
-(void)square{
	double x = (double)_time * [self.phase doubleValue];
//	double
//	_customInteger
}
-(void)sawToothUp{
	
}
-(void)sawToothDown{
	
}
@synthesize phase,amplitude,offset,type;
@end
