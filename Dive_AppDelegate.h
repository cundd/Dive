//
//  Dive_AppDelegate.h
//  Dive
//
//  Created by Daniel Corn on 22.04.10.
//  Copyright cundd 2010 . All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddDiveVideoChainCollectionController.h"
#import <CunddCore/CunddAppEventHandler.h>
#import "CunddDiveMaster.h"
#import "CunddDiveQuitPanel.h"
#import <CunddMIDI/CunddAppMIDIHandler.h>

@interface Dive_AppDelegate : NSObject 
{
    NSWindow *window;
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
	
	IBOutlet CunddDiveVideoChainCollectionController * cunddDiveVideoChainCollectionController;
}

@property (nonatomic, retain) IBOutlet NSWindow *window;

@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) CunddDiveVideoChainCollectionController * cunddDiveVideoChainCollectionController;

- (IBAction)saveAction:sender;

@end
