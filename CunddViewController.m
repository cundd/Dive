//
//  CunddDiveNIBViewController.m
//  Menu
//
//  Created by Daniel Corn on 20.04.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddViewController.h"


@implementation CunddViewController

/*!
    @method     
    @abstract   Call initWithNibName:bundle: and set the target-view
    @discussion The method automatically calls initWithNibName:bundle: and sets the target view to the loaded view.
*/

-(void) awakeFromNib{
	

	
	NSLog(@"awakeFromNib with nib:%@ in bundle:%@",[self nibName],[self nibBundle]);
//	NSLog(@"%@",[(CunddDiveDraggingDestinationView *)[self.view textField] stringValue]);
	[self initWithNibName:[self nibName] bundle:[self nibBundle]];
	if(targetView != nil){
		[self.targetView addSubview:self.view];
	} else {
		NSLog(@"CunddViewController awakeFromNib: Warning no targetView set");
	}
	return;
}

-(void) loadView{
	NSLog(@"loadView");
	[super loadView];
}
/*
-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	NSLog(@"initWithNibName nibNameOrNil: %@, bundle:%@, result:%@",nibNameOrNil,nibBundleOrNil,[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]);
	return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}
-(void) setView:(NSView *)view{
	NSLog(@"setView %@",view);
	[super setView:view];
}
/* */
-(void)registerUserDefaultsEntry{
//	[[NSUserDefaultsController sharedUserDefaultsController] set]
//	[[NSUserDefaults standardUserDefaults] registerDefaults:<#(NSDictionary *)registrationDictionary#>]
//	[[NSUserDefaults standardUserDefaults] setValue:<#(id)value#> forKeyPath:<#(NSString *)keyPath#>]
}
/*
-(NSManagedObjectContext *) managedObjectContext{
	return [[NSApp delegate] managedObjectContext];
}
@synthesize managedObjectContext;
/* */
@synthesize targetView;
@end
