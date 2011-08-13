//
//  FakeConsumerPlugin.h
//  FakeConsumer
//
//  Created by Daniel Corn on 26.04.11.
//  Copyright 2011 cundd. All rights reserved.
//

#import <Quartz/Quartz.h>

@interface FakeConsumerPlugIn : QCPlugIn {
@private
    
}

/*
Declare here the properties to be used as input and output ports for the plug-in e.g.
@property double inputFoo;
@property(assign) NSString* outputBar;
You can access their values in the appropriate plug-in methods using self.inputFoo or self.inputBar
*/
@property (assign) id<QCPlugInInputImageSource> inputImage1;
@property (assign) id<QCPlugInInputImageSource> inputImage2;
@property (assign) id<QCPlugInInputImageSource> inputImage3;

@end
