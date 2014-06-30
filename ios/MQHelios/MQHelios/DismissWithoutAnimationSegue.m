//
//  DismissWithoutAnimationSegue.m
//  MQHelios
//
//  Created by Paris Pinkney on 6/27/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import "DismissWithoutAnimationSegue.h"

@implementation DismissWithoutAnimationSegue

- (void)perform
{
	UIViewController *sourceViewController = self.sourceViewController;
	[sourceViewController.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}

@end
