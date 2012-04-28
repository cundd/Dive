//
//  CunddDiveMasterQCPatchController.m
//
//  Created by Daniel Corn on 11.05.10.
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

#import "CunddDiveMasterQCPatchController.h"

@implementation CunddDiveMasterQCPatchController

-(void)awakeFromNib{
	_videoChains = [NSMutableArray array];
	[_videoChains retain];
	
	// Load the composition
	NSString * compositionPath = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"qtz"];
	if(![[NSFileManager defaultManager] fileExistsAtPath:compositionPath]){
		NSLog(@"CunddDiveMasterQCPatchController the composition couldn't be found @ %@",compositionPath);
		[NSApp terminate:nil];
	}
	if(!self.targetView){
		//[self throw:@"Target view is not set"];
	}
	self.view = [CunddDiveMasterQCView qcViewWithView:targetView andFilePath:compositionPath];
	
	[CunddAppRegistry collectionRegistry:self at:@"CunddDiveMasterQCPatchController"];
//	[CunddAppRegistry registerValue:self at:@"CunddDiveMasterQCPatchController"];
	
	[self addObserver:self forKeyPath:@"patch.environment" options:NSKeyValueObservingOptionNew context:@"environment"];
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
	NSUInteger indexInVcArray;
	
	[change retain];
	id newValue = [change valueForKey:NSKeyValueChangeNewKey];
	
	if([keyPath isEqualToString:@"text"]){
		[self.view setValue:newValue forInputKey:keyPath];
	}
	
	
	[self debug:[NSString stringWithFormat:@"observeValueForKeyPath:%@ ofObject:%@ change:%@ context:%@",keyPath,object,change,context]];
	
	
	if(context == @"settingsDictionary"){
		indexInVcArray = [_videoChains indexOfObject:object];
		if(indexInVcArray != NSNotFound){
			NSLog(@"settingsDictionary");
			[self.view setValue:[object settingsDictionary] forInputKey:[NSString stringWithFormat:@"vc%iSettings",indexInVcArray]];
		} else {
			NSLog(@"VC not found in _videoChains");
		}
	} else 
	if(context == @"outputImage"){
		indexInVcArray = [_outputVideoChainStreams indexOfObject:object];
		if(indexInVcArray != NSNotFound && [object outputImage]){
			//NSLog(@"Update inputPort %@ with %@",[NSString stringWithFormat:@"vc%iImage",indexInVcArray],[object outputImage]);
			[self.view setValue:[object outputImage] forInputKey:[NSString stringWithFormat:@"vc%iImage",indexInVcArray]];
		}/*
		 else {
			NSLog(@"VC not found in _outputVideoChainStreams");
		}// */
	} else 
	if(context == @"environment"){
		[self.view setValue:newValue forInputKey:@"environment"];
	} else 
	{
		NSLog(@"Context is %@ of type %s",context,object_getClassName(context));
	}
}

-(void) finishInitialisationAndSetVcCollectionController:(CunddDiveVideoChainCollectionController *)theCollectionController{
	NSLog(@"MEGGA");
	
	/*
	// Set the collection controller
	self.vcCollectionController = theCollectionController;
	
	[self.text addObserver:self forKeyPath:@"stringValue" options:NSKeyValueObservingOptionNew context:nil];
	[self.text addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
	[self.text addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
	
	
	
	
	NSUInteger numberOfVcsAsInputPorts = [[qcComposition inputKeys] count] / 2;
	for(NSUInteger i = 0;i < numberOfVcsAsInputPorts;i++){
		CunddDiveVideoChain * currentChain = [self.vcCollectionController objectAtIndex:i];
		if(currentChain){
			[currentChain addObserver:self forKeyPath:@"settingsDictionary" options:NSKeyValueObservingOptionNew context:nil];
		}
	}
	
	/*
	CunddDiveVideoChain * currentChain = [self.vcCollectionController objectAtIndex:0];
	NSLog(@"%@",self.vcCollectionController);
	NSLog(@"currentChain = %@",currentChain);
	NSLog(@"currentChain.settingsDictionary = %@",currentChain.settingsDictionary);
	
	
	
	NSUInteger numberOfVcsAsInputPorts = [[qcComposition inputKeys] count] / 2;
	for(NSUInteger i = 0;i < numberOfVcsAsInputPorts;i++){
		CunddDiveVideoChain * currentChain = [self.vcCollectionController objectAtIndex:i];
		if(currentChain){
			NSString * currentInputPort = [NSString stringWithFormat:@"vc%iSettings.value",i];
			[self.view bind:currentInputPort toObject:currentChain  withKeyPath:@"settingsDictionary" options:nil];	
		}
	}
	// */
}

-(void) registerVideoChain:(CunddDiveVideoChain *)aVc{
	if(_videoChains == nil){
		_videoChains = [NSMutableArray array];
		[_videoChains retain];
	}
	
	// Check if it isn't already in the list
	if(![_videoChains containsObject:aVc]){
		[aVc retain];
		
		// Add the video-chain
		[_videoChains addObject:aVc];
		[aVc addObserver:self forKeyPath:@"settingsDictionary" options:NSKeyValueObservingOptionNew context:@"settingsDictionary"];
		[self debug:@"Added the VC %@ to all of them %@" o:aVc o:_videoChains];
	}
}


@synthesize patch,vcCollectionController,text,outputView,targetView;
@end
