//
//  CunddDiveMasterQCView.m
//  Dive
//
//  Created by Daniel Corn on 17.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveMasterQCView.h"


@implementation CunddDiveMasterQCView
+(CunddDiveMasterQCView *) qcViewWithView:(NSView *)aView andFilePath:(NSString *)thePath{
	return [[[self alloc] initWithView:aView andFilePath:thePath] autorelease];
}
-(BOOL) fullscreen{
	return NO;
}
@end
