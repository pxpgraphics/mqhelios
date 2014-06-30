//
//  CardViewController.h
//  MQHelios
//
//  Created by Paris Pinkney on 6/30/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardViewControllerProtocol

- (void)createPass;

@end

@interface CardViewController : UITableViewController

@property (nonatomic, weak) id <CardViewControllerProtocol> delegate;
@property (nonatomic, weak, readwrite) IBOutlet UIBarButtonItem *cancelButton;
@property (nonatomic, weak, readwrite) IBOutlet UIBarButtonItem *addButton
;

@end
