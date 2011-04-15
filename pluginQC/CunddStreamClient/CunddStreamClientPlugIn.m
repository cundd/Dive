//
//  CunddStreamClientPlugIn.m
//  CunddStreamClient
//
//  Created by Daniel Corn on 28.05.10.
//  Copyright (c) 2010 cundd. All rights reserved.
//

/* It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering */
#import <OpenGL/CGLMacro.h>

#import "CunddStreamClientPlugIn.h"

#define	kQCPlugIn_Name				@"CunddStreamClient"
#define	kQCPlugIn_Description		@"Streams data from an CunddStreamServer patch."

@implementation CunddStreamClientPlugIn

@synthesize cunddOutputStringCache,browser,services,currentDownload,serverService,debug,_countSkippedUpdates,_maxSkippedUpdates;
@dynamic outputString;


+ (NSDictionary*) attributes
{
	return [NSDictionary dictionaryWithObjectsAndKeys:kQCPlugIn_Name, QCPlugInAttributeNameKey, kQCPlugIn_Description, QCPlugInAttributeDescriptionKey, nil];
}

+ (NSDictionary*) attributesForPropertyPortWithKey:(NSString*)key
{
	/*
	Specify the optional attributes for property based ports (QCPortAttributeNameKey, QCPortAttributeDefaultValueKey...).
	*/
	
	return nil;
}

+ (QCPlugInExecutionMode) executionMode
{
	return kQCPlugInExecutionModeProvider;
}

+ (QCPlugInTimeMode) timeMode
{
	return kQCPlugInTimeModeNone;
}

- (id) init
{
	if(self = [super init]) {
		/*
		Allocate any permanent resource required by the plug-in.
		*/
	}
	
	return self;
}

- (void) finalize
{
	/*
	Release any non garbage collected resources created in -init.
	*/
	
	[super finalize];
}

- (void) dealloc
{
	/*
	Release any resources created in -init.
	*/
	
	[super dealloc];
}

+ (NSArray*) plugInKeys
{
	return [NSArray arrayWithObjects:@"debug",nil];
}




- (QCPlugInViewController*) createViewController
{
	return [[QCPlugInViewController alloc] initWithPlugIn:self viewNibName:@"Settings"];
}


-(void) startStream{
	BOOL cancelAfterTime = NO;
	BOOL autoRescan = YES;
	
	if(!_countSkippedUpdates){
		_countSkippedUpdates = 0;
	}
	if(!_maxSkippedUpdates){
		[self debug:[NSString stringWithFormat:@"set _maxSkippedUpdates=%i",_maxSkippedUpdates]];
		_maxSkippedUpdates = 10;
	}
	if(!_rescanAfterSkippedUpdates){
		_rescanAfterSkippedUpdates = 200;
	}
	[self debug:[NSString stringWithFormat:@"_countSkippedUpdates=%i",_countSkippedUpdates]];
	
	
	// Automatically rescan for services
	if(_countSkippedUpdates >= _rescanAfterSkippedUpdates && autoRescan){
		[self debug:@"Rescan for services ---------------------------"];
		[self startBrowser];
		
		if(_oldStream){
			[_oldStream close];
			_oldStream = nil;
		}
		
		_countSkippedUpdates = 0;
		_streamRunning = NO;
		return;
	}
	
	if(_countSkippedUpdates >= _maxSkippedUpdates && cancelAfterTime){ // Flush content
		if([currentDownload length]){
			[self.cunddOutputStringCache release];
			self.cunddOutputStringCache = [[NSString alloc] initWithData:currentDownload encoding:NSUTF8StringEncoding];
			
			[currentDownload release];
			currentDownload = nil;			
		}
		if(_oldStream){
			[_oldStream close];
			_oldStream = nil;
		}
		
		_countSkippedUpdates = 0;
		_streamRunning = NO;
		
		[self debug:@"Old stream finished"];
	}
	/* */
	
	
	if(!_streamRunning && self.serverService){
		[self debug:@"startStream"];
		
		NSInputStream * istream;
		[self.serverService getInputStream:&istream outputStream:nil];
		
		if(!istream){
			_countSkippedUpdates = 0;
			[self debug:@"No istream"];
			return;
		}
		[istream retain];
		[istream setDelegate:self];
		[istream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		[istream open];	
		
		_streamRunning = YES;
	}
	_countSkippedUpdates++;
}


#pragma mark NSNetServiceBrowser delegate methods
- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing {
	
	// Just use the last found service
	if(!moreComing){
		[aNetService retain];
		[aNetService setDelegate:self];
		[aNetService resolveWithTimeout:5.0];
	}
}

#pragma mark NSNetService delegate methods
-(void) netServiceDidResolveAddress:(NSNetService *)sender{
	self.serverService = sender;
	[self startStream];
}

#pragma mark NSStreamDelegate methods
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)event {
	switch(event) {
        case NSStreamEventHasBytesAvailable:
            if (!currentDownload) {
                currentDownload = [[NSMutableData alloc] initWithCapacity:409600];
            }
            uint8_t readBuffer[4096];
            int amountRead = 0;
            NSInputStream * is = (NSInputStream *)aStream;
            amountRead = [is read:readBuffer maxLength:4096];
            [currentDownload appendBytes:readBuffer length:amountRead];
			
			// [self debug:[NSString stringWithFormat:@"stream %s",readBuffer]];
			if(!_oldStream) _oldStream = (NSInputStream *)aStream;
			
            break;
        case NSStreamEventEndEncountered:
            [(NSInputStream *)aStream close];
			if(![currentDownload length]){
				_streamRunning = NO;
				break;
			}
			
			[self.cunddOutputStringCache release];
			self.cunddOutputStringCache = [[NSString alloc] initWithData:currentDownload encoding:NSUTF8StringEncoding];
			
			[currentDownload release];
            currentDownload = nil;
			_countSkippedUpdates = 0;
			_streamRunning = NO;
			[self debug:@"Stream finished"];
            break;
        default:
            break;
    }
}


-(void) debug:(NSString *)msg{
	if(self.debug != 0 && self.debug){
		NSLog(@"CunddStreamClient: %@",msg);
	}
}


-(void)startBrowser{
	browser = [[NSNetServiceBrowser alloc] init];
    [browser setDelegate:self];
	
	_countSkippedUpdates = 0;
    
    // Passing in "" for the domain causes us to browse in the default browse domain
    [browser searchForServicesOfType:@"_cunddQCStream._tcp." inDomain:@""];
}

@end

@implementation CunddStreamClientPlugIn (Execution)

- (BOOL) startExecution:(id<QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when rendering of the composition starts: perform any required setup for the plug-in.
	Return NO in case of fatal failure (this will prevent rendering of the composition to start).
	*/
	
	return YES;
}

- (void) enableExecution:(id<QCPlugInContext>)context
{
	[self startBrowser];
}

- (BOOL) execute:(id<QCPlugInContext>)context atTime:(NSTimeInterval)time withArguments:(NSDictionary*)arguments
{
	[self startStream];
	self.outputString = self.cunddOutputStringCache;
	return YES;
}

- (void) disableExecution:(id<QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when the plug-in instance stops being used by Quartz Composer.
	*/
}

- (void) stopExecution:(id<QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when rendering of the composition stops: perform any required cleanup for the plug-in.
	*/
}

@end
