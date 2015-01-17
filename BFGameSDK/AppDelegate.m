//
//  AppDelegate.m
//  CXGameSDK
//
//  Created by NaNa on 14-10-15.
//  Copyright (c) 2014年 nn. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "TalkingDataAppCpa.h"
#import "CXComPlatformBase.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MainViewController *mainCon = [[MainViewController alloc] init];
    self.window.rootViewController = mainCon;
    
    //初始化SDK
    [[CXComPlatformBase defaultPlatform] initializeWithCpId:@"10023"
                                                   andCpKey:@"1021wewg%^d"
                                                  andGameId:@"71"
                                                andServerId:@"1"
                                               andChannelId:@"213"];
    //TD
    [TalkingDataAppCpa init:@"your key" withChannelId:@"your channelId"];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
//    return UIInterfaceOrientationMaskPortrait;    //竖屏
    return UIInterfaceOrientationMaskLandscapeRight; //横屏
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
