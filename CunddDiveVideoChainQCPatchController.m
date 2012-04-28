//
//  CunddDiveVideoChainQCPatchController.m
//  Dive
//
//  Created by Daniel Corn on 23.04.10.
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

#import "CunddDiveVideoChainQCPatchController.h"


@implementation CunddDiveVideoChainQCPatchController
#pragma mark Init scripts

-(id) init{
	[super init];
//	return [self setup];
	return self;
}
-(void) awakeFromNib{
	[self setup];
}


-(id) setup{
	[self debug:@"-------CunddDiveVideoChainQCPatchController init ---------------------"];
	// If no settings are connected they are automatically created
	if(!patch){
		if(self.effectViewContainer){
			self.patch = [CunddDiveVideoChainSettings settingsWithEffectViewContainer:self.effectViewContainer];
		} else {
			NSLog(@"Warning: CunddDiveVideoChainQCPatchController effectViewContainer is not set");
			self.patch = [[[CunddDiveVideoChainSettings alloc] init] autorelease];
		}
	}
	//self.content = self.patch;
	
	
	// Load the Quartz-Composer-composition
	NSString * path = [[NSBundle mainBundle] pathForResource:@"vc" ofType:@"qtz"];
	if(![[NSFileManager defaultManager] fileExistsAtPath:path]){
		NSLog(@"CunddDiveVideoChainQCPatchController the required Quartz Composer-file couldn't be found");
		[NSApp terminate:nil];
	}
	
	self.view = [CunddDiveVideoChainQCView qcViewWithView:self.targetView andFilePath:path];
	
	/*
	void(^qcViewBlock)(void);
	qcViewBlock = ^(void){
		self.view = [CunddDiveVideoChainQCView qcViewWithView:self.targetView andFilePath:path];
	};
	
//	dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), qcViewBlock);
//	dispatch_async(dispatch_get_main_queue(), qcViewBlock);
	
	/*
	[self.view display];
	if(!self.targetView)NSLog(@"Target View not set %@",object_getClassName(nil));
	
	NSLog(@"self.view = %@",self.view);
	//[self.targetView retain];
	[self.targetView addSubview:self.view];
	 // */
	
	[self debug:@"qcComposition inputKeys %@" o:[self.view inputKeys]];
//	[self debug:@"qcComposition outputKeys %@" o:[self.qcComposition outputKeys]];
//	[self debug:@"qcComposition attributes %@" o:[self.qcComposition attributes]];
	
	// Add and connect the QCPatchController
/*	if(![self.qcPatchController patch]){
		[self.qcPatchController setView:self.view];
	}
	// */
	
	
	// Add observers
	
	// Read settings
	BOOL reverseBinding = [CunddConfig isTrue:@"Defaults.CunddDive.CunddDiveVideoChainQCPatchController.reverse_binding"];
	BOOL reverseBindingWithValueKey = [CunddConfig isTrue:@"Defaults.CunddDive.CunddDiveVideoChainQCPatchController.reverse_binding_with_value_key"];
	
	// For every input set an observer at the patch and in reverse
	for(NSString * inputKey in [self.view inputKeys]){
		NSLog(@"add observer for inputKey %@",inputKey);
		[self.patch addObserver:self forKeyPath:inputKey options:NSKeyValueObservingOptionNew context:nil];
		
		if(reverseBinding){
			// key-path with "patch."
			[self.view		addObserver:self forKeyPath:[NSString stringWithFormat:@"patch.%@",inputKey] options:NSKeyValueObservingOptionNew context:nil];
			[self.qcComposition		addObserver:self forKeyPath:[NSString stringWithFormat:@"patch.%@",inputKey] options:NSKeyValueObservingOptionNew context:nil];
			
			// key-path with "patch." and ".value"
			if(reverseBindingWithValueKey){
				if(![inputKey isEqualToString:@"argsPsl1"] && 
				   ![inputKey isEqualToString:@"argsPsl2"] && 
				   ![inputKey isEqualToString:@"argsPsl3"]){
					[self.view		addObserver:self forKeyPath:[NSString stringWithFormat:@"patch.%@.value",inputKey] options:NSKeyValueObservingOptionNew context:nil];
					[self.qcComposition		addObserver:self forKeyPath:[NSString stringWithFormat:@"patch.%@.value",inputKey] options:NSKeyValueObservingOptionNew context:nil];
				}				
			}
			
			// key-path without "patch."
			[self.view	 addObserver:self forKeyPath:inputKey options:NSKeyValueObservingOptionNew context:nil];
			[self.qcComposition addObserver:self forKeyPath:inputKey options:NSKeyValueObservingOptionNew context:nil];
		}
	}
	
	/*
	NSLog(@"self.qcComposition exposedBindings:%@",[self.qcComposition exposedBindings]);
	NSLog(@"self.view exposedBindings:%@ %@",[(QCView *)self.view outputKeys], [self.view valueForKey:@"output"]);
	// Add observer to the output-port
	[self.qcComposition addObserver:self forKeyPath:@"output" options:NSKeyValueObservingOptionNew context:nil];
	[self.view addObserver:self forKeyPath:@"output" options:NSKeyValueObservingOptionNew context:nil];
	// */
	
	// Add observer for the effect-settings
	// NSString * effectChainPropertyAliasIdentifier = [CunddConfig valueForKeyPath:@"Constants.CunddDive.kEffectSettingsPropertyAliasIdentifier"];
	
	for(int i = 0;i < 6;i++){
		/*
		NSLog(@"%@",[NSString stringWithFormat:@"psl1.arg%i.argValue",i]);
		[self.patch addObserver:self forKeyPath:[NSString stringWithFormat:@"psl1.arg%i.argValue",i] options:NSKeyValueObservingOptionNew context:effectChainPropertyAliasIdentifier];
		[self.patch addObserver:self forKeyPath:[NSString stringWithFormat:@"psl2.arg%i.argValue",i] options:NSKeyValueObservingOptionNew context:effectChainPropertyAliasIdentifier];
		[self.patch addObserver:self forKeyPath:[NSString stringWithFormat:@"psl3.arg%i.argValue",i] options:NSKeyValueObservingOptionNew context:effectChainPropertyAliasIdentifier];
		
		/*
		[self addObserver:self forKeyPath:[NSString stringWithFormat:@"patch.psl1.arg%i.argValue",i] options:NSKeyValueObservingOptionNew context:effectChainPropertyAliasIdentifier];
		[self addObserver:self forKeyPath:[NSString stringWithFormat:@"patch.psl2.arg%i.argValue",i] options:NSKeyValueObservingOptionNew context:effectChainPropertyAliasIdentifier];
		[self addObserver:self forKeyPath:[NSString stringWithFormat:@"patch.psl3.arg%i.argValue",i] options:NSKeyValueObservingOptionNew context:effectChainPropertyAliasIdentifier];
//		patch.psl1.arg2.argValue
		 // */

	}
	
	
	
	// Read the vc's user defaults
	[self.patch setPropertiesFromUserDefaults];
	
	return self;
}


