//
//  CunddColorConverter.m
//  Dive
//
//  Created by Daniel Corn on 03.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddColorConverter.h"


@implementation CunddColorConverter

+(CIColor *)CIColorFromCGColor:(CGColorRef)theColor{
	return [CIColor colorWithCGColor:theColor];
}
+(CIColor *)CIColorFromNumberString:(NSString *)theString{
	return [CIColor colorWithString:theString];
}

+(NSString *) numberStringFromCIColor:(CGColorRef)theColor{
	CIColor * coreImageColor = [CIColor colorWithCGColor:theColor];
	return [coreImageColor stringRepresentation];
}


+(NSColor *)NSColorFromCIColor:(CIColor *)theColor{
	return [NSColor colorWithCIColor:theColor];
}

+(NSColor *)NSColorFromCGColor:(CGColorRef)theColor{
	return [self NSColorFromCIColor:[self CIColorFromCGColor:theColor]];
}

+(NSString *)numberStringFromNSColor:(NSColor *)theColor{
	CGFloat red		= (CGFloat)[theColor redComponent];
	CGFloat green	= (CGFloat)[theColor greenComponent];
	CGFloat blue	= (CGFloat)[theColor blueComponent];
	CGFloat alpha;
	if([NSColor ignoresAlpha]){
		alpha = (CGFloat)1;
	} else {
		alpha = (CGFloat)[theColor alphaComponent];
	}
	
	return [NSString stringWithFormat:@"%1.4f %1.4f %1.4f %1.4f",red,green,blue,alpha];
}

+(NSColor *)NSColorFromNumberString:(NSString *)theString{
	return [self NSColorFromCIColor:[self CIColorFromNumberString:theString]];
}

+(CGColorRef) CGColorFromNumberString:(NSString *)theString{
	if([theString isEqualToString:@""]){
		CGColorRef colorRef = CGColorCreateGenericRGB(0,0,0,0);
		CGColorRelease(colorRef);
		return colorRef;
	}
	
	NSArray * colorCompStringArray = [theString componentsSeparatedByString:@" "];
	
	CGFloat red		= (CGFloat)[[colorCompStringArray objectAtIndex:0] floatValue];
	CGFloat green	= (CGFloat)[[colorCompStringArray objectAtIndex:1] floatValue];
	CGFloat blue	= (CGFloat)[[colorCompStringArray objectAtIndex:2] floatValue];
	CGFloat alpha;
	
	if([colorCompStringArray count] > 3){
		alpha = (CGFloat)[[colorCompStringArray objectAtIndex:3] floatValue];
	} else {
		alpha = (CGFloat)1.0;
	}
	
	
	
	CGColorRef returnColor = CGColorCreateGenericRGB(red,green,blue,alpha);
	CGColorRelease(returnColor);
	return returnColor;
}

@end
