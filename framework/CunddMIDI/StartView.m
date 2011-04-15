//
//  StartView.m
//
//  Created by Daniel Corn on 24.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "StartView.h"

@implementation StartView
-(void) awakeFromNib{
	[[CunddAppMIDIMapCreator sharedInstance] open];
}
@end
