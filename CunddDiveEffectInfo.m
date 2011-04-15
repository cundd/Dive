//
//  CunddDiveEffect.m
//  Dive
//
//  Created by Daniel Corn on 29.04.10.
//  Copyright 2010 cundd. All rights reserved.
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
