//
//  CunddStreamServicesTableViewDataSource.m
//  CunddStream_iMonitor
//
//  Created by Daniel Corn on 08.06.10.
//  Copyright 2010 cundd. All rights reserved.
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
