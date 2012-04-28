// 
//  CunddDiveVideoChainSettings.m
//  Dive
//
//  Created by Daniel Corn on 22.04.10.
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

#import "CunddDiveVideoChainSettings.h"


@implementation CunddDiveVideoChainSettings
static int indexCounter;

-(id) init{
	if([super init]){
		// Set the index
		if(!indexCounter)indexCounter = 0;
		index = [NSNumber numberWithInt:indexCounter];
		indexCounter++;
		
		// Create effect-settings-objects
//		self.pslObject1 = [[[CunddDiveEffect alloc] init] autorelease];
//		self.pslObject2 = [[[CunddDiveEffect alloc] init] autorelease];
//		self.pslObject3 = [[[CunddDiveEffect alloc] init] autorelease];
		
		
		// Load userDefaults
		NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
		if(!userDefaultsKey)[self getUserDefaultsKey];
		
		NSMutableDictionary * appDefaults = [CunddConfig valueForKeyPath:@"Defaults.CunddDive.CunddDiveVideoChainSettings"];
		[userDefaults registerDefaults:
		 [NSDictionary dictionaryWithObject:appDefaults forKey:userDefaultsKey]
		 ];
		
		[self setPropertiesFromDictionary:[userDefaults dictionaryForKey:userDefaultsKey]];
	}
	
	return self;
}


+(CunddDiveVideoChainSettings *) settingsWithEffectViewContainer:(CunddDiveEffectViewContainer *)aView{	
	return [[[self alloc] initWithEffectViewContainer:aView] autorelease];
}
-(CunddDiveVideoChainSettings *) initWithEffectViewContainer:(CunddDiveEffectViewContainer *)aView{
	if([self init]){
		self.effectViewContainer = aView;
		
		// Create effect-settings-objects
		if(!self.effectViewContainer || !self.effectViewContainer.slot1 || !self.effectViewContainer.slot2 || !self.effectViewContainer.slot3){
			NSLog(@"CunddDiveVideoChainSettings effectViewContainer or it's slots are not set");
			[NSApp terminate:nil];
		} else {
			self.pslObject1 = [CunddDiveEffect effectWithTargetView:self.effectViewContainer.slot1 andOwner:self];
			self.pslObject2 = [CunddDiveEffect effectWithTargetView:self.effectViewContainer.slot2 andOwner:self];
			self.pslObject3 = [CunddDiveEffect effectWithTargetView:self.effectViewContainer.slot3 andOwner:self];
		}
		
		
//		self.pslObject1.targetView = self.effectViewContainer.slot1;
//		self.pslObject2.targetView = self.effectViewContainer.slot2;
//		self.pslObject3.targetView = self.effectViewContainer.slot3;
//		[self.pslObject1 loadNib];
//		[self.pslObject2 loadNib];
//		[self.pslObject3 loadNib];
	}
	return self;
}


-(NSString *) userDefaultsKey{
	if(!userDefaultsKey)[self getUserDefaultsKey];
	return userDefaultsKey;
}


-(void) getUserDefaultsKey{
	userDefaultsKey = [NSString stringWithFormat:@"%@%@",
					   [CunddConfig valueForKeyPath:@"Constants.CunddDive.kCunddVideoChainSettingsUserDefaultsKey"],
					   index];
	return;
}


-(void)setPropertiesFromDictionary:(NSDictionary *)dictionary{
	// For every key in the given dictionary
	for(NSString * propertyKey in [dictionary allKeys]){
		[self debug:@"setPropertiesFromDictionary with propertyKey: %@" o:propertyKey];
		if([self isValidInstanceAndUserDefaultsProperty:propertyKey]){
			[self setValue:[dictionary valueForKey:propertyKey] forKey:propertyKey];
		}
	}
}

-(void)setPropertiesFromUserDefaults{
	NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
	[self setPropertiesFromDictionary:[userDefaults dictionaryForKey:userDefaultsKey]];
}


