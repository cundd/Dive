//
//  CunddColorConverter.m
//  Dive
//
//  Created by Daniel Corn on 03.06.10.
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
