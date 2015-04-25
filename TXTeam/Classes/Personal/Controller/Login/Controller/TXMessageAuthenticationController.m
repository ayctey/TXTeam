//
//  TXMessageAuthenticationController.m
//  CARPeer

//短信验证控制器

//  Created by yezejiang on 15-1-12.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXMessageAuthenticationController.h"
#import "TXChangePasswordController.h"
#import "SMS_SDK/SMS_SDK.h"
#import "SMS_SDK/CountryAndAreaCode.h"
#import "Common.h"
#import "TXSettingPasswordViewController.h"
#import "TXDataService.h"
@interface TXMessageAuthenticationController ()
{
    UIButton *validationBtn;
    int time;
    UITextField *verificationCodeTF;
    UITextField *phoneNumberTF;
    
}
@end

@implementation TXMessageAuthenticationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    time = 60;
    [self initViews];
}

#pragma mark - 添加视图
- (void)initViews
{
    UILabel *navLabel = [[UILabel alloc] init];
    navLabel.frame = CGRectMake(0, 0, kScreenWidth, 50);
    navLabel.text = @"输入验证码->验证";
    navLabel.font = [UIFont systemFontOfSize:15.0f];
    navLabel.backgroundColor = kBackgroundColor;
    navLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:navLabel];
    
    UIView *bgView1 = [[UIView alloc] init];
    bgView1.frame = CGRectMake(0, 60, kScreenWidth, 50);
    bgView1.backgroundColor = kBackgroundColor;
    [self.view addSubview:bgView1];
    
    phoneNumberTF = [[UITextField alloc] init];
    phoneNumberTF.frame = CGRectMake(20, 10, kScreenWidth-90, 30);
    phoneNumberTF.placeholder = @"手机号";
    phoneNumberTF.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumberTF.tag =101;
    [bgView1 addSubview:phoneNumberTF];
    
    validationBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [validationBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [validationBtn setFrame:CGRectMake(kScreenWidth-100, 10, 80, 30)];
    [validationBtn addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    [bgView1 addSubview:validationBtn];
    
    UIView *bgView2 = [[UIView alloc] init];
    bgView2.frame = CGRectMake(0, 60+52, kScreenWidth, 50);
    bgView2.backgroundColor = kBackgroundColor;
    [self.view addSubview:bgView2];
    
    verificationCodeTF = [[UITextField alloc] init];
    verificationCodeTF.frame = CGRectMake(20, 10, kScreenWidth-90, 30);
    verificationCodeTF.placeholder = @"验证码";
    verificationCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    [bgView2 addSubview:verificationCodeTF];
    
    UIButton *verificationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [verificationBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [verificationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [verificationBtn setBackgroundImage:[UIImage imageNamed:@"Title bar.png"]  forState:UIControlStateNormal];
    [verificationBtn setFrame:CGRectMake((kScreenWidth-120)/2, bgView2.frame.origin.y+70, 120, 40)];
    [verificationBtn addTarget:self action:@selector(verificationClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:verificationBtn];
}

#pragma mark - 点击事件
- (void)sendMessage:(UIButton *)button
{
    
    if (_Cool !=nil) {
        [self WheatherRegister];
        NSLog(@"hehe:%@",_Cool);
    }
    else{
        [self GetphoneCode];
    }
}

- (void)verificationClick
{
    if(verificationCodeTF.text.length!=4)
    {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"请输入四位验证码", nil) delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [SMS_SDK commitVerifyCode:verificationCodeTF.text result:^(enum SMS_ResponseState state) {
            if (1==state) {
                NSLog(@"验证成功");
                [self pushToViewController];
            }
            else if(0==state)
            {
                NSLog(@"验证失败");
                NSString* str=[NSString stringWithFormat:NSLocalizedString(@"验证失败", nil)];
                UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:str delegate:self cancelButtonTitle:NSLocalizedString(@"确定", nil)  otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
  }
}

- (void)countdown:(NSTimer *)timer
{
    time--;
    [validationBtn setTitle:[NSString stringWithFormat:@"%dS",time] forState:UIControlStateDisabled];
    validationBtn.enabled = NO;
    if (time == 0) {
        [validationBtn setTitle:@"发送短信" forState:UIControlStateNormal];
        validationBtn.enabled = YES;
        time = 60;
        [timer invalidate];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)verificationCode
{
    
}
//获取手机验证码
-(void)GetphoneCode {

    [SMS_SDK getVerifyCodeByPhoneNumber:[NSString stringWithFormat:@"%@",phoneNumberTF.text] AndZone:@"86" result:^(enum SMS_GetVerifyCodeResponseState state) {
        
        if (1==state) {
            NSLog(@"block 获取验证码成功");
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown:) userInfo:nil repeats:YES];
            
        }
        else if(0==state)
        {
            NSLog(@"block 获取验证码失败");
            NSString* str=[NSString stringWithFormat:NSLocalizedString(@"获取验证码失败", nil)];
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:str delegate:self cancelButtonTitle:NSLocalizedString(@"sure", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (SMS_ResponseStateMaxVerifyCode==state)
        {
            NSString* str=[NSString stringWithFormat:NSLocalizedString(@"maxcodemsg", nil)];
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"maxcode", nil) message:str delegate:self cancelButtonTitle:NSLocalizedString(@"sure", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
        else if(SMS_ResponseStateGetVerifyCodeTooOften==state)
        {
            NSString* str=[NSString stringWithFormat:NSLocalizedString(@"获取验证码太频繁，请稍后再试", nil)];
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:str delegate:self cancelButtonTitle:NSLocalizedString(@"sure", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

//判断手机号码是否注册过
-(void)WheatherRegister
{
    UITextField *tel = (UITextField *)[self.view viewWithTag:101];
    NSDictionary *dic = @{@"tel":tel.text};
    [TXDataService POST:existTel param:dic isCache:NO caChetime:0 completionBlock:^(id responseObject, NSError *error) {
        NSNumber *ss=[responseObject objectForKey:@"result"];
        //注册过
        if ([ss boolValue]) {
            UIAlertView *aleartview = [[UIAlertView alloc]initWithTitle:@"提示" message:@"此手机号码已被注册过！请直接登录！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [aleartview show];
        }
        else{
            //NSLog(@"未被注册");
            [self GetphoneCode];
        }
    }];

}
- (void)pushToViewController
{

    if (viewController == VCChangePasswordController) {
        
        self.title = @"修改密码";
        TXChangePasswordController *changePasswordVC = [[TXChangePasswordController alloc] init];
        UITextField *telTwxtField = (UITextField *)[self.view viewWithTag:101];
        changePasswordVC.tel =  telTwxtField.text;
        if (!self.isLogin) {
            changePasswordVC.isModifyBytel = YES;
        }
        
        [self.navigationController pushViewController:changePasswordVC animated:YES];
    }
    if (viewController ==VCSetingPassWord) {
 
        self.title =@"注册";
        UITextField *phoneText =(UITextField *)[self.view viewWithTag:101];
        _phonenumbs=phoneText.text;
        NSLog(@"手机号码:%@",_phonenumbs);
        TXSettingPasswordViewController *settingPassword =[[TXSettingPasswordViewController alloc]init];
        [settingPassword GetPhoneNum:_phonenumbs];
        [self.navigationController pushViewController:settingPassword animated:YES];
    }
}

- (void)pushTo:(enum WhichViewController)vc
{
    viewController = vc;
}

-(void)getUserPhonenums:(NSString *)numbers{
    
    UITextField *phonetext  = (UITextField *)[self.view viewWithTag:101];
    phonetext.text = numbers;

}
@end
