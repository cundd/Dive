//
//  CunddStream_MonitorAppDelegate.m
//  CunddStream_Monitor
//
//  Created by Daniel Corn on 02.06.10.
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

#import "CunddStream_MonitorAppDelegate.h"

@implementation CunddStream_MonitorAppDelegate

@synthesize window,textView,client,services,browserTable;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	self.client = [[CunddStreamClient alloc] init];
	self.client.browserTable = self.browserTable;
	
	[self.textView bind:@"string" toObject:self.client withKeyPath:@"outputString" options:nil];
	[self.client addObserver:self forKeyPath:@"services" options:NSKeyValueObservingOptionNew context:nil];
	
	self.services = [NSArray array];
	
	[self.client browse:nil];
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
	if(object == self.client){
		self.services = self.client.services;
		[self.browserTable reloadData];
	}
}

-(BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender{
	return YES;
}

-(void)startStream:(id)sender{
	[self.client startStream:sender];
}

- (void)browse:(id)sender{
	[self.client browse:sender];
}


#pragma mark NSTableViewDataSource methods
-(NSInteger) numberOfRowsInTableView:(NSTableView *)tableView{
	NSLog(@"numberOfRowsInTableView=%i",[self.client.services count]);
	return [self.client.services count];
}
-(id) tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
	NSString * identifier = [tableColumn identifier];
	if([identifier isEqualToString:@"index"]){
		return [NSString stringWithFormat:@"#%i",row+1];
	} else {
		return [[self.client.services objectAtIndex:row] valueForKey:identifier];
	}
}
@end
