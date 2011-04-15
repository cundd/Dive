//
//  MidInAppDelegate.m
//  MidIn
//
//  Created by Daniel Corn on 12.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "MIDITesterAppDelegate.h"

@implementation MIDITesterAppDelegate


NSString * const kCunddMIDIButtonStateOnPress		= @"kCunddMIDIButtonStateOnPress";
NSString * const kCunddMIDIButtonStateOnRelease		= @"kCunddMIDIButtonStateOnRelease";
NSString * const kCunddMIDIButtonStateOffPress		= @"kCunddMIDIButtonStateOffPress";
NSString * const kCunddMIDIButtonStateOffRelease	= @"kCunddMIDIButtonStateOffRelease";

@synthesize window,midiClient,key;

-(void) toggleRecording:(id)sender{

	if(!mapCreator)	mapCreator = [CunddAppMIDIMapCreator sharedInstance];
	if(!mapCreator.recording){
		[mapCreator startRecording];
	}
	NSLog(@"toggleRecording");
}

-(id) init{
	if([super init]){
		value1 = [NSNumber numberWithInt:0];
		value2 = [NSNumber numberWithInt:0];
		value3 = [NSNumber numberWithInt:0];
		value4 = [NSNumber numberWithInt:0];
		value5 = [NSNumber numberWithInt:0];
		value6 = [NSNumber numberWithInt:0];
		value7 = [NSNumber numberWithInt:0];
		value8 = [NSNumber numberWithInt:0];
	}
	return self;
}

-(void) awakeFromNib{
	NSLog(@"awakeFromNib");
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	NSLog(@"applicationDidFinishLaunching");

	
	
	midiClient = [CunddMIDIClient sharedInstance];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMidi:) name:kCunddMIDIDeviceReceivedData object:nil];
	NSLog(@"g");
	
//	CunddMIDIEntity * entity1 = [CunddMIDI objectByUniqueId:1421904];
	[midiClient bindPortToEntityWithUid:-1256072385];
	
	
	printf("\n");
	printf("\n");
//	CunddMIDIEntity * entity = [CunddMIDI objectByUniqueId:-993762735];
//	NSLog(@"entity=%@ entity.name=%@ entity.uid=%@",entity,entity.name,entity.uid);
	
	
//	OSStatus stat = [midiClient bindPortToEntity:entity];
//	NSLog(@"stat=%i",stat);
//	NSLog(@"%s",GetMacOSStatusErrorString(stat));
//	NSLog(@"%s",GetMacOSStatusCommentString(stat));
	
	
	
	
	[midiClient bindPortToEntityWithUid:-1882965413];
	[midiClient bindPortToEntityWithUid:-993762735];
	
	
	printf("\n");
	printf("\n");
	for(CunddMIDIDevice * device in midiClient.devices){
		NSLog(@"device = %@ (count=%i)",device,[device.entities count]);
		
		for(CunddMIDIEntity * entity in device.entities){
			//NSLog(@"  entity=%@ name=%@ uid=%@",entity,entity.name,entity.entityUid);
			NSLog(@"  entity=%@ name=%@ uid=%@",entity,entity.name,entity.entityUid);
			NSLog(@"    dest=%@",[entity.destinations objectAtIndex:0]);
			NSLog(@"    sour=%@",[entity.sources objectAtIndex:0]);
		}
	}
	
	
	
	
	_keysStates = [[NSMutableDictionary dictionary] retain];
	
	
	OSStatus state;
	
	self.launchpad = (CunddMIDIEntity *)[midiClient bindPortToEntityWithUid:-993762735];
//	self.launchpad = (CunddMIDIEntity *)[midiClient bindPortToEntityWithUid:-1882965413];
	[launchpad retain];
	CunddMIDIDestination * destination = [launchpad firstDestination];
	[destination setOutputPort:midiClient.outputPort];
	
	NSLog(@"send to %@",[launchpad name]);
	
	Byte reset[3] = {0xB0,0x00,0x00};
	state = [destination sendBytes:reset];
	
	Byte layout[3] = {0xB0,0x00,0x01};
	state = [destination sendBytes:layout];
	
	NSLog(@"Fing");
}

