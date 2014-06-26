//  Copyright (c) 2013 Marqeta, Inc. All rights reserved.

#import "UILabel+CustomLabel.h"

@implementation UILabel (CustomLabel)

- (id)initWithTextColor:(UIColor *)textColor
          textAlignment:(NSTextAlignment)textAlignment
        backgroundColor:(UIColor *)backgroundColor
               fontName:(NSString *)fontName
               fontSize:(CGFloat)fontSize
          numberOfLines:(NSInteger)numberOfLines
{
    if (self = [super init]) {
		UIFont *font = [UIFont fontWithName:fontName size:fontSize];

		self.textColor = textColor;
		self.textAlignment = textAlignment;
		self.backgroundColor = backgroundColor;
		self.font = font;
		self.numberOfLines = numberOfLines;
    }

    return self;
}

- (id)initWithTextColor:(UIColor *)textColor
          textAlignment:(NSTextAlignment)textAlignment
        backgroundColor:(UIColor *)backgroundColor
               fontSize:(CGFloat)fontSize
				   bold:(BOOL)bold
          numberOfLines:(NSInteger)numberOfLines
{
    if (self = [super init]) {
		UIFont *font;
		if (bold) {
			font = [UIFont boldSystemFontOfSize:fontSize];
		} else {
			font = [UIFont systemFontOfSize:fontSize];
		}

		self.textColor = textColor;
		self.textAlignment = textAlignment;
		self.backgroundColor = backgroundColor;
		self.font = font;
		self.numberOfLines = numberOfLines;
    }

    return self;
}

@end
