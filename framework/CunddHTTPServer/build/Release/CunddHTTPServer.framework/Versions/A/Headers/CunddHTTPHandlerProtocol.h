//
//  CunddHTTPHandlerProtocol.h
//  Dive
//
//  Created by Daniel Corn on 31.08.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddHTTPConstants.h"


@protocol CunddHTTPHandlerProtocol


/*!
    @method     
    @abstract   Invoked when data for a request should be processed.
    @discussion Invoked when data for a request should be processed.
*/
-(NSDictionary *)processDataForURL:(NSURL *)url message:(CFHTTPMessageRef)message;
@end
