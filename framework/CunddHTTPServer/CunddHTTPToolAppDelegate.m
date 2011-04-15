//
//  CunddHTTPToolAppDelegate.m
//  CunddHTTPServer
//
//  Created by Daniel Corn on 31.08.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddHTTPToolAppDelegate.h"


@implementation CunddHTTPToolAppDelegate
-(void) applicationDidFinishLaunching:(NSNotification *)notification{
	CunddHTTPServer * server;
	server = [CunddHTTPServer serverWithPortNumber:60123 andDelegate:self];
}

-(NSDictionary *) processDataForURL:(NSURL *)url message:(CFHTTPMessageRef)message{
	NSLog(@"%@",url);
	
	NSLog(@"%@",(NSData*)CFHTTPMessageCopyBody(message));
	
	NSDictionary * headers = [NSDictionary dictionaryWithObjectsAndKeys:
							  @"text/html",@"Content-Type",
							  nil
							  ];
	NSNumber * code = [NSNumber numberWithInt:200];
	
	NSString * path = [[NSBundle mainBundle] pathForResource:@"nachricht" ofType:@"html"];
	NSData * body = [[NSString stringWithContentsOfFile:path] dataUsingEncoding:NSUTF8StringEncoding];
	
	return [NSDictionary dictionaryWithObjectsAndKeys:
			code,CunddHTTPMessageStatusCode,
			headers,CunddHTTPMessageHeaders,
			body,CunddHTTPMessageBody,
			nil
			];
}
@end
