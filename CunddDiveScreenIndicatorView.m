//
//  CunddDiveScreenIndicatorView.m
//
//  Created by Daniel Corn on 17.07.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveScreenIndicatorView.h"

@implementation CunddDiveScreenIndicatorView
-(id) initWithFrame:(NSRect)frameRect{
	if([super initWithFrame:frameRect]){
		if(![NSBundle loadNibNamed:@"ScreenIndicator" owner:self]){
			NSLog(@"CunddDiveScreenIndicatorView error on loading the nib-file");
		}
		[self addSubview:self.screenIndicatorView];
	}
	return self;
}

@synthesize screenIndicatorView,vcQcPatchController;
@end
