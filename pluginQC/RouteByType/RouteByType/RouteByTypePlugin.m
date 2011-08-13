//
//  RouteByTypePlugIn.m
//  RouteByType
//
//  Created by Daniel Corn on 23.04.11.
//  Copyright 2011 cundd. All rights reserved.
//

/* It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering */
#import <OpenGL/CGLMacro.h>

#import "RouteByTypePlugIn.h"

#define	kQCPlugIn_Name				@"RouteByType"
#define	kQCPlugIn_Description		@"RouteByType description"
#define kCunddLiveVideoURIScheme	@"cunddlivevideo"

#define kRouteByTypeDescriptionImage			@"The file at the given location is an image."
#define kRouteByTypeDescriptionVideo			@"The file at the given location should be some kind of video."
#define kRouteByTypeDescriptionLiveVideo		@"The given location identifies a video capture device."
#define kRouteByTypeDescriptionError			@"The file location may be empty or couldn't be determined."


@implementation RouteByTypePlugIn

@dynamic inputLocation, outputLocation, outputTypeDescription, outputUseIndex, outputVideoLocation, outputImageLocation, outputCaptureDeviceLocation, outputLoop;

+ (NSDictionary *)attributes
{
	/*
	Return a dictionary of attributes describing the plug-in (QCPlugInAttributeNameKey, QCPlugInAttributeDescriptionKey...).
	*/
	
	return [NSDictionary dictionaryWithObjectsAndKeys:kQCPlugIn_Name, QCPlugInAttributeNameKey, kQCPlugIn_Description, QCPlugInAttributeDescriptionKey, nil];
}

+ (NSDictionary *)attributesForPropertyPortWithKey:(NSString *)key
{
	if([key isEqualToString:@"inputLocation"])
		return [NSDictionary dictionaryWithObjectsAndKeys:
				@"Input location", QCPortAttributeNameKey,
				nil];
	if([key isEqualToString:@"outputLocation"])
		return [NSDictionary dictionaryWithObjectsAndKeys:
				@"Output location", QCPortAttributeNameKey,
				nil];
	if([key isEqualToString:@"outputTypeDescription"])
		return [NSDictionary dictionaryWithObjectsAndKeys:
				@"Output description", QCPortAttributeNameKey,
				nil];
	if([key isEqualToString:@"outputUseIndex"])
		return [NSDictionary dictionaryWithObjectsAndKeys:
				@"Output index", QCPortAttributeNameKey,
				nil];
	if([key isEqualToString:@"outputVideoLocation"])
		return [NSDictionary dictionaryWithObjectsAndKeys:
				@"Video location (empty if resource isn't a video)", QCPortAttributeNameKey,
				nil];
	if([key isEqualToString:@"outputImageLocation"])
		return [NSDictionary dictionaryWithObjectsAndKeys:
				@"Image location (empty if resource isn't an image)", QCPortAttributeNameKey,
				nil];
	if([key isEqualToString:@"outputCaptureDeviceLocation"])
		return [NSDictionary dictionaryWithObjectsAndKeys:
				@"Capture device location (empty if resource isn't a capture device)", QCPortAttributeNameKey,
				nil];
	
	return nil;
}

+ (QCPlugInExecutionMode)executionMode
{
	//return kQCPlugInExecutionModeConsumer;
	return kQCPlugInExecutionModeProcessor;
}

+ (QCPlugInTimeMode)timeMode
{
	/*
	Return the time dependency mode of the plug-in: kQCPlugInTimeModeNone, kQCPlugInTimeModeIdle or kQCPlugInTimeModeTimeBase.
	*/
	//return kQCPlugInTimeModeIdle;
	return kQCPlugInTimeModeNone;
}

