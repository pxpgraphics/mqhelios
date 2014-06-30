//
//  MQHAppManager.m
//  MQHelios
//
//  Created by Paris Pinkney on 6/23/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import "MQHAppManager.h"

NSString * const kParseApplicationIDKey = @"E9TblQR0pTlXst1UmxW0xnlOm212b9iK1H3r6Cs6";
NSString * const kParseClientKey = @"Tf81iHu6PeoWZMPd4GT5Mt3IBwQ0mdcJaA36hPAP";
NSString * const kParseJavascriptKey = @"2JXncVhYaUVcGnp2iLK0NnOJoqSFizToN25APYsv";
NSString * const kParseNETKey = @"9j8Twrdymt4kvUzcC5xFOZTYVrtS2NnBeez990m1";
NSString * const kParseRESTAPIKey = @"Z2084OY5D03Ic4J6CXNzskYgZUING3Rn4WkdUv5D";
NSString * const kParseMasterKey = @"Pc5WlcXgXToIYfienQNfGdcJ3zpiwWxg6KATtd5g";

// Date Formatter
NSString * const VLNRDateFormatterStringToDateKey = @"VLNRDateFormatterStringToDateKey";
NSString * const VLNRDateFormatterDateToStringKey = @"VLNRDateFormatterDateToStringKey";

@implementation MQHAppManager

- (instancetype)init
{
    self = [super init];
    if (self) {
		_userAuthGETURLString = @"https://staging.marqeta.com/api/v1/customer_auth_token";
        _userCreatePOSTURLString = @"https://staging.marqeta.com/api/mqhelios/customers";
        _paymentProfilePOSTURLString = @"https://staging.marqeta.com/api/mqhelios/payment_profiles";
        _marqetaCardPOSTURLString = @"https://staging.marqeta.com/api/mqhelios/marqeta_cards";
        _gpaFundsPOSTURLString = @"https://staging.marqeta.com/api/mqhelios/marqeta_cards";
        _purchaseOrdersPOSTURLString = @"https://staging.marqeta.com/api/mqhelios/purchase_orders";
        _passCreatePOSTURLString = @"https://staging.marqeta.com/api/mqhelios/passes";
    }
    return self;
}

+ (MQHAppManager *)sharedManager
{
    static MQHAppManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[MQHAppManager alloc] init];
    });
    return sharedManager;
}

+ (NSDateFormatter *)dateToStringFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle
{
	// Create a thread-safe date formatter.
	NSMutableDictionary *threadDictionary = [NSThread currentThread].threadDictionary;
	NSDateFormatter *dateFormatter = [threadDictionary objectForKey:VLNRDateFormatterDateToStringKey];
	if (!dateFormatter) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle:dateStyle];
		[threadDictionary setObject:dateFormatter forKey:VLNRDateFormatterDateToStringKey];
	}
	[dateFormatter setDateStyle:dateStyle];
	return dateFormatter;
}

+ (NSDateFormatter *)stringToDateFormatter
{
	// Create a thread-safe date formatter.
	NSMutableDictionary *threadDictionary = [NSThread currentThread].threadDictionary;
	NSDateFormatter *dateFormatter = [threadDictionary objectForKey:VLNRDateFormatterStringToDateKey];
	if (!dateFormatter) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
		[threadDictionary setObject:dateFormatter forKey:VLNRDateFormatterStringToDateKey];
	}
	return dateFormatter;
}

+ (NSDateFormatter *)stringToDateFormatterWithDateFormat:(NSString *)dateFormat
{
	// Create a thread-safe date formatter.
	NSMutableDictionary *threadDictionary = [NSThread currentThread].threadDictionary;
	NSDateFormatter *dateFormatter = [threadDictionary objectForKey:VLNRDateFormatterStringToDateKey];
	if (!dateFormatter) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:dateFormat];
		[threadDictionary setObject:dateFormatter forKey:VLNRDateFormatterStringToDateKey];
	}
	return dateFormatter;
}

@end
