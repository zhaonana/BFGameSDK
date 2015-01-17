//
//  CXComPlatformBase.h
//  CXGameSDK
//
//  Created by NaNa on 14-11-14.
//  Copyright (c) 2014年 nn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//登录成功通知
#define LOGIN_SUCCESSED_NOTIFICATION @"loginSuccessedNotification"
//登录失败通知
#define LOGIN_FAILED_NOTIFICATION @"loginFailedNotification"

@interface CXComPlatformBase : NSObject

/**
 *  获取CXComPlatformBase的实例对象
 *
 *  @return CXComPlatformBase
 */
+ (CXComPlatformBase *)defaultPlatform;
/**
 *  应用初始化
 *
 *  @param cpId         合作者ID
 *  @param cpKey        游戏合作商秘钥
 *  @param gameId       游戏ID
 *  @param serverId     服务器ID
 *  @param channelId    渠道ID
 */
- (void)initializeWithCpId:(NSString *)cpId
                  andCpKey:(NSString *)cpKey
                 andGameId:(NSString *)gameId
               andServerId:(NSString *)serverId
              andChannelId:(NSString *)channelId;
/**
 *  应用初始化
 *
 *  @param controller   应用程序调用SDK的当前 UIViewController
 */
- (void)showLoginViewWithController:(UIViewController *)controller;

@end
