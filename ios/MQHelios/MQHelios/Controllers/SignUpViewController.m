//
//  SignUpViewController.m
//  MQHelios
//
//  Created by Paris Pinkney on 6/25/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import "SignUpViewController.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "UserManager.h"

static NSString *googleMapsResultsKey = @"results";
static NSString *googleMapsAddressComponentsKey = @"address_components";
static NSString *googleMapsAdministrativeAreaKey = @"administrative_area_level_1";
static NSString *googleMapsLocalityKey = @"locality";
static NSString *googleMapsLongNameKey = @"long_name";
static NSString *googleMapsShortNameKey = @"short_name";
static NSString *googleMapsTypesKey = @"types";

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
				NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
				[dateFormatter setDateFormat:@"yyyy-MM-dd"];
				NSDate *date = [dateFormatter dateFromString:self.dataSource[@"birthday"]];
				[dateFormatter setDateStyle:NSDateFormatterLongStyle];
				birthdayCell.textLabel.text = [dateFormatter stringFromDate:date] ?: @"birthday";
				cell = birthdayCell;
			} else {
				pickerCell = [tableView dequeueReusableCellWithIdentifier:@"pickerCell" forIndexPath:indexPath];
				datePicker = (UIDatePicker *)[pickerCell viewWithTag:100];
				// Date picker.
				[datePicker addTarget:self action:@selector(saveBirthday:) forControlEvents:UIControlEventValueChanged];
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
				[self.dataSource setValue:textField.text forKey:@"firstName"];
			} else {
				// Last name.
				[self.dataSource setValue:textField.text forKey:@"lastName"];
			}
			break;
		case 1:
			// Email.
			[self.dataSource setValue:textField.text forKey:@"email"];
			break;
		case 2:
			if (row == 0) {
				// Password.
				[self.dataSource setValue:textField.text forKey:@"password"];
			} else if (row == 1) {
				// Confirm password.
				if (![self.dataSource[@"password"] isEqualToString:textField.text]) {
					[self.dataSource removeObjectForKey:@"password"];
				}
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
				[self.dataSource setValue:textField.text forKey:@"addressLineOne"];
			} else {
				// Zip code.
				[self.dataSource setValue:textField.text forKey:@"zip"];
			}
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

- (void)saveBirthday:(id)sender
{
	if (![sender isKindOfClass:[UIDatePicker class]]) {
		return;
	}
	UIDatePicker *datePicker = (UIDatePicker *)sender;
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	[self.dataSource setValue:[dateFormatter stringFromDate:datePicker.date] forKey:@"birthday"];
	if ([datePicker.superview.superview isKindOfClass:[UITableViewCell class]]) {
		UITableViewCell *cell = (UITableViewCell *)datePicker.superview.superview;
		NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
		indexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
		cell = [self.tableView cellForRowAtIndexPath:indexPath];
		[dateFormatter setDateStyle:NSDateFormatterLongStyle];
		[dateFormatter setDateFormat:nil];
		cell.textLabel.text = [dateFormatter stringFromDate:datePicker.date];
	}
}

