//
//  MainViewController.m
//  MQHelios
//
//  Created by Paris Pinkney on 6/24/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import "MainViewController.h"
#import "UserManager.h"
#import "MQMerchantCell.h"

@interface MainViewController () <MKMapViewDelegate, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readwrite) GiftView * giftView;
@property (nonatomic, strong, readwrite) PayView * payView;
@property (nonatomic, strong, readwrite) StoresView * storesView;
@property (nonatomic, strong, readwrite) UIView *previousPopoverView;

@end

@implementation MainViewController
{
	BOOL storesIsDismissing;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	[self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];

	if ([UserManager sharedManager].user) {
		self.profileView.hidden = NO;
	} else {
//		self.profileView.hidden = YES;
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

#pragma mark - Status bar
- (UIStatusBarStyle)preferredStatusBarStyle
{
	return UIStatusBarStyleLightContent;
}

#pragma mark - Scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (storesIsDismissing) {
		return;
	}

	if ([scrollView isEqual:self.storesView.tableView]) {
		// StoresView
		CGFloat minYPosition = -scrollView.contentOffset.y;
		CGFloat offsetHeight = 100.0f;
		if (-minYPosition > 200) {
			// Make storesView fullscreen.

		} else if (minYPosition > 0) {
			// Retain mask and rounded edges on top.
			self.storesView.center = CGPointMake(self.storesView.center.x, self.view.center.y + minYPosition + (offsetHeight / 2.0f));
			[self addMaskLayerToPopoverView:self.storesView];
		} else {
			// Reset to origin frames.
			self.storesView.center = CGPointMake(self.storesView.center.x, self.view.center.y + (offsetHeight / 2.0f));
			[self addMaskLayerToPopoverView:self.storesView];
		}
	}

	if ([scrollView isEqual:self.payView.scrollView]) {
		self.payView.pageControl.currentPage = scrollView.frame.size.width /scrollView.contentOffset.x;
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	if (storesIsDismissing) {
		return;
	}

	if ([scrollView isEqual:self.storesView.tableView]) {
		// StoresView
		CGFloat minYPosition = -scrollView.contentOffset.y;
		CGFloat dragHeight = 60.0f;
		if (minYPosition > dragHeight) {
			[self dismissPopoverView:self.storesView forSender:self.storesButton];
			storesIsDismissing = YES;
		}
	}
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 10;
}

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	MQMerchantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"merchantCell" forIndexPath:indexPath];

	cell.brandNameLabel.text = @"Farley's Coffee"; // self.merchant.name;
	cell.storeAddressLabel.text = @"123 Easy Street"; // self.store.address ?: @"";
	cell.dealCountLabel.attributedText = [[NSAttributedString alloc] initWithString:@"3 offers"]; // dealCountStr;
	cell.storeCountLabel.attributedText = [[NSAttributedString alloc] initWithString:@"3 stores"];  // storeCountStr;
	cell.categoryLabel.text = @"Dining"; // self.merchant.category;
	cell.distanceLabel.text = @"0.4 mi"; // distanceStr ?: @"";

	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [MQMerchantCell height];
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (void)presentSignInViewController
{
	if (!self.signInVC) {
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
		self.signInVC = (SignInViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SignInViewControllerIdentifier"];
	}

	[self.navigationController presentViewController:self.signInVC animated:YES completion:nil];
}

- (void)presentSignUpViewController
{
	if (!self.signUpNavController) {
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
		self.signUpNavController = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"SignUpNavControllerIdentifier"];
	}

	[self.navigationController presentViewController:self.signUpNavController animated:YES completion:nil];
}

- (IBAction)presentPayPopoverController:(id)sender
{
	if (!self.payView) {
		self.payView = [[PayView alloc] init];
		self.payView.scrollView.delegate = self;
		[self.payView.pageControl addTarget:self
									 action:@selector(cardViewDidChange)
						   forControlEvents:UIControlEventValueChanged];

		[self.payView.payButton addTarget:self
								   action:@selector(presentPayViewController:)
						 forControlEvents:UIControlEventTouchUpInside];
	}
	[self presentPopoverView:self.payView forSender:sender];
}

