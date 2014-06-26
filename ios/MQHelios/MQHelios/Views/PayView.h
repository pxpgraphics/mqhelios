//
//  PayView.h
//  MQHelios
//
//  Created by Paris Pinkney on 6/24/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LOGGED_IN_TAG 600
#define LOGGED_OUT_TAG 601

@interface PayView : UIView

@property (nonatomic, readwrite) CGFloat padding;
@property (nonatomic, readwrite) CGFloat buttonHeight;

@property (nonatomic, readonly, strong) UIButton *signInButton;
@property (nonatomic, readonly, strong) UIButton *signUpButton;
@property (nonatomic, readonly, strong) UIImageView *imageView;
@property (nonatomic, readonly, strong) UILabel *bodyLabel;
@property (nonatomic, readonly, strong) UILabel *headlineLabel;

@property (nonatomic, readonly, strong) UIButton *payButton;
@property (nonatomic, readonly, strong) UIButton *reloadButton;
@property (nonatomic, readonly, strong) UIButton *manageButton;

@end
