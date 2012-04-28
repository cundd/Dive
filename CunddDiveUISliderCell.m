//
//  CunddDiveUISliderCell.m
//  Slider
//
//  Created by Daniel Corn on 16.07.10.
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
