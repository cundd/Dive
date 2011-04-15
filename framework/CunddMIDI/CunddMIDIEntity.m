//
//  CunddMIDIEntity.m
//  MidIn
//
//  Created by Daniel Corn on 14.06.10.
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

#import "CunddMIDIEntity.h"


@implementation CunddMIDIEntity
static int counter;

NSString * const kCunddMIDIEntityRegistryCollectionName = @"kCunddMIDIEntityRegistryCollectionName";

+(void)printCounter{
	NSLog(@"CunddMIDIEntity counter = %i",counter);
}

+(id)entityWithMIDIEntityRef:(MIDIEntityRef)theEntity{
	return [[[self alloc] initWithEntity:theEntity] autorelease];
}

-(id) initWithEntity:(MIDIEntityRef)theEntity{
	if([self init]){
		CFStringRef tempString;
		SInt32 tempNumber;
		
		entity = theEntity;
		
		MIDIObjectGetIntegerProperty(entity, kMIDIPropertyUniqueID, &tempNumber);
		entityUid = [[NSNumber numberWithInt:tempNumber] retain];
		
		// Look up the registry if the entity exists
		NSString * entityUidString = [NSString stringWithFormat:@"CunddMIDIEntity%@",entityUid];
		CunddMIDIEntity * entityFromRegistry = [CunddAppRegistry collectionRegistry:kCunddMIDIEntityRegistryCollectionName withKey:entityUidString];
		if(entityFromRegistry){
			[entityFromRegistry retain];
			[self release];
			return entityFromRegistry;
		}
		
		MIDIObjectGetIntegerProperty(entity, kMIDIPropertyDeviceID, &tempNumber);
		deviceId = [[NSNumber numberWithLong:tempNumber] retain];
		
		MIDIObjectGetStringProperty(entity, kMIDIPropertyDisplayName, &tempString);
		displayName = (NSString *)tempString;
		
		MIDIObjectGetStringProperty(entity, kMIDIPropertyName, &tempString);
		name = (NSString *)tempString;
		
		MIDIObjectGetStringProperty(entity, kMIDIPropertyManufacturer, &tempString);
		manufacturer = (NSString *)tempString;
		
		
		
		packetData = [[NSMutableData data] retain];
		
		//NSLog(@"CunddMIDIEntity created with: displayName=%@ name=%@ manufacturer=%@ deviceId=%@ uid=%@",displayName,name,manufacturer,deviceId,uid);
		
		// Prepare the sources
		for(NSUInteger i = 0; i < MIDIEntityGetNumberOfSources(entity); i++){
			CunddMIDISource * tSource = [[CunddMIDISource endpointWithMIDIEndpoint:MIDIEntityGetSource(entity, i)] retain];
			[self.sources addObject:tSource];
		}
		
		// Prepare the destinations
		for(NSUInteger i = 0; i < MIDIEntityGetNumberOfSources(entity); i++){
			CunddMIDIDestination * tDest = [[CunddMIDIDestination endpointWithMIDIEndpoint:MIDIEntityGetDestination(entity, i)] retain];
			[self.destinations addObject:tDest];
		}
		
		
		// Register in the registry collection
		[CunddAppRegistry collectionRegistry:self at:kCunddMIDIEntityRegistryCollectionName withKey:entityUidString];
		if(!counter)counter = 0;
		counter++;
	}
	return self;
}


-(id) init{
	if([super init]){
		sources = [[NSMutableArray array] retain];
		destinations = [[NSMutableArray array] retain];
	}
	return self;
}

-(CunddMIDISource *)firstSource{
	return [self sourceAtIndex:0];
}

-(CunddMIDIDestination *)firstDestination{
	return [self destinationAtIndex:0];
}

-(CunddMIDISource *)sourceAtIndex:(NSUInteger)theIndex{
	return [self.sources objectAtIndex:theIndex];
}
-(CunddMIDIDestination *)destinationAtIndex:(NSUInteger)theIndex{
	return [self.destinations objectAtIndex:theIndex];
}
/*
-(MIDIEndpointRef)sourceAtIndex:(NSUInteger)theIndex{
	return MIDIEntityGetSource(entity, theIndex);
}
-(MIDIEndpointRef)destinationAtIndex:(NSUInteger)theIndex{
	return MIDIEntityGetDestination(entity, theIndex);
}*/

//-(NSString *)customDescription{
-(NSString *)description{
	Byte * sentCommand	= malloc(1);
	Byte * sentKey		= malloc(1);
	Byte * sentVelocity = malloc(1);
	NSDictionary * descDict;
	NSString * returnString;
	
	*sentCommand = 0;
	*sentKey = 0;
	*sentVelocity = 0;
	
	
	NSString * lock = @"locked";
	@synchronized(lock){
		if(self.packetData != nil){
			if([self.packetData length] > 0){
				[self.command getValue:&sentCommand];
				[self.key getValue:&sentKey];
				[self.velocity getValue:&sentVelocity];
			}
		}
		
		if(self.entityUid){
			[entityUid retain];
			descDict = [NSDictionary dictionaryWithObjectsAndKeys:
						self.name,@"name",
						self.manufacturer,@"manufacturer",
						self.entityUid,@"UID",
						self.deviceId,@"deviceId",
						[NSString stringWithFormat:@"%X",*sentCommand],@"command",
						[NSString stringWithFormat:@"%X",*sentKey],@"key",
						[NSString stringWithFormat:@"%X",*sentVelocity],@"velocity",
						self.output,@"output",
						self.notes,@"notes",
						nil
						];
		} else {
			descDict = [NSDictionary dictionaryWithObjectsAndKeys:
						self.name,@"name",
						self.manufacturer,@"manufacturer",
						@"No unique ID",@"UID",
						self.deviceId,@"deviceId",
						[NSString stringWithFormat:@"%X",*sentCommand],@"command",
						[NSString stringWithFormat:@"%X",*sentKey],@"key",
						[NSString stringWithFormat:@"%X",*sentVelocity],@"velocity",
						self.output,@"output",
						self.notes,@"notes",
						nil
						];
		}
	}
	
	returnString = [[NSString stringWithFormat:@"CunddMIDIEntity - %@",[descDict description]] retain];
	
	free(sentCommand);
	free(sentKey);
	free(sentVelocity);
		
	return returnString;
}

-(void) dealloc{
	[packetData release];
	[deviceId release];
	[super dealloc];
}

@synthesize entity,displayName,name,manufacturer,deviceId,entityUid,sources,destinations;
@end
