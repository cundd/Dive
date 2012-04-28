//
//  StructureToStringPlugIn.m
//  StructureToString
//
//  Created by Daniel Corn on 27.05.10.
//  Copyright (c) 2010 cundd. All rights reserved.
//

/* It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering */
#import <OpenGL/CGLMacro.h>

#import "StructureToStringPlugIn.h"

#define	kQCPlugIn_Name				@"Structure To String"
#define	kQCPlugIn_Description		@"The patch creates a string from a given structure."

#define kCunddDictStringSeperator	@"_<_CundD_dictStringSeperator1_>_"
#define kCunddDictStringEqualsSign	@"_<_CundD_dictStringEqualsSign1_>_"

@implementation StructureToStringPlugIn

@synthesize cunddOutputStringCache,cunddOutputDictionaryCache;
@dynamic inputStructure,outputString,inputString,outputStructure;

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
		/*
		Allocate any permanent resource required by the plug-in.
		*/
	}
	
	return self;
}

- (void) finalize
{
	[super finalize];
}

- (void) dealloc
{
	[super dealloc];
}

+ (NSArray*) plugInKeys
{
	/*
	Return a list of the KVC keys corresponding to the internal settings of the plug-in.
	*/
	
	return nil;
}

- (id) serializedValueForKey:(NSString*)key;
{
	/*
	Provide custom serialization for the plug-in internal settings that are not values complying to the <NSCoding> protocol.
	The return object must be nil or a PList compatible i.e. NSString, NSNumber, NSDate, NSData, NSArray or NSDictionary.
	*/
	
	return [super serializedValueForKey:key];
}

- (void) setSerializedValue:(id)serializedValue forKey:(NSString*)key
{
	/*
	Provide deserialization for the plug-in internal settings that were custom serialized in -serializedValueForKey.
	Deserialize the value, then call [self setValue:value forKey:key] to set the corresponding internal setting of the plug-in instance to that deserialized value.
	*/
	
	[super setSerializedValue:serializedValue forKey:key];
}

- (QCPlugInViewController*) createViewController
{
	/*
	Return a new QCPlugInViewController to edit the internal settings of this plug-in instance.
	You can return a subclass of QCPlugInViewController if necessary.
	*/
	
	return [[QCPlugInViewController alloc] initWithPlugIn:self viewNibName:@"Settings"];
}

-(NSString *) serializeDictionary:(NSDictionary *)aDictionary{
	if(!aDictionary)return @"";
	
	NSString * dictString; // = [aDictionary description];
	NSMutableString * dictStringTemp = [NSMutableString string];
	
	for(id key in [aDictionary allKeys]){
		id value = [aDictionary objectForKey:key];
		if(![key isKindOfClass:[NSString class]]){
			key = [NSString stringWithFormat:@"%@",key];
		}
		if(![value isKindOfClass:[NSString class]]){
			value = [NSString stringWithFormat:@"%@",value];
		}
		// NSLog(@"%@",key);
		[dictStringTemp appendFormat:@"%@%@%@%@",key,kCunddDictStringEqualsSign,value,kCunddDictStringSeperator];
	}
	dictString = [dictStringTemp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	// NSLog(@"StructureToStringPlugIn: encodedString=\n%@",[dictString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
	return dictString;
}

-(NSDictionary *) unserializeDictionary:(NSString *)serializedDictString{
	if([serializedDictString isEqualToString:@""]) return [NSDictionary dictionary];
	
	NSString * unescapedString = [serializedDictString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	NSMutableDictionary * tempDict = [NSMutableDictionary dictionary];
	NSArray * keyValuePairs = [unescapedString componentsSeparatedByString:kCunddDictStringSeperator];
	
	NSLog(@"keyValuePairs count=%i",[keyValuePairs count]);
	
	for(NSString * currentKeyValuePair in keyValuePairs){
		if(!currentKeyValuePair)break;
		if([currentKeyValuePair isEqualToString:@""])break;
		
		NSArray * keyValueArray = [currentKeyValuePair componentsSeparatedByString:kCunddDictStringEqualsSign];
		NSString * key = [keyValueArray objectAtIndex:0];
		NSString * value = [keyValueArray objectAtIndex:1];
		[tempDict setObject:value forKey:key];
	}
	
	NSDictionary * returnDict;
	/*
	NSString * path = [[[NSBundle bundleWithIdentifier:@"net.cundd.StructureToStringPlugIn"] pathForResource:@"tempDict" ofType:@"plist"] retain];
	if(![[NSFileManager defaultManager] fileExistsAtPath:path]){
		[[NSFileManager defaultManager] createFileAtPath:path contents:[NSData data] attributes:nil];
	}
	
	NSString * unescapedString = [serializedDictString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSDictionary * returnDict;
	
	// Write temp-file
	[unescapedString writeToFile:path atomically:NO encoding:NSUTF8StringEncoding error:nil];
	
	returnDict = [NSDictionary dictionaryWithContentsOfFile:path];
	// */
	
	returnDict = [NSDictionary dictionaryWithDictionary:tempDict];
	
	return returnDict;
}

@end

@implementation StructureToStringPlugIn (Execution)

- (BOOL) startExecution:(id<QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when rendering of the composition starts: perform any required setup for the plug-in.
	Return NO in case of fatal failure (this will prevent rendering of the composition to start).
	*/
	
	return YES;
}

- (void) enableExecution:(id<QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when the plug-in instance starts being used by Quartz Composer.
	*/
}

- (BOOL) execute:(id<QCPlugInContext>)context atTime:(NSTimeInterval)time withArguments:(NSDictionary*)arguments
{
	if([self didValueForInputKeyChange:@"inputString"]){
		// Refresh struct
		self.cunddOutputDictionaryCache = [self unserializeDictionary:self.inputString];
	}
	if([self didValueForInputKeyChange:@"inputStructure"]){
		// Refresh string
		self.cunddOutputStringCache = [self serializeDictionary:self.inputStructure];
	}
	
	self.outputString = self.cunddOutputStringCache;
	self.outputStructure = self.cunddOutputDictionaryCache;
	
	return YES;
}

- (void) disableExecution:(id<QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when the plug-in instance stops being used by Quartz Composer.
	*/
}

- (void) stopExecution:(id<QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when rendering of the composition stops: perform any required cleanup for the plug-in.
	*/
}

@end
