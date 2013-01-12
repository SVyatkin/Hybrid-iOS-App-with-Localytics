//
//  AppDelegate.m
//  Hybrid App Analytics
//
//  Created by Randy Dailey on 1/9/13.
//  Copyright (c) 2013 Localytics. All rights reserved.
//

#import "AppDelegate.h"
#import "LocalyticsSession.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    [[LocalyticsSession sharedLocalyticsSession] startSession:@"Your AppKey Here"];`
    
    return YES;
}
							
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[LocalyticsSession sharedLocalyticsSession] close];
    [[LocalyticsSession sharedLocalyticsSession] upload];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[LocalyticsSession sharedLocalyticsSession] resume];
    [[LocalyticsSession sharedLocalyticsSession] upload];
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    [[LocalyticsSession sharedLocalyticsSession] close];
    [[LocalyticsSession sharedLocalyticsSession] upload];
}

@end
