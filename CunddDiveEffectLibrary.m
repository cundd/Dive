//
//  CunddDiveEffectLibrary.m
//  Dive
//
//  Created by Daniel Corn on 29.04.10.
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

#import "CunddDiveEffectLibrary.h"


@implementation CunddDiveEffectLibrary
+(CunddDiveEffectLibrary *) sharedLibrary {
    static CunddDiveEffectLibrary *sharedCunddDiveEffectLibraryInstance = NULL;
	
    @synchronized(self) {
        if (sharedCunddDiveEffectLibraryInstance == NULL)
            sharedCunddDiveEffectLibraryInstance = [[self alloc] init];
    }
    return (sharedCunddDiveEffectLibraryInstance);
}

-(id) init{
	if([super init]){
		library = [CunddConfig valueForKeyPath:@"Defaults.CunddDive.Effects"];
		
		[self removeHidden];
		
		// Write all the effects to a dictionary where the effect-names are the keys
		NSMutableDictionary * tempDict = [NSMutableDictionary dictionary];
		for(NSDictionary * effect in library){
			[tempDict setObject:effect forKey:[effect valueForKey:@"Name"]];
		}
		self.libraryDictionary = [NSDictionary dictionaryWithDictionary:tempDict];
		[self debug:@"library %@" o:library];
		[self debug:@"libraryDictionary %@" o:libraryDictionary];
		
		
		// Create the sorted Library
		NSSortDescriptor * descriptor = [NSSortDescriptor sortDescriptorWithKey:@"Category" ascending:YES];
		NSSortDescriptor * descriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"Name" ascending:YES];
		NSArray * allDescriptors = [NSArray arrayWithObjects:descriptor,descriptor2,nil];
		self.sortedLibrary = [library sortedArrayUsingDescriptors:allDescriptors];
		[self debug:@"sortedLibrary %@" o:self.sortedLibrary];
		
	}
	return self;
}

-(void) removeHidden{
	/*
	// Load only effects that are not hidden
	<#(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate#>
	NSIndexSet * indexSet = [library indexesOfObjectsPassingTest:]
	- (void)enumerateIndexesUsingBlock:(void (^)(NSUInteger idx, BOOL *stop))block
	// */
}

+(NSDictionary *) effectAtIndex:(NSUInteger)index{
	return [[CunddDiveEffectLibrary sharedLibrary] effectAtIndex:index];
}
-(NSDictionary *) effectAtIndex:(NSUInteger)index{
	return [self.library objectAtIndex:index];
}


+(NSDictionary *) effectWithName:(NSString *)name{
	return [[CunddDiveEffectLibrary sharedLibrary] effectWithName:name];
}
-(NSDictionary *) effectWithName:(NSString *)name{
	return [self.libraryDictionary objectForKey:name];
}


@synthesize library,libraryDictionary,sortedLibrary;
@end
