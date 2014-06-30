//
//  PayView.m
//  MQHelios
//
//  Created by Paris Pinkney on 6/24/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import "PayView.h"
#import "ZxingObjc.h"

@interface PayView ()

// Logged out.
@property (nonatomic, readwrite, strong) UIButton *signInButton;
@property (nonatomic, readwrite, strong) UIButton *signUpButton;
@property (nonatomic, readwrite, strong) UIImageView *imageView;
@property (nonatomic, readwrite, strong) UILabel *bodyLabel;
@property (nonatomic, readwrite, strong) UILabel *headlineLabel;

// Logged in.
@property (nonatomic, readwrite, strong) UIScrollView *scrollView;
@property (nonatomic, readwrite, strong) UIPageControl *pageControl;
@property (nonatomic, readwrite, strong) UIImageView *cardBackView;
@property (nonatomic, readwrite, strong) UIImageView *cardFrontView;
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
		self.backgroundColor = [UIColor colorWithWhite:0.1f alpha:1.0f];

		_padding = 5.0f;
		_buttonHeight = 50.0f;
		_cardHeight = 162.0f;

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
	UIColor *buttonColor = [UIColor colorWithRed:0.076 green:0.194 blue:0.456 alpha:1.000];

	_payButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[_payButton setTitle:@"PAY" forState:UIControlStateNormal];
	[_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_payButton setBackgroundColor:buttonColor];
	_payButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:22.0];
	_payButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
	_payButton.layer.cornerRadius = 8.0f;
	_payButton.layer.masksToBounds = YES;
	_payButton.tag = LOGGED_IN_TAG;
	[self addSubview:_payButton];

	_reloadButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[_reloadButton setTitle:@"RELOAD" forState:UIControlStateNormal];
	[_reloadButton setTitleColor:buttonColor forState:UIControlStateNormal];
	_reloadButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:18.0];
	_reloadButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
	_reloadButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
	_reloadButton.layer.borderWidth = 1.0f;
	_reloadButton.layer.cornerRadius = 8.0f;
	_reloadButton.tag = LOGGED_IN_TAG;
	[self addSubview:_reloadButton];

	_manageButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[_manageButton setTitle:@"MANAGE" forState:UIControlStateNormal];
	[_manageButton setTitleColor:buttonColor forState:UIControlStateNormal];
	_manageButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:18.0];
	_manageButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
	_manageButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
	_manageButton.layer.borderWidth = 1.0f;
	_manageButton.layer.cornerRadius = 8.0f;
	_manageButton.tag = LOGGED_IN_TAG;
	[self addSubview:_manageButton];

	_scrollView = [[UIScrollView alloc] init];
	_scrollView.pagingEnabled = YES;
	_scrollView.showsHorizontalScrollIndicator = NO;
	_scrollView.showsVerticalScrollIndicator = NO;
	[self addSubview:_scrollView];

	_pageControl = [[UIPageControl alloc] init];
	_pageControl.numberOfPages = 2;
	[self addSubview:_pageControl];

	NSDictionary *boldAttributes = @{ NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-DemiBold" size:18.0],
									  NSForegroundColorAttributeName: buttonColor.lighterColor };
	NSDictionary *regularAttributes = @{ NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Regular" size:18.0],
										 NSForegroundColorAttributeName: buttonColor};

	NSMutableAttributedString *balance = [[NSMutableAttributedString alloc] initWithString:@"BALANCE  $0.00"];
	[balance addAttributes:regularAttributes range:NSMakeRange(0, @"BALANCE".length)];
	[balance addAttributes:boldAttributes range:NSMakeRange(@"BALANCE".length, balance.length - @"BALANCE".length)];

	_balanceLabel = [[UILabel alloc] init];
	_balanceLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:20.0];
	_balanceLabel.attributedText = balance;
	_balanceLabel.textAlignment = NSTextAlignmentCenter;
	_balanceLabel.textColor = buttonColor;
	[self addSubview:_balanceLabel];

	_dateLabel = [[UILabel alloc] init];
	_dateLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:10.0];
	_dateLabel.numberOfLines = 2;
	_dateLabel.text = @"as of\n6/27/14";
	_dateLabel.textColor = [UIColor darkGrayColor];
	[self addSubview:_dateLabel];

	_cardFrontView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardFront"]];
	_cardFrontView.contentMode = UIViewContentModeScaleAspectFit;
	_cardFrontView.tag = LOGGED_IN_TAG;
	[_scrollView addSubview:_cardFrontView];

	_cardBackView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardBack"]];
	_cardBackView.contentMode = UIViewContentModeScaleAspectFit;
    _cardBackView.backgroundColor = [UIColor grayColor];
	_cardBackView.tag = LOGGED_IN_TAG;
    
    NSError *error = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix* result = [writer encode:@"6051864458403629"
                                  format:kBarcodeFormatPDF417
                                   width:200
                                  height:200
                                   error:&error];
    if (result) {
        CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
        _cardBackView.image = [UIImage imageWithCGImage:image];
        // This CGImageRef image can be placed in a UIImage, NSImage, or written to a file.
    } else {
        NSString *errorMessage = [error localizedDescription];
    }
    
	[_scrollView addSubview:_cardBackView];
    
    _cardBackLabel = [[UILabel alloc] init];
    _cardBackLabel.backgroundColor = [UIColor clearColor];
    _cardBackLabel.textAlignment = NSTextAlignmentCenter;
    _cardBackLabel.text = @"6051-8644-5840-3629";
    [_scrollView addSubview:_cardBackLabel];
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
	_signUpButton.tag = LOGGED_OUT_TAG;
	[self addSubview:_signUpButton];

	_signInButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[_signInButton setTitle:@"SIGN IN" forState:UIControlStateNormal];
	[_signInButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
	[_signInButton setBackgroundColor:[UIColor whiteColor]];
	_signInButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:22.0];
	_signInButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
	_signInButton.layer.cornerRadius = 8.0f;
	_signInButton.tag = LOGGED_OUT_TAG;
	[self addSubview:_signInButton];
}

