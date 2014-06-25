//
//  StoresView.h
//  MQHelios
//
//  Created by Paris Pinkney on 6/24/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface StoresView : UIView

@property (nonatomic, readonly, strong) MKMapView *mapView;
@property (nonatomic, readonly, strong) UITableView *tableView;

@end
