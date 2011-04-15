//
//  CunddITunesTracklistDelegate.h
//  Dive
//
//  Created by Daniel Corn on 06.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Cundd.h"
#import "CunddDiveVideoChainCollectionController.h"
#import "CunddDiveDraggingSourceController.h"
#import "CunddITunesTrack.h"


@interface CunddITunesTracklistDelegate : CunddObject <NSTableViewDelegate> {
	IBOutlet CunddDiveDraggingSourceController * draggingSourceController;
	IBOutlet NSButton * loadVc1Button;
	IBOutlet NSButton * loadVc2Button;
	IBOutlet NSButton * loadVc3Button;
	CunddDiveVideoChainCollectionController * cunddDiveVideoChainCollectionController;
}

-(IBAction)loadTrack:(NSButton *)sender;
@property (retain) CunddDiveDraggingSourceController * draggingSourceController;
@property (retain) CunddDiveVideoChainCollectionController * cunddDiveVideoChainCollectionController;
@property (retain) NSButton * loadVc1Button,*loadVc2Button,*loadVc3Button;



@end
