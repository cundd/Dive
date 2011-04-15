//
//  MocModeProcessorPlugIn.h
//  MocModeProcessor
//
//  Created by Daniel Corn on 21.05.10.
//  Copyright (c) 2010 cundd. All rights reserved.
//

#import <Quartz/Quartz.h>

typedef enum{
	CunddDiveMocModeNone	= 0,
	CunddDiveMocModeFront	= 1,
	CunddDiveMocModeLeft	= 2,
	CunddDiveMocModeRight	= 3,
	CunddDiveMocModeTop		= 4,
	CunddDiveMocModeBottom	= 5
} CunddDiveMocMode;

typedef enum{
	CunddDiveScreenNone		= 0,
	CunddDiveScreenFront	= 1,
	CunddDiveScreenBack		= 2,
	CunddDiveScreenLeft		= 3,
	CunddDiveScreenRight	= 4,
	CunddDiveScreenTop		= 5,
	CunddDiveScreenBottom	= 6
} CunddDiveScreen;

typedef enum{
	CunddDiveEdgeModeFold = 1,
	CunddDiveEdgeModeClip = 2,
	CunddDiveEdgeModeWarp = 4
} CunddDiveEdgeMode;


@interface MocModeProcessorPlugIn : QCPlugIn
{
}

/*!
 @method     
 @abstract   Returns the moc mode through checking the relationship between different screens
 @discussion Returns the moc mode through checking the relationship between different screens
 */
-(CunddDiveMocMode)getRelationship;

@property (assign) /* CunddDiveScreen */ NSUInteger inputEnvironment;
@property (assign) /* CunddDiveScreen */ NSUInteger inputScreen;
@property (assign) /* CunddDiveEdgeMode */ NSUInteger inputEdgeMode;

@property (assign) /* CunddDiveMocModes */ NSUInteger outputMocMode;
@end
