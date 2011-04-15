//
//  CunddStreamServicesTableViewDataSource.h
//  CunddStream_iMonitor
//
//  Created by Daniel Corn on 08.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CunddStreamClient.h"


@interface CunddStreamServicesTableViewDataSource : NSObject <UITableViewDelegate,UITableViewDataSource> {
	UITextView * textView;
	UITableView * browserTable;
	NSMutableArray * services;
	CunddStreamClient * client;
}

/*!
 @method     
 @abstract   Starts the stream
 @discussion Starts the stream
 */
-(IBAction)startStream:(id)sender;

/*!
 @method     
 @abstract   Browses for net services
 @discussion Browses for net services
 */
- (IBAction)browse:(id)sender;

@property (retain) CunddStreamClient * client;
@property (retain) IBOutlet UITableView * browserTable;
@property (retain) IBOutlet UITextView * textView;
@property (assign) IBOutlet UIWindow *window;
@property (retain) IBOutlet NSMutableArray * services;

@end
