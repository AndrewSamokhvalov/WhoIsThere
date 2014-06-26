//
//  ASAppDelegate.m
//  WhoIsThere
//
//  Created by Наталья Дидковская on 25.06.14.
//  Copyright (c) 2014 Andrey Samokhvalov. All rights reserved.
//

#import "ASAppDelegate.h"
#import "ASViewController.h"
#import <Parse/Parse.h>
#import "ASPlayer.h"

@implementation ASAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [Parse setApplicationId:@"fqDiDrmJ0Zway2FaL4iE26YCYSGhqwBNUE9qxwwk"
                  clientKey:@"i5ZgYNkt4o5NNxTn2Soo9b0hCbvdIry3lgwlTAPp"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    NSLog(@"EnterForeground");
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
//    // потанцеальная ошибка
    UINavigationController *nc = (UINavigationController*)self.window.rootViewController;
    UIViewController *vc = nc.visibleViewController;
    
    if([vc isKindOfClass:[ASViewController class]]){
        
        [((ASViewController*)vc).state notification];
        
    }
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    application.applicationIconBadgeNumber = 0;
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
    UINavigationController *nc = (UINavigationController*)self.window.rootViewController;
    UIViewController *vc = nc.visibleViewController;
    
    if([vc isKindOfClass:[ASViewController class]]){
        
        [((ASViewController*)vc).player.state terminate];
        
    }
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    application.applicationIconBadgeNumber = 0;
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alarm"
                                                        message:notification.alertBody
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];

    
}

@end
