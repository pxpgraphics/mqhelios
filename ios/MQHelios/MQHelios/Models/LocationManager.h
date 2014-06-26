//
//  LocationManager.h
//  MQHelios
//
//  Created by Paris Pinkney on 6/25/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationManagerDelegate <NSObject>
/**
 Implement this delegate method to forward this location to the appropriate protocol.

 @param location The location which was updated by the manager.
 */

- (void)locationManagerDidUpdateLocation:(CLLocation *)location;

@end

@interface LocationManager : NSObject

@property (nonatomic, weak) id<LocationManagerDelegate>delegate;
@property (nonatomic, readwrite, strong) CLLocationManager *locationManager;
@property (nonatomic, readwrite, strong) CLLocation *location;
@property (nonatomic) double distanceBeforeUpdate;

+ (LocationManager *)sharedManager;

@end