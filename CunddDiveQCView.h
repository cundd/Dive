//
//  CunddDiveQCView.h
//  Dive
//
//  Created by Daniel Corn on 17.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Cundd.h"
#import <Quartz/Quartz.h>
#import <OpenGL/OpenGL.h>
#import <OpenGL/gl.h>
#import <CunddCore/CunddApp.h>
//#import <ConditionalMacros.h>
//#import "CunddDiveMasterQCPatchController.h"


@interface CunddDiveQCView : CunddView <QCCompositionRenderer>{
	QCRenderer * qcRenderer;
	NSOpenGLPixelFormat * format;
	NSOpenGLContext * context;
	NSString * compositionFilePath;
	
	NSTimer * _renderTimer;
	NSTimeInterval _startTime;
	NSEvent * _event;
	
	BOOL isRendering;
}

/*!
    @method     
    @abstract   Returns a new instance with the given path to the composition
    @discussion Returns a new instance with the given path to the composition
*/
+(id)qcViewWithView:(NSView *)aView andFilePath:(NSString *)thePath;
/*!
    @method     
    @abstract   Returns a new instance with the given path to the composition
    @discussion Returns a new instance with the given path to the composition
*/
-(id)initWithView:(NSView *)aView andFilePath:(NSString *)thePath;


/*!
    @method     
    @abstract   Invoked by the timer to render the composition
    @discussion Invoked by the timer to render the composition
*/
-(void)_render:(NSTimer *)timer;

/*!
    @method     
    @abstract   Renders the current frame
    @discussion Renders the current frame with optional event-data
*/
-(void) renderWithEvent:(NSEvent *)event;

/*!
 @method     
 @abstract   Renders the current frame
 @discussion Renders the current frame with optional event-data and on a different thread
 */
-(void) _renderAsBlock;

/*!
    @method     
    @abstract   Starts the rendering loop
    @discussion Starts the timer for the rendering loop
*/
-(BOOL)startRendering;

/*!
    @method     
    @abstract   Starts the timer
    @discussion Starts the timer
*/
-(BOOL)startTimer;


/*!
    @method     
    @abstract   Updates the OpenGL view
    @discussion Updates the OpenGL view
*/
-(void)surfaceDidResize:(NSNotification *)notif;
/*!
    @method     
    @abstract   Updates the OpenGL view
    @discussion Updates the OpenGL view
*/
-(void)surfaceDidMove:(NSNotification *)notif;


/*!
    @method     
    @abstract   Returns if the view should draw fullscreen
    @discussion Returns if the view should draw fullscreen
*/
-(BOOL)fullscreen;


/*!
    @method     
    @abstract   Pauses the playback
    @discussion Pauses the playback
*/
-(IBAction)pause:(id)sender;

/*!
    @method     
    @abstract   Starts the playback
    @discussion Starts the playback
*/
-(IBAction)play:(id)sender;


/*!
    @method     
    @abstract   Starts/pauses the playback
    @discussion Starts/pauses the playback
*/
-(IBAction)togglePlayback:(id)sender;


/*!
    @method     
    @abstract   Restarts the renderer and timer
    @discussion Restarts the renderer and timer
*/
-(IBAction)restart:(id)sender;


/*!
    @method     
    @abstract   Stops the renderer and timer
    @discussion Stops the renderer and timer
*/
-(IBAction)stop:(id)sender;

@property (retain) QCRenderer * qcRenderer;
@property (retain) NSOpenGLPixelFormat * format;
@property (retain) NSOpenGLContext * context;
@property (retain) NSString * compositionFilePath;


@property (readonly) NSArray * outputKeys;
@property (readonly) NSArray * inputKeys;
@property (readonly) NSDictionary * attributes;

@property (readonly) BOOL isRendering;

@end
