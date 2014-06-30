//  Copyright (c) 2013 Marqeta, Inc. All rights reserved.

#import <UIKit/UIKit.h>

#define DEAL_AMOUNT_TAG 1000
#define DEAL_TYPE_TAG 1001
#define DEAL_EXPIRATION_TAG 1002
#define DEAL_DETAIL_TAG 1003
#define DEAL_IMAGE_TAG 1004
#define DEAL_ARROW_IMAGE_TAG 1005

@interface MQDealCell : UITableViewCell

@property (nonatomic, readwrite) CGFloat padding;
@property (nonatomic, readwrite) CGFloat borderWidth;
@property (nonatomic, readwrite) CGFloat buttonHeight;
@property (nonatomic, readwrite) CGFloat arrowHeightAndWidth;
@property (nonatomic, readwrite) CGFloat expandedViewHeight;
@property (nonatomic, readwrite) CGFloat contentViewHeight;

@property (nonatomic, readonly, strong) UILabel *dealAmountLabel;
@property (nonatomic, readonly, strong) UILabel *dealTypeLabel;
@property (nonatomic, readonly, strong) UILabel *dealExpirationLabel;

@property (nonatomic, readonly, strong) UIView *expandedView;
@property (nonatomic, readonly, strong) UIView *expandedContentView;
@property (nonatomic, readonly, strong) UIButton *purchaseButton;
@property (nonatomic, readonly, strong) UILabel *dealDetailsLabel;
@property (nonatomic, readonly, strong) UITextView *dealDetailsTextView;

@property (nonatomic, readonly, strong) UIImageView *dealImageView;
@property (nonatomic, readonly, strong) UIImageView *arrowImageView;

+ (CGFloat)attributedTextFontSize;
+ (CGFloat)dealAmountFontSize;
+ (CGFloat)height;
+ (CGFloat)width;

+ (CGFloat)textViewHeightForAttributedText:(NSAttributedString *)attributedText
								  andWidth:(CGFloat)width;

+ (CGFloat)textViewHeightForText:(NSString *)text
						andWidth:(CGFloat)width;

@end
