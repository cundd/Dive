//
//  CunddToolBlockProcessor.m
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
