//
//  NSObject+UIPopoverAdditions.h
//  MQHelios
//
//  Created by Paris Pinkney on 6/24/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIPopoverController (UIPopoverAdditions)

// Private method to enable UIPopoverControllers on an iPhone device.
+ (BOOL)_popoversDisabled;

@end