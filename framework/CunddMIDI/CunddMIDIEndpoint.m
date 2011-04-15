//
//  CunddMIDIEndpoint.m
//  MidIn
//
//  Created by Daniel Corn on 15.06.10.
//
//	Copyright © 2010 Corn Daniel
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy of this 
//	software and associated documentation files (the "Software"), to deal in the Software 
//	without restriction, including without limitation the rights to use, copy, modify, 
//	merge, publish, distribute, sublicense, and/or sell copies of the Software, and to 
//	permit persons to whom the Software is furnished to do so, subject to the following 
//	conditions: 
//	The above copyright notice and this permission notice shall be included in all copies 
//	or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
//	INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
//	PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
//	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
//	CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
//	OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//

#import "CunddMIDIEndpoint.h"


@implementation CunddMIDIEndpoint
+(id) endpointWithMIDIEndpoint:(MIDIEndpointRef)theEndpoint{
	return [[[self alloc] initWithMIDIEndpoint:theEndpoint] autorelease];
}
-(id) initWithMIDIEndpoint:(MIDIEndpointRef)theEndpoint{
	if([self init]){
		endpoint = theEndpoint;
	}
	return self;
}

-(void) setMessage:(NSData *)theMessage{
	[message release];
	message = theMessage;
	[theMessage retain];
	[self sendData:message];
}

-(OSStatus)sendData:(NSData *)data{
	Byte rawData[256];
	
	//rawData = malloc([data length]);
	[data getBytes:&rawData length:[data length]];
	
	return [self sendBytes:rawData length:[data length]];
	
	//	MIDIPacketList packetList;
	//	MIDIPacket *firstPacket = MIDIPacketListInit(&packetList);
	//	
	//	if([data length] == 0) return kMIDIMessageSendErr;
	//	Byte *dataByte[256] = alloc(256);
	//	dataByte = [data bytes];
	//	
	//	NSLog(@"%d",[[NSProcessInfo processInfo]systemUptime]);
	//	
	//	MIDIPacket *nextPacket = MIDIPacketListAdd(&packetList, sizeof(packetList), firstPacket, 0, sizeof(dataByte), dataByte);
	//	if(!nextPacket){
	//		NSLog(@"MIDIPacketListAdd failed");
	//	}
	//	
	//	return [self sendMIDIPacketList:packetList];
}
-(OSStatus)sendBytes:(Byte *)data{
	return [self sendBytes:data length:3];
}

-(OSStatus)sendBytes:(Byte *)data length:(NSUInteger)theLength {
	if(!data) return kMIDIMessageSendErr;
	if(theLength < 1) return kMIDIMessageSendErr;
	
	MIDIPacketList packetList;
	ByteCount length;
	MIDIPacket *nextPacket = MIDIPacketListInit(&packetList);
	Byte * startDataPointer = data;
	
	
	// NSUInteger numberOfElementsInData = theLength
	for(NSUInteger i = 0;i<theLength;i++){
		length = sizeof(*startDataPointer);
		
		/*
		NSLog(@"MWMWMWMWMWMWMWMWMWMWMWMWMWM i=%i %X %i",i,*startDataPointer,*startDataPointer);

		
		NSLog(@"%X %i",length,length);
		NSLog(@"startDataPointer=%X",*startDataPointer);
		NSLog(@"data[i]=%X",data[i]);
		/* */
		
		nextPacket = MIDIPacketListAdd(&packetList, sizeof(packetList), nextPacket, 0, length, startDataPointer);
		startDataPointer++;
		
		if(!nextPacket){
			NSLog(@"MIDIPacketListAdd failed");
		}
	}
	/* */

	printf("\n");
	
	/*
	
	NSLog(@"%X %i",length,length);
	NSLog(@"data[i]%X data%X",data[i],*data);
	NSLog(@"data[1]%X data%X",data[1],*data);
/* */
	
	
	
	return [self sendMIDIPacketList:&packetList];
}


-(OSStatus)sendMIDIPacketList:(MIDIPacketList *)packetListPointer{
	[[self class] vardumpMIDIObject:self.endpoint];
	
	if(!self.endpoint){
		NSLog(@"CunddMIDIEndpoint: sendMIDIPacketList endpoint not set");
		return kMIDIMessageSendErr;
	}
	
	// Determine if the instance is a destination or a source
	if([[self className] isEqualToString:@"CunddMIDIDestination"]){ // Destination
		if(!self.outputPort){
			NSLog(@"CunddMIDIDestination: sendMIDIPacketList outputPort not set");
			return kMIDIMessageSendErr;
		}
		return MIDISend(self.outputPort, self.endpoint, packetListPointer);
	} else { // Source
		return MIDIReceived(self.endpoint, packetListPointer);
	}
}


@synthesize endpoint,outputPort,message;
@end