-(BOOL)isUserDefaultsValidProperty:(NSString *)propertyKey{
	if([propertyKey isEqualToString:@"effectViewContainer"])return NO;
	
	
	NSRange foundPsl = [propertyKey rangeOfString:@"psl"];
	NSRange foundArgsPsl = [propertyKey rangeOfString:@"argsPsl"];
	
	[self debug:@"found location=%@ %@" o:[NSNumber numberWithInt:foundPsl.location] o:[NSNumber numberWithInt:foundPsl.location == NSNotFound]];
	[self debug:@"dont skip = %i" o:[NSNumber
									 numberWithInt:[CunddConfig isTrue:@"Defaults.CunddDive.CunddDiveVideoChainSettings.set_property_validate_esObjects"]]];
	
	// Check if the current propertyKey doesn't stand for an esObject or if they shall be set
	if(
	   (foundPsl.location == NSNotFound && foundArgsPsl.location == NSNotFound)
	   || 
	   [CunddConfig isTrue:@"Defaults.CunddDive.CunddDiveVideoChainSettings.set_property_dont_skip_esObjects"]
	   ){
		return YES;
	} else {
		return NO;
	}
}


-(BOOL) isValidInstanceProperty:(NSString *)propertyKey{
	BOOL (^isEqualBlock)(id obj, NSUInteger idx, BOOL *stop);
	isEqualBlock = ^ BOOL (id obj, NSUInteger idx, BOOL *stop){
		if([obj isEqualToString:propertyKey]){
			*stop = TRUE;
			return TRUE;
		}
		return FALSE;
	};
	// */
	
	NSUInteger oneItemDidPassTest = [[self cundd_getPropertyList] indexOfObjectPassingTest:
									 isEqualBlock
									 ];
	
	if(oneItemDidPassTest != NSNotFound){
		return YES;
	} else {
		return NO;
	}
}

-(BOOL) isValidInstanceAndUserDefaultsProperty:(NSString *)propertyKey{
	if([self isUserDefaultsValidProperty:propertyKey] && [self isValidInstanceProperty:propertyKey]){
		return YES;
	} else {
		return NO;
	}
}




#pragma mark Save settings on object deletion
-(void) dealloc{
	[self updateUserDefaults];
	[super dealloc];
}
-(void) finalize{
	[self updateUserDefaults];
	[super finalize];
}


-(void) updateUserDefaults{
	// Write userDefaults
	NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
	NSMutableDictionary * newDefaults = [NSMutableDictionary dictionary];
	for(NSString * propertyKey in [self cundd_getPropertyList]){
		id propertyValue = [self valueForKey:propertyKey];
		if(propertyValue && [self isUserDefaultsValidProperty:propertyKey]){
			[newDefaults setValue:propertyValue forKey:propertyKey];
		}
	}
	
	
	if(!userDefaultsKey)[self getUserDefaultsKey];
	[userDefaults setValue:newDefaults forKey:userDefaultsKey];
}

/*
-(id) valueForUndefinedKey:(NSString *)key{
	[self debug:@"CunddDiveVideoChainSettings valueForKey:" o:key];
	return [propertyValues valueForKey:key];
}

// */

#pragma mark Setters
-(void) loadTrack:(CunddITunesTrack *)aTrack{
	[self debug:@"LoadTrack"];
	[self setPropertiesFromTrack:aTrack];
	
}
-(void) setPropertiesFromTrack:(CunddITunesTrack *)aTrack{
	
	NSString * lock = @"locked";
	@synchronized(lock){
		if(![aTrack isKindOfClass:[CunddITunesTrack class]]){
			[lock release];
			return;
		}
		[aTrack retain];
		[aTrack.trackinfo retain];
		if(!aTrack.trackinfo){
			[aTrack release];
			[aTrack.trackinfo release];
			return;
		}
		NSDictionary * tempTrackinfo = [NSDictionary dictionaryWithDictionary:aTrack.trackinfo];
		[self setPropertiesFromDictionary:tempTrackinfo];
		
		if(!tempTrackinfo){
			[aTrack release];
			[aTrack.trackinfo release];
			return;
		}
		
		NSLog(@"aTrack=%@",aTrack);
		NSLog(@"aTrack.trackinfo=%@",tempTrackinfo);
		
		if([[aTrack valueForKey:@"Location"] isKindOfClass:[NSString class]]){
			self.movieLocation = [self preparedMovieLocation:[aTrack valueForKey:@"Location"]];
		}
		
		self.track = aTrack;
		
	}
	[aTrack release];
	[aTrack.trackinfo release];
}