- (IBAction)signUpUser:(id)sender
{
	[self.view endEditing:YES];

	if (self.dataSource.count < 6) {
		return;
	}

	__typeof__(self) __weak weakSelf = self;
	[self fetchFullAddressFromGoogleMapsWithSuccessBlock:^(NSArray *response) {
		[weakSelf.dataSource setValue:response[0][@"short_name"] forKey:@"zip"];
		[weakSelf.dataSource setValue:response[1][@"short_name"] forKey:@"city"];
		[weakSelf.dataSource setValue:response[3][@"short_name"] forKey:@"state"];

		NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:
										 weakSelf.dataSource[@"firstName"] ?: [NSNull null], @"firstName",
										 weakSelf.dataSource[@"lastName"] ?: [NSNull null], @"lastName",
										 weakSelf.dataSource[@"gender"] ?: [NSNull null], @"gender",
										 weakSelf.dataSource[@"birthday"] ?: [NSNull null], @"birthday",
										 weakSelf.dataSource[@"email"] ?: [NSNull null], @"email",
										 weakSelf.dataSource[@"password"] ?: [NSNull null], @"password",
										 weakSelf.dataSource[@"phone"] ?: [NSNull null], @"phone",
										 weakSelf.dataSource[@"mobile_phone"] ?: [NSNull null], @"mobile_phone",
										 weakSelf.dataSource[@"addressLineOne"] ?: [NSNull null], @"addressLineOne",
										 weakSelf.dataSource[@"city"] ?: [NSNull null], @"city",
										 weakSelf.dataSource[@"state"] ?: [NSNull null], @"state",
										 weakSelf.dataSource[@"zip"] ?: [NSNull null], @"zip",
										 nil];

		NSArray *keys = [[userInfo copy] allKeysForObject:[NSNull null]];
		for (id key in keys) {
			[userInfo removeObjectForKey:key];
		}

		[[UserManager sharedManager] registerUserWithUserInfo:[userInfo copy] successBlock:^{
			MQPUser *user = [UserManager sharedManager].user;
			NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
			[defaults setObject:user.authenticationToken forKey:@"authenticationToken"];
			[defaults setObject:user.email forKey:@"email"];
			[defaults setObject:weakSelf.dataSource[@"password"] forKey:@"password"];
			[defaults synchronize];
			[weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
		} failureBlock:^(NSError *error) {
			[[[UIAlertView alloc] initWithTitle:@"Log In Failed"
										message:error.localizedDescription
									   delegate:nil
							  cancelButtonTitle:@"OK"
							  otherButtonTitles:nil] show];
		}];
	} failureBlock:^(NSError *error) {
		return;
	}];
}

- (void)fetchFullAddressFromGoogleMapsWithSuccessBlock:(GoogleMapsSuccessBlock)successBlock
										  failureBlock:(GoogleMapsFailureBlock)failureBlock
{
	NSString *googleMapsURL = [[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=true", self.dataSource[@"zip"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	manager.requestSerializer = [AFJSONRequestSerializer serializer];
	manager.responseSerializer = [AFJSONResponseSerializer serializer];
	[manager GET:googleMapsURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSArray *response = [responseObject objectForKey:googleMapsResultsKey];
		if (response.count == 0) {
			if (failureBlock) failureBlock(nil);
		}

		NSArray *addressComponents = [[responseObject[@"results"] firstObject] objectForKey:googleMapsAddressComponentsKey];
		if (addressComponents.count > 0) {
			if (successBlock) successBlock([addressComponents copy]);
		} else {
			if (failureBlock) failureBlock(nil);
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"Error: %@", error.localizedDescription);
		failureBlock(error);
	}];
}

+ (NSDictionary *)abbreviatedStateInfo
{
	return [NSDictionary dictionaryWithObjects:@[ @"AL", @"AK", @"AZ", @"AR", @"CA", @"CO", @"CT", @"DE", @"FL", @"GA", @"HI", @"ID", @"IL", @"IN", @"IA", @"KS", @"KY", @"LA", @"ME", @"MD", @"MA", @"MI", @"MN", @"MS", @"MO", @"MT", @"NE", @"NV", @"NH", @"NJ", @"NM", @"NY", @"NC", @"ND", @"OH", @"OK", @"OR", @"PA", @"RI", @"SC", @"SD", @"TN", @"TX", @"UT", @"VT", @"VA", @"WA", @"WV", @"WI", @"WY" ]
									   forKeys:@[ @"Alabama", @"Alaska", @"Arizona", @"Arkansas", @"California", @"Colorado", @"Connecticut", @"Delaware", @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri", @"Montana", @"Nebraska", @"Nevada", @"New Hampshire", @"New Jersey", @"New Mexico", @"New York", @"North Carolina", @"North Dakota", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Rhode Island", @"South Carolina", @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virginia", @"Washington", @"West Virginia", @"Wisconsin", @"Wyoming" ]];
}

+ (BOOL)abbreviatedStateInfoAllValuesContainsString:(NSString *)string
{
	return [[[self abbreviatedStateInfo] allValues] containsObject:string];
}

+ (BOOL)abbreviatedStateInfoAllKeyesContainsString:(NSString *)string
{
	return [[[self abbreviatedStateInfo] allKeys] containsObject:string];
}

@end
