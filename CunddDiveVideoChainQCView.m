//
//  CunddDiveVideoChainQCView.m
//  Dive
//
//  Created by Daniel Corn on 17.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddDiveVideoChainQCView.h"
@class CunddDiveMasterQCPatchController;
@class QCImage;

@implementation CunddDiveVideoChainQCView
static int instanceCounter = 0;

+(CunddDiveVideoChainQCView *) qcViewWithView:(NSView *)aView andFilePath:(NSString *)thePath{
	return [[[self alloc] initWithView:aView andFilePath:thePath] autorelease];
}

-(id) initWithFrame:(NSRect)frameRect{
	self.index = instanceCounter++;
	return [super initWithFrame:frameRect];
}
-(void) renderWithEvent:(NSEvent *)event{
	[super renderWithEvent:event];
	 
	NSString * type;
	type = @"QCImage";
	//type = @"NSImage";
	[type retain];
	
	id image = [self.qcRenderer valueForOutputKey:@"output" ofType:type];
	id imageCopy = image;
	if(!image) return;
	
	/*
	NSLog(@"image=%@",image);
	unsigned int outCount = 0;
	Method * metList = class_copyMethodList(object_getClass(image), &outCount);
	if(outCount){
		for(int i = 0; i < outCount; i++){
			NSLog(@"%s",method_getName(metList[i]));
		}
	}
	/* */
	
	
	NSString * inputKey = [NSString stringWithFormat:@"vc%iImage",self.index];
	NSDictionary * controllers = [CunddAppRegistry collectionRegistry:@"CunddDiveMasterQCPatchController"];
	
	
	for(NSString * key in [controllers allKeys]){
		/*
		if([type isEqualToString:@"QCImage"]){
			// Create a copy of the image
			imageCopy = [image createCroppedImageWithRect:[image bounds]];
		} else if([type isEqualToString:@"NSImage"]){
			imageCopy = [image copy];
		}
		/* */
		
		
		CunddDiveMasterQCPatchController * maQcPatchController = [controllers valueForKey:key];
		//CunddDiveMasterQCPatchController * maQcPatchController = [CunddAppRegistry registry:@"CunddDiveMasterQCPatchController"];
		if(![maQcPatchController view]){
			NSLog(@"No view");
		}
		[(<QCCompositionRenderer>)[maQcPatchController view] setValue:imageCopy forInputKey:inputKey];
		[(CIImage *)imageCopy release];
	}
	
}

-(void) surfaceDidResize:(NSNotification *)notif{
	if([self.context view] == self){
		NSRect lBounds = [[self superview] bounds];
		NSRect lFrame = [[self superview] frame];
		
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


@synthesize index;
@end
