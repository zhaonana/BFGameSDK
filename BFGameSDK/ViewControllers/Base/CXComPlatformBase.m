//
//  CXComPlatformBase.m
//  CXGameSDK
//
//  Created by NaNa on 14-11-14.
//  Copyright (c) 2014年 nn. All rights reserved.
//

#import "CXComPlatformBase.h"
#import "CXSDKViewController.h"

static CXComPlatformBase *sharedSingleton = nil;
static CXSDKViewController *cxVC = nil;

@implementation CXComPlatformBase

+ (CXComPlatformBase *)defaultPlatform
{
    if (sharedSingleton == nil) {
        sharedSingleton = [[CXComPlatformBase alloc] init];
    }
    return sharedSingleton;
}

- (void)initializeWithCpId:(NSString *)cpId andCpKey:(NSString *)cpKey andGameId:(NSString *)gameId andServerId:(NSString *)serverId andChannelId:(NSString *)channelId
{
    cxVC = [[CXSDKViewController alloc] init];
    [cxVC setCpKey:cpKey];
    [cxVC setCpID:cpId];
    [cxVC setGameID:gameId];
    [cxVC setServerID:serverId];
    [cxVC setChannelID:channelId];
}

- (void)showLoginViewWithController:(UIViewController *)controller
{
    [cxVC initSDK:controller];
}

@end
