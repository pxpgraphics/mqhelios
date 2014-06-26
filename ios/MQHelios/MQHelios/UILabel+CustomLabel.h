//  Copyright (c) 2013 Marqeta, Inc. All rights reserved.

#import <UIKit/UIKit.h>

@interface UILabel (CustomLabel)

- (id)initWithTextColor:(UIColor *)textColor
          textAlignment:(NSTextAlignment)textAlignment
        backgroundColor:(UIColor *)backgroundColor
               fontName:(NSString *)fontName
               fontSize:(CGFloat)fontSize
          numberOfLines:(NSInteger)numberOfLines;

- (id)initWithTextColor:(UIColor *)textColor
		  textAlignment:(NSTextAlignment)textAlignment
		backgroundColor:(UIColor *)backgroundColor
			   fontSize:(CGFloat)fontSize
				   bold:(BOOL)bold
		  numberOfLines:(NSInteger)numberOfLines;

@end