-(NSString *) preparedMovieLocation:(NSString *)theLocation{
	NSString * homeDir = [NSString stringWithFormat:@"file://localhost%@",NSHomeDirectory()];
	NSString * relativeLocation = [[NSString stringWithFormat:@"%@",[theLocation stringByReplacingOccurrencesOfString:homeDir withString:@"~"]] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[self debug:@"preparedMovieLocation theLocation=%@" o:theLocation];
	[self debug:@"preparedMovieLocation relativeLocation=%@" o:relativeLocation];
	
	[theLocation release];
	return relativeLocation;
}




// */
-(void) setValue:(id)value forUndefinedKey:(NSString *)key{
	NSString * badPrefix = @"patch.";
	if([key hasPrefix:badPrefix]){
		NSString * newKey = [key stringByReplacingOccurrencesOfString:badPrefix withString:@""];
		[self setValue:value forKey:newKey];
	}
}
/*
-(void) setValue:(id)value forUndefinedKey:(NSString *)key{
	[self debug:@"CunddDiveVideoChainSettings setValue:forUndefinedKey:" o:key];
	[value retain];
	[key retain];
	[propertyValues setObject:value forKey:key];
	NSLog(@"%@",propertyValues);
	//[self updateUserDefaults];
	return;
}
*/
-(void) setValue:(id)value forKey:(NSString *)key{
	[self debug:@"CunddDiveVideoChainSettings setValue:%@ forKey:%@" o:value o:key];
	[super setValue:value forKey:key];
	//[self updateUserDefaults];
}
 // */





#pragma mark Getters


-(id) valueForUndefinedKey:(NSString *)key{
	NSString * badPrefix = @"patch.";
	if([key hasPrefix:badPrefix]){
		NSString * newKey = [key stringByReplacingOccurrencesOfString:badPrefix withString:@""];
		return [self valueForKey:newKey];
	}
	return nil;
}



#pragma mark Effect-Getters and Setters
/* All the effect-properties are defined through special getters */
-(NSArray *)argsPsl1{
	return [self.pslObject1 collectArgumentValues];
}
-(NSArray *)argsPsl2{
	return [self.pslObject2 collectArgumentValues];
}
-(NSArray *)argsPsl3{
	return [self.pslObject3 collectArgumentValues];
}

-(NSNumber *)indexPsl1{
	return self.pslObject1.index;
}
-(NSNumber *)indexPsl2{
	return self.pslObject2.index;
}
-(NSNumber *)indexPsl3{
	return self.pslObject3.index;
}


/* Shortcuts for the effects */
-(CunddDiveEffect *) psl1{
	[self debug:@"CunddDiveVideoChainSettings get psl1"];
	return pslObject1;
}
-(CunddDiveEffect *) psl2{
	[self debug:@"CunddDiveVideoChainSettings get psl2"];
	return pslObject2;
}
-(CunddDiveEffect *) psl3{
	[self debug:@"CunddDiveVideoChainSettings get psl3"];
	return pslObject3;
}

/* All the effect-properties are defined through special setters */
-(void) setArgsPsl1:(NSMutableArray *)value{
//	[self didChangeValueForKey:@"argsPsl1"];
	self.pslObject1.arguments = value;
}
-(void) setArgsPsl2:(NSMutableArray *)value{
//	[self didChangeValueForKey:@"argsPsl2"];
	self.pslObject2.arguments = value;
}
-(void) setArgsPsl3:(NSMutableArray *)value{
//	[self didChangeValueForKey:@"argsPsl3"];
	self.pslObject3.arguments = value;
}

-(void) setIndexPsl1:(NSNumber *)value{
//	[self didChangeValueForKey:@"indexPsl1"];
	self.pslObject1.index = value;
}
-(void) setIndexPsl2:(NSNumber *)value{
//	[self didChangeValueForKey:@"indexPsl2"];
	self.pslObject2.index = value;
}
-(void) setIndexPsl3:(NSNumber *)value{
//	[self didChangeValueForKey:@"indexPsl3"];
	self.pslObject3.index = value;
}



@dynamic indexPsl1,indexPsl2,indexPsl3,alpha,argsPsl1,argsPsl2,argsPsl3;
@synthesize movieLocation,speed,selectionStart,selectionDuration,loop,psl,
	pslObject1,pslObject2,pslObject3,effectViewContainer,index,screen,
	width,height,x,y,mode,stack_level,track;



@end
