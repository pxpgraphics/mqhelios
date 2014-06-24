//
//  MapViewController.h
//  MQHelios
//
//  Created by Paris Pinkney on 6/24/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

extern NSString * const kMapViewDidFinishLoadingNotification;

@interface MapViewController : UIViewController

@property (nonatomic, weak) id delegate; // TODO: Add MerchantSelectedDelegate

@property (nonatomic, strong, readonly) MKMapView *mapView;
@property (nonatomic, weak) NSArray *deals;
@property (nonatomic, weak) NSArray *merchants;
@property (nonatomic, assign, getter=isMapFinishedLoading) BOOL mapIsFinishedLoading;
@property (nonatomic, assign, getter=areMapAnnotationsFinishedLoading) BOOL mapAnnotationsAreFinishedLoading;

- (void)panMapViewToCurrentLocation;
- (void)zoomMapViewToCurrentLocation;

@end
