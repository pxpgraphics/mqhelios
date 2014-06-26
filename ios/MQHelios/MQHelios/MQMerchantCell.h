//  Copyright (c) 2013 Marqeta, Inc. All rights reserved.

#import <UIKit/UIKit.h>

#define MERCHANT_BRAND_NAME_TAG 1000
#define MERCHANT_STORE_ADDRESS_TAG 1001
#define MERCHANT_DISTANCE_TAG 1002
#define MERCHANT_CATEGORY_TAG 1003
#define MERCHANT_DEAL_COUNT_TAG 1004
#define MERCHANT_STORE_COUNT_TAG 1005
#define MERCHANT_BRAND_LOGO_TAG 1006

@interface MQMerchantCell : UITableViewCell

@property (nonatomic, readwrite) CGFloat padding;

@property (nonatomic, readonly, strong) UILabel *brandNameLabel;
@property (nonatomic, readonly, strong) UILabel *storeAddressLabel;
@property (nonatomic, readonly, strong) UILabel *distanceLabel;
@property (nonatomic, readonly, strong) UILabel *categoryLabel;
@property (nonatomic, readonly, strong) UILabel *dealCountLabel;
@property (nonatomic, readonly, strong) UILabel *storeCountLabel;

@property (nonatomic, readonly, strong) UIImageView *brandLogoImageView;

+ (CGFloat)attributedTextFontSize;
+ (CGFloat)height;

@end
