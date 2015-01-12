//
//  UserModel.h
//  BXGameSDK
//
//  Created by JZY on 14-2-17.
//  Copyright (c) 2014年 jzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserModel : NSObject <NSCoding>

@property (nonatomic, strong) NSString *user_id;    //畅想游戏 账号 用户唯一编号
@property (nonatomic, strong) NSString *username;   //用户名
@property (nonatomic, strong) NSString *password;   //密码
@property (nonatomic, strong) NSString *ticket;     //用户登录成功的票据 用于服务器端验证用户合法性
@property (nonatomic, strong) NSString *token;      //暴风

@end
