//
//  PayView.m
//  MQHelios
//
//  Created by Paris Pinkney on 6/24/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import "PayView.h"

@interface PayView ()

@property (nonatomic, readwrite, strong) UIButton *signInButton;
@property (nonatomic, readwrite, strong) UIButton *signUpButton;
@property (nonatomic, readwrite, strong) UIImageView *imageView;
@property (nonatomic, readwrite, strong) UILabel *bodyLabel;
@property (nonatomic, readwrite, strong) UILabel *headlineLabel;

@property (nonatomic, readwrite, strong) UIButton *payButton;
@property (nonatomic, readwrite, strong) UIButton *reloadButton;
@property (nonatomic, readwrite, strong) UIButton *manageButton;

@end

@implementation PayView
{
	UIView *backgroundView;
}

- (instancetype)init
{
	if (self = [super init]) {
		_padding = 5.0f;
		_buttonHeight = 50.0f;

		[UserManager sharedManager].user = [MQPUser new];

		if ([UserManager sharedManager].user) {
			[self addViewsForLoggedInUser];
		} else {
			[self addViewsForLoggedOutUser];
		}
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)addViewsForLoggedInUser
{
	_imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Card"]];
	_imageView.contentMode = UIViewContentModeScaleAspectFill;
	_imageView.tag = LOGGED_IN_TAG;
	[self addSubview:_imageView];

	_payButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_payButton setTitle:@"PAY" forState:UIControlStateNormal];
	[_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_payButton setBackgroundColor:[UIColor purpleColor]];
	_payButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
	_payButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
	_payButton.layer.cornerRadius = 8.0f;
	_payButton.layer.masksToBounds = YES;
	_payButton.tag = LOGGED_IN_TAG;
	[self addSubview:_payButton];

	_reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_reloadButton setTitle:@"RELOAD" forState:UIControlStateNormal];
	[_reloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_reloadButton setBackgroundColor:[UIColor purpleColor]];
	_reloadButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
	_reloadButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
	_reloadButton.layer.cornerRadius = 8.0f;
	_reloadButton.layer.masksToBounds = YES;
	_reloadButton.tag = LOGGED_IN_TAG;
	[self addSubview:_reloadButton];

	_manageButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_manageButton setTitle:@"RELOAD" forState:UIControlStateNormal];
	[_manageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_manageButton setBackgroundColor:[UIColor purpleColor]];
	_manageButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
	_manageButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
	_manageButton.layer.cornerRadius = 8.0f;
	_manageButton.layer.masksToBounds = YES;
	_manageButton.tag = LOGGED_IN_TAG;
	[self addSubview:_manageButton];
}

- (void)addViewsForLoggedOutUser
{
	_imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pay"]];
	_imageView.contentMode = UIViewContentModeScaleAspectFill;
	_imageView.tag = LOGGED_OUT_TAG;
	[self addSubview:_imageView];

	backgroundView = [[UIView alloc] init];
	backgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
	backgroundView.tag = LOGGED_OUT_TAG;
	[self addSubview:backgroundView];

	_headlineLabel = [[UILabel alloc] init];
	_headlineLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:22.0];
	_headlineLabel.text = @"Pay With Your Phone";
	_headlineLabel.textColor = [UIColor colorWithRed:0.904 green:0.798 blue:0.495 alpha:1.000];
	_headlineLabel.tag = LOGGED_OUT_TAG;
	[self addSubview:_headlineLabel];

	_bodyLabel = [[UILabel alloc] init];
	_bodyLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:14.0];
	_bodyLabel.numberOfLines = 0;
	_bodyLabel.text = @"Check your balances and transactions, reload your Marqeta Card, take more offers, and get reward dollars.";
	_bodyLabel.textColor = [UIColor whiteColor];
	_bodyLabel.tag = LOGGED_OUT_TAG;
	[self addSubview:_bodyLabel];

	_signUpButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[_signUpButton setTitle:@"SIGN UP" forState:UIControlStateNormal];
	[_signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_signUpButton setBackgroundColor:[UIColor colorWithRed:0.904 green:0.798 blue:0.495 alpha:1.000]];
	_signUpButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
	_signUpButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
	_signUpButton.layer.cornerRadius = 8.0f;
	_signUpButton.layer.masksToBounds = YES;
	_signUpButton.tag = LOGGED_OUT_TAG;
	[self addSubview:_signUpButton];

	_signInButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[_signInButton setTitle:@"SIGN IN" forState:UIControlStateNormal];
	[_signInButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
	[_signInButton setBackgroundColor:[UIColor whiteColor]];
	_signInButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:22.0];
	_signInButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
	_signInButton.layer.cornerRadius = 8.0f;
	_signInButton.layer.masksToBounds = YES;
	_signInButton.tag = LOGGED_OUT_TAG;
	[self addSubview:_signInButton];
}

- (void)layoutSubviewsForLoggedInUser:(CGRect)bounds
{
	CGFloat xOrigin = bounds.origin.x;
	CGFloat yOrigin = bounds.origin.y;

	_payButton.frame = CGRectMake(xOrigin, yOrigin, bounds.size.width, _buttonHeight);

	yOrigin += _buttonHeight + (_padding * 2.0f);

	_reloadButton.frame = CGRectMake(xOrigin, yOrigin, bounds.size.width, _buttonHeight);

	yOrigin += _buttonHeight + (_padding * 2.0f);

	_manageButton.frame = CGRectMake(xOrigin, yOrigin, bounds.size.width, _buttonHeight);
}

- (void)layoutSubviewsForLoggedOutUser:(CGRect)bounds
{
	_imageView.frame = self.layer.mask.bounds;
	backgroundView.frame = self.layer.mask.bounds;

	CGFloat xOrigin = bounds.origin.x;
	CGFloat yOrigin = bounds.origin.y;

	CGFloat headlineLabelHeight = [_headlineLabel.text sizeWithAttributes:@{ NSFontAttributeName: _headlineLabel.font }].height;
	_headlineLabel.frame = CGRectMake(xOrigin, yOrigin, bounds.size.width, headlineLabelHeight);

	yOrigin += _headlineLabel.frame.size.height + (_padding * 2.0);

	CGFloat bodyLabelHeight = [_bodyLabel.text sizeWithAttributes:@{ NSFontAttributeName: _bodyLabel.font }].height * 4.0f;
	_bodyLabel.frame = CGRectMake(xOrigin, yOrigin, bounds.size.width, bodyLabelHeight);

	yOrigin = bounds.origin.y + bounds.size.height - (_buttonHeight * 2.0f) - (_padding * 2.0f);

	_signUpButton.frame = CGRectMake(xOrigin, yOrigin, bounds.size.width, _buttonHeight);

	yOrigin += _buttonHeight + (_padding * 2.0f);

	_signInButton.frame = CGRectMake(xOrigin, yOrigin, bounds.size.width, _buttonHeight);
}

- (void)layoutSubviews
{
	[super layoutSubviews];

	CGRect insetBounds = CGRectInset(self.bounds, (_padding * 4.0), (_padding * 8.0));

	if ([UserManager sharedManager].user) {
		[self layoutSubviewsForLoggedInUser:insetBounds];
		for (UIView *subview in self.subviews) {
			if (subview.tag == LOGGED_OUT_TAG) {
				subview.hidden = YES;
			}
		}
	} else {
		[self layoutSubviewsForLoggedOutUser:insetBounds];
		for (UIView *subview in self.subviews) {
			if (subview.tag == LOGGED_IN_TAG) {
				subview.hidden = YES;
			}
		}
	}
}

@end
