//
//  BaseViewController.h
//  BXGameSDK1.0
//
//  Created by JZY on 14-1-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXSDKViewController.h"
#import "UserModel.h"
#import "StringUtil.h"
#import "SVProgressHUD.h"
#import "GGNetWork.h"
#import "JsonUtil.h"
#import "Common.h"

#define kUserNames @"user_names"
#define kSaveUser @"save_user"
// 操作成功
#define SUCCESS  1
// 系统错误
#define SYSTEM_ERROR  2
// 提交的合作者编号不存在
#define CP_NOT_EXIST  3
// IP地址不允许访问
#define IP_NOT_ALLOWED  4
// 签名验证失败
#define SIGNATURE_INVALID  5

// 提交的数据己超过有效期 30秒
#define SIGNATURE_VERITY_EXPIRED  6

// 游戏或服务器不存在
#define GAME_OR_SERVER_INVALID  7

// 用户不存在
#define USER_NOT_EXIST  8

// 充值失败
#define CHARGE_FAILED  9

// 订单号重复支付
#define ORDERNO_DUPLICATE  10

// 充值金额不正确
#define CHARGE_MONEY_ERROR  11

//充值退出
#define CHARGE_USER_EXIT  22

// 用户封禁错误
#define FROZEN_ERROR  12

// 用户解封错误
#define UNFROZEN_ERROR  13

// 用户密码错误
#define PASSWORD_ERROR  14

// 用户登录错误 用户名不存在
#define LOGIN_ERROR  15

// 票据过期
#define TICKET_EXPIRED  16

// 用户已经存在
#define USER_EXIST  17

// 已经绑定手机号
#define BIND_HAS  18

// 没有绑定手机号
#define BIND_UN  19

// 绑定验证失败
#define BIND_MISSMATCH  20

// 订单不存在
#define BILL_NOT_EXIST  21

// 参数格式不正确
#define PARAMETER_INVALID  100

// 参数格式不正确
#define PARAMETER_PASSWORD_INVALID  111

// 未知错误
#define UNKNOWN_ERROR  200

// 操作失败
#define FAIL  -1

// 没有初始化
#define NO_INIT  -2

// 初始化失败
#define INIT_FAIL  -3

// 无法联网
#define NO_NETWORK  -50

// 没有登陆
#define NO_LOGIN  -100

// 登陆/注册认证失败
#define LOGIN_USER_AUTH_FAIL  -101

// 注册 用户名已经存在
#define REGISTER_USER_AUTH_FAIL_EXISTS  -102

// 登陆被踢出
#define LOGIN_EXIT  -103

// 已经绑定手机
#define BIND_MOBILE_HAS  -200

// 没有绑定手机
#define BIND_MOBILE_UNBIND  -201

// 与绑定手机不一致
#define BIND_MOBILE_PASSWORD_MISMATCH  -202

// 绑定用户不存在
#define BIND_MOBILE_USER_NOT_EXIST  -203

// 绑定用户短信验证码不正确
#define BIND_MOBILE_PASSWORD_CODE_MISMATCH  -204

//原账号已解绑，绑定新账号成功
#define OLD_BIND_DEL_NEW_BIND_SUCCESS  400

#define VERIFYCODE_ERROR  23
//// 操作成功
//#define SUCCESS 1
//// 系统错误
//#define SYSTEM_ERROR 2
//// 用户不存在
//#define USER_NOT_EXIST 10001
//// 登录时密码错误
//#define LOGIN_ERROR 10002
//// 用户已经存在
//#define USER_EXIST 10003
//// 新密码与原始密码相同
//#define NEWPWD_AND_OLDPWD_MATE 10004
//// 验证码过期
//#define PHONE_AUTH_CODE_PAST_DUE 10005
//// 验证码不正确
//#define PHONE_AUTH_CODE_ERROR 10006
//// 手机已经被使用
//#define PHONE_HAS_BIND 10007
//// 已经绑定手机号
//#define BIND_HAS 10008
//// 没有绑定手机号
//#define UNBIND_MOBILE 10009
//// 参数格式不正确
//#define PARAM_ERROR 10010
//// 输入的手机号与绑定的手机号不一致
//#define NOW_PHONE_OR_BAND_PHONE_ERROR 10011
//// 用户名不合法
//#define USERNAME_INVALID 10012
//// 密码必须为6-20个英文字母或数字
//#define PWSSWORD_UNDER_SIX 10013
//// 订单号少于24个字符
//#define ORDER_NUMBER_INVALID 10018
//// 商品不存在
//#define SHOP_NOT_EXIST 20000
//// 商品不可用
//#define SHOP_NOT_USE 20001
//// 生成订单失败
//#define CREATE_ORDER_ERROR 20003
//// 票据正确，但商品不存在
//#define APP_STORY_PRODUCT_ERROR 20006
//// 苹果支付错误
//#define APP_STORY_PAY_ERROR 20007

@interface BaseViewController : UIViewController <UITextFieldDelegate> {
    UIView *_paddingView;
}

@property (nonatomic, strong) CXSDKViewController *rootView;

- (void)showToast:(NSInteger)code;

- (void)saveUsers:(UserModel *)user;

- (void)resetView;

- (void)textFiledReturnEditing:(id)sender;

- (NSMutableArray *)parseJsonData:(NSData *)data;

@end
