//
//  CunddHTTPServer.h
//  Dive
//
//  Created by Daniel Corn on 30.08.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CunddCore/CunddObject.h>

#import "CunddHTTPConnection.h"

#include <sys/socket.h>
#import <netinet/in.h>


@interface CunddHTTPServer : CunddObject {
	NSInteger portNumber;
	
	id delegate;
	NSSocketPort * socketPort;
	NSFileHandle * fileHandle;
	
	NSMutableArray * connections;
	NSMutableArray * requests;
}


/*!
 @method     
 @abstract   Returns a new instance that listens at the given portnumber.
 @discussion Returns a new instance that listens at the given portnumber.
 */
+(id)serverWithPortNumber:(NSInteger)thePortNumber andDelegate:(id)theDelegate;


/*!
    @method     
    @abstract   Returns a new instance that listens at the given portnumber.
    @discussion Returns a new instance that listens at the given portnumber.
*/
-(id)initWithPortNumber:(NSInteger)thePortNumber andDelegate:(id)theDelegate;


/*!
    @method     
    @abstract   Invoked when a new connection is accepted.
    @discussion Invoked when a new connection is accepted.
*/
-(void)newConnection:(NSNotification *)notif;
@end
