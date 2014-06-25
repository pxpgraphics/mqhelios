//
//  LocationManager.m
//  MQHelios
//
//  Created by Paris Pinkney on 6/25/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager () <CLLocationManagerDelegate>

@property (nonatomic, readwrite, strong) NSMutableArray *observers;

@end

@implementation LocationManager

+ (LocationManager *)sharedManager
{
	static LocationManager *sharedManager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedManager = [[LocationManager alloc] init];
	});

	return sharedManager;
}

- (id)init
{
	if (self = [super init]) {
		_locationManager = [[CLLocationManager alloc] init];
		_locationManager.delegate = self;
		_locationManager.desiredAccuracy = kCLLocationAccuracyBest;
		_locationManager.distanceFilter = kCLDistanceFilterNone;
		_locationManager.headingFilter = kCLHeadingFilterNone;

		[_locationManager startUpdatingLocation];
	}

	return self;
}

#pragma mark - Location manager delegate
- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations
{
	CLLocation *location = [locations lastObject];
	if (location) {
		[self setLocation:location];
		[self.delegate locationManagerDidUpdateLocation:location];
	}
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{
	NSLog(@"Location Manager did fail with error: %@", error);
}

@end