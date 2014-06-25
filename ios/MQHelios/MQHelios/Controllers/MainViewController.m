//
//  MainViewController.m
//  MQHelios
//
//  Created by Paris Pinkney on 6/24/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (nonatomic, strong, readwrite) GiftView * giftView;
@property (nonatomic, strong, readwrite) PayView * payView;
@property (nonatomic, strong, readwrite) StoresView * storesView;
@property (nonatomic, strong, readwrite) UIView *previousPopoverView;

@end

@implementation MainViewController

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

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
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

}

- (IBAction)pushToNotificationsViewController:(id)sender
{

}

- (void)presentPopoverView:(UIView *)popoverView forSender:(id)sender
{
	// Presents rounded view as popover with custom animation.
	CGSize viewSize = self.view.frame.size;
	CGFloat offsetHeight = 100.0f;
	CGRect offScreenFrame = CGRectMake(self.view.frame.origin.x,
									   viewSize.height,
									   viewSize.width,
									   viewSize.height - offsetHeight);
	popoverView.frame = offScreenFrame;

	// Add rounded corners to top of view.
	CGFloat radius = 10.0f;
	CGRect maskFrame = popoverView.bounds;
	maskFrame.size.height += radius;

	CALayer *maskLayer = [CALayer layer];
	maskLayer.backgroundColor = [UIColor blackColor].CGColor;
	maskLayer.cornerRadius = radius;
	maskLayer.frame = maskFrame;

	popoverView.layer.mask = maskLayer;

	// Hide rounded view before adding to view controller.
	popoverView.alpha = 0.0f;
	[self.view addSubview:popoverView];

	// Dismiss any other popover views.
	[self dismissViewsForPresentedPopoverView:popoverView];

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
					 } completion:nil];
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
	if (! popoverView || ![sender isKindOfClass:[UIButton class]]) {
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
									   viewSize.height,
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
	popoverView = nil;
}

@end
