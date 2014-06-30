//
//  DealViewController.m
//  MQHelios
//
//  Created by Paris Pinkney on 6/30/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import "DealViewController.h"

@interface DealViewController ()

@property (nonatomic, strong, readwrite) NSMutableDictionary *dataSource;

@end

@implementation DealViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lazy loading
- (NSMutableDictionary *)dataSource
{
	if (!_dataSource) {
		_dataSource = [[NSMutableDictionary alloc] initWithCapacity:2];
	}
	return _dataSource;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	// Return the number of sections.
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	NSUInteger row = indexPath.row;
	NSUInteger section = indexPath.section;

	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSUInteger section = indexPath.section;
	if (section == 1) {
		return 142.0f;
	} else {
		return 44.0f;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSUInteger row = indexPath.row;

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.

}

@end
