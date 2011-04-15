//
//  CunddDiveEffectLibraryValueTransformer.m
//  Dive
//
//  Created by Daniel Corn on 05.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveEffectLibraryValueTransformer.h"


@implementation CunddDiveEffectLibraryValueTransformer
+(Class) transformedValueClass{
	return [NSNumber class];
}
+(BOOL) allowsReverseTransformation{
	return YES;
}

// index in sorted array -> Id of effect
-(id) reverseTransformedValue:(id)value{
	if(!value) return nil;
	id objectInArray;
	
	NSArray * sortedLibrary = [[CunddDiveEffectLibrary sharedLibrary] sortedLibrary];
	
	if([value respondsToSelector:@selector(intValue)]){
		objectInArray = [sortedLibrary objectAtIndex:[value intValue]];
		return [objectInArray valueForKey:@"Id"];
	} else {
		[NSApp terminate:nil];
		[NSException raise: NSInternalInconsistencyException
					format: @"Value (%@) does not respond to -intValue.",
		 [value class]];
	}
	return nil;
}

// Id of effect -> index in sorted array
-(id) transformedValue:(id)value{
	if(!value) return nil;
	if(![value respondsToSelector:@selector(intValue)]){
		[NSException raise: NSInternalInconsistencyException
					format: @"Value (%@) does not respond to -intValue.",
		 [value class]];
	}
	NSUInteger i = 0;
	
	NSArray * library = [[CunddDiveEffectLibrary sharedLibrary] library];
	for(NSDictionary * effect in library){
		if([[effect valueForKey:@"Id"] intValue] == [value intValue]){
			return [NSNumber numberWithInt:i];
		}
		i++;
	}
	return nil;
}
/* */

@end
