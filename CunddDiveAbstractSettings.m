//
//  CunddDiveAbstractSettings.m
//  Dive
//
//  Created by Daniel Corn on 11.05.10.
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

#import "CunddDiveAbstractSettings.h"


@implementation CunddDiveAbstractSettings


-(NSString *) userDefaultsKey{
	if(!userDefaultsKey)[self getUserDefaultsKey];
	return userDefaultsKey;
}



-(void) getUserDefaultsKey{
	userDefaultsKey = [NSString stringWithFormat:@"%@%@",
					   [CunddConfig valueForKeyPath:
						[NSString stringWithFormat:@"Constants.CunddDive.k%s",object_getClassName(self)]
						],
					   index];
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

@synthesize index;
@end