-(void)receiveMidi:(NSNotification*)notif{
	OSStatus state;
	
	
	NSLog(@"notif data=%@\t\tinfo=%@",[(CunddMIDIClient *)[notif object] packetData],[notif userInfo]);
	
	
//	NSData * currentPacketData = [(CunddMIDIEntity *)[[notif userInfo] objectForKey:@"entity"] packetData];
	CunddMIDIEntity * entity = (CunddMIDIEntity *)[[notif userInfo] objectForKey:@"entity"];
	
	
	
	
	CunddMIDIDestination * destination = [(CunddMIDIEntity *)launchpad firstDestination];
	[destination setOutputPort:midiClient.outputPort];
	
	NSLog(@"userinfo=%@ enti=%@",[notif userInfo],[entity description]);
	
	
	/* MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW */
	/* NEU */
	/* MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW */
	
	/*
	Byte * command;
	Byte * sentKey;
	Byte * velocity;
	
	[entity getCommand:&command];
	[entity getKey:&sentKey];
	[entity getVelocity:&velocity];
	
	if(!_keysStates)_keysStates = [[NSMutableDictionary dictionary] retain];
	if(*command == 0xb0) [self sendData:nil];
	
	NSLog(@"%X",*command);
	NSLog(@"%X",*sentKey);
	NSLog(@"%X",*velocity);
	
	NSString * dictKey = [NSString stringWithFormat:@"key%X",*sentKey];
	
	
	
	Byte off[3] = {0x80,*sentKey,0x00};
	Byte green[3] = {0x90,*sentKey,0x3C};
	Byte amber[3] = {0x90,*sentKey,0x1F};
	Byte red[3] = {0x90,*sentKey,0x0F};
	
	if([_keysStates objectForKey:dictKey] == kCunddMIDIButtonStateOnPress || ![_keysStates objectForKey:dictKey]){
		NSLog(@"%@",kCunddMIDIButtonStateOnPress);
		state = [destination sendBytes:amber];
		[_keysStates setObject:kCunddMIDIButtonStateOnRelease forKey:dictKey];
	} else 
	if([_keysStates objectForKey:dictKey] == kCunddMIDIButtonStateOnRelease){
		NSLog(@"%@",kCunddMIDIButtonStateOnRelease);
		state = [destination sendBytes:green];
		[_keysStates setObject:kCunddMIDIButtonStateOffPress forKey:dictKey];
	} else 
	if([_keysStates objectForKey:dictKey] == kCunddMIDIButtonStateOffPress){
		NSLog(@"%@",kCunddMIDIButtonStateOffPress);
		state = [destination sendBytes:red];
		[_keysStates setObject:kCunddMIDIButtonStateOffRelease forKey:dictKey];
	} else 
	if([_keysStates objectForKey:dictKey] == kCunddMIDIButtonStateOffRelease){
		NSLog(@"%@",kCunddMIDIButtonStateOffRelease);
		state = [destination sendBytes:off];
		[_keysStates setObject:kCunddMIDIButtonStateOnPress forKey:dictKey];
	}
	/* */
	

	/* MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW */
	/* ALT */
	/* MWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW */
	/*
	Byte command = 0xff;
	Byte sentKey = 0xff;
	Byte value = 0xff;
	
	
	[currentPacketData getBytes:&command	range:NSMakeRange(0, 1)];
	NSLog(@"DD %X",command);
	
	if([currentPacketData length] >= 2)	[currentPacketData getBytes:&sentKey	range:NSMakeRange(1, 1)];
//	NSLog(@"EE %X",sentKey);
	if([currentPacketData length] >= 3)	[currentPacketData getBytes:&value		range:NSMakeRange(2, 1)];
//	NSLog(@"FF %X",value);
	if(!_keysStates)_keysStates = [[NSMutableDictionary dictionary] retain];
	
	
	if(command == 0xb0) [self sendData:nil];
	
	
	
	NSString * dictKey = [NSString stringWithFormat:@"key%X",sentKey];
	
	
	
	Byte off[3] = {0x80,sentKey,0x00};
	Byte green[3] = {0x90,sentKey,0x1c};
	Byte amber[3] = {0x90,sentKey,0x1d};
	Byte red[3] = {0x90,sentKey,0x0d};
	
	if([_keysStates objectForKey:dictKey] == kCunddMIDIButtonStateOnPress || ![_keysStates objectForKey:dictKey]){
		NSLog(@"%@",kCunddMIDIButtonStateOnPress);
		state = [destination sendBytes:amber];
		[_keysStates setObject:kCunddMIDIButtonStateOnRelease forKey:dictKey];
	} else 
	if([_keysStates objectForKey:dictKey] == kCunddMIDIButtonStateOnRelease){
		NSLog(@"%@",kCunddMIDIButtonStateOnRelease);
		state = [destination sendBytes:green];
		[_keysStates setObject:kCunddMIDIButtonStateOffPress forKey:dictKey];
	} else 
	if([_keysStates objectForKey:dictKey] == kCunddMIDIButtonStateOffPress){
		NSLog(@"%@",kCunddMIDIButtonStateOffPress);
		state = [destination sendBytes:red];
		[_keysStates setObject:kCunddMIDIButtonStateOffRelease forKey:dictKey];
	} else 
	if([_keysStates objectForKey:dictKey] == kCunddMIDIButtonStateOffRelease){
		NSLog(@"%@",kCunddMIDIButtonStateOffRelease);
		state = [destination sendBytes:off];
		[_keysStates setObject:kCunddMIDIButtonStateOnPress forKey:dictKey];
	}
	
	/*
	NSString * dictKey = [NSString stringWithFormat:@"key%X",sentKey];
	if([_keysStates objectForKey:dictKey]){
		
		if(command == 0x80){
			NSLog(@"off");
			Byte off[3] = {0x80,sentKey,0x00};
			state = [destination sendBytes:off];
			[_keysStates removeObjectForKey:dictKey];
		} else {
			NSLog(@"red");
			Byte red[3] = {0x90,sentKey,0x0d};
			state = [destination sendBytes:red];
		}
		
	} else {
		NSLog(@"green");
		Byte green[3] = {0x90,sentKey,0x1d};
		
		if(command == 0x80){
			NSLog(@"green off");
			
		}
		if(command == 0x90){
			NSLog(@"green on");
		}
		state = [destination sendBytes:green];
		[_keysStates setObject:@"on" forKey:dictKey];
	}
	
	/*
	NSLog(@"%s",GetMacOSStatusErrorString(state));
	NSLog(@"%s",GetMacOSStatusCommentString(state));
	/* */
}

