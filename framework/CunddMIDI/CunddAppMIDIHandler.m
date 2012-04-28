//
//  CunddAppMIDIHandler.m
//  Dive
//
//  Created by Daniel Corn on 18.06.10.
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
