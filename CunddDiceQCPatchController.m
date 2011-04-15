//
//  CunddDiceQCPatchController.m
//
//  Created by Daniel Corn on 26.05.10.
//  Copyright 2010 cundd. All rights reserved.
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
