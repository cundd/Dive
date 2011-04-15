//
//  CunddAppEventHandler.h
//  Dive
//
//  Created by Daniel Corn on 06.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Cundd.h"
#import "CunddAppKeyHandler.h"


@interface CunddAppEventHandler : CunddObject {

}

/*!
    @method     
    @abstract   Returns the default handler-instance
    @discussion Returns the default handler-instance
*/
+(CunddAppEventHandler *)defaultHandler;
/*!
    @method     
    @abstract   Routes the event to the appropriate handler
    @discussion Routes the event to the appropriate handler
*/
+(NSEvent *)handleEvent:(NSEvent *)aEvent;
@end
