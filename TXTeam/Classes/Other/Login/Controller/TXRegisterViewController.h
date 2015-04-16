//
//  TXRegisterViewController.h
//  TXTeam
//
//  Created by 吖银 on 15-1-12.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

//注册控制器

#import <UIKit/UIKit.h>
#pragma mark Register TextField Tag enum
enum TAG_REGISTER_TEXTFIELD{
    
    Tag_PhoneTextField  = 100,    //手机号
    Tag_AccountTextField ,        //用户名
    Tag_TempPasswordTextField,    //登录密码
    Tag_ConfirmPasswordTextField, //确认登录密码
};


@interface TXRegisterViewController : UIViewController

@end
