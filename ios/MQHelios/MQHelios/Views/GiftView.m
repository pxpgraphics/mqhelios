//
//  GiftView.m
//  MQHelios
//
//  Created by Paris Pinkney on 6/24/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import "GiftView.h"

@interface GiftView ()

@property (nonatomic, readwrite, strong) UIButton *signInButton;
@property (nonatomic, readwrite, strong) UIButton *signUpButton;
@property (nonatomic, readwrite, strong) UIImageView *imageView;
@property (nonatomic, readwrite, strong) UILabel *bodyLabel;
@property (nonatomic, readwrite, strong) UILabel *headlineLabel;

@end

@implementation GiftView

- (instancetype)init
{
	if (self = [super init]) {
		_imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Gift"]];
		_imageView.contentMode = UIViewContentModeScaleAspectFill;
		[self addSubview:_imageView];
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

	_imageView.frame = bounds;
}

@end
