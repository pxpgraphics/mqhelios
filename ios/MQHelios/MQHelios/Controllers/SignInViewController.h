//
//  SignInViewController.h
//  MQHelios
//
//  Created by Paris Pinkney on 6/25/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController

@property (nonatomic, weak, readwrite) IBOutlet UIButton *cancelButton;
@property (nonatomic, weak, readwrite) IBOutlet UIButton *signInButton;
@property (nonatomic, weak, readwrite) IBOutlet UILabel *forgotPasswordLabel;
@property (nonatomic, weak, readwrite) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak, readwrite) IBOutlet UITextField *passwordTextField;

@end
