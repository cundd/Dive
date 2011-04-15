//
//  CunddAppMIDIValueTransformer.m
//  CunddMIDI
//
//  Created by Daniel Corn on 24.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddAppMIDIValueTransformer.h"

#define kFactor (double)127.0 * 2

@implementation CunddAppMIDIValueTransformer
+(Class) transformedValueClass{
	return [NSNumber class];
}
+(BOOL) allowsReverseTransformation{
	return YES;
}

//		display -> value
-(id) reverseTransformedValue:(id)value{
	if(!value) return nil;
	if(![value respondsToSelector:@selector(doubleValue)]) return nil;
	
	double newValue = [value doubleValue] * kFactor;
	return [NSNumber numberWithDouble:newValue];
}

//		value -> display
-(id) transformedValue:(id)value{
	if(!value) return nil;
	if(![value respondsToSelector:@selector(doubleValue)]) return nil;
	
	double newValue = [value doubleValue] / kFactor;
	return [NSNumber numberWithDouble:newValue];	
}
@end
