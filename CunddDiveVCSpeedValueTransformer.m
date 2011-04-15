//
//  CunddDiveVCSpeedValueTransformer.m
//  Dive
//
//  Created by Daniel Corn on 20.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveVCSpeedValueTransformer.h"


@implementation CunddDiveVCSpeedValueTransformer
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
	
	double difference = [value doubleValue] + (double)1.0;
	return [NSNumber numberWithDouble:difference];
}

//		value -> display
-(id) transformedValue:(id)value{
	if(!value) return nil;
	if(![value respondsToSelector:@selector(doubleValue)]) return nil;
	
	double difference = [value doubleValue] - (double)1.0;
	return [NSNumber numberWithDouble:difference];	
}
/* */
@end
