//
//  CunddDiveMasterIB.m
//  Dive
//
//  Created by Daniel Corn on 11.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveMasterIB.h"


@implementation CunddDiveMasterIB
-(void) awakeFromNib{
	NSLog(@"CunddDiveMasterIB awakeFromNib with self.vcCollectionController = %@ count = %i",self.vcCollectionController,[self.vcCollectionController count]);
	self.master = [CunddDiveMaster masterWithVcCollectionController:self.vcCollectionController];
}

-(void) toggleFullscreen:(id)sender{
	[self.master toggleFullscreen:sender];
}

-(void) reopen:(id)sender{
	if(self.master){
		if(![self.master.window isVisible]){
			[self awakeFromNib];
		}
	} else {
		[self awakeFromNib];
	}
	
}



//@synthesize maEffect,maQCPatchController,
@synthesize master,vcCollectionController,canReopen;
@end
