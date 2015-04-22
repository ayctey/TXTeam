//
//  TXSettingPasswordViewController.h
//  TXTeam
//
//  Created by 吖银 on 15-1-16.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//
//设定密码 控制器


#import "TXBaseViewController.h"

@interface TXSettingPasswordViewController : TXBaseViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
//手机号码
    NSString *phoneNumbers;
    UITextField *PasswordField;
    UITextField *confirmPasswordField;
    UITextField *_accountField;
}
-(void) GetPhoneNum : (NSString *) phoneNum ;

@end
