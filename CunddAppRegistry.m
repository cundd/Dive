//
//  CunddAppRegistry.m
//  Dive
//
//  Created by Daniel Corn on 12.05.10.
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

#import "CunddAppRegistry.h"


@implementation CunddAppRegistry
+(CunddAppRegistry *) defaultRegistry{
	static CunddAppRegistry *sharedRegistryInstance = NULL;

	NSString * lock = @"locked";
	@synchronized(lock) {
		if (sharedRegistryInstance == NULL)
			sharedRegistryInstance = [[[self alloc] init] retain];
	}
	
	return sharedRegistryInstance;
}

-(id) init{
	if([super init]){
		_registeredObjects = [NSMutableDictionary dictionary];
		[_registeredObjects retain];
	}
	return self;
}

#pragma mark Write data
+(void) registry:(id)value at:(NSString *)key{
	[[self defaultRegistry] registry:value at:key];
}
+(void) registerValue:(id)value at:(NSString *)key{
	[[self defaultRegistry] registry:value at:key];
}

-(void) registry:(id)value at:(NSString *)key{
	[_registeredObjects setValue:value forKey:key];
}



#pragma mark Read data
+(id) registry:(NSString *)key{
	return [[self defaultRegistry] registryForKey:key];	
}
+(id) registryForKey:(NSString *)key{
	return [[self defaultRegistry] registryForKey:key];
}

-(id) registryForKey:(NSString *)key{
	return [_registeredObjects valueForKey:key];
}



#pragma mark Collection write data
+(id) collectionRegistry:(id)value at:(NSString *)collectionName withKey:(NSString *)theKey{
	NSMutableDictionary * collection = [self registry:collectionName];
	
	// If a collection exists read the data and add the value to the collection
	if(collection){
		if(!theKey) theKey = [NSString stringWithFormat:@"value%i",[collection count]];
		
		[collection setObject:value forKey:theKey];
	} else {
		if(!theKey) theKey = @"value0";
		
		collection = [[NSMutableDictionary dictionary] retain];
		[collection setObject:value forKey:theKey];
		[self registry:collection at:collectionName];
	}
	return collection;
}

+(id) collectionRegistry:(id)value at:(NSString *)collectionName{
	return [self collectionRegistry:value at:collectionName withKey:nil];
}


#pragma mark Collection read data
+(id) collectionRegistry:(NSString *)collectionName withKey:(NSString *)theKey{
	NSMutableDictionary * collection = (NSMutableDictionary *)[self collectionRegistry:collectionName];
	return [collection objectForKey:theKey];
}
+(id) collectionRegistry:(NSString *)collectionName{
	return [self registry:collectionName];
}

@end