#pragma mark Observer methods
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
	if([self ifDebug])printf("\n");
	[self debug:@"observeValueForKeyPath keyPath = %@" o:keyPath];
	[self debug:@"observeValueForKeyPath change = %@" o:change];
	[self debug:@"observeValueForKeyPath object = %@" o:object];
	[self debug:@"observeValueForKeyPath context = %@ of type = %@" o:context o:[NSString stringWithFormat:@"%s",object_getClassName(context)]];
	
	id newValue = [change valueForKey:NSKeyValueChangeNewKey];
	if(context){
		// Wenn ein context übergeben wurde und dieser signalisiert, dass effect-settings geändert wurden
		NSString * contextAsString = [NSString stringWithFormat:@"%@",context];
		if([contextAsString isEqualToString:[CunddConfig valueForKeyPath:@"Constants.CunddDive.kEffectSettingsPropertyAliasIdentifier"]]){
			NSRange rangeOfStringPsl1 = [keyPath rangeOfString:@"psl1"];
			NSRange rangeOfStringPsl2 = [keyPath rangeOfString:@"psl2"];
			NSRange rangeOfStringPsl3 = [keyPath rangeOfString:@"psl3"];
			if(rangeOfStringPsl1.location != NSNotFound){
				[self refreshArgsPsl1];
			} else 
			if(rangeOfStringPsl2.location != NSNotFound){
				[self refreshArgsPsl2];
			} else
			if(rangeOfStringPsl3.location != NSNotFound){
				[self refreshArgsPsl3];
			}
		}
	} else if(object == self.patch){
		[self.view setValue:newValue forInputKey:keyPath];
		
	/* Beim ersten Durchlauf löscht die Composition die Werte aller Input-Ports, dabei sollen die Settings 
	 nicht überschrieben werden.
	*/
	} else if((object == self.view || object == self.qcComposition) && [self _qcCompositionDidClear]){
		if(![keyPath isEqualToString:@"argsPsl1"]){
			[self setValue:newValue forKeyPath:keyPath];
		}
	}
	
}

