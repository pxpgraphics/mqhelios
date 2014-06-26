//
//  UserManager.m
//  MQHelios
//
//  Created by Paris Pinkney on 6/24/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import "UserManager.h"
#import <AFHTTPRequestOperationManager.h>
#import <AFNetworkActivityIndicatorManager.h>
#import "AFHTTPRequestOperation.h"

@interface UserManager ()

@property (nonatomic) BOOL loading;

@end
@implementation UserManager

#pragma mark User Registration
- (NSDictionary *)preparedParametersForUserRegistrationWithUserInfo:(NSDictionary *)userInfo
{
    NSDictionary *parameters = @{ @"customer" :
                                      @{ @"salutation" : userInfo[@"gender"],
                                         @"addresses_attributes" :
                                             @[ @{ @"state" : userInfo[@"state"],
                                                   @"city" : userInfo[@"city"],
                                                   @"line_one": userInfo[@"addressLineOne"],
                                                   @"zip": userInfo[@"zip"]
                                                   }
                                                ],
                                         @"first_name" : userInfo[@"firstName"],
                                         @"phone" : userInfo[@"phone"],
                                         @"mobile_phone" : userInfo[@"mobilePhone"],
                                         @"last_name" : userInfo[@"lastName"],
                                         @"email" : userInfo[@"email"]
                                         }
                                  };
    
    NSLog(@"Parameters: %@", parameters);
    return parameters;
}

- (void)registerUserWithUserInfo:(NSDictionary *)userInfo
                    successBlock:(MQHUserManagerSuccessBlock)successBlock
                    failureBlock:(MQHUserManagerFailureBlock)failureBlock
{
    if (self.loading) {
        NSLog(@"Operation is already in progress!");
        return;
    }
    self.loading = YES;
    
    __typeof__(self) __weak weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:[MQHAppManager sharedManager].userCreatePOSTURLString
       parameters:[self preparedParametersForUserRegistrationWithUserInfo:userInfo]
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              weakSelf.loading = NO;
              NSLog(@"Success = %@", responseObject);
              if (responseObject) {
                  weakSelf.user = [MQPUser initWithJSONData:responseObject];
                  if (successBlock) {
                      successBlock();
                  }
              } else {
                  NSError *error = [NSError errorWithDomain:@"com.marqeta.MQPegasus.errorDomain"
                                                       code:0
                                                   userInfo:@{ NSLocalizedDescriptionKey: @"Response object not found!" }];
                  if (failureBlock) {
                      failureBlock(error);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              weakSelf.loading = NO;
              NSLog(@"Failure = %@", error);
              if (failureBlock) {
                  failureBlock(error);
              }
          }];
}

#pragma mark Payment Profile
- (NSDictionary *)preparedParametersForPaymentProfileWithUserInfo:(NSDictionary *)userInfo
{
    NSDictionary *parameters = @{ @"payment_profile" :
                                      @{ @"billing_address_attributes" :
                                             @{ @"city" : userInfo[@"city"],
                                                @"line_one" : userInfo[@"addressLineOne"],
                                                @"state" : userInfo[@"state"],
                                                @"zip" : userInfo[@"zip"]
                                                },
                                         @"credit_card_attributes" :
                                             @{ @"first_name" : userInfo[@"firstName"],
                                                @"last_name" : userInfo[@"lastName"],
                                                @"month" : userInfo[@"month"],
                                                @"number" : userInfo[@"number"],
                                                @"verification_value" : userInfo[@"cvv"],
                                                @"year" : userInfo[@"year"]
                                                }
                                         }
                                  };
    
    return parameters;
}

