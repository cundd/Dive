//
//  CunddDiveEffectPullDownCell.m
//  Dive
//
//  Created by Daniel Corn on 05.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveEffectPullDownCell.h"


@implementation CunddDiveEffectPullDownCell
-(id) init{
	if([super init]){
		[self setup];
	}
	return self;
}
-(void) awakeFromNib{
	[self setup];
}


-(void)setup{
	NSMutableArray * effectLibrary = [NSMutableArray arrayWithArray:[[CunddDiveEffectLibrary sharedLibrary] library]];
	NSSortDescriptor * descriptor = [NSSortDescriptor sortDescriptorWithKey:@"category" ascending:YES];
	self.sortedObjects = [effectLibrary sortedArrayUsingDescriptors:descriptor];
}

@synthesize menuItemPrototype,separatorPrototype,sortedObjects;
@end
