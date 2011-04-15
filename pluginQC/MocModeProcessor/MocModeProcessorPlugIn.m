//
//  MocModeProcessorPlugIn.m
//  MocModeProcessor
//
//  Created by Daniel Corn on 21.05.10.
//  Copyright (c) 2010 cundd. All rights reserved.
//

/* It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering */
#import <OpenGL/CGLMacro.h>

#import "MocModeProcessorPlugIn.h"

#define	kQCPlugIn_Name				@"MocModeProcessor"
#define	kQCPlugIn_Description		@"Determines the MOC mode for the given inputEnvironment and screen.\nCunddDiveMocModeNone = 0\nCunddDiveMocModeFront = 1\nCunddDiveMocModeLeft = 2\nCunddDiveMocModeRight = 3\nCunddDiveMocModeTop = 4\nCunddDiveMocModeBottom = 5"
@implementation MocModeProcessorPlugIn

@dynamic inputEnvironment,inputScreen,inputEdgeMode,outputMocMode;


+ (NSDictionary*) attributes{
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

+ (NSArray*) plugInKeys
{
	/*
	Return a list of the KVC keys corresponding to the internal settings of the plug-in.
	*/
	
	return nil;
}

- (QCPlugInViewController*) createViewController
{
	return [[QCPlugInViewController alloc] initWithPlugIn:self viewNibName:@"Settings"];
}

-(CunddDiveMocMode) getRelationship{
	switch(self.inputEnvironment){
			// The environment is the front canvas
		case CunddDiveScreenFront:
			switch(self.inputScreen){
				case CunddDiveScreenFront:
					return CunddDiveMocModeFront;
					break;
					
				case CunddDiveScreenBack:
					return CunddDiveMocModeNone;
					break;
					
				case CunddDiveScreenLeft:
					return CunddDiveMocModeLeft;
					break;
					
				case CunddDiveScreenRight:
					return CunddDiveMocModeRight;
					break;
					
				case CunddDiveScreenTop:
					return CunddDiveMocModeTop;
					break;
					
				case CunddDiveScreenBottom:
					return CunddDiveMocModeBottom;
					break;
					
				default:
					return CunddDiveMocModeNone;
					break;
			}
			
			// The environment is the back canvas
		case CunddDiveScreenBack:
			switch(self.inputScreen){
				case CunddDiveScreenFront:
					return CunddDiveMocModeNone;
					break;
					
				case CunddDiveScreenBack:
					return CunddDiveMocModeFront;
					break;
					
				case CunddDiveScreenLeft:
					return CunddDiveMocModeRight;
					break;
					
				case CunddDiveScreenRight:
					return CunddDiveMocModeLeft;
					break;
					
				case CunddDiveScreenTop:
					return CunddDiveMocModeTop;
					break;
					
				case CunddDiveScreenBottom:
					return CunddDiveMocModeBottom;
					break;
					
				default:
					return CunddDiveMocModeNone;
					break;
			}
			
			
			// The environment is the left canvas
		case CunddDiveScreenLeft:
			switch(self.inputScreen){
				case CunddDiveScreenFront:
					return CunddDiveMocModeRight;
					break;
					
				case CunddDiveScreenBack:
					return CunddDiveMocModeLeft;
					break;
					
				case CunddDiveScreenLeft:
					return CunddDiveMocModeFront;
					break;
					
				case CunddDiveScreenRight:
					return CunddDiveMocModeNone;
					break;
					
				case CunddDiveScreenTop:
					return CunddDiveMocModeTop;
					break;
					
				case CunddDiveScreenBottom:
					return CunddDiveMocModeBottom;
					break;
					
				default:
					return CunddDiveMocModeNone;
					break;
			}
			
			
			// The environment is the right canvas
		case CunddDiveScreenRight:
			switch(self.inputScreen){
				case CunddDiveScreenFront:
					return CunddDiveMocModeLeft;
					break;
					
				case CunddDiveScreenBack:
					return CunddDiveMocModeRight;
					break;
					
				case CunddDiveScreenLeft:
					return CunddDiveMocModeNone;
					break;
					
				case CunddDiveScreenRight:
					return CunddDiveMocModeFront;
					break;
					
				case CunddDiveScreenTop:
					return CunddDiveMocModeTop;
					break;
					
				case CunddDiveScreenBottom:
					return CunddDiveMocModeBottom;
					break;
					
				default:
					return CunddDiveMocModeNone;
					break;
			}
			
			
			// The environment is the top canvas
		case CunddDiveScreenTop:
			switch(self.inputScreen){
				case CunddDiveScreenFront:
					return CunddDiveMocModeBottom;
					break;
					
				case CunddDiveScreenBack:
					return CunddDiveMocModeTop;
					break;
					
				case CunddDiveScreenLeft:
					return CunddDiveMocModeLeft;
					break;
					
				case CunddDiveScreenRight:
					return CunddDiveMocModeRight;
					break;
					
				case CunddDiveScreenTop:
					return CunddDiveMocModeFront;
					break;
					
				case CunddDiveScreenBottom:
					return CunddDiveMocModeNone;
					break;
					
				default:
					return CunddDiveMocModeNone;
					break;
			}
			
			
			// The environment is the bottom canvas
		case CunddDiveScreenBottom:
			switch(self.inputScreen){
				case CunddDiveScreenFront:
					return CunddDiveMocModeTop;
					break;
					
				case CunddDiveScreenBack:
					return CunddDiveMocModeBottom;
					break;
					
				case CunddDiveScreenLeft:
					return CunddDiveMocModeLeft;
					break;
					
				case CunddDiveScreenRight:
					return CunddDiveMocModeRight;
					break;
					
				case CunddDiveScreenTop:
					return CunddDiveMocModeNone;
					break;
					
				case CunddDiveScreenBottom:
					return CunddDiveMocModeFront;
					break;
					
				default:
					return CunddDiveMocModeNone;
					break;
			}
			
			
		default:
			return CunddDiveMocModeNone;
	}
}
@end

@implementation MocModeProcessorPlugIn (Execution)

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
	if(self.inputScreen == CunddDiveScreenNone){
		self.outputMocMode = CunddDiveMocModeNone;
	}
	
	
	// If edgeMode is "clip" only the front-display will be drawed
	if(self.inputEdgeMode == CunddDiveEdgeModeClip && self.inputScreen == self.inputEnvironment){
		self.outputMocMode = CunddDiveMocModeFront;
	} else if(self.inputEdgeMode == CunddDiveEdgeModeClip && self.inputScreen != self.inputEnvironment){
		self.outputMocMode = CunddDiveMocModeNone;
	}
	// If edgeMode is "warp" the local outputMocMode is set corresponding to the current inputEnvironment
	else if(self.inputEdgeMode == CunddDiveEdgeModeWarp){
		self.outputMocMode = [self getRelationship];
	}
	
	return YES;
}



@end
