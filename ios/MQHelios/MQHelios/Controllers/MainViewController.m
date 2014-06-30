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
@property (nonatomic, strong) PKPass *userPass;

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
	if (![scrollView isEqual:self.storesView.tableView] || storesIsDismissing) {
		return;
	}

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

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	CGFloat minYPosition = -scrollView.contentOffset.y;
	CGFloat dragHeight = 60.0f;
	if (minYPosition > dragHeight) {
		[self dismissPopoverView:self.storesView forSender:self.storesButton];
		storesIsDismissing = YES;
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

- (IBAction)pushToSettingsViewController:(id)sender
{
    [[UserManager sharedManager] createPassWithSuccessBlock:^{
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString* passFile = [documentsDirectory stringByAppendingPathComponent:@"test.pkpass"];
        
        NSData *passData = [NSData dataWithContentsOfFile:passFile];
        NSError* error = nil;
        self.userPass = [[PKPass alloc] initWithData:passData
                                                 error:&error];
        
        PKPassLibrary *passLibrary = [[PKPassLibrary alloc] init];
        NSLog(@"passes = %@",[passLibrary passes]);
        if ([passLibrary containsPass:self.userPass]) {
            NSLog(@"Contains pass!!!");
        }
        
        NSLog(@"newpass %@ error %@", self.userPass, error);
        
        if (error!=nil) {
            [[[UIAlertView alloc] initWithTitle:@"Error"
                                        message:[error
                                                 localizedDescription]
                                       delegate:nil
                              cancelButtonTitle:@"Okay"
                              otherButtonTitles: nil] show];
            return;
        }
        
        NSLog(@"newpass = %@", self.userPass);
        PKAddPassesViewController *addController =
        [[PKAddPassesViewController alloc] initWithPass:self.userPass];
        
        [self presentViewController:addController
                           animated:YES
                         completion:nil];
        
        
    } failureBlock:^(NSError *error) {
        
        
    }];
}

- (IBAction)pushToNotificationsViewController:(id)sender
{
    [[UserManager sharedManager] passUpdateForPassWithPassSerialID:self.userPass.serialNumber successBlock:^{
        NSLog(@"SUCCESS updating!!!");
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString* passFile = [documentsDirectory stringByAppendingPathComponent:@"test.pkpass"];
        
        NSData *passData = [NSData dataWithContentsOfFile:passFile];
        NSError* error = nil;

        self.userPass = [[PKPass alloc] initWithData:passData
                                               error:&error];
        
        PKPassLibrary *passLibrary = [[PKPassLibrary alloc] init];
        NSLog(@"passes = %@",[passLibrary passes]);
        if ([passLibrary containsPass:self.userPass]) {
            NSLog(@"Contains pass!!!");
            [passLibrary replacePassWithPass:self.userPass];
            [[[UIAlertView alloc] initWithTitle:@"Pass updated!"
                                        message:@"Pass updated with balance: $15.00"
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        } else {
            NSLog(@"Doesn't contain pass =(");
        }
    } failureBlock:^(NSError *error) {

        
    }];
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

@end
