//
//  CunddDiveQCView.m
//  Dive
//
//  Created by Daniel Corn on 17.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveQCView.h"


@implementation CunddDiveQCView
+(id) qcViewWithView:(NSView *)aView andFilePath:(NSString *)thePath{
	return [[[self alloc] initWithView:aView andFilePath:thePath] autorelease];
}


-(id) initWithView:(NSView *)aView andFilePath:(NSString *)thePath{
	if([self initWithFrame:[aView bounds]]){
		self.compositionFilePath = thePath;
		
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(surfaceDidResize:) 
													 name:NSViewGlobalFrameDidChangeNotification
												   object:self];
		/*
		 [[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(_surfaceNeedsUpdate:) 
													 name:
												   object:self];
		/* */
		[aView addSubview:self];
		[self startRendering];
	}
	return self;
}


-(BOOL) startRendering{
	// Create the context and it's attributes
	NSOpenGLPixelFormatAttribute attributes[] = {
		//		NSOpenGLPFAFullScreen,
		//		NSOpenGLPFAScreenMask,
		//		CGDisplayIDToOpenGLDisplayMask(kCGDirectMainDisplay),
		NSOpenGLPFANoRecovery,
		NSOpenGLPFADoubleBuffer,
		NSOpenGLPFAAccelerated,
		NSOpenGLPFADepthSize,
		24,
		(NSOpenGLPixelFormatAttribute) 0
	};
	
	
	self.format = [[NSOpenGLPixelFormat alloc] initWithAttributes:attributes];
	
	NSOpenGLContext * sharedContext = [CunddAppRegistry registry:@"CunddDiveQCViewOpenGLSharedContext"];
	if(sharedContext){
		self.context = [[NSOpenGLContext alloc] initWithFormat:self.format shareContext:sharedContext];		
	} else {
		self.context = [[NSOpenGLContext alloc] initWithFormat:self.format shareContext:nil];
		[CunddAppRegistry registry:self.context at:@"CunddDiveQCViewOpenGLSharedContext"];
	}
	
	
	if([self fullscreen]){
		[self.context setFullScreen];
	}
	
	int value = 1;
	[self.context setValues:&value forParameter:kCGLCPSwapInterval];
	
	if(!context) return NO;
	
	
	// Create the renderer
	self.qcRenderer = [[QCRenderer alloc] initWithOpenGLContext:context pixelFormat:format file:compositionFilePath];
	
	if(!qcRenderer) return NO;
	
	if([self startTimer]){
		[self debug:@"startRendering: ok"];
		return YES;
	} else {
		return NO;
	}
}


-(BOOL) startTimer{
	BOOL useGCD = YES;
	
	NSTimeInterval timeInterval = (NSTimeInterval) 1.0 / [[CunddConfig valueForKeyPath:@"Defaults.CunddDive.CunddDiveMaster.Framerate"] intValue];
	
	if(useGCD){
#if MAC_OS_X_VERSION_10_6 || MAC_OS_X_VERSION_10_7
		uint64_t timeInterval_gcd;
		timeInterval_gcd = timeInterval * NSEC_PER_SEC;
		
		// Info: http://libdispatch.macosforge.org/trac/wiki/tutorial#Respondingtoevents:Sources
		dispatch_queue_t queue	= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
		
		dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
		if(!source){
			[self throw:@"Source couldn't be created"];
		}
		dispatch_source_set_timer(source, 0, timeInterval_gcd, 0);
		
		void (^renderBlock)(void);
		renderBlock = ^(void) {
			[self renderWithEvent:nil];
		};
		
		
		dispatch_source_set_event_handler(source, renderBlock);
		dispatch_resume(source);
#endif
	} else {
		_renderTimer = [[NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(_render:) userInfo:nil repeats:YES]retain];
		
		if(!_renderTimer){
			return NO;
		}
		
		// Enable firing when GUI control is clicked
		// Info: http://www.cocoadev.com/index.pl?NSTimerDoesntRunWhenMenuClicked
		// Info: http://hayne.net/MacDev/TestButtonDown/
		[[NSRunLoop currentRunLoop] addTimer:_renderTimer forMode:NSEventTrackingRunLoopMode];
	}
	
	isRendering = TRUE;
	return YES;
}


-(void) lockFocus{
	[super lockFocus];
	
	if([self.context view] != self && self != nil && [self fullscreen] != TRUE){
		[self.context setView:self];
	}
	[self.context makeCurrentContext];
}


-(void) _render:(NSTimer *)timer{
	[self renderWithEvent:nil];
}


-(void) renderWithEvent:(NSEvent *)event{
	_event = event;
	
	[self _renderAsBlock];
	return;
	
}


