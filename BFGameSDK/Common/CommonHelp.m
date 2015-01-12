//
//  CommonHelp.m
//  BFGameSDK
//
//  Created by NaNa on 15/1/12.
//  Copyright (c) 2015年 nn. All rights reserved.
//

#import "CommonHelp.h"

@implementation CommonHelp

+ (UserModel*)parseUserModel:(NSDictionary *)dic
{
    UserModel *user = [[UserModel alloc] init];
    if (dic) {
        user.username = [dic objectForKey:@"username"];
        user.password = [dic objectForKey:@"password"];
        user.user_id = [dic objectForKey:@"user_id"];
        user.ticket = [dic objectForKey:@"ticket"];
        user.token = [dic objectForKey:@"token"];
    }
    
    return user;
}

+ (void)saveUser:(UserModel *)user
{
    NSMutableArray *usersArray = [CommonHelp getUserArray];
    
    //判断是否已经存储
    if (usersArray && usersArray.count > 0) {
        for (UserModel *mUser in usersArray) {
            if([mUser.username isEqualToString:user.username]) {
                [usersArray removeObject:mUser];
                break;
            }
        }
    } else {
        usersArray = [[NSMutableArray alloc] init];
    }
    
    //存储用户信息
    [usersArray addObject:user];
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:usersArray];
    [[NSUserDefaults standardUserDefaults] setObject:archiveData forKey:USER_INFO];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (UserModel *)getUser
{
    NSMutableArray *usersArray = [CommonHelp getUserArray];
    
    if (usersArray && usersArray.count > 0) {
        UserModel *user = [usersArray lastObject];
        return user;
    } else {
        return nil;
    }
}

+ (NSMutableArray *)getUserArray
{
    NSData *encodedData = [[NSUserDefaults standardUserDefaults] objectForKey:USER_INFO];
    NSMutableArray *usersArray = [NSKeyedUnarchiver unarchiveObjectWithData: encodedData];
    return usersArray;
}

@end
