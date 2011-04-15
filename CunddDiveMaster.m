//
//  CunddDiveMaster.m
//
//  Created by Daniel Corn on 11.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveMaster.h"

@implementation CunddDiveMaster
static NSUInteger count;

+(CunddDiveMaster *) master{
	CunddDiveMaster * newMaster = [[self alloc] init];
	[newMaster setup];
	return [newMaster autorelease];
}

+(CunddDiveMaster *) masterWithEffect:(CunddDiveMasterEffect *)aEffect qCPatchController:(CunddDiveMasterQCPatchController *)aQCPatchController andVcCollectionController:(CunddDiveVideoChainCollectionController *)aVcCollectionController{
	return [[[self alloc]
			initWithEffect:aEffect qCPatchController:aQCPatchController andVcCollectionController:aVcCollectionController] 
			autorelease
			];
}

-(CunddDiveMaster *) initWithEffect:(CunddDiveMasterEffect *)aEffect qCPatchController:
(CunddDiveMasterQCPatchController *)aQCPatchController andVcCollectionController:(CunddDiveVideoChainCollectionController *)aVcCollectionController{
	if([self init]){
		self.maEffect = aEffect;
		self.maQCPatchController = aQCPatchController;
		self.vcCollectionController = aVcCollectionController;
		[self setup];
	}
	return self;
}

+(CunddDiveMaster *) masterWithVcCollectionController:(CunddDiveVideoChainCollectionController *)aVcCollectionController{
	return [[[self alloc] initWithVcCollectionController:aVcCollectionController] autorelease];
}
-(CunddDiveMaster *) initWithVcCollectionController:(CunddDiveVideoChainCollectionController *)aVcCollectionController{
	if([self init]){
		self.vcCollectionController = aVcCollectionController;
		
		[self setup];
	}
	return self;
}

-(id) init{
	if([super init]){
		if(!count) count = 0;
		index = [NSNumber numberWithInt:count];
		count++;
	}
	return self;
}

-(void)setup{
	// Unpack the MasterOutputPreview-NIB
	[NSBundle loadNibNamed:@"MainOutputPreview" owner:self];
	
	[self registerSelf];
	return;
}


-(void) awakeFromNib{
	// Check if the VCs are ready: if YES -> register them
	if(self.vcCollectionController){
		if([self.vcCollectionController objectAtIndex:0]){
			for(NSUInteger i = 0;i < [self.vcCollectionController count];i++){
				[self registerVideoChain:[self.vcCollectionController objectAtIndex:i]];
			}
		}
	}
}
-(void) registerVideoChain:(CunddDiveVideoChain *)aVc{
	[maQCPatchController registerVideoChain:aVc];
}

-(void) registerSelf{
	[CunddAppRegistry registry:self at:[CunddConfig stringForKeyPath:@"Defaults.CunddDive.CunddDiveMaster.RegistryKey"]];
	
	/*
	NSArray * masterArray = [CunddAppRegistry registry:[CunddConfig stringForKeyPath:@"Defaults.CunddDive.CunddDiveMaster.RegistryKey"]];
	
	NSMutableArray * tempMasterArray = [NSMutableArray arrayWithArray:masterArray];
	[tempMasterArray addObject:self];
	
	[CunddAppRegistry registry:[NSArray arrayWithArray:tempMasterArray] at:[CunddConfig stringForKeyPath:@"Defaults.CunddDive.CunddDiveMaster.RegistryKey"]];
	 */
}


-(void) toggleFullscreen:(id)sender{
	if(fullscreenWindow){ // If fullscreenWindow -> leave fullscreen
		NSRect newFrame = [fullscreenWindow frameRectForContentRect:
						   [window contentRectForFrameRect:[window frame]]];
		[fullscreenWindow
		 setFrame:newFrame
		 display:YES
		 animate:YES];
		
		// [window setContentView:_oldContentView];
		[window setContentView:_oldContentView];
		[self.qcContainer addSubview:[fullscreenWindow contentView]];
		
		
		[window makeKeyAndOrderFront:nil];
		
		[fullscreenWindow close];
		fullscreenWindow = nil;
		
		// Hide the menu
		if([[window screen] isEqual:[[NSScreen screens] objectAtIndex:0]]){
			[NSMenu setMenuBarVisible:YES];
		}
	} else { // If not fullscreenWindow -> go fullscreen
		[window deminiaturize:nil];
		
		CunddDiveMasterQCView * qcView = (CunddDiveMasterQCView *)self.maQCPatchController.view;
		
		if([[window screen] isEqual:[[NSScreen screens] objectAtIndex:0]]){
			[NSMenu setMenuBarVisible:NO];
		}
		
		fullscreenWindow = [[NSWindow alloc]
							initWithContentRect:[window contentRectForFrameRect:[window frame]]
							styleMask:NSBorderlessWindowMask
							backing:NSBackingStoreBuffered
							defer:YES];
		[fullscreenWindow setLevel:NSFloatingWindowLevel];
		
		// [fullscreenWindow setContentView:[window contentView]];
		_oldContentView = [window contentView];
		[fullscreenWindow setContentView:qcView];
		
		[fullscreenWindow setTitle:[window title]];
		[fullscreenWindow makeKeyAndOrderFront:nil];
		
		[fullscreenWindow setFrame:[fullscreenWindow frameRectForContentRect:[[window screen] frame]] display:YES animate:YES];
		[window orderOut:nil];
	}
}

-(NSString *) name{
	return [NSString stringWithFormat:@"Master #%@",index];
}

@synthesize maEffect,maQCPatchController,vcCollectionController,window,fullscreenWindow,qcContainer,_oldContentView;
@end
