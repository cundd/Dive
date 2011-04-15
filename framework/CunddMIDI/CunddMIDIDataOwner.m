//
//  CunddMIDIDataOwner.m
//  CunddMIDI
//
//  Created by Daniel Corn on 22.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddMIDIDataOwner.h"


@implementation CunddMIDIDataOwner

-(id) init{
	if([super init]){
		notes = [[NSMutableDictionary dictionary] retain];
	}
	return self;
}

-(void) setPacketData:(NSMutableData *)theValue{
	NSString * noteName;
	Byte vale[3];
	[theValue getBytes:&vale length:3];
	
	
	NSString * lock = @"locked";
	@synchronized(lock){
		[super setPacketData:theValue];
		
		// Set the notes
		noteName = [[NSString stringWithFormat:@"%X",vale[1]] retain];
		
		CunddMIDIData * noteData = [[CunddMIDIData MIDIDataWithMutableData:theValue] retain];
		[self willChangeValueForKey:noteName];
		[self.notes setObject:noteData forKey:noteName];
		[self didChangeValueForKey:noteName];
	}
	
	[noteName release];
}

#pragma mark KVC for the stored notes
-(id) valueForUndefinedKey:(NSString *)aKey{
	// Try to return an existing object if one exists, else return a zero-velocity note
	if([notes objectForKey:aKey]){
		return [notes objectForKey:aKey];
	} else {
		CunddMIDIData * zeroData = [[CunddMIDIData zeroMIDIData] retain];
		[notes setObject:zeroData forKey:aKey];
		//[zeroData autorelease];
		return [notes objectForKey:aKey];
	}
	
}


-(void) dealloc{
	[notes release];
	[super dealloc];
}
@synthesize notes;
@end
