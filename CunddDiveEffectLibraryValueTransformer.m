//
//  CunddDiveEffectLibraryValueTransformer.m
//  Dive
//
//  Created by Daniel Corn on 05.05.10.
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
// */

@end
