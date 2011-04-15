//
//  NSControl+CunddAppMapCreator.h
//  Dive
//
//  Created by Daniel Corn on 21.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CunddCore/CunddAppAbstractMapCreator.h>
#import <CunddCore/CunddAppRegistry.h>
#import <CunddCore/CunddUIButtonAppMapCreatorRecord.h>
#import </usr/include/objc/runtime.h>


@interface NSControl (CunddAppMapCreator)

+(void)swapMouseDownMethod;
-(void) recordingMouseDown:(NSEvent *)theEvent;
@end
