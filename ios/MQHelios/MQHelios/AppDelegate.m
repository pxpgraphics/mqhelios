//
//  AppDelegate.m
//  MQHelios
//
//  Created by Paris Pinkney on 6/23/14.
//  Copyright (c) 2014 Marqeta, Inc. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
            

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[self setupParseWithLaunchOptions:launchOptions];
	[self setupParsePushNotificationsForApplication:application];

	/* 
	 // Removed for storyboards.
	 self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	 // Override point for customization after application launch.
	 self.window.backgroundColor = [UIColor whiteColor];
	 [self.window makeKeyAndVisible];
	 */
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	[self resetBadgeNumberForCurrentInstallation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
	[self saveDeviceTokenForCurrentInstallation:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
	[self handlePushWithRemoteNotification:userInfo];
}

#pragma mark - Parse methods
- (void)setupParseWithLaunchOptions:(NSDictionary *)launchOptions
{
	[Parse setApplicationId:kParseApplicationIDKey clientKey:kParseClientKey];
	[PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
}

- (void)setupParsePushNotificationsForApplication:(UIApplication *)application
{
	UIUserNotificationType notificationTypes = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
	UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
	[application registerUserNotificationSettings:notificationSettings];
	[application registerForRemoteNotifications];
}

- (void)resetBadgeNumberForCurrentInstallation
{
	PFInstallation *currentInstallation = [PFInstallation currentInstallation];
	if (currentInstallation.badge > 0) {
		currentInstallation.badge = 0;
		[currentInstallation saveEventually];
	}
}

- (void)saveDeviceTokenForCurrentInstallation:(NSData *)deviceToken
{
	PFInstallation *currentInstallation = [PFInstallation currentInstallation];
	[currentInstallation setDeviceTokenFromData:deviceToken];
	[currentInstallation saveInBackground];
}

- (void)handlePushWithRemoteNotification:(NSDictionary *)userInfo
{
	[PFPush handlePush:userInfo];
}

@end
