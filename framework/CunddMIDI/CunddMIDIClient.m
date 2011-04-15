//
//  CunddMIDIClient.m
//  MidIn
//
//  Created by Daniel Corn on 12.06.10.
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

#import "CunddMIDIClient.h"



@implementation CunddMIDIClient

NSString * const kCunddMIDIDeviceReceivedData = @"CunddMIDIClient.DeviceReceivedData";
NSString * const kCunddMIDIDeviceInformationDidChange = @"kCunddMIDIDeviceInformationDidChange";

//NSString * const kCunddMIDIDeviceReceivedData_private = @"CunddMIDIClient.DeviceReceivedDataPrivate";
//NSString * const kCunddMIDIDeviceInformationDidChange_private = @"kCunddMIDIDeviceInformationDidChangePrivate";

void notifFunction(const MIDINotification *message, void *refCon){
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc]init];
	NSNotificationCenter * defCenter = [NSNotificationCenter defaultCenter];
	BOOL mainThreadOnly = NO;
	

	NSString * messageName;
	NSString * messageDesc = @"";
	switch(message->messageID){
		case 1:
			messageName = @"kMIDIMsgSetupChanged";
			break;
			
		case 2:
			messageName = @"kMIDIMsgObjectAdded";
			break;
	
		case 3:
			messageName = @"kMIDIMsgObjectRemoved";
			break;
			
		case 4:
			messageName = @"kMIDIMsgPropertyChanged";
			break;
	
		case 5:
			messageName = @"kMIDIMsgThruConnectionsChanged";
			break;

		case 6:
			messageName = @"kMIDIMsgSerialPortOwnerChanged";
			break;

		case 7:
			messageName = @"kMIDIMsgIOError";
			break;
			
		default:
			messageName = @"unknown message ID";
	}
	NSLog(@"CunddMIDIClient: Received message: %@ (%i%@)",messageName,message->messageID,messageDesc);
	
	
	
	if(mainThreadOnly){
		void (^postNotification)(void);
		postNotification = ^(void){
			[defCenter postNotificationName:kCunddMIDIDeviceInformationDidChange object:(CunddMIDIClient *)refCon];
			[defCenter postNotificationName:kCunddMIDIDeviceInformationDidChange_private object:(CunddMIDIClient *)refCon];
		};
		
		[[NSOperationQueue mainQueue] addOperationWithBlock:postNotification];
	} else {
		[defCenter postNotificationName:kCunddMIDIDeviceInformationDidChange object:(CunddMIDIClient *)refCon];
		[defCenter postNotificationName:kCunddMIDIDeviceInformationDidChange_private object:(CunddMIDIClient *)refCon];
	}
	
	
//	[pool drain];
	return;
}

void readFunction(const MIDIPacketList *pktlist,void *readProcRefCon,void *srcConnRefCon){
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSLog(@"CunddMIDIClient: Received midi data");
	NSMutableData * tData = [NSMutableData data];
	NSNumber * timeStamp = [NSNumber numberWithInt:100];
	BOOL mainThreadOnly = YES;
	
	for(NSUInteger i = 0;i<pktlist->numPackets;i++){
		MIDIPacket packet = pktlist->packet[i];
		
		if(packet.timeStamp){
			timeStamp = [NSNumber numberWithInt:packet.timeStamp];
		}
		
		
		tData = [NSMutableData dataWithBytes:packet.data length:packet.length];
		
		void (^writeDataOwners)(void);
		writeDataOwners = ^(void){
			[(CunddMIDIClient *)readProcRefCon setPacketData:tData];
			[(CunddMIDIEntity *)srcConnRefCon setPacketData:tData];
		};
		
//		[[NSOperationQueue mainQueue] addOperationWithBlock:writeDataOwners];
		
		[(CunddMIDIClient *)readProcRefCon setPacketData:tData];
		[(CunddMIDIEntity *)srcConnRefCon setPacketData:tData];
	}
	
		
	
	
	if(mainThreadOnly){
		void (^postNotification)(void);
		postNotification = ^(void){
			NSDictionary * userInfo = nil;
			
//			NSLog(@"%@",readProcRefCon);
//			NSLog(@"%@",srcConnRefCon);
			
			userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
						readProcRefCon,@"readProcRefCon",
						readProcRefCon,@"client",
						srcConnRefCon,@"srcConnRefCon",
						srcConnRefCon,@"entity",
						tData,@"data",
						timeStamp,@"timeStamp",
						nil];
			
			
			NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
			[center postNotificationName:kCunddMIDIDeviceReceivedData object:srcConnRefCon userInfo:userInfo];
			[center postNotificationName:kCunddMIDIDeviceReceivedData_private object:srcConnRefCon userInfo:userInfo];
		};
		
		[[NSOperationQueue mainQueue] addOperationWithBlock:postNotification];
		
	} else {
		NSDictionary * userInfo = nil;
		
//		NSLog(@"%@",readProcRefCon);
//		NSLog(@"%@",srcConnRefCon);
		
		userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
					readProcRefCon,@"readProcRefCon",
					readProcRefCon,@"client",
					srcConnRefCon,@"srcConnRefCon",
					srcConnRefCon,@"entity",
					tData,@"data",
					timeStamp,@"timeStamp",
					nil];

		
		NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
		[center postNotificationName:kCunddMIDIDeviceReceivedData object:srcConnRefCon userInfo:userInfo];
		[center postNotificationName:kCunddMIDIDeviceReceivedData_private object:srcConnRefCon userInfo:userInfo];
	}
	
	
	
	
	
