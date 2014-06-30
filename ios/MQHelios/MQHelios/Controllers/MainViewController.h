//
//  MainViewController.h
//  MQHelios
//
//  Created by Paris Pinkney on 6/24/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignInViewController.h"
#import "CardViewController.h"
#import "DealViewController.h"
#import "GiftView.h"
#import "PayView.h"
#import "StoresView.h"

@interface MainViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton * giftButton;
@property (nonatomic, weak) IBOutlet UIButton * notificationsButton;
@property (nonatomic, weak) IBOutlet UIButton * payButton;
@property (nonatomic, weak) IBOutlet UIButton * settingsButton;
@property (nonatomic, weak) IBOutlet UIButton * signInButton;
@property (nonatomic, weak) IBOutlet UIButton * signUpButton;
@property (nonatomic, weak) IBOutlet UIButton * storesButton;
@property (nonatomic, weak) IBOutlet UILabel * aboutLabel;
@property (nonatomic, weak) IBOutlet UILabel * notificationLabel;
@property (nonatomic, weak) IBOutlet UILabel * welcomeLabel;
@property (nonatomic, weak) IBOutlet UIView * profileView;

@property (nonatomic, weak) IBOutlet UILabel * nameLabel;
@property (nonatomic, weak) IBOutlet UIImageView * profileImage;

@property (nonatomic, weak) DealViewController *dealVC;
@property (nonatomic, weak) CardViewController *cardVC;
@property (nonatomic, weak) SignInViewController * signInVC;
@property (nonatomic, weak) UINavigationController *dealNavController;
@property (nonatomic, weak) UINavigationController *cardNavController;
@property (nonatomic, weak) UINavigationController *signUpNavController;
@property (nonatomic, weak) UINavigationController *payNavController;
@property (nonatomic, strong, readonly) GiftView * giftView;
@property (nonatomic, strong, readonly) PayView * payView;
@property (nonatomic, strong, readonly) StoresView * storesView;

@end
