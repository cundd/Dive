//
//  CunddRouteByTypePlugin.h
//  CunddRouteByType
//
//  Created by Daniel Corn on 08.05.11.
//  Copyright 2011 cundd. All rights reserved.
//

#import <Quartz/Quartz.h>


typedef enum {
	CunddRouteByTypeTypeIndexError = -1,
	CunddRouteByTypeTypeIndexImage = 1,
	CunddRouteByTypeTypeIndexVideo = 2,
	CunddRouteByTypeTypeIndexCaptureDevice = 3,
	CunddRouteByTypeTypeIndexQuartzComposition = 4,
} CunddRouteByTypeTypeIndex;


@interface CunddRouteByTypePlugIn : QCPlugIn {
@private
    NSArray * imageTypeIdentifiers;
	NSArray * quartzTypeIdentifiers;
}

@property (assign) NSString *	inputLocation;
@property (assign) BOOL			inputLoop;

@property (assign) NSUInteger	outputIndex;
@property (assign) NSString *	outputLocation;
@property (assign) NSString *	outputDescription;
@property (assign) BOOL			outputLoop;


/**
 * Returns the type identifiers that will be recognized as images.
 */
@property(readonly) NSArray * imageTypeIdentifiers;

/**
 * Returns the type identifiers that will be recognized as quartz compositions.
 */
@property(readonly) NSArray * quartzTypeIdentifiers;
@end
