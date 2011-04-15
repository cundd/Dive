//
//  CunddDiveEffectColorValueTransformer.m
//  Dive
//
//  Created by Daniel Corn on 03.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveEffectColorValueTransformer.h"


@implementation CunddDiveEffectColorValueTransformer

+(Class) transformedValueClass{
	return [NSString class];
}
+(BOOL) allowsReverseTransformation{
	return YES;
}

//		display -> value
-(id) reverseTransformedValue:(id)value{
	if(!value) return nil;
	if(![value isKindOfClass:[NSColor class]]) return nil;
	
	return [CunddColorConverter numberStringFromNSColor:value];
}

//		value -> display
-(id) transformedValue:(id)value{
	if(!value) return nil;
	if(![value isKindOfClass:[NSString class]]) return nil;
	
	return [CunddColorConverter NSColorFromNumberString:value];
}

@end
