//
//  CunddDiveVideoChain.m
//  Dive
//
//  Created by Daniel Corn on 26.04.10.
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

#import "CunddDiveVideoChain.h"


@implementation CunddDiveVideoChain
static int indexCounter;


+(id) vcWithTargetView:(NSView *)newTargetView{
	return [[[self alloc] initWithTargetView:newTargetView] autorelease];
}
-(id) initWithTargetView:(NSView *)newTargetView{
	self.targetView = newTargetView;
	return [self init];
}
-(id) init{
	if(![super init]){
		return self;
	}
	
	if(!indexCounter)indexCounter = 0;
	index = [NSNumber numberWithInt:indexCounter];
	indexCounter++;
	
	
	// Load the vc-nib
	if(![NSBundle loadNibNamed:@"VideoChain" owner:self]){
		NSLog(@"CunddDiveVideoChain error on loading the nib-file");
	}
	
	
	// Check dependencies
	if(!targetView){
		NSLog(@"CunddDiveVideoChain targetView is not set");
		[NSApp terminate:nil];
	}
	if(!vcView){
		NSLog(@"CunddDiveVideoChain vcView is not set");
		[NSApp terminate:nil];
	}
	if(!vcQCPatchController){
		NSLog(@"CunddDiveVideoChain vcQCPatchController is not set");
		[NSApp terminate:nil];
	}
	
	
	// Set connections that can be read
	if(!previewView){
		previewView = self.vcQCPatchController.view;
	}
	
	
	// Draw the view
	[self.targetView addSubview:self.vcView];
	
	
	// Add observers for the original objects in the settingsDictionary
	_keysOfSettings = [NSArray arrayWithObjects:
					   @"screen",	
					   @"width",	
					   @"height",	
					   @"x",		
					   @"y",	
					   @"alpha",	
					   @"mode",	
					   @"stack_level",
					   @"movieLocation",
					   @"speed",
					   
					   @"argsPsl1",
					   @"argsPsl2",
					   @"argsPsl3",
					   @"indexPsl1",
					   @"indexPsl2",
					   @"indexPsl3",
					   nil
					   ];
	[_keysOfSettings retain];
	for(id key in _keysOfSettings){
		[self.vcQCPatchController.patch addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew context:nil];
	}
	
	// Add an observer to be notified if the output of the composition did change
//	NSLog(@"%@",[self.vcQCPatchController.qcComposition outputKeys]);
//	[self addObserver:self forKeyPath:[self.vcQCPatchController.qcComposition output] options:<#(NSKeyValueObservingOptions)options#> context:<#(void *)context#>]
	
	
	// Add observer for resize
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(vcViewDidResize:) name:NSViewGlobalFrameDidChangeNotification object:self.vcView];
	
	
	// Inform the master about self
	id master = [CunddAppRegistry registry:[CunddConfig stringForKeyPath:@"Defaults.CunddDive.CunddDiveMaster.RegistryKey"]];
	[self debug:@"registerVideoChain at master %@" o:master];
	[master performSelector:@selector(registerVideoChain:) withObject:self];
	
	return self;
}


-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
	[self debug:[NSString stringWithFormat:@"observeValueForKeyPath:%@ ofObject:%@",keyPath,object]];
	// A property of the settings-object is changed the VC is informed and simulates a -setSettingsArray call
	if(object == self.vcQCPatchController.patch){
		
		[self willChangeValueForKey:@"settingsDictionary"];
		[self didChangeValueForKey:@"settingsDictionary"];
	}
}


-(BOOL) loadTrack:(CunddITunesTrack *)aTrack{
	[self.vcQCPatchController.patch setPropertiesFromTrack:aTrack];
	[self.vcQCPatchController refreshAllPorts];
	return YES;
}
//-(BOOL) loadTrack{
//	return YES;
//}


-(void) awakeFromNib{
	[self debug:@"CunddDiveVideoChain awakeFromNib"];
	// Inform the master about self
	id master = [CunddAppRegistry registry:[CunddConfig stringForKeyPath:@"Defaults.CunddDive.CunddDiveMaster.RegistryKey"]];
	[self debug:@"registerVideoChain at master %@" o:master];
	[master performSelector:@selector(registerVideoChain:) withObject:self];
}

- (IBAction) saveAction:(id)sender {
	[self.vcQCPatchController.patch updateUserDefaults];
}

-(void) refreshAllPorts{
	[self.vcQCPatchController refreshAllPorts];
}
-(void) refreshAllEffectIndexes{
	[self.vcQCPatchController refreshAllEffectIndexes];
}

-(NSImage *) outputImage{
//	if(!outputImage){
//		outputImage = self.vc
//	}
//	NSLog(@"oI1 = %@",[self.vcQCPatchController.view valueForOutputKey:@"output" ofType:QCPortTypeImage]);
//	NSLog(@"oI2 = %@",[self.vcQCPatchController.view valueForOutputKey:@"output"]);
	
//	return [self.vcQCPatchController.view valueForOutputKey:@"output"];
	
	NSString * type;
	//type = @"QCImage";
	type = @"NSImage";
	[type retain];
	[self.vcQCPatchController.view retain];
	
	if([self.vcQCPatchController.view valueForOutputKey:@"output" ofType:type]){
		return [self.vcQCPatchController.view valueForOutputKey:@"output" ofType:type];
	} else {
		return nil;
	}
}

-(NSDictionary *) settingsDictionary{
	//if(!settingsDictionary){
		NSMutableArray * objectsOfSettings = [NSMutableArray array];
		for(id key in _keysOfSettings){
			id valueAtKey = [self.vcQCPatchController.patch valueForKey:key];
			
			if(!valueAtKey){
				if([CunddConfig valueForKeyPath:[NSString stringWithFormat:@"Defaults.CunddDive.CunddVideoChainSettings.%@",key]]){
					valueAtKey = [CunddConfig valueForKeyPath:[NSString stringWithFormat:@"Defaults.CunddDive.CunddVideoChainSettings.%@",key]];
				} else {
					valueAtKey = [NSNull null];
				}
			}
			[objectsOfSettings addObject:valueAtKey];
		}
		
		settingsDictionary = [NSDictionary dictionaryWithObjects:objectsOfSettings forKeys:_keysOfSettings];
		[self debug:@"settingsDictionary = %@" o:settingsDictionary];
	//}
	return settingsDictionary;
}
-(void) setSettingsDictionary:(NSDictionary *)value{
	// Do nothing
}


-(void) play:(id)sender{
	[self.vcQCPatchController.view play:sender];
}
-(void) pause:(id)sender{
	[self.vcQCPatchController.view pause:sender];
}
-(void) togglePlayback:(id)sender{
	[self.vcQCPatchController.view togglePlayback:sender];
}



-(void) vcViewDidResize:(NSNotification *)notif{
	[self.vcQCPatchController.view surfaceDidMove:notif];
}

@synthesize targetView,vcView,vcQCPatchController,vcViewController,previewView,index;
@end
