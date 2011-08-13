//
//  CunddRouteByTypePlugIn.m
//  CunddRouteByType
//
//  Created by Daniel Corn on 08.05.11.
//  Copyright 2011 cundd. All rights reserved.
//

/* It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering */
#import <OpenGL/CGLMacro.h>

#import "CunddRouteByTypePlugIn.h"

#define	kQCPlugIn_Name				@"Cundd - RouteByType"
#define	kQCPlugIn_Description		@"Sets the output index according to the type of the file/stream at the given input location."

#define kCunddLiveVideoURIScheme	@"cunddlivevideo"

#define kRouteByTypeDescriptionImage			@"The file at the given location is an image."
#define kRouteByTypeDescriptionVideo			@"The file at the given location should be some kind of video."
#define kRouteByTypeDescriptionLiveVideo		@"The given location identifies a video capture device."
#define kRouteByTypeDescriptionError			@"The file location may be empty or couldn't be determined."


@implementation CunddRouteByTypePlugIn

/*
Here you need to declare the input / output properties as dynamic as Quartz Composer will handle their implementation
@dynamic inputFoo, outputBar;
*/
@dynamic inputLocation, inputLoop, outputIndex, outputLocation, outputDescription, outputLoop;

+ (NSDictionary *)attributes
{
	/*
	Return a dictionary of attributes describing the plug-in (QCPlugInAttributeNameKey, QCPlugInAttributeDescriptionKey...).
	*/
	
	return [NSDictionary dictionaryWithObjectsAndKeys:kQCPlugIn_Name, QCPlugInAttributeNameKey, kQCPlugIn_Description, QCPlugInAttributeDescriptionKey, nil];
}

+ (NSDictionary *)attributesForPropertyPortWithKey:(NSString *)key
{
	/*
	Specify the optional attributes for property based ports (QCPortAttributeNameKey, QCPortAttributeDefaultValueKey...).
	*/
	
	return nil;
}

+ (QCPlugInExecutionMode)executionMode
{
	return kQCPlugInExecutionModeProcessor;
}

+ (QCPlugInTimeMode)timeMode
{
	return kQCPlugInTimeModeNone;
}

- (id)init
{
	self = [super init];
	if (self) {
		/*
		Allocate any permanent resource required by the plug-in.
		*/
	}
	
	return self;
}

- (void)finalize
{
	/*
	Release any non garbage collected resources created in -init.
	*/
	
	[super finalize];
}

- (void)dealloc
{
	/*
	Release any resources created in -init.
	*/
	
	[super dealloc];
}

-(NSArray *)imageTypeIdentifiers{
	if(!imageTypeIdentifiers){
		imageTypeIdentifiers = [[NSArray arrayWithObjects:@"com.adobe.illustrator.ai-image",
								 @"public.png",
								 @"public.jpeg",
								 @"com.adobe.pdf",
								 nil] retain];
	}
	return imageTypeIdentifiers;
}

-(NSArray *)quartzTypeIdentifiers{
	return quartzTypeIdentifiers;
}


@end

@implementation CunddRouteByTypePlugIn (Execution)

- (BOOL)startExecution:(id <QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when rendering of the composition starts: perform any required setup for the plug-in.
	Return NO in case of fatal failure (this will prevent rendering of the composition to start).
	*/
	
	return YES;
}

- (void)enableExecution:(id <QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when the plug-in instance starts being used by Quartz Composer.
	*/
}

- (BOOL)execute:(id <QCPlugInContext>)context atTime:(NSTimeInterval)time withArguments:(NSDictionary *)arguments
{
	NSString * inLo;
	NSURL * locationURL;
	BOOL isDetermined;
	NSUInteger oIndex;
	NSString * oDescription, * oLocation;
	BOOL oLoop;
	
	NSArray * resourceKeys;
	NSDictionary * resourceValues;
	NSError * error;
	
	if(![self didValueForInputKeyChange:@"inputLocation"]){
		return YES;
	}
	
	inLo = [self valueForInputKey:@"inputLocation"];
	if(!inLo || [inLo isEqualToString:@"undefined"] || [inLo isEqualToString:@""]){
		locationURL = nil;
	} else {
		inLo = [[inLo stringByStandardizingPath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		locationURL = [NSURL URLWithString:inLo];
	}
	
	/*
	 * Make sure the URL contains a scheme, but only if it is not empty.
	 */
	if(locationURL && ![locationURL scheme]){
		NSLog(@"RouteByType rel: '%@'",[locationURL relativeString]);
		locationURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@:%@",NSURLFileScheme,[locationURL absoluteString]]];
	} else 
	/*
	 * Check if the URL is a live stream.
	 */
	if(locationURL && [[locationURL scheme] isEqualToString:kCunddLiveVideoURIScheme]){
		oIndex = CunddRouteByTypeTypeIndexCaptureDevice;
		oLocation = @"BING";
		oDescription = kRouteByTypeDescriptionLiveVideo;
		isDetermined = TRUE;
	}
	/*
	 * Read the information of the file.
	 */
	
	resourceKeys = [NSArray arrayWithObjects:NSURLLocalizedNameKey, NSURLTypeIdentifierKey, NSURLLocalizedTypeDescriptionKey, nil];
	resourceValues = [locationURL resourceValuesForKeys:resourceKeys error:&error];
	NSLog(@"RouteByType resource path and values %@ %@ %@ stand: %@",[locationURL absoluteString],resourceValues,inLo,[inLo stringByStandardizingPath]);
	
	/*
	 * Search the image type URI list for the type of the file.
	 */
	if(!isDetermined && [resourceValues objectForKey:NSURLTypeIdentifierKey] && [self.imageTypeIdentifiers indexOfObject:[resourceValues objectForKey:NSURLTypeIdentifierKey]] != NSNotFound){
		// It is an image.
		oIndex			= CunddRouteByTypeTypeIndexImage;
		oLocation		= [locationURL absoluteString];
		oDescription	= kRouteByTypeDescriptionImage;
		oLoop			= NO;
		NSLog(@"KK %i",__LINE__);
		isDetermined	= TRUE;
	} else if(!isDetermined && locationURL){
		oIndex			= CunddRouteByTypeTypeIndexVideo;
		oLocation		= [locationURL absoluteString];
		oDescription	= kRouteByTypeDescriptionVideo;
		oLoop			= YES;
		NSLog(@"KK %i",__LINE__);
		isDetermined	= TRUE;
	} else if(!locationURL){
		oIndex			= CunddRouteByTypeTypeIndexError;
		oLocation		= nil;
		oDescription	= kRouteByTypeDescriptionError;
		oLoop			= NO;
		isDetermined	= NO;
	}
	
	[self setValue:oLocation forOutputKey:@"outputLocation"];
	[self setValue:oDescription forOutputKey:@"outputDescription"];
	[self setValue:[NSNumber numberWithUnsignedInteger:oIndex] forOutputKey:@"outputIndex"];
	[self setValue:[NSNumber numberWithBool:oLoop] forOutputKey:@"outputLoop"];
	
	return isDetermined;
}

- (void)disableExecution:(id <QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when the plug-in instance stops being used by Quartz Composer.
	*/
}

- (void)stopExecution:(id <QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when rendering of the composition stops: perform any required cleanup for the plug-in.
	*/
}

@end
