//
//  InputsToStructurePlugIn.m
//  InputsToStructure
//
//  Created by Daniel Corn on 26.05.10.
//  Copyright (c) 2010 cundd. All rights reserved.
//

/* It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering */
#import <OpenGL/CGLMacro.h>

#import "InputsToStructurePlugIn.h"

#define	kQCPlugIn_Name				@"InputsToStructure"
#define	kQCPlugIn_Description		@"InputsToStructure description"

@implementation InputsToStructurePlugIn


@dynamic 
inputKey1,inputKey2,inputKey3,inputKey4,inputKey5,inputKey6,inputKey7,inputKey8,
inputNumber1,inputNumber2,inputNumber3,inputNumber4,inputNumber5,inputNumber6,inputNumber7,inputNumber8,
inputString1,inputString2,inputString3,inputString4,inputString5,inputString6,inputString7,inputString8,
inputColor1,inputColor2,inputColor3,inputColor4,inputColor5,inputColor6,inputColor7,inputColor8,
inputInt1,inputInt2,inputInt3,inputInt4,inputInt5,inputInt6,inputInt7,inputInt8,
inputBool1,inputBool2,inputBool3,inputBool4,inputBool5,inputBool6,inputBool7,inputBool8,
inputStruct1,inputStruct2,inputStruct3,inputStruct4,inputStruct5,inputStruct6,inputStruct7,inputStruct8,
outputOutput;






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


@end

@implementation InputsToStructurePlugIn (Execution)

- (BOOL) startExecution:(id<QCPlugInContext>)context
{
	NSLog(@"startExecution");
	return YES;
}

- (BOOL) execute:(id<QCPlugInContext>)context atTime:(NSTimeInterval)time withArguments:(NSDictionary*)arguments
{
	NSMutableDictionary * tempOutput = [NSMutableDictionary dictionary];
	NSUInteger numberOfPorts = 8;
	
	for(NSUInteger i = 1;i<=numberOfPorts;i++){
		id validValue = nil;
		NSString * validKey = nil;
		
		NSLog(@"current port number=%i",i);
		
		// Get the valid key
		if([self valueForKey:[NSString stringWithFormat:@"inputKey%i",i]]){
			validKey = [self valueForKey:[NSString stringWithFormat:@"inputKey%i",i]];
		} else {
			validKey = [NSString stringWithFormat:@"%i",i];
		}
		
		// Go through all the ports to get the valid value
		NSArray * selfPorts = [NSArray arrayWithObjects:@"inputString",@"inputNumber",@"inputColor",@"inputInt",@"inputBool",@"inputStruct",nil];
		for(NSUInteger j = 0;j < [selfPorts count];j++){
			NSString * currentPort = [NSString stringWithFormat:@"%@%i",[selfPorts objectAtIndex:j],i];
			
			NSLog(@"%@",currentPort);
			if([self valueForKey:currentPort]){
				validValue = [self valueForKey:currentPort];
				break;
			}
		}
		
		
		[tempOutput setObject:validValue forKey:validKey];
	}
	
	_outputDict = [NSDictionary dictionaryWithDictionary:tempOutput];
	NSLog(@"%@",_outputDict);
	[_outputDict retain];
	self.outputOutput = [NSDictionary dictionaryWithDictionary:tempOutput];
	return YES;
}
@end
