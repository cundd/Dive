//
//  CunddAppMIDIMapCreator.m
//  CunddMIDI
//
//  Created by Daniel Corn on 21.06.10.
//
//    Copyright © 2010-2012 Corn Daniel
//
//    This file is part of Dive.
//
//    Dive is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    Foobar is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
//
//

#import "CunddAppMIDIMapCreator.h"


@implementation CunddAppMIDIMapCreator
- (id) init
{
	self = [super init];
	if (self != nil) {
		midiClient = [CunddMIDIClient sharedInstance];
	}
	return self;
}


-(NSString *) defaultsPath{
	return kCunddAppMIDIHandlerPath;
}

-(BOOL) startRecording{
	NSLog(@"startRecording");
	return [super startRecording];
}

-(NSEvent *)recordControl:(NSControl *)theControl withEvent:(NSEvent *)theEvent{
	[self willRecordControl];
	self.control = theControl;
	
	NSDictionary * traverseResult = [self traverseBindingsOfObject:theControl];
	if(!traverseResult) traverseResult = [self getModelForObject:theControl];
	if(!traverseResult) return nil;
	
	if(traverseResult){
		if([[traverseResult objectForKey:kCunddAppAbstractMapCreatorControlType] intValue] == CunddAppAbstractMapCreatorControlTypeValue){
			// Bind the value
		} else 
		if([[traverseResult objectForKey:kCunddAppAbstractMapCreatorControlType] intValue] == CunddAppAbstractMapCreatorControlTypeClick){
			// Perform click
		}
	}
	
	[self waitForCaller];
	
	[self didRecordControl];
	return theEvent;
}


-(void) waitForCaller{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedMIDIData:) name:kCunddMIDIDeviceReceivedData_private object:nil];
}

-(void) receivedMIDIData:(NSNotification *)notif{
	CunddMIDIEntity * entity = (CunddMIDIEntity *)[[notif userInfo] objectForKey:@"entity"];
	
	/*
	self.newMapping = [NSDictionary dictionaryWithObjectsAndKeys:
					   entity.entityUid,@"entityUid",
					   
					   ]
	 */
	
	void (^renderCallerBlock)(void);
	renderCallerBlock = ^(void){
		[self recordCaller:entity];
	};
	
	[[NSOperationQueue mainQueue] addOperationWithBlock:renderCallerBlock];
	// [self recordCaller:entity];
}

-(BOOL) recordCaller:(id)theCaller{
	if([theCaller isKindOfClass:[CunddMIDIEntity class]]){
		self.caller = (CunddMIDIEntity *)theCaller;
		self.callerBinding = [NSString stringWithFormat:@"%@.output",[self.caller keyAsString]];
		
//		NSLog(@"%@ %@ %@ %@ ----------",theCaller, self.callerBinding,self.selectedControlController,self.controlBinding);
//		
//		NSLog(@"%@  ---",[(CunddMIDIEntity *)theCaller valueForKey:@"7.output"]);
		
//		NSLog(@"NNNNNOB -------------------------------------------------------------------------------------------------------\n-------------------------------------------------------------------------------------------------------");
		// [theCaller bind:self.callerBinding toObject:self.selectedControlController withKeyPath:self.controlBinding options:nil];
		@try {
			[self.controlController bind:self.controlBinding toObject:theCaller 
							 withKeyPath:self.callerBinding options:
			 [NSDictionary dictionaryWithObjectsAndKeys:
			  @"CunddAppMIDIValueTransformer",NSValueTransformerNameBindingOption,nil]
			 ];			
		}
		@catch (NSException * e) {
			NSLog(@"CunddAppMIDIMapCreator Exception: %@\n%@\n%@",[e name],[e reason],[e userInfo]);
			[self.controlController unbind:self.controlBinding];
		}
		@finally {
			
		}
		//		NSLog(@"BUUUURN -------------------------------------------------------------------------------------------------------\n-------------------------------------------------------------------------------------------------------");
//		NSLog(@"%@ bind:self.callerBinding=%@ toObject:self.selectedControl=%@ withKeyPath:self.controlBinding=%@ options:nil",theCaller, self.callerBinding,self.selectedControlController,self.controlBinding);
//		NSLog()//
		
		// NSView -viewWithTag file:///Developer/Documentation/DocSets/com.apple.adc.documentation.AppleSnowLeopard.CoreReference.docset/Contents/Resources/Documents/documentation/Cocoa/Reference/ApplicationKit/Classes/NSView_Class/Reference/NSView.html#//apple_ref/occ/instm/NSView/viewWithTag:
		if([self.control tag] && [self.control tag] != 0){
			//  Format = "caller-entityUid.callerBinding" (z.B.: "-1882965413.2.output" )
			NSString * newValue = [NSString stringWithFormat:@"%@.%@",[theCaller entityUid],self.callerBinding];
			
			// Format = "control-tag.controlBinding.controlType"
			NSString * newKey = [NSString stringWithFormat:@"%i.%@.%i",[self.control tag],self.controlBinding,self.controlType];
			self.newMapping = [NSDictionary dictionaryWithObjectsAndKeys:
							   newValue,
							   newKey,
							   nil
							   ];
			
			[self save];
		}
		
		
		return YES;
	}
	return NO;
}

