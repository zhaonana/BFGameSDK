
//
//  LoginViewController.m
//  BXGameSDK1.0
//
//  Created by JZY on 14-1-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "PreferencesUtils.h"
#import "CXSDKViewController.h"
#import "OtherLoginViewController.h"
#import "TalkingDataAppCpa.h"
#import "CommonHelp.h"

@interface LoginViewController () <UITableViewDataSource, UITableViewDelegate> {
    UITextField    *_accountField;
    UITextField    *_passWordField;
    NSMutableArray *_userArray;
    UITableView    *_tableView;
    UIButton       *_forgotBtn;
    UILabel        *_forgetLab;
    NSMutableArray *_dataArray;
    UserModel      *_userModel;
}

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self setUpSubViews];
    } else {
        [self setUpPadSubViews];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - setUpSubViews
- (void)setUpSubViews
{
    //set accountView
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(26, 58, 177, 27)];
    [accountView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:accountView];
    
    //set accountBackgroundView
    UIImageView *accountBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 177, 27)];
    [accountBackView setImage:[UIImage imageNamed:@"CXshoujichangtouming"]];
    [accountView addSubview:accountBackView];
    
    //set accountImgView
    UIImageView *accountImgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 6, 15, 15)];
    [accountImgView setImage:[UIImage imageNamed:@"CXzhanghao"]];
    [accountView addSubview:accountImgView];
    
    //set accountTextField
    _accountField = [[UITextField alloc] initWithFrame:CGRectMake(35, 7, 126, 14)];
    [_accountField setPlaceholder:@"请输入账号"];
    [_accountField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_accountField setFont:[UIFont systemFontOfSize:13.0]];
    [_accountField setTextColor:[UIColor whiteColor]];
    _accountField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_accountField setReturnKeyType:UIReturnKeyDone];
    _accountField.delegate = self;
    [accountView addSubview:_accountField];
    
    //set switchBtn
    UIImageView *switchImgView = [[UIImageView alloc] initWithFrame:CGRectMake(156, 6, 15, 15)];
    [switchImgView setImage:[UIImage imageNamed:@"CXxiala"]];
    [accountView addSubview:switchImgView];
    
    UIButton *switchBtn = [[UIButton alloc] initWithFrame:CGRectMake(150, 0, 27, 27)];
    [switchBtn addTarget:self action:@selector(switchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [accountView addSubview:switchBtn];
    
    //set passWordView
    UIView *passWordView = [[UIView alloc] initWithFrame:CGRectMake(26, 92, 177, 27)];
    [passWordView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:passWordView];
    
    //set passWordBackgroundView
    UIImageView *passWordBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 177, 27)];
    [passWordBackView setImage:[UIImage imageNamed:@"CXshoujichangtouming"]];
    [passWordView addSubview:passWordBackView];
    
    //set passWordImgView
    UIImageView *passWordImgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 6, 15, 15)];
    [passWordImgView setImage:[UIImage imageNamed:@"CXmima"]];
    [passWordView addSubview:passWordImgView];
    
    //set passWordTextField
    _passWordField = [[UITextField alloc] initWithFrame:CGRectMake(35, 7, 130, 14)];
    [_passWordField setPlaceholder:@"请输入密码"];
    [_passWordField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_passWordField setFont:[UIFont systemFontOfSize:13.0]];
    _passWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_passWordField setReturnKeyType:UIReturnKeyDone];
    _passWordField.secureTextEntry = YES;
    _passWordField.delegate = self;
    [passWordView addSubview:_passWordField];
    
    //set accountField and passwordField
    [self setUpAccountFieldAndPasswordField];
    
    //set loginBtn
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(26, 130, 84, 27)];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateHighlighted];
    [loginBtn setTitle:@"1秒注册" forState:UIControlStateNormal];
    [loginBtn setTitle:@"1秒注册" forState:UIControlStateHighlighted];
    [loginBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [loginBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    //set touristsBtn
    UIButton *touristsBtn = [[UIButton alloc] initWithFrame:CGRectMake(119, 130, 84, 27)];
    [touristsBtn setBackgroundImage:[UIImage imageNamed:@"CXyoukedenglu"] forState:UIControlStateNormal];
    [touristsBtn setBackgroundImage:[UIImage imageNamed:@"CXyoukedenglu"] forState:UIControlStateHighlighted];
    [touristsBtn setTitle:@"登录" forState:UIControlStateNormal];
    [touristsBtn setTitle:@"登录" forState:UIControlStateHighlighted];
    [touristsBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [touristsBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [touristsBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [touristsBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:touristsBtn];
    
    //set otherLoginLab
    UILabel *otherLab = [[UILabel alloc] initWithFrame:CGRectMake(38, 213, 63, 13)];
    [otherLab setText:@"其他登陆:"];
    [otherLab setFont:[UIFont systemFontOfSize:14.0]];
    [otherLab setTextColor:[UIColor whiteColor]];
    [self.view addSubview:otherLab];
    
    //set sinaBtn
    UIButton *sinaBtn = [[UIButton alloc] initWithFrame:CGRectMake(104, 205, 29, 28)];
    [sinaBtn setImage:[UIImage imageNamed:@"bx_icon_baofeng"] forState:UIControlStateNormal];
    [sinaBtn setImage:[UIImage imageNamed:@"bx_icon_baofeng"] forState:UIControlStateHighlighted];
    [sinaBtn addTarget:self action:@selector(sinaBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sinaBtn];
    
    //set forgotPassWordBtn
    _forgotBtn = [[UIButton alloc] initWithFrame:CGRectMake(144, 246, 64, 13)];
    [_forgotBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_forgotBtn setTitle:@"忘记密码?" forState:UIControlStateHighlighted];
    [_forgotBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [_forgotBtn addTarget:self action:@selector(forgotPasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgotBtn];
    
    //set forgetLab
    _forgetLab = [[UILabel alloc] initWithFrame:CGRectMake(143, 260, 65, 1)];
    [self.view addSubview:_forgetLab];
    
    //set forgotPassWordBtn and forgetLab state
    [self setUpForgotPasswordBtnWithToken:[CommonHelp getUser].token];
    
    //set switchTableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(26, 85, 177, 0) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)setUpPadSubViews
{
    //set accountView
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(29, 70, 228, 35)];
    [accountView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:accountView];
    
    //set accountBackgroundView
    UIImageView *accountBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 228, 35)];
    [accountBackView setImage:[UIImage imageNamed:@"padChangtouming"]];
    [accountView addSubview:accountBackView];
    
    //set accountImgView
    UIImageView *accountImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 18, 18)];
    [accountImgView setImage:[UIImage imageNamed:@"padZhanghao"]];
    [accountView addSubview:accountImgView];
    
    //set accountTextField
    _accountField = [[UITextField alloc] initWithFrame:CGRectMake(43, 10, 162, 15)];
    [_accountField setPlaceholder:@"请输入账号"];
    [_accountField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_accountField setFont:[UIFont systemFontOfSize:15.0]];
    [_accountField setTextColor:[UIColor whiteColor]];
    _accountField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_accountField setReturnKeyType:UIReturnKeyDone];
    _accountField.userInteractionEnabled = NO;
    _accountField.delegate = self;
    [accountView addSubview:_accountField];
    
    //set switchBtn
    UIImageView *switchImgView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 8, 18, 18)];
    [switchImgView setImage:[UIImage imageNamed:@"padXiala"]];
    [accountView addSubview:switchImgView];
    
    UIButton *switchBtn = [[UIButton alloc] initWithFrame:CGRectMake(193, 0, 35, 35)];
    [switchBtn addTarget:self action:@selector(switchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [accountView addSubview:switchBtn];

    //set passWordView
    UIView *passWordView = [[UIView alloc] initWithFrame:CGRectMake(29, 114, 228, 35)];
    [passWordView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:passWordView];
    
    //set passWordBackgroundView
    UIImageView *passWordBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 228, 35)];
    [passWordBackView setImage:[UIImage imageNamed:@"padChangtouming"]];
    [passWordView addSubview:passWordBackView];
    
    //set passWordImgView
    UIImageView *passWordImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 18, 18)];
    [passWordImgView setImage:[UIImage imageNamed:@"padMima"]];
    [passWordView addSubview:passWordImgView];
    
    //set passWordTextField
    _passWordField = [[UITextField alloc] initWithFrame:CGRectMake(43, 10, 180, 15)];
    [_passWordField setPlaceholder:@"请输入密码"];
    [_passWordField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_passWordField setFont:[UIFont systemFontOfSize:15.0]];
    [_passWordField setTextColor:[UIColor whiteColor]];
    _passWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_passWordField setReturnKeyType:UIReturnKeyDone];
    _passWordField.secureTextEntry = YES;
    _passWordField.userInteractionEnabled = NO;
    _passWordField.delegate = self;
    [passWordView addSubview:_passWordField];
    
    //set accountField and passwordField
    [self setUpAccountFieldAndPasswordField];
    
    //set loginBtn
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(29, 162, 107, 35)];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateHighlighted];
    [loginBtn setTitle:@"1秒注册" forState:UIControlStateNormal];
    [loginBtn setTitle:@"1秒注册" forState:UIControlStateHighlighted];
    [loginBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [loginBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    //set touristsBtn
    UIButton *touristsBtn = [[UIButton alloc] initWithFrame:CGRectMake(149, 162, 107, 35)];
    [touristsBtn setBackgroundImage:[UIImage imageNamed:@"padYouikedenglu"] forState:UIControlStateNormal];
    [touristsBtn setBackgroundImage:[UIImage imageNamed:@"padYouikedenglu"] forState:UIControlStateHighlighted];
    [touristsBtn setTitle:@"登录" forState:UIControlStateNormal];
    [touristsBtn setTitle:@"登录" forState:UIControlStateHighlighted];
    [touristsBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [touristsBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [touristsBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [touristsBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:touristsBtn];
    
    //set otherLoginLab
    UILabel *otherLab = [[UILabel alloc] initWithFrame:CGRectMake(54, 270, 70, 16)];
    [otherLab setText:@"其他登陆:"];
    [otherLab setFont:[UIFont systemFontOfSize:16.0]];
    [otherLab setTextColor:[UIColor whiteColor]];
    [self.view addSubview:otherLab];
    
    //set sinaBtn
    UIButton *sinaBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 264, 31, 31)];
    [sinaBtn setImage:[UIImage imageNamed:@"bx_icon_baofeng"] forState:UIControlStateNormal];
    [sinaBtn setImage:[UIImage imageNamed:@"bx_icon_baofeng"] forState:UIControlStateHighlighted];
    [sinaBtn addTarget:self action:@selector(sinaBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sinaBtn];
    
    //set forgotPassWordBtn
    _forgotBtn = [[UIButton alloc] initWithFrame:CGRectMake(178, 310, 74, 16)];
    [_forgotBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_forgotBtn setTitle:@"忘记密码?" forState:UIControlStateHighlighted];
    [_forgotBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [_forgotBtn addTarget:self action:@selector(forgotPasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgotBtn];
    
    //set forgetLab
    _forgetLab = [[UILabel alloc] initWithFrame:CGRectMake(176, 326, 74, 1)];
    [_forgetLab setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_forgetLab];
    
    //set forgotPassWordBtn and forgetLab state
    [self setUpForgotPasswordBtnWithToken:[CommonHelp getUser].token];

    //set switchTableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(29, 105, 228, 0) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)setUpForgotPasswordBtnWithToken:(NSString *)token
{
    if (token.length) {
        [_forgotBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_forgotBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _forgotBtn.userInteractionEnabled = NO;
        [_forgetLab setBackgroundColor:[UIColor grayColor]];
        _accountField.textColor = [UIColor colorWithRed:90.0/255.0 green:167.0/255.0 blue:225.0/255.0 alpha:1.0];
    } else {
        [_forgotBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_forgotBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        _forgotBtn.userInteractionEnabled = YES;
        [_forgetLab setBackgroundColor:[UIColor whiteColor]];
        _accountField.textColor = [UIColor whiteColor];
    }
}

- (void)setUpAccountFieldAndPasswordField
{
    if (_accountField.text.length) {
        [_passWordField setTextColor:[UIColor grayColor]];
        _accountField.userInteractionEnabled = NO;
        _passWordField.userInteractionEnabled = NO;
    } else {
        [_passWordField setTextColor:[UIColor whiteColor]];
        _accountField.userInteractionEnabled = YES;
        _passWordField.userInteractionEnabled = YES;
    }
}


/**
 *  设置下拉菜单显示
 */
- (void)showSwitchTableView
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if (_dataArray.count < 6) {
            [_tableView setFrame:CGRectMake(26, 85, 177, 27 * _dataArray.count)];
        } else {
            [_tableView setFrame:CGRectMake(26, 85, 177, 135)];
        }
    } else {
        if (_dataArray.count < 6) {
            [_tableView setFrame:CGRectMake(29, 105, 228, 35 * _dataArray.count)];
        } else {
            [_tableView setFrame:CGRectMake(29, 105, 228, 175)];
        }
    }
}

/**
 *  设置下拉菜单隐藏
 */
- (void)hiddenSwitchTableView
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [_tableView setFrame:CGRectMake(26, 85, 177, 0)];
    } else {
        [_tableView setFrame:CGRectMake(29, 105, 228, 0)];
    }
}

/**
 *  设置键盘消失
 */
- (void)setKeyBoardHidden
{
    [_accountField resignFirstResponder];
    [_passWordField resignFirstResponder];
}

#pragma mark - UIButtonClick
/**
 *  切换账户
 */
- (void)switchBtnClick
{
    [self setKeyBoardHidden];
    
    _userArray = [CommonHelp getUserArray];
    if (_userArray && _userArray.count > 0) {
        [UIView animateWithDuration:0.3 animations:^{
            if (_tableView.bounds.size.height == 0) {
                [self showSwitchTableView];
            } else {
                [self hiddenSwitchTableView];
            }
        } completion:^(BOOL finished) {
            
        }];
        [_tableView reloadData];
    } else {
        [SVProgressHUD showErrorWithStatus:@"没有其他账户"];
    }
    
    _dataArray = [[NSMutableArray alloc] initWithArray:_userArray];
    UserModel *user = [[UserModel alloc] init];
    user.username = @"其他用户";
    [_dataArray addObject:user];
}

/**
 *  登录游戏
 */
- (void)loginBtnClick
{
    NSLog(@"登录游戏");
    
    [self setKeyBoardHidden];
    
    if (_userModel.token.length) {
        NSDictionary *dic = @{@"token": _userModel.token};
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
        [GGNetWork getHttp:@"user/loginbytoken" parameters:params sucess:^(id responseObj) {
            if (responseObj) {
                NSInteger code = [[responseObj objectForKey:@"code"] intValue];
                if(code == 1){
                    NSDictionary *dic = [responseObj objectForKey:@"data"];
                    UserModel *user = [CommonHelp parseUserModel:dic];
                    user.token = _userModel.token;
                    [CommonHelp saveUser:user];
                    [self.rootView closeSDK];
                    //TD
                    [TalkingDataAppCpa onLogin:user.user_id];
                } else {
                    NSDictionary *dic = @{@"code": [NSString stringWithFormat:@"%ld",(long)code]};
                    [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_FAILED_NOTIFICATION object:nil userInfo:dic];
                    [self showToast:code];
                }
            }
        } failed:^(NSString *errorMsg) {
            [SVProgressHUD showErrorWithStatus:@"链接失败"];
        }];
    } else {
        NSString *username = _userModel.username;
        NSString *password = _userModel.password;
        NSString *userid = nil;
        
        if (_accountField.userInteractionEnabled == YES) {
            if([StringUtil isEmpty:_accountField.text]) {
                [SVProgressHUD showErrorWithStatus:@"用户名不能为空"];
                return;
            }
            
            if([StringUtil isEmpty:_passWordField.text]) {
                [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
                return;
            }
            username = _accountField.text;
            password = _passWordField.text;
            userid = @"";
        } else {
            userid = _userModel.user_id;
        }
        
        NSDictionary *dic = @{@"account": username,
                              @"password": password,
                              @"user_id": userid
                              };
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
        [GGNetWork getHttp:@"user/login" parameters:params sucess:^(id responseObj) {
            if (responseObj) {
                NSInteger code = [[responseObj objectForKey:@"code"] intValue];
                if(code == 1){
                    NSDictionary *dic = [responseObj objectForKey:@"data"];
                    UserModel *user = [CommonHelp parseUserModel:dic];
                    user.username = username;
                    user.password = password;
                    [CommonHelp saveUser:user];
                    
                    [self.rootView closeSDK];
                    //TD
                    [TalkingDataAppCpa onLogin:user.user_id];
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
}

/**
 *  注册
 */
- (void)registBtnClick
{
    NSLog(@"注册");
    [self.rootView showTabByTag:TYPE_REGISTER];
}

/**
 *  忘记密码
 */
- (void)forgotPasswordBtnClick
{
    NSLog(@"忘记密码");
    [[NSUserDefaults standardUserDefaults] setObject:_accountField.text forKey:@"pUserName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.rootView showTabByTag:TYPE_FORGOT_PASSWORD];
}

/**
 *  暴风登陆
 */
- (void)sinaBtnClick
{
    NSLog(@"暴风登陆");
    
    OtherLoginViewController *olVct = [[OtherLoginViewController alloc] init];
    olVct.cancelOtherLoginBlock = ^() {
        [self.rootView showSDK];
    };
    olVct.loginSuccessedBlock = ^(NSString *user_id, NSString *ticket) {
        NSDictionary *dic = @{@"user_id": user_id,
                              @"ticket": ticket
                              };
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SUCCESSED_NOTIFICATION object:nil userInfo:dic];
    };
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:olVct];
    [self.rootView.controller presentViewController:nc animated:YES completion:^{
        [self.rootView hiddenSDK];
    }];
}

#pragma mark - resetView
- (void)resetView
{
    if ([CommonHelp getUser]) {
        _accountField.text = [CommonHelp getUser].username;
        _userModel = [CommonHelp getUser];
        if ([CommonHelp getUser].token.length) {
            _passWordField.text = @"123456";
        } else {
            _passWordField.text = [CommonHelp getUser].password;
        }
    }
    
    //set forgotPassWordBtn and forgetLab state
    [self setUpForgotPasswordBtnWithToken:[CommonHelp getUser].token];
    //set accountField and passwordField
    [self setUpAccountFieldAndPasswordField];
    
    [self setKeyBoardHidden];
}

- (void)showUpdatePassword
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改密码" message:@"快速登录账户，需要修改密码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    UserModel *user = [_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    return cell;
}

#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return 27.0;
    } else {
        return 35.0;
    }
    return 0.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setKeyBoardHidden];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self hiddenSwitchTableView];
    } completion:^(BOOL finished) {
        
    }];
    UserModel *user = [_dataArray objectAtIndex:indexPath.row];
    if ([user.username isEqualToString:@"其他用户"]) {
        _accountField.text = @"";
        _passWordField.text = @"";
        _accountField.userInteractionEnabled = YES;
        _passWordField.userInteractionEnabled = YES;
        _passWordField.textColor = [UIColor whiteColor];
    } else {
        _accountField.text = user.username;
        if (user.token.length) {
            _passWordField.text = @"123456";
        } else {
            _passWordField.text = user.password;
        }
        _userModel = user;
        _accountField.userInteractionEnabled = NO;
        _passWordField.userInteractionEnabled = NO;
        _passWordField.textColor = [UIColor grayColor];
    }
    
    //set forgotPassWordBtn and forgetLab state
    [self setUpForgotPasswordBtnWithToken:user.token];
    [tableView reloadData];
}

@end
