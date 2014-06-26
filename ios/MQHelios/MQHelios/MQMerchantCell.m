//  Copyright (c) 2013 Marqeta, Inc. All rights reserved.

#import "MQMerchantCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UILabel+CustomLabel.h"

@interface MQMerchantCell ()

@property (nonatomic, readwrite, strong) UILabel *brandNameLabel;
@property (nonatomic, readwrite, strong) UILabel *storeAddressLabel;
@property (nonatomic, readwrite, strong) UILabel *distanceLabel;
@property (nonatomic, readwrite, strong) UILabel *categoryLabel;
@property (nonatomic, readwrite, strong) UILabel *dealCountLabel;
@property (nonatomic, readwrite, strong) UILabel *storeCountLabel;

@property (nonatomic, readwrite, strong) UIImageView *brandLogoImageView;

@end

@implementation MQMerchantCell
{
	UIView *mainView;
	UIView *leftView;
	UIView *rightView;
	UIView *dealCountView;
	UIView *storeCountView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [MQColor grayColor];
		self.selectionStyle = UITableViewCellSelectionStyleNone;

        _padding = 5.0f;

		mainView = [[UIView alloc] init];
		mainView.backgroundColor = [MQColor veryLightBlueColor];

		leftView = [[UIView alloc] init];
		rightView = [[UIView alloc] init];

		_brandLogoImageView = [[UIImageView alloc] init];
		_brandLogoImageView.backgroundColor = [UIColor whiteColor];
		_brandLogoImageView.tag = MERCHANT_BRAND_LOGO_TAG;

		[mainView addSubview:_brandLogoImageView];

		_brandNameLabel = [[UILabel alloc] initWithTextColor:[UIColor blackColor]
											   textAlignment:NSTextAlignmentLeft
											 backgroundColor:[UIColor clearColor]
													fontSize:13.0f
														bold:YES
											   numberOfLines:1];

		_brandNameLabel.tag = MERCHANT_BRAND_NAME_TAG;

		[leftView addSubview:_brandNameLabel];

		_storeAddressLabel = [[UILabel alloc] initWithTextColor:[MQColor darkBlueColor]
												  textAlignment:NSTextAlignmentLeft
												backgroundColor:[UIColor clearColor]
													   fontSize:9.0f
														   bold:NO
												  numberOfLines:1];

		_storeAddressLabel.tag = MERCHANT_STORE_ADDRESS_TAG;

		[leftView addSubview:_storeAddressLabel];

		dealCountView = [[UIView alloc] init];
		dealCountView.backgroundColor = [MQColor lightBlueColor];

		[leftView addSubview:dealCountView];

		_dealCountLabel = [[UILabel alloc] initWithTextColor:[MQColor blueColor]
											   textAlignment:NSTextAlignmentLeft
											 backgroundColor:[UIColor clearColor]
													fontSize:[MQMerchantCell attributedTextFontSize]
														bold:YES
											   numberOfLines:1];

		_dealCountLabel.tag = MERCHANT_DEAL_COUNT_TAG;

		[dealCountView addSubview:_dealCountLabel];

		storeCountView = [[UIView alloc] init];
		storeCountView.backgroundColor = [MQColor lightBlueColor];

		[leftView addSubview:storeCountView];

		_storeCountLabel = [[UILabel alloc] initWithTextColor:[MQColor blueColor]
												textAlignment:NSTextAlignmentLeft
											  backgroundColor:[UIColor clearColor]
													 fontSize:[MQMerchantCell attributedTextFontSize]
														 bold:YES
												numberOfLines:1];

		_storeCountLabel.tag = MERCHANT_STORE_COUNT_TAG;

		[storeCountView addSubview:_storeCountLabel];

		_distanceLabel = [[UILabel alloc] initWithTextColor:[MQColor darkBlueColor]
											  textAlignment:NSTextAlignmentRight
											backgroundColor:[UIColor clearColor]
												   fontSize:8.0f
													   bold:NO
											  numberOfLines:1];

		_distanceLabel.tag = MERCHANT_DISTANCE_TAG;

		[rightView addSubview:_distanceLabel];

		_categoryLabel = [[UILabel alloc] initWithTextColor:[MQColor darkBlueColor]
											  textAlignment:NSTextAlignmentRight
											backgroundColor:[UIColor clearColor]
												   fontSize:8.0f
													   bold:NO
											  numberOfLines:1];

		_categoryLabel.tag = MERCHANT_CATEGORY_TAG;

		[rightView addSubview:_categoryLabel];

		[mainView addSubview:leftView];
		[mainView addSubview:rightView];

		[self.contentView addSubview:mainView];
    }
    return self;
}

