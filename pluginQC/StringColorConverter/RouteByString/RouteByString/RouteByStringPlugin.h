//
//  RouteByStringPlugin.h
//  RouteByString
//
//  Created by Daniel Corn on 22.04.11.
//  Copyright 2011 cundd. All rights reserved.
//

#import <Quartz/Quartz.h>

@interface RouteByStringPlugIn : QCPlugIn {
@private
    
}

@property(assign) id<QCPlugInInputImageSource> inputImage1;
@property(assign) id<QCPlugInInputImageSource> inputImage2;
@property(assign) id<QCPlugInInputImageSource> inputImage3;


@property(assign) id<QCPlugInOutputImageProvider> outputImage;

@end
