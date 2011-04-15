//
//  CunddStreamServerPlugIn.m
//  CunddStreamServer
//
//  Created by Daniel Corn on 28.05.10.
//  Copyright (c) 2010 cundd. All rights reserved.
//

/* It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering */
#import <OpenGL/CGLMacro.h>

#import <sys/socket.h>
#import <netinet/in.h>
#import <unistd.h>

#import "CunddStreamServerPlugIn.h"

#define	kQCPlugIn_Name				@"CunddStreamServer"
#define	kQCPlugIn_Description		@"The patch publishs the given string via Bonjour to be received by a CunddStreamClient-patch."

@implementation CunddStreamServerPlugIn


@synthesize netService,listeningSocket,portNumber,cunddInputStringCache,debug;
@dynamic inputString;

+ (NSDictionary*) attributes
{
	return [NSDictionary dictionaryWithObjectsAndKeys:kQCPlugIn_Name, QCPlugInAttributeNameKey, kQCPlugIn_Description, QCPlugInAttributeDescriptionKey, nil];
}

+ (NSDictionary*) attributesForPropertyPortWithKey:(NSString*)key
{
	return nil;
}

+ (QCPlugInExecutionMode) executionMode
{
	return kQCPlugInExecutionModeConsumer;
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
	return [NSArray arrayWithObjects:@"portNumber",@"debug",nil];
}

- (id) serializedValueForKey:(NSString*)key;
{
	/*
	Provide custom serialization for the plug-in internal settings that are not values complying to the <NSCoding> protocol.
	The return object must be nil or a PList compatible i.e. NSString, NSNumber, NSDate, NSData, NSArray or NSDictionary.
	*/
	
	return [super serializedValueForKey:key];
}

- (void) setSerializedValue:(id)serializedValue forKey:(NSString*)key
{
	/*
	Provide deserialization for the plug-in internal settings that were custom serialized in -serializedValueForKey.
	Deserialize the value, then call [self setValue:value forKey:key] to set the corresponding internal setting of the plug-in instance to that deserialized value.
	*/
	
	[super setSerializedValue:serializedValue forKey:key];
}

- (QCPlugInViewController*) createViewController
{
	/*
	Return a new QCPlugInViewController to edit the internal settings of this plug-in instance.
	You can return a subclass of QCPlugInViewController if necessary.
	*/
	
	return [[QCPlugInViewController alloc] initWithPlugIn:self viewNibName:@"Settings"];
}



#pragma mark NSNetService delegate methods
-(void) netServiceDidPublish:(NSNetService *)sender{
	
}
-(void) netServiceWillPublish:(NSNetService *)sender{
	
}


- (void)connectionReceived:(NSNotification *)aNotification {
	NSFileHandle * incomingConnection = [[aNotification userInfo] objectForKey:NSFileHandleNotificationFileHandleItem];
	
	// Tell the handle to keep on listening
	[[aNotification object] acceptConnectionInBackgroundAndNotify];
	
	
	NSData * representationToSend = [self.cunddInputStringCache dataUsingEncoding:NSUTF8StringEncoding];
    
	// NSLog(@"CunddStreamServerPlugIn: WriteData %@",representationToSend);
	_updateCacheLocked = YES;
    [incomingConnection writeData:representationToSend];
    [incomingConnection closeFile];
	_updateCacheLocked = NO;
    numberOfDownloads++;
	[self debug:@"connectionReceived"];
}

-(void) setCunddInputStringCache:(NSString *)value{
	if(!_updateCacheLocked){
		[cunddInputStringCache release];
		cunddInputStringCache = value;
		[value retain];
	} else {
		[self debug:@"cunddInputStringCache is locked"];
	}
}

-(void) debug:(NSString *)msg{
	if(self.debug != 0 && self.debug){
		NSLog(@"CunddStreamServer: %@",msg);
	}
}

@end

@implementation CunddStreamServerPlugIn (Execution)

- (BOOL) startExecution:(id<QCPlugInContext>)context
{
	uint16_t chosenPort = [self.portNumber intValue];
	if(!chosenPort){
		chosenPort = 0; // allows the kernel to choose the port for us.
	}
    
    if(!listeningSocket) {
        // Here, create the socket from traditional BSD socket calls, and then set up an NSFileHandle with that to listen for incoming connections.
        int fdForListening;
        struct sockaddr_in serverAddress;
        socklen_t namelen = sizeof(serverAddress);
		
        // In order to use NSFileHandle's acceptConnectionInBackgroundAndNotify method, we need to create a file descriptor that is itself a socket, bind that socket, and then set it up for listening. At this point, it's ready to be handed off to acceptConnectionInBackgroundAndNotify.
        if((fdForListening = socket(AF_INET, SOCK_STREAM, 0)) > 0) {
            memset(&serverAddress, 0, sizeof(serverAddress));
            serverAddress.sin_family = AF_INET;
            serverAddress.sin_addr.s_addr = htonl(INADDR_ANY);
            serverAddress.sin_port = chosenPort;
			
            if(bind(fdForListening, (struct sockaddr *)&serverAddress, namelen) < 0) {
                close(fdForListening);
				NSLog(@"CunddStreamServerPlugIn: Couldn't bind port.");
                return NO;
            }
			
            if(chosenPort == 0){ // Find out what port number was chosen for us.
				if(getsockname(fdForListening, (struct sockaddr *)&serverAddress, &namelen) < 0) {
					close(fdForListening);
					NSLog(@"CunddStreamServerPlugIn: No port found.");
					return NO;
				}
				
				chosenPort = ntohs(serverAddress.sin_port);
			}
			
            
            if(listen(fdForListening, 1) == 0) {
                listeningSocket = [[NSFileHandle alloc] initWithFileDescriptor:fdForListening closeOnDealloc:YES];
            }
        }
    }
    
    if(!netService) {
        // lazily instantiate the NSNetService object that will advertise on our behalf.
        netService = [[NSNetService alloc] initWithDomain:@"" type:@"_cunddQCStream._tcp." name:NSUserName() port:chosenPort];
        [netService setDelegate:self];
    }
    
    if(netService && listeningSocket) {
		BOOL startServices = YES;
		
		if(startServices){
			numberOfDownloads = 0;
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectionReceived:) name:NSFileHandleConnectionAcceptedNotification object:listeningSocket];
            [listeningSocket acceptConnectionInBackgroundAndNotify];
            
			[netService publish];
        } else {
            [netService stop];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:NSFileHandleConnectionAcceptedNotification object:listeningSocket];
            [listeningSocket release];
            listeningSocket = nil;
        }
    }
	
	return YES;
}

- (void) enableExecution:(id<QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when the plug-in instance starts being used by Quartz Composer.
	*/
}

- (BOOL) execute:(id<QCPlugInContext>)context atTime:(NSTimeInterval)time withArguments:(NSDictionary*)arguments
{
	if([self didValueForInputKeyChange:@"inputString"] || !self.cunddInputStringCache){
		[self debug:@"inputString changed"];
		self.cunddInputStringCache = [self valueForInputKey:@"inputString"];
	}
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
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSFileHandleConnectionAcceptedNotification object:listeningSocket];
	
	if(netService){
		[netService stop];
	}
	
	if(listeningSocket){
		[listeningSocket closeFile];
		[listeningSocket release];
		listeningSocket = nil;
		
	}
}

@end
