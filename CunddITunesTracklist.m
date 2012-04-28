//
//  CunddITunesTracklist.m
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

#import "CunddITunesTracklist.h"


@implementation CunddITunesTracklist

// Reading the data
#pragma mark reading the data

-(void) awakeFromNib {
	if(self.ifDebug)NSLog(@"CunddITunesTracklistController awakeFromNib");
	NSDictionary * trackinfo = [NSDictionary dictionaryWithObject : @"empty" forKey : @"name"];
	NSDictionary * emptyTrack = [NSDictionary dictionaryWithObject : trackinfo forKey : @"trackinfo"];
	self.tracklist = [NSArray arrayWithObject : emptyTrack];
	
	// Load the user defaults
//	[self setTracklistWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:kCunddUserDefaultsKeyForTracklistArray]];
//	[defaultsController bind:kCunddUserDefaultsKeyForTracklistArray toObject:self withKeyPath:@"tracklist" options:nil];
	
	[self.tableView setDelegate:self];

    return;
}


/*-(void)setTracklist:(NSArray *)array{
	[tracklist release];
	tracklist = array;
	[array retain];
	return;	
}


/*
-(id) tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
        if(debug)NSLog(@"objectValueForTableColumn %@",[tableColumn identifier]);
        CunddITunesTrack * track = [self.tracklist objectAtIndex:row];
        [track valueForKey:[tableColumn identifier]];
        return [track valueForKey:[tableColumn identifier]];
}

-(NSInteger) numberOfRowsInTableView:(NSTableView *)tableView{
        return [self.tracklist count];
}
// */

-(void) setTracklistWithArray : (NSArray *) array {
    if(self.ifDebug)NSLog(@"setTracklistWithArray");
    [self setValue : array forKey : @"tracklist"];
    //self.tracklist = array;
    if(self.ifDebug)NSLog(@"self.tracklist %@", self.tracklist);
    return;
}

/*
- (void)tableView:(NSTableView *)tableView mouseDownInHeaderOfTableColumn:(NSTableColumn *)tableColumn{
        NSLog(@"show popup");
        if([[NSApp currentEvent] modifierFlags] & NSControlKeyMask){
                //control was pressed at the time the event was posted
                NSLog(@"hallo");
                [NSMenu popUpContextMenu:[self.tableView showContextMenu] withEvent:[NSApp currentEvent] forView:tableView];
        }
}

/*
-(id) valueForUndefinedKey:(NSString *)key{
        if(debug)NSLog(@"CunddITunesTracklistController valueForKey:%@",key);
        return [self.tracklist valueForKey:key];
}
// */
-(void) setValue : (id) value forKey : (NSString *) key {
    if(self.ifDebug)NSLog(@"CunddITunesTracklistController setValue forKey:%@", key);
    return [super setValue : value forKey : key];
}
// */

-(BOOL)ifDebug{
	if([[CunddConfig valueForKeyPath : @"Debug.CunddITunes.Tracklist"]boolValue] == 0){
		return NO;
	} else {
		return YES;
	}
}



@synthesize tracklist, tableView;
@end