- (void) _renderAsBlock{
	NSEvent * event = _event;
    NSTimeInterval  time = [NSDate timeIntervalSinceReferenceDate];
    NSPoint             mouseLocation;
    NSMutableDictionary  *arguments;
	
    if(_startTime == 0){
		_startTime = time;
        time = 0;
    } else {
		time -= _startTime;
	}
	
    mouseLocation = [NSEvent mouseLocation];
    mouseLocation.x /= self.bounds.size.width;
    mouseLocation.y /= self.bounds.size.height;
    arguments = [NSMutableDictionary dictionaryWithObject:[NSValue 
                                                           valueWithPoint:mouseLocation]
                                                   forKey:QCRendererMouseLocationKey];
    if(event){
		[arguments setObject:event forKey:QCRendererEventKey];
	}
	
	
	if(![qcRenderer renderAtTime:time arguments:arguments]){
		[self debug:[NSString stringWithFormat:@"Rendering failed at time %.3fs",time]];
	}
	[self.context flushBuffer];
	
	return;
}


-(void) surfaceDidResize:(NSNotification *)notif{
	if([self.context view] == self){
		NSRect lBounds = [[self superview] bounds];
		NSRect lFrame = [[self superview] frame];
		
		[self setFrame:lBounds];
		[self setBounds:lBounds];
		
		glViewport((GLint)0,(GLint)0,(GLsizei)lFrame.size.width,(GLsizei)lFrame.size.height);

		/*
		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();
		/* */
		
		
		[self debug:[NSString stringWithFormat:@"update OpenGL context to (%i, %i, %ix%i)",(GLint)lFrame.origin.x,(GLint)lFrame.origin.y,(GLsizei)lFrame.size.width,(GLsizei)lFrame.size.height]];
		[self.context update];
		//[self display];
	}
}
-(void) surfaceDidMove:(NSNotification *)notif{
	[self surfaceDidResize:notif];
}


-(void) play:(id)sender{
	[self startTimer];
}

-(void) pause:(id)sender{
	isRendering = FALSE;
	[_renderTimer invalidate];
}

-(void) togglePlayback:(id)sender{
	if(isRendering){
		[self pause:sender];
	} else {
		[self play:sender];
	}
}

-(void)restart:(id)sender{
	[self stop:nil];
	
	// Create the renderer
	self.qcRenderer = [[QCRenderer alloc] initWithOpenGLContext:context pixelFormat:format file:compositionFilePath];
	
	if([self startTimer]){
		[self debug:@"startRendering: ok"];
	}
}


-(void) stop:(id)sender{
	if(!self.qcRenderer) return;
	if(!self.isRendering) return;
		
	[self.context clearDrawable];
	
	if([self.qcRenderer retainCount] > 0)
		[self.qcRenderer release];
	
	NSLog(@"renderTimer");
	
	if(_renderTimer != nil || _renderTimer != NULL){
		if([_renderTimer retainCount]){
			if([_renderTimer isValid]){
				[_renderTimer invalidate];
			}
			[_renderTimer release];
		}
	}
	[self display];
	isRendering = NO;
}


#pragma mark QCCompositionRenderer methods 
-(NSMutableDictionary *) userInfo{
	return [self.qcRenderer userInfo];
}
-(void) setInputValuesWithPropertyList:(id)plist{
	[self.qcRenderer setInputValuesWithPropertyList:plist];
}
-(id) propertyListFromInputValues{
	return [self.qcRenderer propertyListFromInputValues];
}
-(id) valueForInputKey:(NSString *)key{
	return [self valueForInputKey:key];
}
-(BOOL) setValue:(id)value forInputKey:(NSString *)key{
	return [self.qcRenderer setValue:value forInputKey:key];
}
-(id) valueForOutputKey:(NSString *)key{
	return [self.qcRenderer valueForOutputKey:key];
}
-(id) valueForOutputKey:(NSString *)key ofType:(NSString *)type{
	return [self.qcRenderer valueForOutputKey:key ofType:type];
}
-(NSArray *) outputKeys{
	return [self.qcRenderer outputKeys];
}
-(NSArray *) inputKeys{
	return [self.qcRenderer inputKeys];
}
-(NSDictionary *) attributes{
	return [self.qcRenderer attributes];
}


-(void) dealloc{
	[[NSNotificationCenter defaultCenter] removeObserver:self 
													name:NSViewGlobalFrameDidChangeNotification
												  object:self];
	[self.context clearDrawable];
	[format release];
	[super dealloc];
}


-(BOOL) fullscreen{
	return NO;
}


@synthesize qcRenderer,format,context,compositionFilePath,isRendering;
@end
