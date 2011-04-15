//
//  CunddSingleton.h
//  Dive
//
//  Created by Daniel Corn on 21.06.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CunddCore/CunddObject.h>


@interface CunddSingleton : CunddObject {

}
/*!
 @method     
 @abstract   Returns the shared instance.
 @discussion Returns the shared instance.
 */
+(id)sharedInstance;
@end
