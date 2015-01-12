//
//  CommonHelp.h
//  BFGameSDK
//
//  Created by NaNa on 15/1/12.
//  Copyright (c) 2015年 nn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

#define USER_INFO @"userInfo"

@interface CommonHelp : NSObject

+ (UserModel*)parseUserModel:(NSDictionary *)dic;
+ (void)saveUser:(UserModel *)user;
+ (UserModel *)getUser;
+ (NSMutableArray *)getUserArray;

@end