- (void)layoutSubviews
{
    CGRect bounds = self.bounds;
	CGRect mainViewBounds = CGRectInset(bounds, (_padding * 2.0f), _padding);

	mainView.frame = mainViewBounds;

	CGFloat brandLogoWidthAndHeight = mainViewBounds.size.height;

	CGFloat brandNameLabelHeight = [_brandNameLabel.text sizeWithFont:_brandNameLabel.font].height;
	CGFloat storeAddressLabelHeight = [_storeAddressLabel.text sizeWithFont:_storeAddressLabel.font].height;

	CGFloat dealCountLabelHeight = [_dealCountLabel.text sizeWithFont:_dealCountLabel.font].height + (_padding * 1.5f);
	CGFloat dealCountLabelWidth = [_dealCountLabel.text sizeWithFont:_dealCountLabel.font].width + (_padding * 3.0f);
	CGFloat storeCountLabelHeight = [_storeCountLabel.text sizeWithFont:_storeCountLabel.font].height + (_padding * 1.5f);
	CGFloat storeCountLabelWidth = [_storeCountLabel.text sizeWithFont:_storeCountLabel.font].width + (_padding * 3.0f);

	CGFloat distanceLabelHeight = [_distanceLabel.text sizeWithFont:_distanceLabel.font].height;
	CGFloat distanceLabelWidth = [_distanceLabel.text sizeWithFont:_distanceLabel.font].width;
	CGFloat categoryLabelHeight = [_categoryLabel.text sizeWithFont:_categoryLabel.font].height;
	CGFloat categoryLabelWidth = [_categoryLabel.text sizeWithFont:_categoryLabel.font].width;

	// Image view.
	_brandLogoImageView.frame = CGRectMake(bounds.origin.x,
										   bounds.origin.y,
										   brandLogoWidthAndHeight,
										   brandLogoWidthAndHeight);

	// Left-aligned view.
	UIEdgeInsets leftViewEdgeInsets = UIEdgeInsetsMake((_padding * 1.5f),
													   brandLogoWidthAndHeight + (_padding * 2.0f),
													   (_padding * 1.5f),
													   (_padding * 11.0f));

	leftView.frame = UIEdgeInsetsInsetRect(mainView.bounds, leftViewEdgeInsets);

	CGFloat xOriginLeftView = leftView.bounds.origin.x;
    CGFloat yOriginLeftView = leftView.bounds.origin.y;

	CGFloat leftViewWidth = leftView.bounds.size.width;

	_brandNameLabel.frame = CGRectMake(xOriginLeftView,
									   yOriginLeftView,
									   leftViewWidth,
									   brandNameLabelHeight);

	yOriginLeftView += brandNameLabelHeight + (_padding / 2.5f);

	_storeAddressLabel.frame = CGRectMake(xOriginLeftView,
										  yOriginLeftView,
										  leftViewWidth,
										  storeAddressLabelHeight);

	yOriginLeftView += storeAddressLabelHeight + _padding;

	dealCountView.frame = CGRectMake(xOriginLeftView,
									 yOriginLeftView,
									 dealCountLabelWidth,
									 dealCountLabelHeight);

	_dealCountLabel.frame = CGRectInset(dealCountView.bounds, (_padding * 1.5f), (_padding / 2.0f));

	xOriginLeftView += dealCountLabelWidth + _padding;

	storeCountView.frame = CGRectMake(xOriginLeftView,
									  yOriginLeftView,
									  storeCountLabelWidth,
									  storeCountLabelHeight);

	_storeCountLabel.frame = CGRectInset(storeCountView.bounds, (_padding * 1.5f), (_padding / 2.0f));

	// Right-aligned view.
	UIEdgeInsets rightViewEdgeInsets = UIEdgeInsetsMake((_padding * 2.5f),
														leftViewWidth + brandLogoWidthAndHeight + (_padding * 2.0f),
														(_padding * 4.5f),
														(_padding * 4.0f));

	rightView.frame = UIEdgeInsetsInsetRect(mainView.bounds, rightViewEdgeInsets);

	CGFloat xOriginRightView = rightView.bounds.size.width;
    CGFloat yOriginRightView = rightView.bounds.origin.y;

	_distanceLabel.frame = CGRectMake(xOriginRightView - distanceLabelWidth,
									  yOriginRightView,
									  distanceLabelWidth,
									  distanceLabelHeight);

	yOriginRightView = rightView.bounds.size.height;

	_categoryLabel.frame = CGRectMake(xOriginRightView - categoryLabelWidth,
									  yOriginRightView,
									  categoryLabelWidth,
									  categoryLabelHeight);
}

+ (CGFloat)attributedTextFontSize
{
	return 10.0f;
}

+ (CGFloat)height
{
	return 80.0f;
}

@end
