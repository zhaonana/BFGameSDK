//
//  BaseViewController.m
//  BXGameSDK1.0
//
//  Created by JZY on 14-1-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "PreferencesUtils.h"

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showToast:(NSInteger)code
{
    NSString *msg;
    switch (code) {
        case SUCCESS:
            msg = @"登录成功";
            break;
        case PASSWORD_ERROR:
            msg = @"用户密码错误";
            break;
        case LOGIN_ERROR:
            msg = @"用户名密码错误";
            break;
        case SYSTEM_ERROR:
            msg = @"业务繁忙请稍后再试";
            break;
        case USER_NOT_EXIST:
            msg = @"用户不存在";
            break;
        case BIND_MOBILE_PASSWORD_CODE_MISMATCH:
            msg = @"绑定用户短信验证码不正确";
            break;
        case BIND_MOBILE_USER_NOT_EXIST:
            msg = @"绑定用户不存在";
            break;
        case BIND_MOBILE_PASSWORD_MISMATCH:
            msg = @"与绑定手机不一致";
            break;
        case BIND_MOBILE_UNBIND:
            msg = @"没有绑定手机";
            break;
        case BIND_MOBILE_HAS:
            msg = @"已经绑定手机";
            break;
        case REGISTER_USER_AUTH_FAIL_EXISTS:
            msg = @"注册 用户名已经存在";
            break;
        case LOGIN_USER_AUTH_FAIL:
            msg = @"认证失败";
            break;
        case FAIL:
            msg = @"操作失败";
            break;
        case UNKNOWN_ERROR:
            msg = @"未知错误";
            break;
        case PARAMETER_INVALID:
            msg = @"参数格式不正确";
            break;
        case BILL_NOT_EXIST:
            msg = @"订单不存在";
            break;
        case BIND_MISSMATCH:
            msg = @"绑定验证失败";
            break;
        case BIND_UN:
            msg = @"未绑定手机号码";
            break;
        case USER_EXIST:
            msg = @"用户已经存在";
            break;
        case CHARGE_FAILED:
            msg = @"充值失败";
            break;
        case CHARGE_MONEY_ERROR:
            msg = @"充值金额不正确";
            break;
        case PARAMETER_PASSWORD_INVALID:
            msg = @"原始密码输入错误";
            break;
        case OLD_BIND_DEL_NEW_BIND_SUCCESS:
            msg = @"原账号已解绑，绑定新账号成功";
            break;
        case VERIFYCODE_ERROR:
            msg = @"验证码不正确";
            break;
        default:
            msg = @"错误码1001";
            break;
    }
    
    [SVProgressHUD showErrorWithStatus:msg];
}

- (void)resetView
{
    
}

//点击return时触发的事件
- (void)textFiledReturnEditing:(id)sender
{
    [sender resignFirstResponder];
}

#pragma mark textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

@end
