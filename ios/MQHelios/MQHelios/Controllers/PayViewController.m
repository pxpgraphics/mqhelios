//
//  PayViewController.m
//  MQHelios
//
//  Created by Paris Pinkney on 6/27/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import "PayViewController.h"

@interface PayViewController ()

@end

@implementation PayViewController

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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)dismissViewController:(id)sender
{
	[self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

@end