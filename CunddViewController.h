//
//  CunddDiveNIBViewController.h
//  Menu
//
//  Created by Daniel Corn on 20.04.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
//#import "CunddDiveDraggingDestinationView.h"


@interface CunddViewController : NSViewController {
	IBOutlet NSView * targetView;
	//NSManagedObjectContext * managedObjectContext;
}
/*!
    @method     
    @abstract   Register the user-defaults for the VC
    @discussion Register the user-defaults for the VC
*/

-(void)registerUserDefaultsEntry;

@property (retain) NSView * targetView;
//@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@end
