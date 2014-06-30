//
//  SignUpViewController.h
//  MQHelios
//
//  Created by Paris Pinkney on 6/25/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GoogleMapsSuccessBlock)(NSArray *response);
typedef void (^GoogleMapsFailureBlock)(NSError *error);

@interface SignUpViewController : UITableViewController

@property (nonatomic, weak, readwrite) IBOutlet UIBarButtonItem *cancelButton;
@property (nonatomic, weak, readwrite) IBOutlet UIBarButtonItem *continueButton;

@end