- (id)init
{
	self = [super init];
	if (self) {
	//	[self _setValue:@"bb" forOutputPort:@"Location"];
	//	self.outputIndex = CunddRouteByTypeTypeIndexError;
	/*	self.outputLocation = @"";
		self.outputDescription = @"";
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
	[imageTypeIdentifiers release];
	[_outputDescriptionCache release];
	[_outputLocationCache release];
	
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

+ (NSArray*) sortedPropertyPortKeys
{
	return [NSArray array];
    return [NSArray arrayWithObjects:@"inputLocation",@"outputUseIndex",@"outputLocation",@"outputTypeDescription",
			@"outputVideoLocation", @"outputImageLocation", @"outputCaptureDeviceLocation", @"outputLoop",nil];
}

-(void)setOutputLocations{
	BOOL success = YES;
	NSUInteger currentIndex = _scheduledIndex;
	if(!currentIndex) currentIndex = _outputIndexCache;
	if(!currentIndex) currentIndex = CunddRouteByTypeTypeIndexError;
	
	NSLog(@"KK %i %lu",__LINE__,currentIndex);
	
	switch (currentIndex) {
		case CunddRouteByTypeTypeIndexCaptureDevice:
			success *= [self setValue:_outputLocationCache forOutputKey:@"outputCaptureDeviceLocation"];
			success *= [self setValue:@"" forOutputKey:@"outputImageLocation"];
			success *= [self setValue:@"" forOutputKey:@"outputVideoLocation"];
			success *= [self setValue:[NSNumber numberWithBool:FALSE] forOutputKey:@"outputLoop"];
			//[self removeOutputPortForKey:@"outputVideoLocation"];
			break;
			
		case CunddRouteByTypeTypeIndexImage:
			success *= [self setValue:_outputLocationCache forOutputKey:@"outputImageLocation"];
			success *= [self setValue:@"" forOutputKey:@"outputCaptureDeviceLocation"];
			success *= [self setValue:@"" forOutputKey:@"outputVideoLocation"];
			success *= [self setValue:[NSNumber numberWithBool:TRUE] forOutputKey:@"outputLoop"];
			//[self removeOutputPortForKey:@"outputVideoLocation"];
			break;
			
		case CunddRouteByTypeTypeIndexVideo:
			success *= [self setValue:_outputLocationCache forOutputKey:@"outputVideoLocation"];
			success *= [self setValue:@"" forOutputKey:@"outputCaptureDeviceLocation"];
			success *= [self setValue:@"" forOutputKey:@"outputImageLocation"];
			success *= [self setValue:[NSNumber numberWithBool:FALSE] forOutputKey:@"outputLoop"];
			break;
			
		case CunddRouteByTypeTypeIndexError:
		default:
			success *= [self setValue:@"" forOutputKey:@"outputVideoLocation"];
			success *= [self setValue:@"" forOutputKey:@"outputCaptureDeviceLocation"];
			success *= [self setValue:@"" forOutputKey:@"outputImageLocation"];
			success *= [self setValue:[NSNumber numberWithBool:FALSE] forOutputKey:@"outputLoop"];
			break;
	}
	
	NSLog(@"RouteByType success %i",success);
}

@end

@implementation RouteByTypePlugIn (Execution)

- (BOOL)startExecution:(id <QCPlugInContext>)context
{
//	[self setValue:@"Location" forOutputKey:@"Location"];
//	[self setValue:@"Type description" forOutputKey:@"TypeDescription"];
	return YES;
}

- (void)enableExecution:(id <QCPlugInContext>)context
{
	NSLog(@"RouteByType enabled");
}

- (BOOL)execute:(id <QCPlugInContext>)context atTime:(NSTimeInterval)time withArguments:(NSDictionary *)arguments
{
	NSString * inLo;
	NSURL * locationURL = nil;
	NSError * error = nil;
	NSArray * resourceKeys;
	BOOL isDetermined = FALSE;
	
	/*
	 * Check if a index is scheduled.
	 */
	if(_scheduledIndex && _scheduledIndex != CunddRouteByTypeTypeIndexError){
//		return YES;
		NSLog(@"KK %i",__LINE__);
		_outputIndexCache = _scheduledIndex;
		_scheduledIndex = 0;
		
		[self setValue:[NSNumber numberWithUnsignedInteger:_outputIndexCache] forOutputKey:@"outputUseIndex"];
		[self setValue:_outputLocationCache forOutputKey:@"outputLocation"];
		[self setValue:_outputDescriptionCache forOutputKey:@"outputTypeDescription"];
		[self setOutputLocations];
		NSLog(@"scheduled");
		return YES;
	}
		
	if(![self didValueForInputKeyChange:@"inputLocation"] && _outputLocationCache){
		return YES;
		NSLog(@"Use cache");
		[self setValue:_outputLocationCache forOutputKey:@"outputLocation"];
		[self setValue:_outputDescriptionCache forOutputKey:@"outputTypeDescription"];
		[self setOutputLocations];
		NSLog(@"KK %i",__LINE__);
		return YES;
	} else if(![self didValueForInputKeyChange:@"inputLocation"]){
		NSLog(@"No changes to the port inputLocation");
		return YES;
	}
	
	inLo = [self valueForInputKey:@"inputLocation"];
	if(!inLo || [inLo isEqualToString:@"undefined"] || [inLo isEqualToString:@""]){
		locationURL = nil;
	} else {
		inLo = [[inLo stringByStandardizingPath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		locationURL = [NSURL URLWithString:inLo];
	}
	
	_scheduledIndex = CunddRouteByTypeTypeIndexError;
	[_outputDescriptionCache release];
	_outputDescriptionCache = nil;
	[_outputLocationCache release];
	_outputLocationCache = nil;
	
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
		_scheduledIndex		= CunddRouteByTypeTypeIndexCaptureDevice;
		_outputLocationCache	= @"BING";
		NSLog(@"KK %i",__LINE__);
		_outputDescriptionCache = kRouteByTypeDescriptionLiveVideo;
		isDetermined = TRUE;
	}
	
	/*
	 * Read the information of the file.
	 */
	resourceKeys = [NSArray arrayWithObjects:NSURLLocalizedNameKey, NSURLTypeIdentifierKey, NSURLLocalizedTypeDescriptionKey, nil];
	NSDictionary * resourceValues = [locationURL resourceValuesForKeys:resourceKeys error:&error];
	NSLog(@"RouteByType resource path and values %@ %@ %@ stand: %@",[locationURL absoluteString],resourceValues,inLo,[inLo stringByStandardizingPath]);
	
	/*
	 * Search the image type URI list for the type of the file.
	 */
	if(!isDetermined && [resourceValues objectForKey:NSURLTypeIdentifierKey] && [self.imageTypeIdentifiers indexOfObject:[resourceValues objectForKey:NSURLTypeIdentifierKey]] != NSNotFound){
		// It is an image.
		_scheduledIndex			= CunddRouteByTypeTypeIndexImage;
		_outputLocationCache	= [locationURL absoluteString];
		_outputDescriptionCache = kRouteByTypeDescriptionImage;
		NSLog(@"KK %i",__LINE__);
		isDetermined = TRUE;
	} else if(!isDetermined && locationURL){
		_scheduledIndex			= CunddRouteByTypeTypeIndexVideo;
		_outputLocationCache	= [locationURL absoluteString];
		_outputDescriptionCache = kRouteByTypeDescriptionVideo;
		NSLog(@"KK %i",__LINE__);
		isDetermined = TRUE;
	} else if(!locationURL){
		_scheduledIndex			= CunddRouteByTypeTypeIndexError;
		_outputLocationCache	= nil;
		_outputDescriptionCache = kRouteByTypeDescriptionError;
		isDetermined = NO;
	}
	
	/*
	 * First empty the output location.
	 */
	[self setValue:_outputLocationCache forOutputKey:@"outputLocation"];
	[self setValue:_outputDescriptionCache forOutputKey:@"outputTypeDescription"];
	[self setValue:[NSNumber numberWithUnsignedInteger:_outputIndexCache] forOutputKey:@"outputUseIndex"];
	[self setOutputLocations];
	
	[_outputLocationCache retain];
	[_outputDescriptionCache retain];
	
	[self setValue:[NSNumber numberWithUnsignedInteger:_scheduledIndex] forOutputKey:@"outputUseIndex"];
	_scheduledIndex = 0;
	
	NSLog(@"RouteByType output %@ %@ (%lu)",_outputLocationCache,[locationURL scheme],_scheduledIndex);
	return isDetermined;
}

/*
-_setValue:(id)value forOutputPort:(id)port{
	NSLog(@"value: %@ for port: %@",value,port);
	if(port) return [super _setValue:value forOutputPort:port];
}*/

- (void)disableExecution:(id <QCPlugInContext>)context
{
	NSLog(@"RouteByType disabled");
}

- (void)stopExecution:(id <QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when rendering of the composition stops: perform any required cleanup for the plug-in.
	*/
}

@end
