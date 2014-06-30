//  Copyright (c) 2013 Marqeta, Inc. All rights reserved.

#import "MQDealCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UILabel+CustomLabel.h"

@interface MQDealCell ()

@property (nonatomic, readwrite, strong) UILabel *dealAmountLabel;
@property (nonatomic, readwrite, strong) UILabel *dealTypeLabel;
@property (nonatomic, readwrite, strong) UILabel *dealExpirationLabel;

@property (nonatomic, readwrite, strong) UIView *expandedView;
@property (nonatomic, readwrite, strong) UIView *expandedContentView;
@property (nonatomic, readwrite, strong) UIButton *purchaseButton;
@property (nonatomic, readwrite, strong) UILabel *dealDetailsLabel;
@property (nonatomic, readwrite, strong) UITextView *dealDetailsTextView;

@property (nonatomic, readwrite, strong) UIImageView *dealImageView;
@property (nonatomic, readwrite, strong) UIImageView *arrowImageView;

@end

@implementation MQDealCell
{
	UIView *mainView;
	UIView *leftView;
	UIView *dealTypeView;
	UIView *dealExpirationView;
	UIView *expandedViewBorder;
	UIView *dealDetailsBorder;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		self.backgroundColor = [MQColor grayColor];
		self.selectionStyle = UITableViewCellSelectionStyleNone;

		_padding = 5.0f;
		_borderWidth = 1.0f;
		_buttonHeight = 44.0f;
		_arrowHeightAndWidth = 14.0f;

		mainView = [[UIView alloc] init];
		mainView.backgroundColor = [MQColor veryLightBlueColor];

		mainView.layer.shadowColor = [UIColor blackColor].CGColor;
		mainView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
		mainView.layer.shadowOpacity = 0.25f;
		mainView.layer.shadowRadius = 1.0f;

		leftView = [[UIView alloc] init];

		_dealImageView = [[UIImageView alloc] init];
		_dealImageView.backgroundColor = [UIColor whiteColor];
		_dealImageView.tag = DEAL_IMAGE_TAG;

		[mainView addSubview:_dealImageView];

		_dealAmountLabel = [[UILabel alloc] initWithTextColor:[UIColor blackColor]
												textAlignment:NSTextAlignmentLeft
											  backgroundColor:[UIColor clearColor]
													 fontSize:[MQDealCell dealAmountFontSize]
														 bold:YES
												numberOfLines:1];

		_dealAmountLabel.tag = DEAL_AMOUNT_TAG;

		[leftView addSubview:_dealAmountLabel];

		dealTypeView = [[UIView alloc] init];
		dealTypeView.backgroundColor = [UIColor colorWithRed:(200.0f / 255.0f)
													   green:(240.0f / 255.0f)
														blue:(255.0f / 255.0f)
													   alpha:1.0f];

		[leftView addSubview:dealTypeView];

		_dealTypeLabel = [[UILabel alloc] initWithTextColor:[MQColor blueColor]
											  textAlignment:NSTextAlignmentLeft
											backgroundColor:[UIColor clearColor]
												   fontSize:[MQDealCell attributedTextFontSize]
													   bold:YES
											  numberOfLines:1];

		_dealTypeLabel.tag = DEAL_TYPE_TAG;

		[dealTypeView addSubview:_dealTypeLabel];

		dealExpirationView = [[UIView alloc] init];
		dealExpirationView.backgroundColor = [MQColor lightBlueColor];

		[leftView addSubview:dealExpirationView];

		_dealExpirationLabel = [[UILabel alloc] initWithTextColor:[MQColor blueColor]
													textAlignment:NSTextAlignmentLeft
												  backgroundColor:[UIColor clearColor]
														 fontSize:[MQDealCell attributedTextFontSize]
															 bold:YES
													numberOfLines:1];

		_dealExpirationLabel.tag = DEAL_EXPIRATION_TAG;

		[dealExpirationView addSubview:_dealExpirationLabel];

		_arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down_arrow_thick.png"]];
		_arrowImageView.backgroundColor = [UIColor clearColor];
		_arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
		_arrowImageView.tintColor = [MQColor blueColor];
		_arrowImageView.tag = DEAL_ARROW_IMAGE_TAG;

		[leftView addSubview:_arrowImageView];

		[mainView addSubview:leftView];
		[self.contentView addSubview:mainView];

		_expandedView = [[UIView alloc] init];
		_expandedView.backgroundColor = [UIColor whiteColor];
		_expandedView.hidden = YES;

		expandedViewBorder = [[UIView alloc] init];
		expandedViewBorder.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];

		_expandedContentView = [[UIView alloc] init];

		_purchaseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		_purchaseButton.backgroundColor = [MQColor blueColor];
		_purchaseButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
		_purchaseButton.titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);

		_purchaseButton.layer.cornerRadius = 4.0f;
		_purchaseButton.layer.shadowColor = [UIColor blackColor].CGColor;
		_purchaseButton.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
		_purchaseButton.layer.shadowRadius = 0.5f;

		[_purchaseButton setTitle:@"Take This Offer" forState:UIControlStateNormal];
		[_purchaseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[_purchaseButton setTitleShadowColor:[[MQColor blueColor] darkerColor] forState:UIControlStateNormal];

		[_expandedContentView addSubview:_purchaseButton];

		_dealDetailsTextView = [[UITextView alloc] init];
		_dealDetailsTextView.backgroundColor = [UIColor clearColor];
		_dealDetailsTextView.editable = NO;
		_dealDetailsTextView.selectable = NO;

		[_expandedContentView addSubview:_dealDetailsTextView];

		_dealDetailsLabel = [[UILabel alloc] initWithTextColor:[UIColor blackColor]
												 textAlignment:NSTextAlignmentLeft
											   backgroundColor:[UIColor clearColor]
													  fontSize:12.0f
														  bold:YES
												 numberOfLines:1];

		_dealDetailsLabel.text = @"Offer Details";

		[_expandedContentView addSubview:_dealDetailsLabel];

		dealDetailsBorder = [[UIView alloc] init];
		dealDetailsBorder.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];

		[_expandedView addSubview:_expandedContentView];
		[_expandedView addSubview:dealDetailsBorder];
		[_expandedView addSubview:expandedViewBorder];
		[self.contentView addSubview:_expandedView];
    }

    return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];

	CGRect bounds = self.bounds;

	CGFloat verticalInset = _padding;
	CGFloat horizontalInset = _padding * 2.0f;

	mainView.frame = CGRectInset(bounds, horizontalInset, verticalInset);

	CGFloat dealImageWidthAndHeight = [MQDealCell height] - (verticalInset * 2.0f);

	CGFloat dealAmountLabelHeight = [_dealAmountLabel.text sizeWithFont:_dealAmountLabel.font].height;

	CGFloat dealTypeLabelHeight = [_dealTypeLabel.text sizeWithFont:_dealTypeLabel.font].height + (_padding * 1.5f);
	CGFloat dealTypeLabelWidth = [_dealTypeLabel.text sizeWithFont:_dealTypeLabel.font].width + (_padding * 3.0f);

	CGFloat dealExpirationLabelHeight = [_dealExpirationLabel.text sizeWithFont:_dealExpirationLabel.font].height + (_padding * 1.5f);
	CGFloat dealExpirationLabelWidth = [_dealExpirationLabel.text sizeWithFont:_dealExpirationLabel.font].width + (_padding * 3.0f);

	CGFloat dealDetailsLabelHeight = [_dealDetailsLabel.text sizeWithFont:_dealDetailsLabel.font].height;

	// Image view.
	_dealImageView.frame = CGRectMake(bounds.origin.x,
									  bounds.origin.y,
									  dealImageWidthAndHeight,
									  dealImageWidthAndHeight);

	// Left-aligned view.
	UIEdgeInsets leftViewEdgeInsets = UIEdgeInsetsMake(_padding,
													   dealImageWidthAndHeight + (_padding * 2.0f),
													   _padding,
													   (_padding * 10.0f));

	leftView.frame = UIEdgeInsetsInsetRect(mainView.bounds, leftViewEdgeInsets);

	CGFloat xOriginLeftView = leftView.bounds.origin.x;
	CGFloat yOriginLeftView = leftView.bounds.origin.y;
	CGFloat leftViewWidth = leftView.bounds.size.width;

	_dealAmountLabel.frame = CGRectMake(xOriginLeftView,
										yOriginLeftView,
										leftViewWidth,
										dealAmountLabelHeight);

	yOriginLeftView += dealAmountLabelHeight + (_padding / 2.0f);

	dealTypeView.frame = CGRectMake(xOriginLeftView,
									yOriginLeftView,
									dealTypeLabelWidth,
									dealTypeLabelHeight);

	_dealTypeLabel.frame = CGRectInset(dealTypeView.bounds, (_padding * 1.5f), (_padding / 2.0f));

	xOriginLeftView += dealTypeLabelWidth + _padding;

	dealExpirationView.frame = CGRectMake(xOriginLeftView,
										  yOriginLeftView,
										  dealExpirationLabelWidth,
										  dealExpirationLabelHeight);

	_dealExpirationLabel.frame = CGRectInset(dealExpirationView.bounds, (_padding * 1.5f), (_padding / 2.0f));

	UIEdgeInsets arrowImageViewEdgeInsets = UIEdgeInsetsMake((_padding * 5.0f),
															 leftViewWidth + dealImageWidthAndHeight - _arrowHeightAndWidth - (_padding * 6.0),
															 (_padding * 5.0f),
															 (_padding * 6.0f));

	CGRect arrowImageViewBounds = UIEdgeInsetsInsetRect(leftView.bounds, arrowImageViewEdgeInsets);

	_arrowImageView.frame = CGRectMake(arrowImageViewBounds.origin.x,
									   arrowImageViewBounds.origin.y,
									   _arrowHeightAndWidth,
									   _arrowHeightAndWidth);

	// Expanded view.
	UIEdgeInsets expandedViewEdgeInsets = UIEdgeInsetsMake(dealImageWidthAndHeight,
														   horizontalInset,
														   verticalInset,
														   horizontalInset);

	_expandedView.frame = UIEdgeInsetsInsetRect(bounds, expandedViewEdgeInsets);

	CGFloat xOriginExpandedView = _expandedView.bounds.origin.x;
	CGFloat yOriginExpandedView = _expandedView.bounds.origin.y;
	CGFloat expandedViewWidth = _expandedView.bounds.size.width;

	expandedViewBorder.frame = CGRectMake(xOriginExpandedView,
										  yOriginExpandedView,
										  expandedViewWidth,
										  _borderWidth);

	_expandedContentView.frame = CGRectInset(_expandedView.bounds, horizontalInset, -(verticalInset * 2.0f));

	CGRect expandedContentViewBounds = _expandedContentView.bounds;
	CGFloat xOriginExpandedContentView = _expandedContentView.bounds.origin.x;
	CGFloat yOriginExpandedContentView = _expandedContentView.bounds.origin.y;

	// Expanded content view.
	UIEdgeInsets purchaseViewEdgeInsets = UIEdgeInsetsMake((_padding * 4.0f),
														   horizontalInset,
														   expandedContentViewBounds.size.height - (_padding * 4.0f) - _buttonHeight,
														   horizontalInset);

	_purchaseButton.frame = UIEdgeInsetsInsetRect(_expandedContentView.bounds, purchaseViewEdgeInsets);

	yOriginExpandedContentView += _purchaseButton.bounds.origin.y + _purchaseButton.bounds.size.height + (_padding * 4.0f);

	dealDetailsBorder.frame = CGRectMake(xOriginExpandedView,
										 yOriginExpandedContentView,
										 expandedViewWidth,
										 _borderWidth);

	yOriginExpandedContentView += (_padding * 4.0f);

	_dealDetailsLabel.frame = CGRectMake(xOriginExpandedContentView + _padding,
										 yOriginExpandedContentView,
										 expandedContentViewBounds.size.width,
										 dealDetailsLabelHeight);

	yOriginExpandedContentView += (_padding * 1.5f);
    
	_dealDetailsTextView.frame = CGRectMake(xOriginExpandedContentView,
											yOriginExpandedContentView,
											expandedContentViewBounds.size.width,
											[MQDealCell textViewHeightForText:_dealDetailsTextView.text
                                                                     andWidth:expandedContentViewBounds.size.width]);

	yOriginExpandedContentView -= (_padding * 6.0f);

	_contentViewHeight = yOriginExpandedContentView;
}

+ (CGFloat)attributedTextFontSize
{
	return 10.0f;
}

+ (CGFloat)dealAmountFontSize
{
	return 28.0f;
}

+ (CGFloat)height
{
	return 80.0f;
}

+ (CGFloat)width
{
	return 280.0f;
}

+ (CGFloat)textViewHeightForAttributedText:(NSAttributedString *)attributedText
								  andWidth:(CGFloat)width
{
	UITextView *textView = [[UITextView alloc] init];
	textView.attributedText = attributedText;

	CGSize size = [textView sizeThatFits:CGSizeMake(width, FLT_MAX)];
	return size.height + 16.0f;
}

+ (CGFloat)textViewHeightForText:(NSString *)text
						andWidth:(CGFloat)width
{
	UITextView *textView = [[UITextView alloc] init];
	textView.text = text;
	
	CGSize size = [textView sizeThatFits:CGSizeMake(width, FLT_MAX)];
	return size.height + 16.0f;
}

@end
