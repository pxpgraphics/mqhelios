//
//  UserManager.h
//  MQHelios
//
//  Created by Paris Pinkney on 6/24/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQPUser.h"

typedef void (^MQHUserManagerSuccessBlock)();
typedef void (^MQHUserManagerFailureBlock)(NSError *error);

extern NSString * const kUserManagerUserDidFinishLoadingNotification;
extern NSString * const kUserManagerUserDidFailLoadingNotification;

@interface UserManager : NSObject

@property (nonatomic, strong) MQPUser *user;

- (void)loginUserWithUserInfo:(NSDictionary *)userInfo
				 successBlock:(MQHUserManagerSuccessBlock)successBlock
				 failureBlock:(MQHUserManagerFailureBlock)failureBlock;

- (void)registerUserWithUserInfo:(NSDictionary *)userInfo
                    successBlock:(MQHUserManagerSuccessBlock)successBlock
                    failureBlock:(MQHUserManagerFailureBlock)failureBlock;

- (void)createPaymentProfileWithUserInfo:(NSDictionary *)userInfo
                            successBlock:(MQHUserManagerSuccessBlock)successBlock
                            failureBlock:(MQHUserManagerFailureBlock)failureBlock;

- (void)createMarqetaCardWithSuccessBlock:(MQHUserManagerSuccessBlock)successBlock
                             failureBlock:(MQHUserManagerFailureBlock)failureBlock;

- (void)addGPAFundsWithUserInfo:(NSDictionary *)userInfo
                   successBlock:(MQHUserManagerSuccessBlock)successBlock
                   failureBlock:(MQHUserManagerFailureBlock)failureBlock;

- (void)purchaseOrdersWithUserInfo:(NSDictionary *)userInfo
                      successBlock:(MQHUserManagerSuccessBlock)successBlock
                      failureBlock:(MQHUserManagerFailureBlock)failureBlock;

- (void)createPassWithSuccessBlock:(MQHUserManagerSuccessBlock)successBlock
                      failureBlock:(MQHUserManagerFailureBlock)failureBlock;

+ (UserManager *)sharedManager;

@end
