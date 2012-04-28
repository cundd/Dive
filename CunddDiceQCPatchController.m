//
//  CunddDiceQCPatchController.m
//
//  Created by Daniel Corn on 26.05.10.
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

#import "CunddDiceQCPatchController.h"

@implementation CunddDiceQCPatchController
-(void)awakeFromNib{
	// Load the composition
//	NSString * compositionPath = [[NSBundle mainBundle] pathForResource:@"ClientMain" ofType:@"qtz"];
	NSString * compositionPath = [[NSBundle mainBundle] pathForResource:@"ClientVCController" ofType:@"qtz"];
	if(![[NSFileManager defaultManager] fileExistsAtPath:compositionPath]){
		[self throw:@"CompositionNotFound" reason:[NSString stringWithFormat:@"No composition found at %@",compositionPath]];
	}
	
	if(!self.targetView){
		[self throw:@"Target view is not set"];
	}
	self.view = [CunddDiceQCView qcViewWithView:targetView andFilePath:compositionPath];
	
	[CunddAppRegistry registerValue:self at:@"CunddDiveMasterQCPatchController"];
	
	[self addObserver:self forKeyPath:@"patch.environment" options:NSKeyValueObservingOptionNew context:@"environment"];
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
	id newValue = [change valueForKey:NSKeyValueChangeNewKey];
	[self debug:@"observeValueForKeyPath keyPath = %@" o:keyPath];
	[self debug:@"observeValueForKeyPath change = %@" o:change];
	[self debug:@"observeValueForKeyPath object = %@" o:object];
	[self debug:@"observeValueForKeyPath context = %@ of type = %@" o:context o:[NSString stringWithFormat:@"%s",object_getClassName(context)]];
	
	if([keyPath isEqualToString:@"patch.environment"]){
		[self.view setValue:newValue forInputKey:@"environment"];
	}
}

@synthesize targetView,patch;
@end