- (void)layoutSubviewsForLoggedInUser:(CGRect)bounds
{
	self.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];

	CGFloat xOrigin = bounds.origin.x;
	CGFloat yOrigin = bounds.origin.y;

	CGFloat halfWidth = (bounds.size.width - (_padding * 2.0f)) / 2.0f;

	_scrollView.frame = CGRectMake(self.bounds.origin.x, yOrigin, self.bounds.size.width, _cardHeight);

	_scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * 2.0f, _scrollView.frame.size.height);

	_cardFrontView.frame = CGRectMake(xOrigin, 0.0f, bounds.size.width, _cardHeight);

	CGFloat cardOffset = _scrollView.frame.size.width + (_padding * 4.0f);
	_cardBackView.frame = CGRectOffset(_cardFrontView.bounds, cardOffset, 0.0f);
    
    _cardBackLabel.frame = CGRectOffset(_cardFrontView.bounds, cardOffset, 40.0f);

	yOrigin += _scrollView.frame.size.height + (_padding * 2.0f);

	CGFloat pageControlHeight = 20.0f;
	_pageControl.frame = CGRectMake(xOrigin, yOrigin, bounds.size.width, pageControlHeight);

	yOrigin += _pageControl.frame.size.height + (_padding * 2.0f);

	CGFloat balanceLabelHeight = [_balanceLabel.text sizeWithAttributes:@{ NSFontAttributeName: _balanceLabel.font }].height;
	[_balanceLabel sizeToFit];
	_balanceLabel.center = CGPointMake(self.center.x - (_padding * 4.0f), yOrigin + (balanceLabelHeight / 2.0f));

	[_dateLabel sizeToFit];
	_dateLabel.center = CGPointMake(_balanceLabel.frame.origin.x + _balanceLabel.frame.size.width + (_dateLabel.frame.size.width / 2.0f) + _padding, _balanceLabel.center.y - 2.0f);

	yOrigin = bounds.size.height - ((_buttonHeight + _padding) * 2.0f);

	_payButton.frame = CGRectMake(xOrigin, yOrigin, bounds.size.width, _buttonHeight);

	yOrigin += _buttonHeight + (_padding * 2.0f);

	_reloadButton.frame = CGRectMake(xOrigin, yOrigin, halfWidth, _buttonHeight);

	xOrigin += _reloadButton.frame.size.width + (_padding * 2.0f);

	_manageButton.frame = CGRectMake(xOrigin, yOrigin, halfWidth, _buttonHeight);
}

- (void)layoutSubviewsForLoggedOutUser:(CGRect)bounds
{
	self.backgroundColor = [UIColor colorWithWhite:0.1f alpha:1.0f];

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

	CGRect insetBounds;
	if ([UserManager sharedManager].user) {
		insetBounds = CGRectInset(self.bounds, (_padding * 4.0), (_padding * 4.0f));
		[self layoutSubviewsForLoggedInUser:insetBounds];
		for (UIView *subview in self.subviews) {
			if (subview.tag == LOGGED_OUT_TAG) {
				subview.hidden = YES;
			}
		}
	} else {
		insetBounds = CGRectInset(self.bounds, (_padding * 4.0), (_padding * 8.0));
		[self layoutSubviewsForLoggedOutUser:insetBounds];
		for (UIView *subview in self.subviews) {
			if (subview.tag == LOGGED_IN_TAG) {
				subview.hidden = YES;
			}
		}
	}
}

@end