- (IBAction)presentStoresPopoverController:(id)sender
{
	if (!self.storesView) {
		self.storesView = [[StoresView alloc] init];
		self.storesView.mapView.delegate = self;
		self.storesView.tableView.dataSource = self;
		self.storesView.tableView.delegate = self;

		[self.storesView.tableView registerClass:[MQMerchantCell class]
						  forCellReuseIdentifier:@"merchantCell"];
	}
	[self presentPopoverView:self.storesView forSender:sender];
}

- (IBAction)presentGiftPopoverController:(id)sender
{
    if (!self.giftView) {
        self.giftView = [[GiftView alloc] init];
    }
    [self presentPopoverView:self.giftView forSender:sender];
}

- (void)presentPayViewController:(id)sender
{
	if (!self.payNavController) {
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
		self.payNavController = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"PayNavControllerIdentifier"];
	}

	if (self.payView.pageControl.currentPage == 0) {
		self.payView.pageControl.currentPage = 1;
		[self cardViewDidChange];
	}

	[self.navigationController presentViewController:self.payNavController animated:NO completion:^{
		self.payNavController.view.alpha = 0.0f;
		[UIView animateWithDuration:0.6 animations:^{
			self.payNavController.view.alpha = 1.0f;
		}];
	}];
}

- (IBAction)pushToSettingsViewController:(id)sender
{
    [[UserManager sharedManager] createPassWithSuccessBlock:^{
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        //2
        NSString* passFile = [documentsDirectory stringByAppendingPathComponent:@"test.pkpass"];
        
        //3
        NSData *passData = [NSData dataWithContentsOfFile:passFile];
        //4
        NSError* error = nil;
        PKPass *newPass = [[PKPass alloc] initWithData:passData
                                                 error:&error];
        
        NSLog(@"newpass %@ error %@", newPass, error);
        
        //5
        if (error!=nil) {
            [[[UIAlertView alloc] initWithTitle:@"Error"
                                        message:[error
                                                 localizedDescription]
                                       delegate:nil
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles: nil] show];
            return;
        }
        
        NSLog(@"newpass = %@", newPass);
        //6
        PKAddPassesViewController *addController =
        [[PKAddPassesViewController alloc] initWithPass:newPass];
        
        [self presentViewController:addController
                           animated:YES
                         completion:nil];
        
        
    } failureBlock:^(NSError *error) {
        
        
    }];
}

- (IBAction)pushToNotificationsViewController:(id)sender
{

}

- (void)presentPopoverView:(UIView *)popoverView forSender:(id)sender
{
	// Dismiss any other popover views.
	[self dismissViewsForPresentedPopoverView:popoverView];

	// Presents rounded view as popover with custom animation.
	CGSize viewSize = self.view.frame.size;
	CGFloat offsetHeight = 100.0f;
	CGRect offScreenFrame = CGRectMake(self.view.frame.origin.x,
									   viewSize.height,
									   viewSize.width,
									   viewSize.height - offsetHeight);
	popoverView.frame = offScreenFrame;
	[self addMaskLayerToPopoverView:popoverView];

	// Hide rounded view before adding to view controller.
	popoverView.alpha = 0.0f;
	[self.view addSubview:popoverView];

	// Dismiss popover when the sender is tapped again.
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopoverView:)];
	[sender addGestureRecognizer:tap];

	[UIView animateWithDuration:1.0
						  delay:0.0
		 usingSpringWithDamping:0.7f
		  initialSpringVelocity:1.2f
						options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
						 popoverView.alpha = 1.0f;
						 popoverView.center = CGPointMake(popoverView.center.x, self.view.center.y + (offsetHeight / 2.0f));
						 self.previousPopoverView = popoverView;
					 } completion:^(BOOL finished) {
						 [self addActionsForButtonsInPopoverView:popoverView];
					 }];
}

- (void)addMaskLayerToPopoverView:(UIView*)popoverView
{
	// Add rounded corners to top of view.
	CGFloat radius = 10.0f;
	CGRect maskFrame = popoverView.bounds;
	maskFrame.size.height += radius;

	CALayer *maskLayer = [CALayer layer];
	maskLayer.backgroundColor = [UIColor blackColor].CGColor;
	maskLayer.cornerRadius = radius;
	maskLayer.frame = maskFrame;

	popoverView.layer.mask = maskLayer;
}

