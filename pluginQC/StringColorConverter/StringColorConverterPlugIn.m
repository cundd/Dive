//
//  StringColorConverterPlugIn.m
//  StringColorConverter
//
//  Created by Daniel Corn on 27.05.10.
//  Copyright (c) 2010 cundd. All rights reserved.
//

/* It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering */
#import <OpenGL/CGLMacro.h>

#import "StringColorConverterPlugIn.h"

#define	kQCPlugIn_Name				@"StringColor Converter"
#define	kQCPlugIn_Description		@"Conversion from hexadecimal string to color and reverse."

@implementation StringColorConverterPlugIn

@synthesize colorOutputCache,stringOutputCache;
@dynamic inputColor,outputString,inputString,outputColor;



+ (NSDictionary*) attributes
{
	return [NSDictionary dictionaryWithObjectsAndKeys:kQCPlugIn_Name, QCPlugInAttributeNameKey, kQCPlugIn_Description, QCPlugInAttributeDescriptionKey, nil];
}

+ (NSDictionary*) attributesForPropertyPortWithKey:(NSString*)key
{
	return nil;
}

+ (QCPlugInExecutionMode) executionMode
{
	return kQCPlugInExecutionModeProcessor;
}

+ (QCPlugInTimeMode) timeMode
{
	return kQCPlugInTimeModeNone;
}

- (id) init
{
	if(self = [super init]) {
		self.colorOutputCache = CGColorCreateGenericRGB(1, 1, 1, 1);
		
		self.stringOutputCache = [[NSString stringWithFormat:@"1.0 1.0 1.0 1.0"] retain];
	}
	
	return self;
}

- (void) finalize
{
	[super finalize];
}

- (void) dealloc
{
	CGColorRelease(self.colorOutputCache);
	[self.stringOutputCache release];
	[super dealloc];
}


-(NSString *) stringFromColor:(CGColorRef)theColor{
	CIColor * coreImageColor = [CIColor colorWithCGColor:theColor];
	return [coreImageColor stringRepresentation];
}
-(CGColorRef) colorFromString:(NSString *)theString{
	if([theString isEqualToString:@""])return CGColorCreateGenericRGB(0,0,0,0);
	CGColorRef returnColor;
	
	NSArray * colorCompStringArray = [theString componentsSeparatedByString:@" "];
	
	CGFloat red		= (CGFloat)0;
	CGFloat green	= (CGFloat)0;
	CGFloat blue	= (CGFloat)0;
	CGFloat alpha	= (CGFloat)1.0;
	NSUInteger count = [colorCompStringArray count];
	
	if(count > 0)	red		= (CGFloat)[[colorCompStringArray objectAtIndex:0] floatValue];
	if(count > 1)	green	= (CGFloat)[[colorCompStringArray objectAtIndex:1] floatValue];
	if(count > 2)	blue	= (CGFloat)[[colorCompStringArray objectAtIndex:2] floatValue];
	if(count > 3)	alpha	= (CGFloat)[[colorCompStringArray objectAtIndex:3] floatValue];
	
	
	
	returnColor = CGColorCreateGenericRGB(red,green,blue,alpha);
	return returnColor;
}

@end

@implementation StringColorConverterPlugIn (Execution)

- (BOOL) startExecution:(id<QCPlugInContext>)context
{
	return YES;
}

- (BOOL) execute:(id<QCPlugInContext>)context atTime:(NSTimeInterval)time withArguments:(NSDictionary*)arguments
{
	// Check if input-values did change
	if([self didValueForInputKeyChange:@"inputColor"]){
		self.stringOutputCache = [self stringFromColor:self.inputColor];
	}
	if([self didValueForInputKeyChange:@"inputString"]){
		self.colorOutputCache = [self colorFromString:self.inputString];
	}
	
	self.outputString = self.stringOutputCache;
	self.outputColor = self.colorOutputCache;
	
	return YES;
}


@end
