//
//  CunddStreamServicesTableViewDataSource.m
//  CunddStream_iMonitor
//
//  Created by Daniel Corn on 08.06.10.
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

#import "CunddStreamServicesTableViewDataSource.h"


@implementation CunddStreamServicesTableViewDataSource
-(void) awakeFromNib{
	self.client = [[CunddStreamClient alloc] init];
	self.client.browserTable = self.browserTable;
	
	//[self.textView bind:@"string" toObject:self.client withKeyPath:@"outputString" options:nil];
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

-(void)startStream:(id)sender{
	[self.client startStream:sender];
}

- (void)browse:(id)sender{
	[self.client browse:sender];
}

#pragma mark UITableViewDataSource methods
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
	NSLog(@"numberOfRowsInTableView=%i",[self.client.services count]);
	return [self.client.services count];
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSUInteger row = [indexPath indexAtPosition:0];
	UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"default"];
	return cell;
	// return [[self.client.services objectAtIndex:row] valueForKey:identifier];
}

@synthesize client,browserTable,services,textView,window;
@end
