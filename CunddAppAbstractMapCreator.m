//
//  CunddAppAbstractMapCreator.m
//  Dive
//
//  Created by Daniel Corn on 21.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddAppAbstractMapCreator.h"


@implementation CunddAppAbstractMapCreator
NSString * const kCunddAppMapCreatorCurrent = @"kCunddAppMapCreatorCurrent";
NSString * const kCunddAppMapCreatorRecording = @"kCunddAppMapCreatorRecording";
NSString * const kCunddAppAbstractMapCreatorControlType = @"kCunddAppAbstractMapCreatorControlType";

-(id) init{
	if([super init]){
		recording = NO;
		[self open];
	}
	return self;
}

#pragma mark Toggle recording
-(void)toggleRecording:(id)sender{
	[self toggleRecording];
}
-(void)toggleRecording{
	if(recording){
		[self stopRecording];
	} else {
		[self startRecording];
	}
}


#pragma mark Start recording
-(void) willStartRecording{
	
}
-(BOOL) startRecording{
	[self willStartRecording];
	
	[CunddAppRegistry registry:[NSNumber numberWithBool:YES] at:kCunddAppMapCreatorRecording];
	[CunddAppRegistry registry:self at:kCunddAppMapCreatorCurrent];
	recording = YES;
	
	[NSControl swapMouseDownMethod];
	
	[self didStartRecording];
	return YES;
}
-(void) didStartRecording{
	
}


#pragma mark Stop recording
-(void) willStopRecording{
	
}
-(BOOL) stopRecording{
	[self willStopRecording];
	
	[CunddAppRegistry registry:[NSNumber numberWithBool:NO] at:kCunddAppMapCreatorRecording];
	recording = NO;
	
	[NSControl swapMouseDownMethod];
	
	self.control = nil;
	self.controlBinding = nil;
	self.controlController = nil;
	
	[self didStopRecording];
	return YES;
}
-(void) didStopRecording{
	
}


#pragma mark Record control
-(void) willRecordControl{
	
}
-(NSEvent *)recordControl:(NSControl *)theControl withEvent:(NSEvent *)theEvent{
	[self willRecordControl];
	self.control = theControl;
	
	[self traverseBindingsOfObject:theControl];
	
	[self waitForCaller];
	
	[self didRecordControl];
	return theEvent;
}

-(void) checkControl{
	
}

-(NSDictionary *) traverseBindingsOfObject:(id)theObject{
	// [self throw:@"implementTraverseBindings"];
	
	
	NSString * searchObject = @"value";
	
	BOOL (^isEqualToStringBlock)(id obj, NSUInteger idx, BOOL *stop);
	isEqualToStringBlock = ^ BOOL (id obj, NSUInteger idx, BOOL *stop){
		if([obj isEqualToString:searchObject]){
			*stop = TRUE;
			return TRUE;
		}
		return FALSE;
	};
	
	for(NSString * binding in [theObject exposedBindings]){
		NSLog(@"Binding: %@ - %@",binding,[theObject infoForBinding:binding]);
		
	}
	
	if([[theObject exposedBindings] indexOfObjectPassingTest:isEqualToStringBlock] != NSNotFound){
		// For the control
//		if(theObject == self.control){
			NSDictionary * bindingInfo = [theObject infoForBinding:searchObject];
			NSMutableDictionary * bindingInfoPlusType = [NSMutableDictionary dictionaryWithDictionary:bindingInfo];
			[bindingInfoPlusType 
			 setObject: [NSNumber numberWithInt:CunddAppAbstractMapCreatorControlTypeValue]
			 forKey:	kCunddAppAbstractMapCreatorControlType];
			bindingInfo = [NSDictionary dictionaryWithDictionary:bindingInfoPlusType];
			
			
			// Check for the necessary data
			if([bindingInfo objectForKey:NSObservedObjectKey] &&
			   [bindingInfo objectForKey:NSObservedKeyPathKey]){
				self.controlBinding		= [bindingInfo objectForKey:NSObservedKeyPathKey];
				self.controlController	= [bindingInfo objectForKey:NSObservedObjectKey];
				
				return bindingInfo;
			}
//		}
	}
	return nil;
}

-(NSDictionary *) getModelForObject:(id)theObject{
	if([theObject isKindOfClass:[NSButton class]]){
		self.controlType = CunddAppAbstractMapCreatorControlTypeClick;
		self.controlController = theObject;
		
		return [NSDictionary dictionaryWithObjectsAndKeys:
				theObject,NSObservedObjectKey,
				[NSNumber numberWithInt:CunddAppAbstractMapCreatorControlTypeClick],kCunddAppAbstractMapCreatorControlType,
				nil
				];
	}
	return nil;	
}

-(void) didRecordControl{
	
}


#pragma mark Record caller
-(void) waitForCaller{
	
}

-(void) willRecordCaller{
	
}
-(BOOL) recordCaller:(id)theCaller{
	[self willRecordCaller];
	self.caller = theCaller;
	
	[self traverseBindingsOfObject:theCaller];
	
	
	[self didRecordCaller];
	return YES;
}


-(void) didRecordCaller{
	
}




#pragma mark User defaults
-(NSString *) defaultsPath{
	[self throw:@"implementDefaultsPath"];
	return @"";
}

-(BOOL) save{
	NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
	NSString * defaultsDirectory = [NSString stringWithFormat:@"%@.map",[self defaultsPath]];
	
	
	NSMutableDictionary * tempMap = [NSMutableDictionary dictionaryWithDictionary:[userDefaults dictionaryForKey:defaultsDirectory]];
	
	// Add the new map to the defaults
	/*
	id newKey = [[self.newMapping allKeys] objectAtIndex:0];
	id newValue = [self.newMapping objectForKey:newKey];
	[tempMap setObject:newValue forKey:newKey];
	/* */
	[tempMap addEntriesFromDictionary:self.newMapping];
	
	tempMap = [NSDictionary dictionaryWithDictionary:tempMap];
	
	[userDefaults setObject:tempMap forKey:defaultsDirectory];
	[userDefaults synchronize];
	
	return YES;
}


-(BOOL) open{
	NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
	NSString * defaultsDirectory = [NSString stringWithFormat:@"%@.map",[self defaultsPath]];
	
	
	map = [userDefaults dictionaryForKey:defaultsDirectory];
	
	[self didOpen];
	return YES;
}


-(BOOL) clearDefaults{
	NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
	NSString * defaultsDirectory = [NSString stringWithFormat:@"%@.map",[self defaultsPath]];
	[userDefaults removeObjectForKey:defaultsDirectory];
	return YES;
}

-(void) didOpen{
	
}

@synthesize newMapping,control,controlBinding,controlController,caller,callerBinding,recording,controlType,map;
@end
