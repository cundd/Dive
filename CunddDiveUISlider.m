//
//  CunddDiveUISlider.m
//  Slider
//
//  Created by Daniel Corn on 16.07.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveUISlider.h"


@implementation CunddDiveUISlider
-(void) awakeFromNib{
	CunddDiveUISliderCell * newCell = [CunddDiveUISliderCell new];
	[self setCell:newCell];
}
@end