- (void)createPaymentProfileWithUserInfo:(NSDictionary *)userInfo
                            successBlock:(MQHUserManagerSuccessBlock)successBlock
                            failureBlock:(MQHUserManagerFailureBlock)failureBlock
{
    if (self.loading) {
        NSLog(@"Operation is already in progress!");
        return;
    }
    self.loading = YES;
    
    __typeof__(self) __weak weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *paymentProfileURL = [NSString stringWithFormat:@"%@?auth_token=%@", [MQHAppManager sharedManager].paymentProfilePOSTURLString, self.user.authenticationToken];
    [manager POST:paymentProfileURL
       parameters:[self preparedParametersForPaymentProfileWithUserInfo:userInfo]
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              weakSelf.loading = NO;
              NSLog(@"Success = %@", responseObject);
              if (responseObject) {
                  if (successBlock) {
                      successBlock();
                  }
              } else {
                  NSError *error = [NSError errorWithDomain:@"com.marqeta.MQPegasus.errorDomain"
                                                       code:0
                                                   userInfo:@{ NSLocalizedDescriptionKey: @"Response object not found!" }];
                  if (failureBlock) {
                      failureBlock(error);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              weakSelf.loading = NO;
              NSLog(@"Failure = %@", error);
              if (failureBlock) {
                  failureBlock(error);
              }
          }];
}

#pragma mark Card creation
- (void)createMarqetaCardWithSuccessBlock:(MQHUserManagerSuccessBlock)successBlock
                             failureBlock:(MQHUserManagerFailureBlock)failureBlock
{
    if (self.loading) {
        NSLog(@"Operation is already in progress!");
        return;
    }
    self.loading = YES;
    
    __typeof__(self) __weak weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *marqetaCardURL = [NSString stringWithFormat:@"%@?auth_token=%@", [MQHAppManager sharedManager].marqetaCardPOSTURLString, self.user.authenticationToken];
    [manager POST:marqetaCardURL
       parameters:@{}
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              weakSelf.loading = NO;
              NSLog(@"Success = %@", responseObject);
              if (responseObject) {
                  if (successBlock) {
                      successBlock();
                  }
              } else {
                  NSError *error = [NSError errorWithDomain:@"com.marqeta.MQPegasus.errorDomain"
                                                       code:0
                                                   userInfo:@{ NSLocalizedDescriptionKey: @"Response object not found!" }];
                  if (failureBlock) {
                      failureBlock(error);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              weakSelf.loading = NO;
              NSLog(@"Failure = %@", error);
              if (failureBlock) {
                  failureBlock(error);
              }
          }];
}

#pragma mark GPA Funds
- (NSDictionary *)preparedParametersForAddGPAFundsWithUserInfo:(NSDictionary *)userInfo
{
    NSDictionary *parameters = @{ @"gpa_transaction" :
                                      @{ @"payment_profile_id" : userInfo[@"paymentProfileID"],
                                         @"price" : userInfo[@"price"]
                                         }
                                  };
    
    return parameters;
}

- (void)addGPAFundsWithUserInfo:(NSDictionary *)userInfo
                   successBlock:(MQHUserManagerSuccessBlock)successBlock
                   failureBlock:(MQHUserManagerFailureBlock)failureBlock
{
    if (self.loading) {
        NSLog(@"Operation is already in progress!");
        return;
    }
    self.loading = YES;
    
    __typeof__(self) __weak weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *gpaFundURL = [NSString stringWithFormat:@"%@?auth_token=%@", [MQHAppManager sharedManager].gpaFundsPOSTURLString, self.user.authenticationToken];
    [manager POST:gpaFundURL
       parameters:[self preparedParametersForAddGPAFundsWithUserInfo:userInfo]
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              weakSelf.loading = NO;
              NSLog(@"Success = %@", responseObject);
              if (responseObject) {
                  if (successBlock) {
                      successBlock();
                  }
              } else {
                  NSError *error = [NSError errorWithDomain:@"com.marqeta.MQPegasus.errorDomain"
                                                       code:0
                                                   userInfo:@{ NSLocalizedDescriptionKey: @"Response object not found!" }];
                  if (failureBlock) {
                      failureBlock(error);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              weakSelf.loading = NO;
              NSLog(@"Failure = %@", error);
              if (failureBlock) {
                  failureBlock(error);
              }
          }];
}

#pragma mark Purchase Orders
- (NSDictionary *)preparedParametersForPurchaseOrderWithUserInfo:(NSDictionary *)userInfo
{
    NSDictionary *parameters = @{ @"purchase_order" :
                                      @{ @"payment_profile_id" : userInfo[@"paymentProfileID"],
                                         @"quantity" : userInfo[@"quantity"]
                                         },
                                    @"deal_id" : userInfo[@"dealID"]
                                  };
    
    return parameters;
}

- (void)purchaseOrdersWithUserInfo:(NSDictionary *)userInfo
                      successBlock:(MQHUserManagerSuccessBlock)successBlock
                      failureBlock:(MQHUserManagerFailureBlock)failureBlock
{
    if (self.loading) {
        NSLog(@"Operation is already in progress!");
        return;
    }
    self.loading = YES;
    
    __typeof__(self) __weak weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *purchaseOrderURL = [NSString stringWithFormat:@"%@?auth_token=%@", [MQHAppManager sharedManager].purchaseOrdersPOSTURLString, self.user.authenticationToken];
    [manager POST:purchaseOrderURL
       parameters:[self preparedParametersForPurchaseOrderWithUserInfo:userInfo]
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              weakSelf.loading = NO;
              NSLog(@"Success = %@", responseObject);
              if (responseObject) {
                  if (successBlock) {
                      successBlock();
                  }
              } else {
                  NSError *error = [NSError errorWithDomain:@"com.marqeta.MQPegasus.errorDomain"
                                                       code:0
                                                   userInfo:@{ NSLocalizedDescriptionKey: @"Response object not found!" }];
                  if (failureBlock) {
                      failureBlock(error);
                  }
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              weakSelf.loading = NO;
              NSLog(@"Failure = %@", error);
              if (failureBlock) {
                  failureBlock(error);
              }
          }];
}

#pragma mark Pass creation
- (void)createPassWithSuccessBlock:(MQHUserManagerSuccessBlock)successBlock
                      failureBlock:(MQHUserManagerFailureBlock)failureBlock
{
    if (self.loading) {
        NSLog(@"Operation is already in progress!");
        return;
    }
    self.loading = YES;
    
    __typeof__(self) __weak weakSelf = self;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSDictionary *parameters = @{ @"customer_id" : self.user.userID };
    NSDictionary *parameters = @{ @"customer_id" : @"1" };

    [manager POST:[MQHAppManager sharedManager].passCreatePOSTURLString
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
              NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"test.pkpass"];
              NSError *error;
              NSLog(@"path = %@", path);
              [responseObject writeToFile:path options:NSDataWritingAtomic error:&error];

              successBlock();
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              weakSelf.loading = NO;
              NSLog(@"Failure = %@", error);
              if (failureBlock) {
                  failureBlock(error);
              }
          }];
}

+ (UserManager *)sharedManager
{
    static UserManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[UserManager alloc] init];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    });
    return sharedManager;
}

@end
