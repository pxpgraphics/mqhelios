//
//  MQHAppManager.h
//  MQHelios
//
//  Created by Paris Pinkney on 6/23/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PassKit/PassKit.h>
#import <Parse/Parse.h>
#import "LocationManager.h"

extern NSString * const kParseApplicationIDKey;
extern NSString * const kParseClientKey;
extern NSString * const kParseJavascriptKey;
extern NSString * const kParseNETKey;
extern NSString * const kParseRESTAPIKey;
extern NSString * const kParseMasterKey;

@interface MQHAppManager : NSObject

@property (nonatomic, strong) NSString *userCreatePOSTURLString;
@property (nonatomic, strong) NSString *paymentProfilePOSTURLString;
@property (nonatomic, strong) NSString *marqetaCardPOSTURLString;
@property (nonatomic, strong) NSString *gpaFundsPOSTURLString;
@property (nonatomic, strong) NSString *purchaseOrdersPOSTURLString;
@property (nonatomic, strong) NSString *passCreatePOSTURLString;

+ (MQHAppManager *)sharedManager;

@end
