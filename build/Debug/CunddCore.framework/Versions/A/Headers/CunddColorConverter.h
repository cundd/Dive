//
//  CunddColorConverter.h
//  Dive
//
//  Created by Daniel Corn on 03.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddObject.h"


@interface CunddColorConverter : CunddObject {

}


+(CIColor *)CIColorFromCGColor:(CGColorRef)theColor;

+(CIColor *)CIColorFromNumberString:(NSString *)theString;

+(NSString *) numberStringFromCIColor:(CGColorRef)theColor;

+(NSColor *)NSColorFromCIColor:(CIColor *)theColor;

+(NSColor *)NSColorFromCGColor:(CGColorRef)theColor;

+(NSColor *)NSColorFromNumberString:(NSString *)theString;

+(NSString *)numberStringFromNSColor:(NSColor *)theColor;

+(CGColorRef) CGColorFromNumberString:(NSString *)theString;
@end
