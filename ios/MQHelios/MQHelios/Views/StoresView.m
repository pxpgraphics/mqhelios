//
//  StoresView.m
//  MQHelios
//
//  Created by Paris Pinkney on 6/24/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import "StoresView.h"

@interface StoresView ()

@property (nonatomic, readwrite, strong) MKMapView *mapView;
@property (nonatomic, readwrite, strong) UITableView *tableView;

@end

@implementation StoresView

- (instancetype)init
{
	if (self = [super init]) {
		_mapView = [[MKMapView alloc] init];
		_mapView.userTrackingMode = MKUserTrackingModeFollow;

		_tableView = [[UITableView alloc] init];
		_tableView.tableHeaderView = _mapView;
		[self addSubview:_tableView];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];

	CGRect bounds = self.bounds;

	_mapView.frame = CGRectMake(0.0f, 0.0f, bounds.size.width, 200.0f);
	_tableView.frame = self.layer.mask.bounds;
}

@end
