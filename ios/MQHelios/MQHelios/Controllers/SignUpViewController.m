//
//  SignUpViewController.m
//  MQHelios
//
//  Created by Paris Pinkney on 6/25/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController () <UITextFieldDelegate>

@property (nonatomic, strong, readwrite) NSMutableDictionary *dataSource;

@end

@implementation SignUpViewController
{
	BOOL birthdayCellActive;
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

	birthdayCellActive = NO;

	// Uncomment the following line to preserve selection between presentations.
	// self.clearsSelectionOnViewWillAppear = NO;

	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	// self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
	return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// Return the number of rows in the section.
	switch (section) {
		case 0:
		case 2:
		case 4:
			return 2;
			break;
		case 1:
			return 1;
			break;
		case 3:
			if (birthdayCellActive) {
				return 2;
			} else {
				return 1;
			}
  default:
			return 0;
			break;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UIDatePicker *datePicker;
	UITableViewCell *cell;
	UITableViewCell *textCell;
	UITableViewCell *emailCell;
	UITableViewCell *passwordCell;
	UITableViewCell *birthdayCell;
	UITableViewCell *pickerCell;
	UITextField *textField;

	NSUInteger row = indexPath.row;
	NSUInteger section = indexPath.section;
	switch (section) {
		case 0:
			textCell = [tableView dequeueReusableCellWithIdentifier:@"textCell" forIndexPath:indexPath];
			textCell.selectionStyle = UITableViewCellSelectionStyleNone;
			textField = (UITextField *)[textCell viewWithTag:100];
			if (row == 0) {
				// First name.
				textField.placeholder = @"first name";
			} else {
				// Last name.
				textField.placeholder = @"last name";
			}
			cell = textCell;
			break;
		case 1:
			emailCell = [tableView dequeueReusableCellWithIdentifier:@"emailCell" forIndexPath:indexPath];
			emailCell.selectionStyle = UITableViewCellSelectionStyleNone;
			textField = (UITextField *)[emailCell viewWithTag:100];
			// Email.
			textField.placeholder = @"email@example.com";
			cell = emailCell;
			break;
		case 2:
			passwordCell = [tableView dequeueReusableCellWithIdentifier:@"passwordCell" forIndexPath:indexPath];
			passwordCell.selectionStyle = UITableViewCellSelectionStyleNone;
			textField = (UITextField *)[passwordCell viewWithTag:100];
			if (row == 0) {
				// Password.
				textField.placeholder = @"password";
			} else {
				// Confirm password.
				textField.placeholder = @"confirm password";
			}
			cell = passwordCell;
			break;
		case 3:
			if (row == 0) {
				birthdayCell = [tableView dequeueReusableCellWithIdentifier:@"birthdayCell" forIndexPath:indexPath];
				// Birthday.
				birthdayCell.textLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:14.0f];
				birthdayCell.textLabel.text = @"birthday";
				cell = birthdayCell;
			} else {
				pickerCell = [tableView dequeueReusableCellWithIdentifier:@"pickerCell" forIndexPath:indexPath];
				datePicker = (UIDatePicker *)[pickerCell viewWithTag:100];
				// Date picker.

				cell = pickerCell;
			}
			break;
		case 4:
			textCell = [tableView dequeueReusableCellWithIdentifier:@"textCell" forIndexPath:indexPath];
			textCell.selectionStyle = UITableViewCellSelectionStyleNone;
			textField = (UITextField *)[textCell viewWithTag:100];
			if (row == 0) {
				// Street address.
				textField.placeholder = @"street address";
			} else {
				// Zip code.
				textField.placeholder = @"zip code";
			}
			cell = textCell;
			break;
	}
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSUInteger row = indexPath.row;
	NSUInteger section = indexPath.section;
	if (section == 3 && row == 1) {
		return 162.0f;
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
			if (row == 0) {
				// First name.

			} else {
				// Last name.

			}
			break;
		case 1:
			// Email.

			break;
		case 2:
			if (row == 0) {
				// Password.

			} else {
				// Confirm password.

			}
			break;
		case 3:
			// Birthday.
			if (row == 0 && birthdayCellActive) {
				// Hide date picker.
				birthdayCellActive = NO;
				[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
			} else if (row == 0) {
				// Show date picker.
				birthdayCellActive = YES;
				[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
			} else {
				// Date picker selected.

			}
			break;
		case 4:
			if (row == 0) {
				// Street address.

			} else {
				// Zip code.

			}
			break;
	}
	[textField becomeFirstResponder];
}

#pragma mark - Text field delegate


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
	
}

@end
