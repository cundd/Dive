//
//  CunddAppEventHandler.m
//  Dive
//
//  Created by Daniel Corn on 06.05.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import "CunddAppEventHandler.h"


@implementation CunddAppEventHandler
+(CunddAppEventHandler *)defaultHandler{
    static CunddAppEventHandler *defaultHandlerInstance = NULL;
	
    @synchronized(self) {
        if (defaultHandlerInstance == NULL)
            defaultHandlerInstance = [[self alloc] init];
    }
    return (defaultHandlerInstance);
}


+(NSEvent *) handleEvent:(NSEvent *)aEvent{
	if(aEvent.type == NSKeyDown){
		return [CunddAppKeyHandler handleEvent:aEvent];
	}
	NSLog(@"%@",aEvent);
	return aEvent;
}
@end
