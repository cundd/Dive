//
//  CunddDiveDragAndDropController.h
//  Menu
//
//  Created by Daniel Corn on 16.04.10.
//  Copyright 2010 cundd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CunddITunes.h"

//extern NSString * const kCunddDraggingType;

@interface CunddDiveDraggingSourceController : NSArrayController {
	IBOutlet CunddITunesTracklist * tracklist;
	BOOL useSpecialDragType;
}

@property (retain) CunddITunesTracklist * tracklist;
//@property (retain) BOOL useSpecialDragType;
@end