-(void)sendData:(id)sender{
	OSStatus state;
	
	[CunddMIDIEntity printCounter];
	
	
	CunddMIDIDestination * destination = [launchpad firstDestination];
	[destination setOutputPort:midiClient.outputPort];
	
	NSLog(@"send to %@",[launchpad name]);
	
	Byte reset[3] = {0xB0,0x00,0x00};
	state = [destination sendBytes:reset];
	
	_keysStates = [[NSMutableDictionary dictionary] retain];
	/*
	OSStatus state;
	
	id green = [midiClient bindPortToEntityWithUid:-993762735];
	CunddMIDIDestination * destination = [(CunddMIDIEntity *)green firstDestination];
	[destination setOutputPort:midiClient.outputPort];
	
	NSLog(@"send to %@ %i",[green name],(MIDIEndpointRef)destination.endpoint);
	
	MIDIEntityRef ref;
	MIDIEndpointGetEntity(destination.endpoint, &ref);
	CFPropertyListRef proList;
	MIDIObjectGetProperties(destination.endpoint, &proList, YES);
	NSLog(@"%@ %s %i",(NSDictionary *)proList);
	
	MIDIObjectGetProperties(ref, &proList, YES);
	NSLog(@"%@ %s %i",(NSDictionary *)proList);
	
	
	Byte on[3] = {0x90,0x01,0x3C};
	Byte on2[3] = {0x90,0x40,0x3C};
	Byte off[3] = {0x80,0x01,0x0C};
	Byte allOn[3] = {0xb0,0x0,0x7e};
	
	state = [destination sendBytes:on];
	state = [destination sendBytes:on2];
	state = [destination sendBytes:off];
	
	NSLog(@"%s",GetMacOSStatusErrorString(state));
	NSLog(@"%s",GetMacOSStatusCommentString(state));
	
	
	NSLog(@"send to CunddMIDISource");
	
	state = [self.midiClient.sourcePoint sendBytes:on];
	
	NSLog(@"%s",GetMacOSStatusErrorString(state));
	NSLog(@"%s",GetMacOSStatusCommentString(state));
	printf("\n");
	/* */
}

@synthesize launchpad,value1,value2,value3,value4,value5,value6,value7,value8;
@end

/*
//
// Programmer:    Craig Stuart Sapp <craig@ccrma.stanford.edu>
// Creation Date: Mon Dec 21 18:00:42 PST 1998
// Last Modified: Mon Dec 21 18:00:42 PST 1998
// Filename:      ...linuxmidi/output/method1.c
// Syntax:        C 
// $Smake:        gcc -O -o %b %f && strip %b
//
// Description:   This program sends out a single MIDI note (middle C)
//		  and then exits.  The MIDI driver usually turns the
//                note off automatically when the program is exited.
//

#include <linux/soundcard.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>

int main(void) {
	char* device = "/dev/sequencer";
	unsigned char devnum = 0;
	unsigned char packet[4] = {SEQ_MIDIPUTC, 0, devnum, 0};
	
	
	// step 1: open the OSS device for writing
	int fd = open(device, O_WRONLY);
	if (fd < 0) {
		printf("Error: cannot open %s\n", device);
		exit(1);
	}
	
	
	// step 2: write the note-on message to MIDI output
	packet[1] = 0x90;                        // note-on MIDI command
	write(fd, packet, sizeof(packet));
	packet[1] = 60;                          // kenumber: 60 = middle c
	write(fd, packet, sizeof(packet));
	packet[1] = 127;                         // attack velocity: 127 = loud
	write(fd, packet, sizeof(packet));   
	
	
	// step 3: (optional) close the device
	close(fd);
	
	
	return 0;
}
/* */