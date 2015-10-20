//
//  M2AppDelegate.m
//  m2048
//
//  Created by Danqing on 3/16/14.
//  Copyright (c) 2014 Danqing. All rights reserved.
//

#import "M2AppDelegate.h"
#import "Amplitude.h"

@implementation M2AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [Amplitude instance].trackingSessionEvents = YES;
  [[Amplitude instance] initializeApiKey:@"cd6312957e01361e6c876290f26d9104"];

  // Add action for remind later.
  UIMutableUserNotificationAction *laterAction = [[UIMutableUserNotificationAction alloc] init];
  [laterAction setIdentifier:@"later_action_id"];
  [laterAction setTitle:@"Later..."];
  [laterAction setActivationMode:UIUserNotificationActivationModeBackground];

  // Add action for play now.
  UIMutableUserNotificationAction *playAction = [[UIMutableUserNotificationAction alloc] init];
  [playAction setIdentifier:@"play_action_id"];
  [playAction setTitle:@"Play Now!"];
  [playAction setActivationMode:UIUserNotificationActivationModeForeground];

  UIMutableUserNotificationCategory* category = [[UIMutableUserNotificationCategory alloc] init];
  [category setIdentifier:@"reminder_category_id"];
  [category setActions:@[laterAction, playAction] forContext:UIUserNotificationActionContextDefault];
  NSSet* categories = [NSSet setWithArray:@[category]];

  NSUInteger types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge;
  if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
    NSLog(@"Requesting permission for push notifications..."); // iOS 8
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    [UIApplication.sharedApplication registerUserNotificationSettings:settings];
  } else {
    NSLog(@"Registering device for push notifications..."); // iOS 7 and earlier
    [UIApplication.sharedApplication registerForRemoteNotificationTypes:types];
  }

  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  [self sendReminderNotification:5];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}


#pragma mark - Push Notifications

- (void)sendReminderNotification:(long)delay
{
  // Schedule reminder local notification.
  long score = (long)[Settings integerForKey:@"Best Score"];
  UILocalNotification *localNotification = [[UILocalNotification alloc] init];
  localNotification.alertBody = [NSString stringWithFormat:@"You got all the way to %ld points. Play again and go higher!", score];
  localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
  localNotification.category = @"reminder_category_id";
  localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:delay];
  localNotification.timeZone = [NSTimeZone defaultTimeZone];
  [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void)application:(UIApplication *)application
        didRegisterUserNotificationSettings:(UIUserNotificationSettings *)settings
{
    NSLog(@"Registering device for push notifications..."); // iOS 8
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application
        didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)token
{
    NSLog(@"Registration successful, bundle identifier: %@, device token: %@",
          [NSBundle.mainBundle bundleIdentifier], token);
}

- (void)application:(UIApplication *)application
        didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Failed to register: %@", error);
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier
        forRemoteNotification:(NSDictionary *)notification completionHandler:(void(^)())completionHandler
{
    NSLog(@"Received push notification: %@, identifier: %@", notification, identifier); // iOS 8
    [[Amplitude instance] initializeApiKey:@"cd6312957e01361e6c876290f26d9104"];
    [[Amplitude instance] logEvent:@"Opened Remote Notification"];

    completionHandler();
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier
        forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler
{
  if ([notification.category isEqualToString:@"reminder_category_id"])
  {
    [[Amplitude instance] initializeApiKey:@"cd6312957e01361e6c876290f26d9104" userId:nil];
    [[Amplitude instance] logEvent:@"Local Notification Action" withEventProperties:@{@"Action": identifier}];

    if ([identifier isEqualToString:@"later_action_id"])
    {
      [self sendReminderNotification:10];
    }
    else if ([identifier isEqualToString:@"play_action_id"])
    {
      NSLog(@"Play now was pressed");
    }
  }

  completionHandler();
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
        fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))handler
{
    NSLog(@"Received push notification: %@ %ld", userInfo[@"aps"], (long)application.applicationState); // iOS 7 and earlier
}

@end
