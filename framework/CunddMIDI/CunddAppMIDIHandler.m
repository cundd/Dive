//
//  CunddAppMIDIHandler.m
//  Dive
//
//  Created by Daniel Corn on 18.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddAppMIDIHandler.h"


@implementation CunddAppMIDIHandler

NSString * const kCunddAppMIDIHandlerUserDefaultsEntitiesPath = @"CunddApp.CunddAppMIDIHandler.defaultsEntities";

-(id) init{
	if([super init]){
		client = [CunddMIDIClient sharedInstance];
		
		// Bind the saved entities
		[self getUserDefaultEntities];
		if(userDefaultEntities){
			for(NSNumber * entityUid in userDefaultEntities){
				[client bindPortToEntityWithUid:[entityUid intValue]];
			}
		}
		
		// Add the observer
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMIDINotification:) name:kCunddMIDIDeviceReceivedData object:nil];
		
	}
	return self;
}

-(NSString *) defaultsPath{
	return kCunddAppMIDIHandlerPath;
}


-(BOOL) handleMIDINotification:(NSNotification *)notif{
	NSString * theMapKey;
	CunddMIDIEntity * entity = (CunddMIDIEntity *)[[notif userInfo] objectForKey:@"entity"];
	NSString * recording = [CunddAppRegistry registry:kCunddAppMapCreatorRecording];
	
	if(recording){
		if([recording intValue] == 1){
			// Record this control
			CunddAppAbstractMapCreator * mapCreator = [CunddAppRegistry registry:kCunddAppMapCreatorCurrent];
			if([[mapCreator className] isEqualToString:@"CunddAppMIDIMapCreator"]){
				if([mapCreator recordCaller:entity]) return YES;
			}
		}
	}
	
	
//	theMapKey = [entity dataAsString];
	theMapKey = [NSString stringWithFormat:@"%@.%@",entity.name,[entity dataAsString]];
	
	return [self handleMapKey:theMapKey withObject:entity];
}

-(NSArray *) getUserDefaultEntities{
	// Load userDefaults
	NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
	self.userDefaultEntities = [userDefaults arrayForKey:kCunddAppMIDIHandlerUserDefaultsEntitiesPath];
	return self.userDefaultEntities;
}

@synthesize client,userDefaultEntities;
@end
