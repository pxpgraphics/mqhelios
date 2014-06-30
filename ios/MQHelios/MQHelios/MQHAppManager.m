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

@implementation MQHAppManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _userCreatePOSTURLString = @"http://localhost:3000/api/mqhelios/customers";
        _paymentProfilePOSTURLString = @"http://localhost:3000/api/mqhelios/paryment_profiles";
        _marqetaCardPOSTURLString = @"http://localhost:3000/api/mqhelios/marqeta_cards";
        _gpaFundsPOSTURLString = @"http://localhost:3000/api/mqhelios/marqeta_cards";
        _purchaseOrdersPOSTURLString = @"http://localhost:3000/api/mqhelios/purchase_orders";
        _passCreatePOSTURLString = @"https://staging.marqeta.com/api/mqhelios/passes";
        _passUpdateGETURLString = @"https://staging.marqeta.com/api/mqhelios/get_updated_pass/";
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

@end
