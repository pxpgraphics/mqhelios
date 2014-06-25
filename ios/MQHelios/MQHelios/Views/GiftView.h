//
//  GiftView.h
//  MQHelios
//
//  Created by Paris Pinkney on 6/24/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiftView : UIView

@property (nonatomic, readonly, strong) UIButton *signInButton;
@property (nonatomic, readonly, strong) UIButton *signUpButton;
@property (nonatomic, readonly, strong) UIImageView *imageView;
@property (nonatomic, readonly, strong) UILabel *bodyLabel;
@property (nonatomic, readonly, strong) UILabel *headlineLabel;

@end
