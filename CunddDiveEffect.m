//
//  CunddEffect.m
//  Dive
//
//  Created by Daniel Corn on 30.04.10.
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

#import "CunddDiveEffect.h"


@implementation CunddDiveEffect

-(id) init{
	if([super init]){
		//self.settings = [CunddDiveEffectSettings ];
		
		// Load the BYPASS
		self.index = [NSNumber numberWithInt:0];
		[self refreshEffectInfo];
	}
	return self;
}


+(CunddDiveEffect *) effectWithTargetView:(NSView *)aView andOwner:(id)theOwner;{
	return [[[self alloc] initWithTargetView:aView andOwner:theOwner] autorelease];
}


-(CunddDiveEffect *) initWithTargetView:(NSView *)aView andOwner:(id)theOwner;{
	if([self init]){
		self.targetView = aView;
		self.owner = theOwner;
	}
	return self;
}

/*
-(void) willChangeValueForKey:(NSString *)key{
	[self resetEffectArguments];
	[super willChangeValueForKey:key];
}
// */

-(void) resetEffectArguments{
	// Check if the last effect has been the transform effect
	if([self.index intValue] == 21){
		NSDictionary * defaults = [CunddConfig valueForKeyPath:@"Defaults.CunddDive.CunddDiveVideoChainSettings"];
		[self.owner performSelector:@selector(setWidth:) withObject:[defaults objectForKey:@"width"]];
		[self.owner performSelector:@selector(setHeight:) withObject:[defaults objectForKey:@"height"]];
		[self.owner performSelector:@selector(setX:) withObject:[defaults objectForKey:@"x"]];
		[self.owner performSelector:@selector(setY:) withObject:[defaults objectForKey:@"y"]];
	}
	
}

-(void) setIndex:(NSNumber *)value{
	[self resetEffectArguments];
	[index release];
	index = value;
	[value retain];
	[self debug:@"CunddDiveEffect setIndex:%@" o:value];
	[self refreshEffectInfo];
}


-(NSMutableArray *) collectArgumentValues{
	[self debug:@"CunddDiveEffect collectArgumentValues"];
	NSMutableArray * returnValue = [NSMutableArray array];
	[self.arguments retain];
	
	NSLock *theLock = [[NSLock alloc] init];
	[theLock lock];
	
	for(CunddDiveEffectArgument * arg in self.arguments){
		if(arg){
			[arg retain];
			NSLog(@"%@",arg);
			if([arg argValue]){
				NSLog(@"argValue=%@",arg.argValue);
				
				[arg.argValue retain];
				[returnValue addObject:arg.argValue];
			}			
		}
	}
	
	[theLock unlock];
	[theLock release];
	
	[self debug:@"CunddDiveEffect collectArgumentValues after %@" o:returnValue];
	return returnValue;
}


-(void) refreshEffectInfo{
	[self debug:@"CunddDiveEffect refreshEffectInfo"];
	
	// Transform the index
	NSValueTransformer * transformer = [NSValueTransformer valueTransformerForName:@"CunddDiveEffectLibraryValueTransformer"];
	NSNumber * transformedIndex = [transformer transformedValue:self.index];
	
	self.info = [CunddDiveEffectInfo effectWithLibraryObjectAtIndex:[transformedIndex intValue]];
	
	/*
	NSString * refreshEffectInfoNotification = [CunddConfig valueForKeyPath:@"Constants.CunddDive.Notifications.RefreshEffectInfoNotification"];
	[[NSNotificationCenter defaultCenter] postNotificationName:refreshEffectInfoNotification object:self];
	// */
	
	self.arg0 = self.info.arg0;
	self.arg1 = self.info.arg1;
	self.arg2 = self.info.arg2;
	self.arg3 = self.info.arg3;
	self.arg4 = self.info.arg4;
	self.arg5 = self.info.arg5;
	
	
	self.name = self.info.name;
	self.arguments = self.info.arguments;
	self.desc = self.info.desc;
	
	[self loadNib];
}


-(void) loadNib{
	if(!targetView){
		NSLog(@"CunddDiveEffect targetView is not set");
		return;
	} else {
		[self debug:@"CunddDiveEffect targetView is set"];
	}
	
	NSString * nibName = [self.name stringByReplacingOccurrencesOfString:@" " withString:@"_"];
	NSView * oldView = self.view;
	
	// If the special nib couldn't be loaded load the dummy
	if(![NSBundle loadNibNamed:nibName owner:self]){
		if([NSBundle loadNibNamed:@"EffectDummy" owner:self]){
			[self debug:@"CunddDiveEffect loadNib EffectDummy"];
		} else {
			NSLog(@"CunddDiveEffect failed loadNib EffectDummy");
			[NSApp terminate:self];
		}
	} else {
		[self debug:@"CunddDiveEffect loadNib %@" o:nibName];
	}
	
	// Print log if view-outlet in the nib-file is not connected
	if(!self.view){
		NSLog(@"CunddDiveEffect view is not set");
		[NSApp terminate:self];
	}
	if([[self.targetView subviews]count] > 0){
		[self.targetView replaceSubview:oldView with:self.view];
	} else {
		[self.targetView addSubview:self.view];
	}
	
}




@synthesize view,targetView,info,index,arg0,arg1,arg2,arg3,arg4,arg5,name,desc,arguments,owner;
@end
