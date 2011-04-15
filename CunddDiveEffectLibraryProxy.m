//
//  CunddDiveEffectLibraryProxy.m
//  Dive
//
//  Created by Daniel Corn on 05.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveEffectLibraryProxy.h"


@implementation CunddDiveEffectLibraryProxy
-(NSArray *) sortedLibrary{
	return [[CunddDiveEffectLibrary sharedLibrary] sortedLibrary];
}
-(NSArray *) content{
	if(!content){
		content = self.sortedLibrary;
	}
	return content;
}
-(NSUInteger) count{
	return [self.content count];
}
-(id)objectAtIndex:(NSUInteger)index{
	return [self.content objectAtIndex:index];
}

@synthesize content;
@end
