//
//  CunddDiveUISliderCell.m
//  Slider
//
//  Created by Daniel Corn on 16.07.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveUISliderCell.h"


@implementation CunddDiveUISliderCell
static NSImage * barImage;
static NSImage * knobImage;

-(id) init{
	if([super init]){
		[super setNumberOfTickMarks:21];
		[super setAllowsTickMarkValuesOnly:YES];
	}
	return self;
}
-(void) setNumberOfTickMarks:(NSInteger)count{
	// Do nothing
}
-(void) setAllowsTickMarkValuesOnly:(BOOL)yorn{
	// Do nothing
}

-(void) drawBarInside:(NSRect)aRect flipped:(BOOL)flipped{
	[[self controlView] lockFocus];
	
	[self.barImage drawInRect:aRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	[[self controlView] unlockFocus];
}

-(void) drawKnob:(NSRect)knobRect{
	[[self controlView] lockFocus];
//	[super drawKnob:knobRect];
	
	[self.knobImage drawAtPoint:knobRect.origin fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	[[self controlView] unlockFocus];
}

- (void) drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView*)controlView {
    cellFrame = [self drawingRectForBounds:cellFrame];
    [controlView lockFocus];
	
    [self drawBarInside:cellFrame flipped:[controlView isFlipped]];
    [self drawKnob];
    [controlView unlockFocus];
}


-(NSImage *) barImage{
	if(!barImage) barImage = [NSImage imageNamed:@"dive_slider_bar"];
	return barImage;
}
-(NSImage *) knobImage{
	if(!knobImage) knobImage = [NSImage imageNamed:@"dive_slider_thumb"];
	return knobImage;
}

@end
