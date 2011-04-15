//
//  CunddMIDIData.m
//  CunddMIDI
//
//  Created by Daniel Corn on 22.06.10.
//  Copyright 2010 cundd. All rights reserved.
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
	/* */
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
	/* */
	return [NSString stringWithFormat:@"CunddMIDIData: command=%X key=%X velocity=%X | output=%@",
			vale[0],
			vale[1],
			vale[2],
			self.output
			];
}

@end
