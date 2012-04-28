//
//  CunddMIDIData.m
//  CunddMIDI
//
//  Created by Daniel Corn on 22.06.10.
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

#import "CunddMIDIData.h"


@implementation CunddMIDIData

+(id) zeroMIDIData{
	static CunddMIDIData * zeroMIDIDataInstance = nil;
	if(!zeroMIDIDataInstance){
		Byte vale[3] = {0x0,0x0,0x0};
		NSMutableData * theData = [NSMutableData dataWithBytes:vale length:3];
		zeroMIDIDataInstance = [self MIDIDataWithMutableData:theData];
	}
	
	return zeroMIDIDataInstance;
}

+(id) MIDIDataWithMutableData:(NSMutableData *)theData{
	return [[[self alloc] initWithMutableData:theData] autorelease];
}

-(id) initWithMutableData:(NSMutableData *)theData{
	if([self init]){
		packetData = [NSMutableData data];
		[self setPacketData:theData];
	}
	return self;
}
/*
-(void) setPacketData:(NSMutableData *)theValue{
	[super setPacketData:theValue];
	
	/*
	NSLog(@"CunddMIDIData: setPacketData=%@ %X %X %X",theValue, vale[0],vale[1],vale[2]);
	Byte vale[3];
	[theValue getBytes:&vale length:3];
	
	
	NSLog(@"%@ %X %X %X",self, vale[0],vale[1],vale[2]);
	[packetData getBytes:&vale length:3];
	NSLog(@"%@ %X %X %X",self, vale[0],vale[1],vale[2]);
	return;
	// */
//}

-(NSString *) description{
	Byte vale[3];
	[packetData getBytes:&vale length:3];
	
	/*
	
	Byte * sentCommand	= malloc(1);
	Byte * sentKey		= malloc(1);
	Byte * sentVelocity = malloc(1);
	
	*sentCommand = vale[0];
	*sentKey = vale[1];
	*sentVelocity = vale[2];
	
//	if([packetData length] > 0){
//		[self.command getValue:&sentCommand];
//		[self.key getValue:&sentKey];
//		[self.velocity getValue:&sentVelocity];
//	}
	
	
	free(sentCommand);
	free(sentKey);
	free(sentVelocity);
	
	
	return [NSString stringWithFormat:@"CunddMIDIData: command=%@ key=%@ velocity=%@",
			[NSString stringWithFormat:@"%X",*sentCommand],
			[NSString stringWithFormat:@"%X",*sentKey],
			[NSString stringWithFormat:@"%X",*sentVelocity]];
	// */
	return [NSString stringWithFormat:@"CunddMIDIData: command=%X key=%X velocity=%X | output=%@",
			vale[0],
			vale[1],
			vale[2],
			self.output
			];
}

@end
