//
//  StringColorConverterPlugIn.h
//  StringColorConverter
//
//  Created by Daniel Corn on 27.05.10.
//  Copyright (c) 2010 cundd. All rights reserved.
//

#import <Quartz/Quartz.h>

@interface StringColorConverterPlugIn : QCPlugIn
{
	CGColorRef colorOutputCache;
	NSString * stringOutputCache;
}

/*!
    @method     
    @abstract   Converts the color into a hexadecimal string representation
    @discussion Converts the color into a hexadecimal string representation
*/
-(NSString *)stringFromColor:(CGColorRef)theColor;
/*!
    @method     
    @abstract   Converts the string into color
    @discussion Converts the string into color
*/
-(CGColorRef)colorFromString:(NSString *)theString;


// Ports
@property (assign) CGColorRef inputColor;
@property (assign) NSString * outputString;

@property (assign) NSString * inputString;
@property (assign) CGColorRef outputColor;


// Properties
@property (assign) CGColorRef colorOutputCache;
@property (retain) NSString * stringOutputCache;

@end