- (void)addActionsForButtonsInPopoverView:(UIView *)popoverView
{
	if ([popoverView isEqual:self.payView]) {
		// PayView.
		[self.payView.signInButton addTarget:self action:@selector(presentSignInViewController) forControlEvents:UIControlEventTouchUpInside];
		[self.payView.signUpButton addTarget:self action:@selector(presentSignUpViewController) forControlEvents:UIControlEventTouchUpInside];
	} else if ([popoverView isEqual:self.giftView])	{
		// GiftView.
		[self.giftView.signInButton addTarget:self action:@selector(presentSignInViewController) forControlEvents:UIControlEventTouchUpInside];
		[self.giftView.signUpButton addTarget:self action:@selector(presentSignUpViewController) forControlEvents:UIControlEventTouchUpInside];
	}
}

- (void)dismissViewsForPresentedPopoverView:(UIView *)popoverView
{
	if ([popoverView isEqual:self.payView]) {
		// PayView.
		[self dismissPopoverView:self.storesView forSender:self.storesButton];
		[self dismissPopoverView:self.giftView forSender:self.giftButton];
	} else if ([popoverView isEqual:self.storesView]) {
		// StoresView.
		[self dismissPopoverView:self.payView forSender:self.payButton];
		[self dismissPopoverView:self.giftView forSender:self.giftButton];
	} else if ([popoverView isEqual:self.giftView])	{
		// GiftView.
		[self dismissPopoverView:self.payView forSender:self.payButton];
		[self dismissPopoverView:self.storesView forSender:self.storesButton];
	}
}

- (void)dismissPopoverView:(UIGestureRecognizer *)gestureRecognizer
{
	UIButton *button = (UIButton *)gestureRecognizer.view;
	if (!button) {
		return;
	}

	UIView *view;
	if ([button isEqual:self.payButton]) {
		view = self.payView;
	} else if ([button isEqual:self.storesButton]) {
		view = self.storesView;
	} else if ([button isEqual:self.giftButton]) {
		view = self.giftView;
	}

	if (!view) {
		return;
	}

	[self dismissPopoverView:view
				   forSender:button];
}

- (void)dismissPopoverView:(UIView *)popoverView forSender:(id)sender
{
	if (!popoverView || ![sender isKindOfClass:[UIButton class]]) {
		return;
	}

	UIButton *button = (UIButton *)sender;
	for (UIGestureRecognizer *tap in button.gestureRecognizers) {
		[button removeGestureRecognizer:tap];
	}

	// Dismiss with custom animation.
	CGSize viewSize = self.view.frame.size;
	CGFloat offsetHeight = 100.0f;
	CGRect offScreenFrame = CGRectMake(self.view.frame.origin.x,
									   viewSize.height + (offsetHeight / 2.0f),
									   viewSize.width,
									   viewSize.height - offsetHeight);

	[UIView animateWithDuration:0.6
						  delay:0.0
		 usingSpringWithDamping:1.0f
		  initialSpringVelocity:1.2f
						options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
						 popoverView.frame = offScreenFrame;

					 } completion:^(BOOL finished) {
						 [popoverView removeFromSuperview];
						 [self deallocPopoverView:popoverView];
					 }];
}

- (void)deallocPopoverView:(UIView *)popoverView
{
	if ([popoverView isEqual:self.storesView]) {
		storesIsDismissing = NO;
	}
	popoverView = nil;
}

- (void)cardViewDidChange
{
	CGFloat xOffset = self.payView.scrollView.frame.size.width * self.payView.pageControl.currentPage;
	[UIView animateWithDuration:0.6
						  delay:0.0
		 usingSpringWithDamping:0.5f
		  initialSpringVelocity:1.2f
						options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
						 self.payView.scrollView.contentOffset = CGPointMake(xOffset, self.payView.scrollView.contentOffset.y);
					 } completion:nil];
}

@end
