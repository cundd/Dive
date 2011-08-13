//
//  RouteByTypePlugin.h
//  RouteByType
//
//  Created by Daniel Corn on 23.04.11.
//  Copyright 2011 cundd. All rights reserved.
//

#import <Quartz/Quartz.h>

typedef enum {
	CunddRouteByTypeTypeIndexError = -1,
	CunddRouteByTypeTypeIndexImage = 1,
	CunddRouteByTypeTypeIndexVideo = 2,
	CunddRouteByTypeTypeIndexCaptureDevice = 3,
	
} CunddRouteByTypeTypeIndex;

@interface RouteByTypePlugIn : QCPlugIn {
	NSArray * imageTypeIdentifiers;
	NSString * _outputLocationCache;
	NSString * _outputDescriptionCache;
	NSUInteger _outputIndexCache;
	NSUInteger _scheduledIndex;
@private
    
}

@property(assign) NSString * inputLocation;
@property(assign) NSString * outputLocation;
@property(assign) NSString * outputVideoLocation;
@property(assign) NSString * outputImageLocation;
@property(assign) NSString * outputCaptureDeviceLocation;
@property(assign) NSString * outputTypeDescription;
@property(assign) NSUInteger outputUseIndex;
//@property(assign) NSNumber * outputUseIndex;
@property(assign) BOOL outputLoop;

/**
 * Returns the type identifiers that will be recognized as images.
 */
@property(readonly) NSArray * imageTypeIdentifiers;


/**
 * Set the output locations according to the current output index.
 */
-(void)setOutputLocations;

@end
