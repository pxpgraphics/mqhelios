//
//  DimissSegue.m
//  MQHelios
//
//  Created by Paris Pinkney on 6/25/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import "DimissSegue.h"

@implementation DimissSegue

- (void)perform
{
	UIViewController *sourceViewController = self.sourceViewController;
	[sourceViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
