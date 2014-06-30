//
//  CardViewController.m
//  MQHelios
//
//  Created by Paris Pinkney on 6/30/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import "CardViewController.h"

@interface CardViewController ()

@property (nonatomic, strong, readwrite) NSMutableDictionary *dataSource;

@end

@implementation CardViewController

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

#pragma mark - Lazy loading
- (NSMutableDictionary *)dataSource
{
	if (!_dataSource) {
		_dataSource = [[NSMutableDictionary alloc] initWithCapacity:7];
	}
	return _dataSource;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	// Return the number of sections.
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == 0) {
		return 4;
	} else {
		return 1;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;
	UITableViewCell *textCell;
	UITextView *textView;
	UITextField *textField;

	NSUInteger row = indexPath.row;
	NSUInteger section = indexPath.section;

	switch (section) {
	  case 0:
		{
			textCell = [tableView dequeueReusableCellWithIdentifier:@"textCell" forIndexPath:indexPath];
			textCell.selectionStyle = UITableViewCellSelectionStyleNone;
			textField = (UITextField *)[textCell viewWithTag:100];
			if (row == 0) {
				// Card number.
				textField.placeholder = @"1234 5678 9012 3456";
			} else if (row == 1) {
				// Exp month.
				textField.placeholder = @"MM";
			} else if (row == 2) {
				// Exp year.
				textField.placeholder = @"YY";
			} else if (row == 3) {
				// CVV.
				textField.placeholder = @"CVV";
			}
			cell = textCell;
			break;
		}
		case 1:
		{
			textCell = [tableView dequeueReusableCellWithIdentifier:@"textViewCell" forIndexPath:indexPath];
			textCell.selectionStyle = UITableViewCellSelectionStyleNone;
			textView = (UITextView *)[textCell viewWithTag:100];
			textView.editable = NO;
			MQPUser *user = [UserManager sharedManager].user;
			textView.text = [NSString stringWithFormat:@"%@ %@\n158 Brighton Avenue\nOakland\nCA\n94602", user.firstName, user.lastName];
			// Billing address.
			cell = textCell;
			break;
		}
	  default:
			break;
	}
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSUInteger section = indexPath.section;
	if (section == 1) {
		return 142.0f;
	} else {
		return 44.0f;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSUInteger row = indexPath.row;
	NSUInteger section = indexPath.section;
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	UITextField *textField = (UITextField *)[cell viewWithTag:100];
	switch (section) {
	  case 0:
		{
			if (row == 0) {
				// Card number.
				[self.dataSource setValue:textField.text forKey:@"number"];
			} else if (row == 1) {
				// Exp month.
				[self.dataSource setValue:textField.text forKey:@"month"];
			} else if (row == 2) {
				// Exp year.
				[self.dataSource setValue:textField.text forKey:@"year"];
			} else if (row == 3) {
				// CVV.
				[self.dataSource setValue:textField.text forKey:@"cvv"];
			}
			break;
		}
	  case 1:
			return;
			break;
	}

	NSLog(@"%@", textField.text);
}

#pragma mark - Text field delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	[self selectTableViewCellWithTextfield:textField];
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
	[self selectTableViewCellWithTextfield:textField];
	return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.

}

- (void)selectTableViewCellWithTextfield:(UITextField *)textField
{
	if ([textField.superview.superview isKindOfClass:[UITableViewCell class]]) {
		UITableViewCell *cell = (UITableViewCell *)textField.superview.superview;
		NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
		[self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
	}
}

- (IBAction)addCard:(id)sender
{
	[self.view endEditing:YES];

	if (self.dataSource.count < 4) {
		return;
	}

	/* Real call.
	MQPUser *user = [UserManager sharedManager].user;
	NSMutableDictionary *userInfo =[NSMutableDictionary dictionaryWithObjectsAndKeys:
									user.firstName ?: [NSNull null], @"firstName",
									user.lastName ?: [NSNull null], @"lastName",
									@"158 Brighton Avenue", @"addressLineOne",
									@"Oakland", @"city",
									@"CA", @"state",
									@"94602", @"zip",
//									user.addressLineOne ?: [NSNull null], @"addressLineOne",
//									user.city ?: [NSNull null], @"city",
//									user.state ?: [NSNull null], @"state",
//									user.zip ?: [NSNull null], @"zip",
									@"378282246310005", @"number",
//									self.dataSource[@"number"] ?: [NSNull null], @"number",
									self.dataSource[@"month"] ?: [NSNull null], @"month",
									self.dataSource[@"year"] ?: [NSNull null], @"year",
									self.dataSource[@"cvv"] ?: [NSNull null], @"cvv",
									nil];

	NSArray *keys = [[userInfo copy] allKeysForObject:[NSNull null]];
	for (id key in keys) {
		[userInfo removeObjectForKey:key];
	}

	__typeof__(self) __weak weakSelf = self;
	[[UserManager sharedManager] createPaymentProfileWithUserInfo:[userInfo copy] successBlock:^{
		NSLog(@"Sucess!!!!");
	} failureBlock:^(NSError *error) {
		[[[UIAlertView alloc] initWithTitle:@"Card Failed"
									message:error.localizedDescription
								   delegate:nil
						  cancelButtonTitle:@"OK"
						  otherButtonTitles:nil] show];
	}];
	 */
}

@end
