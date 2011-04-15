//
//  CunddStreamServerPlugIn.h
//  CunddStreamServer
//
//  Created by Daniel Corn on 28.05.10.
//  Copyright (c) 2010 cundd. All rights reserved.
//

#import <Quartz/Quartz.h>

@interface CunddStreamServerPlugIn : QCPlugIn <NSNetServiceDelegate>
{
	NSNetService * netService;
    NSFileHandle * listeningSocket;
	NSString * portNumber;
	BOOL debug;
	
	NSString * cunddInputStringCache;
	
	NSUInteger numberOfDownloads;
	
	BOOL _updateCacheLocked;
}

-(void)debug:(NSString *)msg;

// Ports
@property (assign) NSString * inputString;


// Properties
@property (retain) NSString * cunddInputStringCache;
@property (retain) NSNetService * netService;
@property (retain) NSFileHandle * listeningSocket;
@property (retain) NSString * portNumber;
@property (assign) BOOL debug;
@end
