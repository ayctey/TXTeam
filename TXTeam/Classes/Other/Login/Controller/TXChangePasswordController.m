//
//  TXChangePasswordController.m
//  CARPeer
//
//  Created by yezejiang on 15-1-12.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXChangePasswordController.h"
#import "Common.h"
#import "TXDataService.h"
#import "TXLoginViewController.h"
@interface TXChangePasswordController ()
{
    UITextField *newPasswordField;
    UITextField *confirmPasswordField;
}
@end

@implementation TXChangePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initViews];
}
#pragma mark - 加载数据

#pragma mark - 添加视图
- (void)initViews
{
    UIView *newPwView = [[UIView alloc] init];
    newPwView.backgroundColor = kBackgroundColor;
    newPwView.frame = CGRectMake(0, 10, kScreenWidth, 40);
    [self.view addSubview:newPwView];
    
    newPasswordField = [[UITextField alloc] init];
    newPasswordField.frame = CGRectMake(20, 5, kScreenWidth-40, 30);
    newPasswordField.placeholder = @"新密码";
    newPasswordField.secureTextEntry = YES;
    [newPwView addSubview:newPasswordField];
    
    UIView *confirmPwView = [[UIView alloc] init];
    confirmPwView.backgroundColor = kBackgroundColor;
    confirmPwView.frame = CGRectMake(0, 10+40+10, kScreenWidth, 40);
    [self.view addSubview:confirmPwView];
    
    confirmPasswordField = [[UITextField alloc] init];
    confirmPasswordField.frame = CGRectMake(20, 5, kScreenWidth-40, 30);
    confirmPasswordField.placeholder = @"确认新密码";
    confirmPasswordField.secureTextEntry = YES;
    [confirmPwView addSubview:confirmPasswordField];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"完 成" forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:[UIColor redColor]];
    [submitBtn setFrame:CGRectMake((kScreenWidth-200)/2, 100+20, 200, 30)];
    [submitBtn addTarget:self action:@selector(submitNewPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
}


#pragma mark - 点击事件
- (void)submitNewPassword
{
    //获取原来密码
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    NSString *formalPass= [defaults objectForKey:@"password"];
    

    if (![newPasswordField.text isEqualToString:confirmPasswordField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"输入的两次密码不相同！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
       }
    else if ([newPasswordField.text isEqual:@""] ||[confirmPasswordField.text isEqual:@""])
      {
          UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"提示" message:@"新密码不能为空！请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
          [alert2 show];
    
        }
    else if  ([newPasswordField.text isEqualToString:formalPass])
    {
        UIAlertView *worning = [[UIAlertView alloc]initWithTitle:@"提示" message:@"和原来密码一样！请重新修改！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [worning show];
    }
    
    else{
            
            //上传新密码
            NSDictionary *dic =@{@"password":newPasswordField.text};
            [TXDataService POST:updataPass param:dic completionBlock:^(id responseObject, NSError *error) {
            if ([responseObject objectForKey:@"success"]) {
               // NSLog(@"修改密码成功！！");
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的密码修改成功！请重新登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
              }
             }];
              }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==0) {
        TXLoginViewController *loginviewcntroller = [[TXLoginViewController alloc]init];
        loginviewcntroller.hidesBottomBarWhenPushed =  YES;
        [self.navigationController pushViewController:loginviewcntroller animated:YES];

    }


}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