//	[pool drain];
}


+(CunddMIDIClient *)sharedInstance{
	static CunddMIDIClient *instance = nil;
	
	if (instance == nil)
		instance = [[self alloc] _hiddenInit];
	
	return instance;
}

-(id) init{
	return [CunddMIDIClient sharedInstance];
}

-(id)_hiddenInit{
	if([super init]){
		OSStatus err;
		CFStringRef clientName = (CFStringRef)@"CunddMIDIClient";
		CFStringRef portName = (CFStringRef)@"CunddMIDIPort";
		
		
		err = MIDIClientCreate(clientName,notifFunction,self,&midiClient);
		if(err){
			NSLog(@"MIDIClientCreate failed: %s (%s)",GetMacOSStatusErrorString(err),GetMacOSStatusCommentString(err));
			return nil;
		}
		
		
		err = MIDIInputPortCreate(midiClient, portName, readFunction, self, &inputPort);
		if(err){
			NSLog(@"MIDIInputPortCreate failed: %s (%s)",GetMacOSStatusErrorString(err),GetMacOSStatusCommentString(err));
			return nil;
		}
		
		
		
		err = MIDIOutputPortCreate(midiClient, CFSTR("Output Port"), &outputPort);
		if (err) {
			NSLog(@"MIDIOutputPortCreate failed: %s (%s)",GetMacOSStatusErrorString(err),GetMacOSStatusCommentString(err));
			return nil;
		}
		
		
		err = MIDIDestinationCreate(midiClient, CFSTR("CunddMIDIDestination"), readFunction,self, &_destinationPoint);
		if (err) {
			NSLog(@"MIDIDestinationCreate failed: %s (%s)",GetMacOSStatusErrorString(err),GetMacOSStatusCommentString(err));
			return nil;
		}
		self.destinationPoint = [[CunddMIDIDestination endpointWithMIDIEndpoint:_destinationPoint] retain];
		
		err = MIDISourceCreate(midiClient, CFSTR("CunddMIDISource"), &_sourcePoint);
		if (err) {
			NSLog(@"MIDISourceCreate failed: %s (%s)",GetMacOSStatusErrorString(err),GetMacOSStatusCommentString(err));
			return nil;
		}
		self.sourcePoint = [[CunddMIDISource endpointWithMIDIEndpoint:_sourcePoint] retain];
		
		devices = [[NSMutableArray array] retain];
		[self rescanDevices];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rescanDevices:) name:kCunddMIDIDeviceInformationDidChange object:self];
	}
	return self;
}


-(void)rescanDevices:(id)sender{
	[self rescanDevices];
}
-(void)rescanDevices{
	NSString * lock = @"locked";
	@synchronized(lock){
		if(!devices) devices = [[NSMutableArray array] retain];
		
		// devices
		for(NSUInteger i = 0;i < MIDIGetNumberOfDevices(); i++){
			MIDIDeviceRef device = MIDIGetDevice(i);
			CunddMIDIDevice * theCunddDevice = [[CunddMIDIDevice deviceWithMIDIDeviceRef:device] retain];
			[devices addObject:theCunddDevice];
		}
		
		
		// external devices
		for(NSUInteger i = 0;i < MIDIGetNumberOfExternalDevices(); i++){
			MIDIDeviceRef device = MIDIGetExternalDevice(i);
			CunddMIDIDevice * theCunddDevice = [[CunddMIDIDevice deviceWithMIDIDeviceRef:device] retain];
			[devices addObject:theCunddDevice];
		}
	}
}

-(OSStatus) bindPortToEntity:(CunddMIDIEntity *)theEntity{
	[theEntity retain];
	CunddMIDISource * source = [theEntity firstSource];
	MIDIEndpointRef coreSource = source.endpoint;
	
	return MIDIPortConnectSource(inputPort, coreSource, theEntity);
}

-(id) bindPortToEntityWithUid:(NSInteger)theUid{
	OSStatus returnStatus = kMIDIObjectNotFound;
	CunddMIDIObject * tObject = [[CunddMIDI objectByUniqueId:theUid] retain];
	if([tObject isKindOfClass: [CunddMIDIEntity class]]){
		returnStatus = [self bindPortToEntity:(CunddMIDIEntity *)tObject];
	}
	
	if(returnStatus == noErr){
		return tObject;
	} else {
		return [[NSValue valueWithPointer:&returnStatus] retain];
	}
}


/*
-(void) dealloc{
	[devices release];
	CFRelease(&inputPort);
	CFRelease(&outputPort);
	CFRelease(&_destinationPoint);
	CFRelease(&_sourcePoint);
	[sourcePoint release];
	[destinationPoint release];
	[super dealloc];
}
 /* */

@synthesize midiClient,inputPort,outputPort,sourcePoint,devices,destinationPoint;
@end
