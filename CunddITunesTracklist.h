//
//  CunddITunesTracklist.h
//  Menu
//
//  Created by Daniel Corn on 12.04.10.
//
//    Copyright © 2010-2012 Corn Daniel
//
//    This file is part of Dive.
//
//    Dive is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    Foobar is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
//
//

#import <Cocoa/Cocoa.h>
#import "CunddITunesTrack.h"
#import <AppKit/NSTableView.h>

/*!
 @class CunddITunesTracklist
 @discussion The class functions as data-object for a bound array-controller to fill a tableview.
 */
@interface CunddITunesTracklist : NSObject <NSTableViewDataSource, NSTableViewDelegate>
{
	NSArray * tracklist;
	IBOutlet NSTableView * tableView;
}

/*!
    @method     
    @discussion Sets the tracklist-property to the given array.
*/
-(void) setTracklistWithArray : (NSArray *) array;

-(BOOL)ifDebug;

@property(retain) NSArray * tracklist;
@property(retain) NSTableView * tableView;

@end