-(void) didOpen{
	NSLog(@"%@",[NSApp keyWindow]);
	NSLog(@"%@",[NSApp orderedWindows]);
	NSWindow * mainWindow = [[NSApp orderedWindows] objectAtIndex:0];
	NSView * rootView = [mainWindow contentView];
		
	NSLog(@"self.map = %@",self.map);
	for(NSString * key in [self.map allKeys]){
		NSString * value;
		NSControl * aControl;
		id aControlController;
		NSString * aControlBinding;
		CunddMIDIEntity * aCaller;
		NSString * aCallerBinding;
		NSDictionary * traverseResult;
		
		value = [self.map objectForKey:key];
		
		// Get the controls data: [0] = control.tag, [1] = controlBinding, [2] = controlType
		NSArray * controlMappingParts = [[key componentsSeparatedByString:@"."] retain];
		NSInteger tag = [(NSString *)[controlMappingParts objectAtIndex:0] integerValue];
		aControlBinding = [controlMappingParts objectAtIndex:1];
		
		// Search for a matching view 
		aControl = [rootView viewWithTag:tag];
		
//		NSLog(@"aControl=%@ in rootView=%@",aControl,rootView);
		if(!aControl) continue;
		traverseResult = [self traverseBindingsOfObject:aControl];
//		NSLog(@"traverseResult=%@",traverseResult);
		if(!traverseResult)
			traverseResult = [self getModelForObject:aControl];
		
		if(!traverseResult) continue;
		
		
		aControlController = [traverseResult objectForKey:NSObservedObjectKey];
		
		
		// Get the caller data: [0] = caller.entityUid, [1] = callerBinding
		NSArray * callerMappingParts = [[value componentsSeparatedByString:@"."] retain];
		NSInteger uid = [(NSString *)[callerMappingParts objectAtIndex:0] integerValue];
		
		aCaller = [self.midiClient bindPortToEntityWithUid:uid];
		
		// If aCaller is of class NSValue an error in midi-binding occured
		if([aCaller isKindOfClass:[NSValue class]]){
			OSStatus error;
			[(NSValue *)aCaller getValue:&error];
			NSLog(@"CunddAppMIDIMapCreator failed creating and binding the saved entity: %s (%s)",GetMacOSStatusErrorString(error),GetMacOSStatusCommentString(error));
			continue;
		}
		
		
		aCallerBinding = [NSString stringWithFormat:@"%@.output",[callerMappingParts objectAtIndex:1]];
		
		NSLog(@"%@",controlMappingParts);
		NSLog(@"%@",callerMappingParts);
		NSLog(@"CunddAppMIDIMapCreator: didOpen: bind to caller: %@",aCaller);
		NSLog(@"[aControlController=%@ bind:aControlBinding=%@ toObject:aCaller=%@ withKeyPath:aCallerBinding=%@ options:nil];",aControlController,aControlBinding,aCaller,aCallerBinding);
		
		[aControlController bind:aControlBinding toObject:aCaller withKeyPath:aCallerBinding options:nil];
	}
}
// */

-(void) willStopRecording{
	NSLog(@"willStopRecording");
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(CunddMIDIClient *) midiClient{
	if(!midiClient){
		midiClient = [CunddMIDIClient sharedInstance];
	}
	return midiClient;
}
@synthesize midiClient;
@end


