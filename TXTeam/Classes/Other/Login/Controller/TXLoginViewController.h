//
//  TXLoginViewController.h
//  TXTeam
//
//  Created by 吖银 on 15-1-12.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//
//登陆控制器
#import <UIKit/UIKit.h>
#import "RCHttpRequest.h"
#import "RCIM.h"
@interface TXLoginViewController : UIViewController<HttpConnectionDelegate,UITextFieldDelegate>
{
    //登陆即时通讯
    NSString* loginToken;
    NSString  *Userid;
    //账号输入框
    UITextField *usernameTextField;
    //创建密码输入框
    UITextField *passwordTextField;
    //用来存放输入框
    UIImageView *inputBackground;
    //登陆按钮
    UIButton *loginButton;
    //注册按钮
    UIButton *signupButton;
    //忘记密码按钮
    UIButton *forgetPassword;
    /*
    //显示更新版本日期
    UILabel *buildVersionLabel;
    //显示版本号
    UILabel *shortVersionLabel;
     */
}

@property (nonatomic,strong) RCHttpRequest *loginRequest;
@property (nonatomic,strong) RCHttpRequest *friendRquest;
//创建一个数组存放缓存的好友列表
@property(nonatomic, strong) NSMutableArray *allFriendsArray;

@end
