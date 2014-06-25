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

		_imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pay"]];
		_imageView.contentMode = UIViewContentModeScaleAspectFill;
		[self addSubview:_imageView];

		backgroundView = [[UIView alloc] init];
		backgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
		[self addSubview:backgroundView];

		_headlineLabel = [[UILabel alloc] init];
		_headlineLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:22.0];
		_headlineLabel.text = @"Pay With Your Phone";
		_headlineLabel.textColor = [UIColor colorWithRed:0.904 green:0.798 blue:0.495 alpha:1.000];
		[self addSubview:_headlineLabel];

		_bodyLabel = [[UILabel alloc] init];
		_bodyLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:14.0];
		_bodyLabel.numberOfLines = 0;
		_bodyLabel.text = @"Check your balances and transactions, reload your Marqeta Card, take more offers, and get reward dollars.";
		_bodyLabel.textColor = [UIColor whiteColor];
		[self addSubview:_bodyLabel];

		_signUpButton = [UIButton buttonWithType:UIButtonTypeSystem];
		[_signUpButton setTitle:@"SIGN UP" forState:UIControlStateNormal];
		[_signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[_signUpButton setBackgroundColor:[UIColor colorWithRed:0.904 green:0.798 blue:0.495 alpha:1.000]];
		_signUpButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
		_signUpButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
		_signUpButton.layer.cornerRadius = 8.0f;
		_signUpButton.layer.masksToBounds = YES;
		[self addSubview:_signUpButton];

		_signInButton = [UIButton buttonWithType:UIButtonTypeSystem];
		[_signInButton setTitle:@"SIGN IN" forState:UIControlStateNormal];
		[_signInButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
		[_signInButton setBackgroundColor:[UIColor whiteColor]];
		_signInButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:22.0];
		_signInButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
		_signInButton.layer.cornerRadius = 8.0f;
		_signInButton.layer.masksToBounds = YES;
		[self addSubview:_signInButton];
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

- (void)layoutSubviews
{
	[super layoutSubviews];

	CGRect bounds = self.bounds;

	_imageView.frame = self.layer.mask.bounds;
	backgroundView.frame = self.layer.mask.bounds;

	CGRect insetBounds = CGRectInset(bounds, (_padding * 4.0), (_padding * 8.0));

	CGFloat xOrigin = insetBounds.origin.x;
	CGFloat yOrigin = insetBounds.origin.y;

	CGFloat headlineLabelHeight = [_headlineLabel.text sizeWithAttributes:@{ NSFontAttributeName: _headlineLabel.font }].height;
	_headlineLabel.frame = CGRectMake(xOrigin, yOrigin, insetBounds.size.width, headlineLabelHeight);

	yOrigin += _headlineLabel.frame.size.height + (_padding * 2.0);

	CGFloat bodyLabelHeight = [_bodyLabel.text sizeWithAttributes:@{ NSFontAttributeName: _bodyLabel.font }].height * 4.0f;
	_bodyLabel.frame = CGRectMake(xOrigin, yOrigin, insetBounds.size.width, bodyLabelHeight);

	yOrigin = insetBounds.origin.y + insetBounds.size.height - (_buttonHeight * 2.0f) - (_padding * 2.0f);

	_signUpButton.frame = CGRectMake(xOrigin, yOrigin, insetBounds.size.width, _buttonHeight);

	yOrigin += _buttonHeight + (_padding * 2.0f);

	_signInButton.frame = CGRectMake(xOrigin, yOrigin, insetBounds.size.width, _buttonHeight);
}

@end
