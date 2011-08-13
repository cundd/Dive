//
//  FakeConsumerPlugIn.m
//  FakeConsumer
//
//  Created by Daniel Corn on 26.04.11.
//  Copyright 2011 cundd. All rights reserved.
//

/* It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering */
#import <OpenGL/CGLMacro.h>

#import "FakeConsumerPlugIn.h"

#define	kQCPlugIn_Name				@"FakeConsumer"
#define	kQCPlugIn_Description		@"FakeConsumer pulls data from the input patches but doesn't process anything. This allows you for example to update a 'Movie Importer' even if it's output isn't used."

@implementation FakeConsumerPlugIn

@dynamic inputImage1,inputImage2,inputImage3;

+ (NSDictionary *)attributes
{
	/*
	Return a dictionary of attributes describing the plug-in (QCPlugInAttributeNameKey, QCPlugInAttributeDescriptionKey...).
	*/
	
	return [NSDictionary dictionaryWithObjectsAndKeys:kQCPlugIn_Name, QCPlugInAttributeNameKey, kQCPlugIn_Description, QCPlugInAttributeDescriptionKey, nil];
}

+ (NSDictionary *)attributesForPropertyPortWithKey:(NSString *)key
{
	/*
	Specify the optional attributes for property based ports (QCPortAttributeNameKey, QCPortAttributeDefaultValueKey...).
	*/
	
	return nil;
}

+ (QCPlugInExecutionMode)executionMode
{
	/*
	Return the execution mode of the plug-in: kQCPlugInExecutionModeProvider, kQCPlugInExecutionModeProcessor, or kQCPlugInExecutionModeConsumer.
	*/
	return kQCPlugInExecutionModeProcessor;
	return kQCPlugInExecutionModeConsumer;
}

+ (QCPlugInTimeMode)timeMode
{
	/*
	Return the time dependency mode of the plug-in: kQCPlugInTimeModeNone, kQCPlugInTimeModeIdle or kQCPlugInTimeModeTimeBase.
	*/
	
	return kQCPlugInTimeModeNone;
}

- (id)init
{
	self = [super init];
	if (self) {
		/*
		Allocate any permanent resource required by the plug-in.
		*/
	}
	
	return self;
}

- (void)finalize
{
	/*
	Release any non garbage collected resources created in -init.
	*/
	
	[super finalize];
}

- (void)dealloc
{
	/*
	Release any resources created in -init.
	*/
	
	[super dealloc];
}


@end

@implementation FakeConsumerPlugIn (Execution)

- (BOOL)startExecution:(id <QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when rendering of the composition starts: perform any required setup for the plug-in.
	Return NO in case of fatal failure (this will prevent rendering of the composition to start).
	*/
	
	return YES;
}

- (void)enableExecution:(id <QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when the plug-in instance starts being used by Quartz Composer.
	*/
}

- (BOOL)execute:(id <QCPlugInContext>)context atTime:(NSTimeInterval)time withArguments:(NSDictionary *)arguments
{
	// Define a context and set it. This line causes OpenGL to use macros.
	CGLContextObj	 cgl_ctx = [context CGLContextObj];
	
	
	if(cgl_ctx == NULL)
		return NO;
	
	glClearColor(0.4, 0.4, 1, 0.1);
	//glClearColor(0.0, 0.0, 0.0, 0.0);
	glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
	
	
	return YES;
	
	
	
	
	
	
//	id<QCPlugInInputImageSource>	image;
	GLuint			textureName;
	GLint			 saveMode;
	const CGFloat*	colorComponents;
	GLenum	  error;
	
	if(cgl_ctx == NULL)
		return NO;
/*	
	// Get a texture from the image in the context color space
	if(image && [image lockTextureRepresentationWithColorSpace:([image shouldColorMatch] ? [context colorSpace] :
																[image imageColorSpace])
													 forBounds:[image imageBounds]])
		textureName = [image textureName];
	else
		textureName = 0;
	
	// Save and set the modelview matrix.
	glGetIntegerv(GL_MATRIX_MODE, &saveMode);
	glMatrixMode(GL_MODELVIEW);
	glPushMatrix();
	// Translate the matrix
//	glTranslatef(self.inputX, self.inputY, self.inputZ);
	// Rotate the matrix
//	glRotatef(self.inputAngle, 0.0, 1.0, 0.0);
	
	// Bind the texture to a texture unit
	if(textureName) {
		[image bindTextureRepresentationToCGLContext:cgl_ctx
										 textureUnit:GL_TEXTURE0
								normalizeCoordinates:YES];
	}*/
	// Get the color components (RGBA) from the input color port.
//	colorComponents = CGColorGetComponents(self.inputColor);
	// Set the color.
	glColor4f(colorComponents[0], colorComponents[1], colorComponents[2], colorComponents[3]);
	
	// Render the textured quad by mapping the texture coordinates to the vertices
	glBegin(GL_QUADS);
	glTexCoord2f(1.0, 1.0);
	glVertex3f(0.5, 0.5, 0); // upper right
	glTexCoord2f(0.0, 1.0);
	glVertex3f(-0.5, 0.5, 0); // upper left
	glTexCoord2f(0.0, 0.0);
	glVertex3f(-0.5, -0.5, 0); // lower left
	glTexCoord2f(1.0, 0.0);
	glVertex3f(0.5, -0.5, 0); // lower right
	glEnd();
	
	// Unbind the texture from the texture unit.
//	if(textureName)
//		[image unbindTextureRepresentationFromCGLContext:cgl_ctx
//											 textureUnit: GL_TEXTURE0];
	
	// Restore the modelview matrix.
	glMatrixMode(GL_MODELVIEW);
	glPopMatrix();
	glMatrixMode(saveMode);
	
	// Check for OpenGL errors and log them if there are errors.
	if(error = glGetError())
		[context logMessage:@"OpenGL error %04X", error];
	
	// Release the texture.
//	if(textureName)
//		[image unlockTextureRepresentation];
	
	return (error ? NO : YES);
}

- (void)disableExecution:(id <QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when the plug-in instance stops being used by Quartz Composer.
	*/
}

- (void)stopExecution:(id <QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when rendering of the composition stops: perform any required cleanup for the plug-in.
	*/
}

@end
