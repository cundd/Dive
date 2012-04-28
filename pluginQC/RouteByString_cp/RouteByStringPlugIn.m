//
//  StructurerPlugIn.m
//  Structurer
//
//  Created by Daniel Corn on 26.05.10.
//  Copyright (c) 2010 cundd. All rights reserved.
//

/* It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering */
#import <OpenGL/CGLMacro.h>

#import "StructurerPlugIn.h"

#define	kQCPlugIn_Name				@"Structurer"
#define	kQCPlugIn_Description		@"The patch takes values of configurable input ports and combine them in a dictionary with user defined keys."

@implementation StructurerPlugIn


@synthesize choser1,choser2,choser3,choser4,choser5,choser6,choser7,choser8,choser9,choser10,choser11,choser12,choser13,choser14;
@synthesize cunddOutputCache,cunddPorts;
@dynamic outputOutput;
/*
@dynamic 
inputKey1,inputKey2,inputKey3,inputKey4,inputKey5,inputKey6,inputKey7,inputKey8,
inputNumber1,inputNumber2,inputNumber3,inputNumber4,inputNumber5,inputNumber6,inputNumber7,inputNumber8,
inputString1,inputString2,inputString3,inputString4,inputString5,inputString6,inputString7,inputString8,
inputColor1,inputColor2,inputColor3,inputColor4,inputColor5,inputColor6,inputColor7,inputColor8,
inputInt1,inputInt2,inputInt3,inputInt4,inputInt5,inputInt6,inputInt7,inputInt8,
inputBool1,inputBool2,inputBool3,inputBool4,inputBool5,inputBool6,inputBool7,inputBool8,
inputStruct1,inputStruct2,inputStruct3,inputStruct4,inputStruct5,inputStruct6,inputStruct7,inputStruct8,
outputOutput;
// */

+ (NSDictionary*) attributes
{
	/*
	Return a dictionary of attributes describing the plug-in (QCPlugInAttributeNameKey, QCPlugInAttributeDescriptionKey...).
	*/
	
	return [NSDictionary dictionaryWithObjectsAndKeys:kQCPlugIn_Name, QCPlugInAttributeNameKey, kQCPlugIn_Description, QCPlugInAttributeDescriptionKey, nil];
}

+ (NSDictionary*) attributesForPropertyPortWithKey:(NSString*)key
{
	/*
	Specify the optional attributes for property based ports (QCPortAttributeNameKey, QCPortAttributeDefaultValueKey...).
	*/
	
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
		[self addObserver:self forKeyPath:@"choser1" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"choser2" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"choser3" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"choser4" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"choser5" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"choser6" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"choser7" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"choser8" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"choser9" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"choser10" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"choser11" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"choser12" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"choser13" options:NSKeyValueObservingOptionNew context:nil];
		[self addObserver:self forKeyPath:@"choser14" options:NSKeyValueObservingOptionNew context:nil];
	}
	
	return self;
}

- (void) finalize
{
	[self removeObserver:self forKeyPath:@"choser"];
	[super finalize];
}

- (void) dealloc
{
	[self removeObserver:self forKeyPath:@"cunddInputPorts"];
	[super dealloc];
}

+ (NSArray*) plugInKeys
{
	return [NSArray arrayWithObjects:@"choser1",@"choser2",@"choser3",@"choser4",@"choser5",@"choser6",@"choser7",@"choser8",@"choser9",@"choser10",@"choser11",@"choser12",@"choser13",@"choser14",nil];
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
	return [[QCPlugInViewController alloc] initWithPlugIn:self viewNibName:@"Settings"];
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//	NSLog(@"observeValueForKeyPath %@",newValue);
//	NSLog(@"choserX=%@",choser1);
//	NSLog(@"choserX=%@",choser2);
//	NSLog(@"choserX=%@",choser3);
	[self reloadPorts];
}

-(void) reloadPorts{
	if(!cunddPorts){
		cunddPorts = [[NSMutableDictionary dictionary] retain];
	}
	
	for(NSUInteger i = 1;i <= [[StructurerPlugIn plugInKeys] count];i++){
		NSString * currentType;
		NSString * currentName = [[NSString stringWithFormat:@"value%i",i] retain];
		NSString * currentKeyName = [[NSString stringWithFormat:@"key%i",i] retain];
		NSString * currentChoser = [[NSString stringWithFormat:@"choser%i",i] retain];
		
		// Get the currentType
		currentType = [self valueForKey:currentChoser];
		
		if(currentName && currentType){
			if([[cunddPorts objectForKey:currentName] isEqualToString:currentType] || 
			   [cunddPorts objectForKey:currentName] == currentType
			   ){
				// SKIP
				
			} else {
				// Check if the port already exists
				if([cunddPorts objectForKey:currentName]){
					[self removeInputPortForKey:currentName];
					[self removeInputPortForKey:currentKeyName];
					[cunddPorts removeObjectForKey:currentName];
				}
				
				// Add the new port
				[self addInputPortWithType:currentType forKey:currentName withAttributes:nil];
				[self addInputPortWithType:QCPortTypeString forKey:currentKeyName withAttributes:nil];
				[cunddPorts setObject:currentType forKey:currentName];
			}
			
		}
	}
}

-(void) refreshOutputCache{
	if(!cunddOutputCache){
		cunddOutputCache = [[NSMutableDictionary dictionary] retain];	
	}
	
	for(NSUInteger i = 1;i <= [[StructurerPlugIn plugInKeys] count];i++){
		NSString * currentName = [[NSString stringWithFormat:@"value%i",i] retain];
		NSString * currentKeyName = [[NSString stringWithFormat:@"key%i",i] retain];
		
		// Reset key if value did change since last execution
		if([self didValueForInputKeyChange:currentName] || [self didValueForInputKeyChange:currentKeyName]){
			id currentValue = [self valueForInputKey:currentName];
			if(!currentValue) currentValue = [NSNull null];
			
			NSString * currentKeyValue = [self valueForInputKey:currentKeyName];
			[cunddOutputCache setObject:currentValue forKey:currentKeyValue];
		}
	}
	//NSLog(@"cunddOutputCache=%@",cunddOutputCache);
}

@end

@implementation StructurerPlugIn (Execution)

- (BOOL) startExecution:(id<QCPlugInContext>)context
{
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
	[self refreshOutputCache];
	self.outputOutput = self.cunddOutputCache;
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