-(void) refreshAllPorts{
	// TODO: Wirklich alle ports neu laden
	[self refreshArgsPsl1];
	[self refreshArgsPsl2];
	[self refreshArgsPsl3];
	[self refreshMovieLocation];
}

-(void)refreshAllEffectIndexes{
	//[self refresh]
}

-(void) refreshArgsPsl1{
	[self debug:@"refreshArgsPsl1 %@" o:self.patch.argsPsl1];
	[self.view setValue:self.patch.argsPsl1 forInputKey:@"argsPsl1"];
}
-(void) refreshArgsPsl2{
	[self debug:@"refreshArgsPsl2"];
	[self.view setValue:self.patch.argsPsl2 forInputKey:@"argsPsl2"];
}
-(void) refreshArgsPsl3{
	[self debug:@"refreshArgsPsl3"];
	[self.view setValue:self.patch.argsPsl3 forInputKey:@"argsPsl3"];
}

-(void) refreshMovieLocation{
	[self debug:@"refreshMovieLocation movieLocation=%@" o:self.patch.movieLocation];
	[self.view setValue:self.patch.movieLocation forInputKey:@"movieLocation"];
}





#pragma mark NSCoding Dummy
-(id) initWithCoder:(NSCoder *)aDecoder{
	return self;
}
-(void) encodeWithCoder:(NSCoder *)aCoder{
	
}


#pragma mark Setters
-(void) setValue:(id)value forUndefinedKey:(NSString *)key{
	// Passing accessors for undefined properties to the patch
	[self.patch setValue:value forKey:key];
	[self debug:@"setValue:%@ forUndefinedKey:%@" o:value o:key];
}

/*
-(void) setValue:(id)value forKeyPath:(NSString *)keyPath{
	[self debug:@"setValue:%@ forKeyPath:%@" o:value o:keyPath];
	[super setValue:value forKeyPath:keyPath];
//	[self.patch setValue:value forKey:keyPath];
}
 // */


#pragma mark Getters
-(id) valueForKeyPath:(NSString *)keyPath{
	[self debug:@"valueForKeyPath:%@" o:keyPath];
	return [super valueForKeyPath:keyPath];
}

-(id) valueForUndefinedKey:(NSString *)key{
	[self debug:@"valueForUndefinedKey:%@" o:key];
	return nil;
}




-(BOOL)_qcCompositionDidClear{
	if(!_qcCompositionDidClearInputsOnce){
		if(!_qcCompositionDidClearMax){
			_qcCompositionDidClearMax = [[self.qcComposition inputKeys] count];
		}
		_qcCompositionDidClearCounter++;
		if(_qcCompositionDidClearCounter > _qcCompositionDidClearMax){
			_qcCompositionDidClearInputsOnce = YES;
		}
	}
	return _qcCompositionDidClearInputsOnce;
	
}

//@dynamic content;
@synthesize view,qcComposition,effectViewContainer,patch,targetView;
@end
