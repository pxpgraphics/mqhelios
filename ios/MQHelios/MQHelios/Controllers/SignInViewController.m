//
//  SignInViewController.m
//  MQHelios
//
//  Created by Paris Pinkney on 6/25/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import "SignInViewController.h"
#import "UserManager.h"

@interface SignInViewController () <UITextFieldDelegate>

@end

@implementation SignInViewController

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
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];

	[[self view] endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
	
}

- (IBAction)signInUser:(id)sender
{
	if (!self.usernameTextField.text || !self.passwordTextField.text) {
		return;
	}

	[self.view endEditing:YES];

	NSDictionary *userInfo = @{ @"email": [self.usernameTextField.text copy],
								@"password": [self.passwordTextField.text copy] };

	__typeof__(self) __weak weakSelf = self;
	[[UserManager sharedManager] loginUserWithUserInfo:userInfo successBlock:^{
		MQPUser *user = [UserManager sharedManager].user;
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults setObject:user.authenticationToken forKey:@"authenticationToken"];
		[defaults setObject:user.email forKey:@"email"];
		[defaults setObject:userInfo[@"password"] forKey:@"password"];
		[defaults synchronize];
		[weakSelf dismissViewControllerAnimated:YES completion:nil];
	} failureBlock:^(NSError *error) {
		[[[UIAlertView alloc] initWithTitle:@"Log In Failed"
									message:error.localizedDescription
								   delegate:nil
						  cancelButtonTitle:@"OK"
						  otherButtonTitles:nil] show];
	}];
}

@end
