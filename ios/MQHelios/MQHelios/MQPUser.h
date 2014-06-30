//
//  MQPUser.h
//  MQHelios
//
//  Created by Zack Thar on 6/24/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MQPUser : NSObject

@property (nonatomic, strong) NSString *authenticationToken;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *salutation;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *nationality;
@property (nonatomic, strong) NSString *photoPath;
@property (nonatomic, strong) NSDate *dateOfBirth;

@property (nonatomic, strong) NSString *addressLineOne;
@property (nonatomic, strong) NSString *addressLineTwo;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zip;
@property (nonatomic, strong) NSString *country;

@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *email;

+ (id)initWithJSONData:(NSDictionary *)jsonData;

@end
