//
//  OtherLoginViewController.m
//  CXGameSDK
//
//  Created by NaNa on 14-10-29.
//  Copyright (c) 2014年 nn. All rights reserved.
//

#import "OtherLoginViewController.h"
#import "CXCommon.h"
#import "DeviceInfo.h"
#import "TalkingDataAppCpa.h"
#import "CommonHelp.h"

@interface OtherLoginViewController () <UIWebViewDelegate>

@end

@implementation OtherLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"暴风游戏";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(barButtonClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    // no transforms applied to window in iOS 8, but only if compiled with iOS 8 sdk as base sdk, otherwise system supports old rotation logic.
    BOOL ignoreOrientation = NO;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([[NSProcessInfo processInfo] respondsToSelector:@selector(operatingSystemVersion)]) {
        ignoreOrientation = YES;
    }
#endif
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGRect frame = CGRectMake(0, 0, 0, 0);
    if (ignoreOrientation) {
        frame = CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT);
    } else {
        switch (interfaceOrientation) {
            case UIInterfaceOrientationLandscapeLeft:
                frame = CGRectMake(0, 0, KSCREENHEIGHT, KSCREENWIDTH);
                break;
            case UIInterfaceOrientationLandscapeRight:
                frame = CGRectMake(0, 0, KSCREENHEIGHT, KSCREENWIDTH);
                break;
            case UIInterfaceOrientationPortraitUpsideDown:
                frame = CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT);
                break;
            default:
                frame = CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT);
                break;
        }
    }
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    [webView setDelegate:self];
    
    NSString *phoneVer = [[UIDevice currentDevice] systemVersion];
    NSString *urlStr = [NSString stringWithFormat:@"http://sso.baofeng.net/api/mlogin/default?from=gamecenter&version=%@&did=%@&btncolor=blue",phoneVer,[DeviceInfo getIDFA]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    [self.view addSubview:webView];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIButtonClick
- (void)barButtonClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.cancelOtherLoginBlock) {
            self.cancelOtherLoginBlock();
        }
    }];
}

#pragma mark - UIWebViewDelegate methods
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    NSString *absoluteString = url.absoluteString;
    NSRange token = [absoluteString rangeOfString:@"token="];
    NSRange absolute = [absoluteString rangeOfString:@"http://sso.baofeng.net/api/mlogin/appok"];
    if (token.location != NSNotFound && absolute.location != NSNotFound) {
        NSString *firstStr = [absoluteString substringFromIndex:token.location + 6];
        NSRange flag = [firstStr rangeOfString:@"&"];
        NSString *tokenStr = [firstStr substringToIndex:flag.location];
        
        NSDictionary *dic = @{@"token": tokenStr};
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
        [GGNetWork getHttp:@"user/loginbytoken" parameters:params sucess:^(id responseObj) {
            if (responseObj) {
                NSInteger code = [[responseObj objectForKey:@"code"] intValue];
                if(code == 1){
                    NSDictionary *dic = [responseObj objectForKey:@"data"];
                    UserModel *user = [CommonHelp parseUserModel:dic];
                    user.token = tokenStr;
                    [CommonHelp saveUser:user];

                    if (self.loginSuccessedBlock) {
                        self.loginSuccessedBlock(user.user_id, user.ticket);
                    }
                    //TD
                    [TalkingDataAppCpa onLogin:user.user_id];
                    [self dismissViewControllerAnimated:YES completion:nil];
                } else {
                    NSDictionary *dic = @{@"code": [NSString stringWithFormat:@"%ld",(long)code]};
                    [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_FAILED_NOTIFICATION object:nil userInfo:dic];
                    [self showToast:code];
                }
            }
        } failed:^(NSString *errorMsg) {
            [SVProgressHUD showErrorWithStatus:@"链接失败"];
        }];
    }
    return YES;
}

@end
