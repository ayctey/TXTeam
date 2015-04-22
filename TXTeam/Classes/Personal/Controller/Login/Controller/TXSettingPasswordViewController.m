//
//  TXSettingPasswordViewController.m
//  TXTeam
//
//  Created by 吖银 on 15-1-16.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXSettingPasswordViewController.h"
#import "TXPerfetOersonalViewController.h"
#import "InputHelper.h"
#import "TXDataService.h"
#import "Common.h"

@interface TXSettingPasswordViewController ()

@end

@implementation TXSettingPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设定密码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initViews];
    //用类inputHelper解决键盘遮挡问题
    [inputHelper setupInputHelperForView:self.view withDismissType:InputHelperDismissTypeTapGusture];
}
-(void)initViews
{
    
    UIView *count=[[UIView alloc]init];
    count.backgroundColor=kBackgroundColor;
    count.frame =CGRectMake(0,0, kScreenWidth, 40);
    [self.view addSubview:count];
    //phoneNumbers =@"13828970132";
    NSMutableString *string=[[NSMutableString alloc]initWithString:@"账号： "];
    [string insertString:phoneNumbers atIndex:3];
    UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth*0.25, 10, kScreenWidth*0.5, 20)];
    lab.text =string;
    lab.textAlignment=NSTextAlignmentCenter;
    [count addSubview:lab];
    
    UIView *_accountview = [[UIView alloc] init];
    _accountview.backgroundColor = kBackgroundColor;
    _accountview.frame = CGRectMake(0, 50, kScreenWidth, 40);
    [self.view addSubview:_accountview];
    _accountField = [[UITextField alloc] init];
    _accountField.frame = CGRectMake(20, 5, kScreenWidth-40, 30);
    _accountField.placeholder = @"请输入用户名";
    _accountField.tag =104;
    _accountField.delegate =self;
    [_accountview addSubview:_accountField];
    
    UIView *PwView = [[UIView alloc] init];
    PwView.backgroundColor = kBackgroundColor;
    PwView.frame = CGRectMake(0, 40+5+50, kScreenWidth, 40);
    [self.view addSubview:PwView];
    PasswordField = [[UITextField alloc] init];
    PasswordField.frame = CGRectMake(20, 5, kScreenWidth-40, 30);
    PasswordField.placeholder = @"请输入密码";
    PasswordField.secureTextEntry =YES;
    PasswordField.tag =101;
    PasswordField.delegate =self;
    [PwView addSubview:PasswordField];
    
    UIView *confirmPwView = [[UIView alloc] init];
    confirmPwView.backgroundColor = kBackgroundColor;
    confirmPwView.frame = CGRectMake(0, 50+90, kScreenWidth, 40);
    [self.view addSubview:confirmPwView];
    
    confirmPasswordField = [[UITextField alloc] init];
    confirmPasswordField.frame = CGRectMake(20, 5, kScreenWidth-40, 30);
    confirmPasswordField.placeholder = @"请确认密码";
    confirmPasswordField.secureTextEntry = YES;
    confirmPasswordField.tag =102;
    confirmPasswordField.delegate =self;
    [confirmPwView addSubview:confirmPasswordField];
    
    
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[UIColor redColor]];
    [submitBtn setFrame:CGRectMake((kScreenWidth-200)/2, 100+20+50+40, 200, 30)];
    [submitBtn addTarget:self action:@selector(submitNewPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    


}
#pragma mark - 检测账号名是否被注册过
-(void) WheaResgister_Account{

    UITextField *text = (UITextField *)[self.view viewWithTag:104];
    NSDictionary *dic = @{@"account":text.text};
    [TXDataService POST:existAccount param:dic isCache:NO caChetime:0 completionBlock:^(id responseObject, NSError *error) {
        NSNumber *num = [responseObject objectForKey:@"result"];
        //已经注册过
        if ([num boolValue]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的用户名已经被注册过！请重新填写您的用户名！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
        else {
            //上传注册信息
            [self Resgiter_Data];
        }
    }];

}
#pragma mark - 点击事件
- (void)submitNewPassword
{
    if (![PasswordField.text isEqualToString:confirmPasswordField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"输入的两次密码不相同！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else
    {
        [self WheaResgister_Account];
    }
}

-(void) GetPhoneNum : (NSString *) phoneNum
{
    
    phoneNumbers =phoneNum;
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - 加载数据
-(void)Resgiter_Data{
    NSLog(@"用户名:%@",_accountField.text);
    NSLog(@"密码:%@",confirmPasswordField.text);
    NSLog(@"注册手机号码:%@",phoneNumbers);
    NSDictionary *dic =@{@"account":_accountField.text,@"password":confirmPasswordField.text,@"tel":phoneNumbers};
    [TXDataService POST:register param:dic isCache:NO caChetime:0 completionBlock:^(id responseObject, NSError *error) {
        MyLog(@"ssff:%@",[responseObject objectForKey:@"result"]);
        NSNumber *number =[responseObject objectForKey:@"result"];
        //注册成功
        if ([number boolValue]) {
            UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"恭喜！" message:@"恭喜您成功注册同乡团！请进一步完善您的信息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertview show];
        }
    }];



}
#pragma mark - UIAlertview delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSDictionary *parm =  @{@"account":_accountField.text,
                            @"password":confirmPasswordField.text};

    [TXDataService POST:_login param:parm isCache:NO caChetime:0 completionBlock:^(id responseObject, NSError *error) {
        if ([[responseObject objectForKey:@"success"] intValue] == 1) {//登录成功
            //保存信息
            MyLog(@"message:%@",[responseObject objectForKey:@"success"]);
            MyLog(@"data : %@",[responseObject objectForKey:@"data"]);
            NSDictionary *data = [responseObject objectForKey:@"data"];
            
            //将数据存到系统自带的单例中
            NSUserDefaults *defaults = [NSUserDefaults  standardUserDefaults];
            [defaults setValue:[data objectForKey:@"account"] forKey:@"account"];
            //家乡
            [defaults setValue:[data objectForKey:@"area"] forKey:@"area"];
            //头像
            [defaults setValue:[data objectForKey:@"protrait_url"] forKey:@"protrait_url"];
            //生日
            [defaults setValue:[data objectForKey:@"birthday"] forKey:@"birthday"];
            //性别
            [defaults setValue:[data objectForKey:@"sex"] forKey:@"sex"];
            //姓名
            [defaults setValue:[data objectForKey:@"name"] forKey:@"name"];
            //手机号码
            [defaults setValue:[data objectForKey:@"tel"] forKey:@"tel"];
            //用户id
            [defaults setValue:[data objectForKey:@"user_id"] forKey:@"user_id"];
            //密码
            [defaults setValue:[data objectForKey:@"password"] forKey:@"password"];
            //个人简介
            [defaults setValue:[data objectForKey:@"introduction"] forKey:@"introduction"];
            //有效否
            [defaults setValue:[data objectForKey:@"isvalid"] forKey:@"isvalid"];
        }
    }];
    TXPerfetOersonalViewController *perfit=[[TXPerfetOersonalViewController alloc]init];
    [self.navigationController pushViewController:perfit animated:YES];

}
#pragma mark - TextField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    if (textField.tag ==102) {
//        self.view.frame =CGRectMake(0, -20, kScreenWidth, kScreenHeight);
//    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    if (textField.tag ==102) {
//        self.view.frame =CGRectMake(0, 20, kScreenWidth, kScreenHeight);
//    }

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [PasswordField resignFirstResponder];
    [confirmPasswordField resignFirstResponder];
    return YES;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
