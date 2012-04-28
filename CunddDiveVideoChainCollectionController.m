//
//  CunddDiveVideoChainCollection.m
//  Dive
//
//  Created by Daniel Corn on 22.04.10.
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

#import "CunddDiveVideoChainCollectionController.h"


@implementation CunddDiveVideoChainCollectionController
+(void) initialize{
	[CunddDiveVideoChainCollectionController exposeBinding:@"vcCount"];
}

-(void) awakeFromNib{
	NSLog(@"STURELE");
	vcCount = [NSNumber numberWithInt:6];
	
	
	if(!targetView0){
		NSLog(@"CunddDiveVideoChainCollectionController no targetView has been set");
		[NSApp terminate:nil];
	}
	NSMutableArray * tempArray = [NSMutableArray array];
	NSString * keyForCurrentVC;
	for(int i = 0;i < [vcCount intValue];i++){
		keyForCurrentVC = [NSString stringWithFormat:@"targetView%i",i];
		
		if([self valueForKey:keyForCurrentVC] != nil){
			[tempArray addObject:[CunddDiveVideoChain vcWithTargetView:[self valueForKey:keyForCurrentVC]]];
		}
	}
	self.content = [NSArray arrayWithArray:tempArray];
	
	
	// Add notification-observers for changes in effect-choice
	NSString * refreshEffectInfoNotification = [CunddConfig valueForKeyPath:@"Constants.CunddDive.Notifications.RefreshEffectInfoNotification"];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleEffectChoice:) name:refreshEffectInfoNotification object:nil];
	
	// Add notification-observers for changes in effect-arguments
	NSString * notificationName = [CunddConfig valueForKeyPath:@"Constants.CunddDive.Notifications.HandleEffectArgumentChange"];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleEffectArgumentChange:) name:notificationName object:nil];
	
	// Add notification-observers to load a track to a VC
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLoadTrack:) name:@"CunddDiveVideoChain1ShouldLoadTrack" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLoadTrack:) name:@"CunddDiveVideoChain2ShouldLoadTrack" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLoadTrack:) name:@"CunddDiveVideoChain3ShouldLoadTrack" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLoadTrack:) name:@"CunddDiveVideoChain4ShouldLoadTrack" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLoadTrack:) name:@"CunddDiveVideoChain5ShouldLoadTrack" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLoadTrack:) name:@"CunddDiveVideoChain6ShouldLoadTrack" object:nil];
	
	// Send notification that the VCs should be ready
	[[NSNotificationCenter defaultCenter] postNotificationName:[CunddConfig constForKeyPath:@"CunddDive.Notifications.VideoChainsReady"] object:self];
	NSLog(@"Video chains are ready");
}

/*!
 @method     
 @abstract   Retrieve the first video-chain
 @discussion The method calls objectAtIndex: to retrieve the video-chain at index 0.
 */
-(CunddDiveVideoChain *)objectAtIndex:(NSUInteger)index{
	if([self.content count] > index){
		return [self.content objectAtIndex:index];
	} else {
		NSLog(@"CunddDiveVideoChainCollectionController: a video-chain with the index %i doesn't exist",index);
		return nil;
	}
}


- (IBAction) saveAction:(id)sender {
	for(CunddDiveVideoChain * chain in self.content){
		[chain saveAction:sender];
	}
}


-(void)handleEffectArgumentChange:(NSNotification *)notif{
	for(CunddDiveVideoChain * chain in self.content){
		[chain refreshAllPorts];
	}
}
-(void)handleEffectChoice:(NSNotification *)notif{
	for(CunddDiveVideoChain * chain in self.content){
		[chain refreshAllEffectIndexes];
	}
}


-(void)handleLoadTrack:(NSNotification *)notif{
	NSUInteger vcIndex = 0;
	
	if([notif.name isEqualToString:@"CunddDiveVideoChain1ShouldLoadTrack"]){
		vcIndex = 0;
	} else 
	if([notif.name isEqualToString:@"CunddDiveVideoChain2ShouldLoadTrack"]){
		vcIndex = 1;
	} else 
	if([notif.name isEqualToString:@"CunddDiveVideoChain3ShouldLoadTrack"]){
		vcIndex = 2;
	} else 
	if([notif.name isEqualToString:@"CunddDiveVideoChain4ShouldLoadTrack"]){
		vcIndex = 3;
	} else 
	if([notif.name isEqualToString:@"CunddDiveVideoChain5ShouldLoadTrack"]){
		vcIndex = 4;
	} else 
	if([notif.name isEqualToString:@"CunddDiveVideoChain6ShouldLoadTrack"]){
		vcIndex = 5;
	}
	
	if([self.content count] == 0) return;
	
	if(!draggingSourceController)[NSException raise:@"CunddDiveVideoChainCollectionControllerDraggingSourceControllerNotSet" format:@"CunddDiveVideoChainCollectionController draggingSourceController is not set"];
	CunddITunesTrack * newTrack = [[draggingSourceController selectedObjects] objectAtIndex:0];
	CunddDiveVideoChain * vc = [self.content objectAtIndex:vcIndex];
	[vc loadTrack:newTrack];
}

-(NSUInteger) count{
	return [self.content count];
}

-(void) playVideoInMainPreview{
	
}

@synthesize vcCount,targetView0,targetView1,targetView2,targetView3,targetView4,targetView5,draggingSourceController;;
@end
