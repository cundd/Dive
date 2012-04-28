//
//  CunddDiveEffect.m
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

#import "CunddDiveEffectInfo.h"


@implementation CunddDiveEffectInfo

+(CunddDiveEffectInfo *) effectWithLibraryObject:(NSDictionary *)dictionary{
	return [[[self alloc] initWithLibraryObject:dictionary] autorelease];
}
-(CunddDiveEffectInfo *) initWithLibraryObject:(NSDictionary *)dictionary{
	if([self init]){
		self.libraryObject = dictionary;
		name = [dictionary objectForKey:@"Name"];
		type = [dictionary objectForKey:@"Type"];
		desc = [dictionary objectForKey:@"Description"];
		self._argumentsSource = [dictionary objectForKey:@"arguments"];
		
		
		// Create an _emptyArgument
		_emptyArgument = [CunddDiveEffectArgument argumentDummy];
		[_emptyArgument retain];
		
		NSMutableArray * argumentsTemp = [NSMutableArray array];
		for(NSDictionary * arg in _argumentsSource){
			// Create new argument-object
			[argumentsTemp addObject:[CunddDiveEffectArgument argumentWithDictionary:arg]];
		}
		//NSLog(@"%@ \n %@",_argumentsSource,argumentsTemp);
		arguments = [NSArray arrayWithArray:argumentsTemp];
		[arguments retain];
		
		for(NSUInteger i = 0;i < 6;i++){
			[self setValue:[self getArgumentIfIndexExists:i] forKey:[NSString stringWithFormat:@"arg%i",i]];
		}
	}
	return self;
}


+(CunddDiveEffectInfo *) effectWithLibraryObjectAtIndex:(NSUInteger)index{
	return [[[self alloc] initWithLibraryObjectAtIndex:index] autorelease];
}
-(CunddDiveEffectInfo *) initWithLibraryObjectAtIndex:(NSUInteger)index{
	NSDictionary * effectDictionary = [CunddDiveEffectLibrary effectAtIndex:index];
	if(effectDictionary){
		return [self initWithLibraryObject:effectDictionary];
	} else {
		return [self init];
	}
}



#pragma mark Access argument-array-elements
//@property (retain) CunddDiveEffectArgument * arg0;
//@property (retain) CunddDiveEffectArgument * arg1;
//@property (retain) CunddDiveEffectArgument * arg2;
//@property (retain) CunddDiveEffectArgument * arg3;
//@property (retain) CunddDiveEffectArgument * arg4;
//@property (retain) CunddDiveEffectArgument * arg5;

-(CunddDiveEffectArgument *) getArgumentIfIndexExists:(NSUInteger)index{
	[arguments retain];
	[self debug:@"getArgumentIfIndexExists index:%i arguments=%@" o:[NSNumber numberWithInt:index] o:arguments];
	if(!arguments){
		[self debug:@"the arguments are empty"];
		return _emptyArgument;
	} else if([arguments count] > index){
		return [arguments objectAtIndex:index];		
	} else {
		[self debug:@"CunddDiveEffectInfo argument count is 0 so _emptyArgument is returned %@" o:_emptyArgument];
		return _emptyArgument;
	}
}




@synthesize name,type,arguments,libraryObject,_argumentsSource,desc,arg0,arg1,arg2,arg3,arg4,arg5;
@end
