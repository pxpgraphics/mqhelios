//
//  PayViewController.h
//  MQHelios
//
//  Created by Paris Pinkney on 6/27/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton *doneButton;
@property (nonatomic, weak) IBOutlet UIImageView *cardView;
@property (nonatomic, weak) IBOutlet UIVisualEffectView *blurView;

@end
