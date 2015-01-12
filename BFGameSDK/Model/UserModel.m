//
//  UserModel.m
//  BXGameSDK
//
//  Created by JZY on 14-2-17.
//  Copyright (c) 2014年 jzy. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

#pragma mark - NSCoding
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self == [super init]) {
        self.user_id = [decoder decodeObjectForKey:@"user_id"];
        self.username = [decoder decodeObjectForKey:@"username"];
        self.password = [decoder decodeObjectForKey:@"password"];
        self.ticket = [decoder decodeObjectForKey:@"ticket"];
        self.token = [decoder decodeObjectForKey:@"token"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.user_id forKey:@"user_id"];
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.password forKey:@"password"];
    [encoder encodeObject:self.ticket forKey:@"ticket"];
    [encoder encodeObject:self.token forKey:@"token"];
}

@end
