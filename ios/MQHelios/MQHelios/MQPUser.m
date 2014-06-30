//
//  MQPUser.m
//  MQHelios
//
//  Created by Zack Thar on 6/24/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import "MQPUser.h"

@implementation MQPUser

+ (id)initWithJSONData:(NSDictionary *)data
{
    return [[MQPUser alloc] initWithJSONData:data];
}

- (id)initWithJSONData:(NSDictionary *)data
{
    if (self = [super init]) {
		_authenticationToken = data[@"token"];
		_userID = data[@"customer"][@"id"];
		_salutation = data[@"customer"][@"salutation"];
		_firstName = data[@"customer"][@"first_name"];
		_lastName = data[@"customer"][@"last_name"];
		if ([_salutation isKindOfClass:[NSNull class]]) {
			_gender = nil;
		} else if ([_salutation isEqualToString:@"Mr."]) {
			_gender = @"Male";
		} else {
			_gender = @"Female";
		}
		_nationality = nil;
		_photoPath = data[@"customer"][@"customer_photo"][@"customer_photo"][@"url"];
		NSDateFormatter *dateFormatter = [MQHAppManager stringToDateFormatterWithDateFormat:@"yyyy-MM-dd"];
		_dateOfBirth = [dateFormatter dateFromString:data[@"customer"][@"birthday"]];
		_addressLineOne = data[@"customer"][@"address"];
		_addressLineTwo = data[@"customer"][@"address_line_two"];
		_city = data[@"customer"][@"city"];
		_state = data[@"customer"][@"state"];
		_zip = data[@"customer"][@"zip"];
		_country = nil;
		_mobile = data[@"customer"][@"mobile_phone"];
		_phone = data[@"customer"][@"phone"];
		_email = data[@"customer"][@"email"];
    }
    return self;
}

@end
