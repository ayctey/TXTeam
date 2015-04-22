//
//  TXLoginViewController.m
//  TXTeam
//
//  Created by 吖银 on 15-1-12.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXLoginViewController.h"
#import "MMProgressHUD.h"
#import "UserDataModel.h"
//菜单控制器
#import "MainViewController.h"
//注册控制器
#import "TXRegisterViewController.h"
#import "Common.h"
//忘记密码、修改密码 短信验证
#import "TXMessageAuthenticationController.h"
#import "TXSettingPasswordViewController.h"
#import "TXLoginRCIM.h"
#import "TXUserModel.h"
#import "TXDataService.h"
#import "RCIM.h"

@interface TXLoginViewController ()<RCIMFriendsFetcherDelegate, RCIMUserInfoFetcherDelegagte>

@end

@implementation TXLoginViewController

-(void)viewWillAppear:(BOOL)animated
{
   self.navigationController.navigationBarHidden=YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    [self initMianview];
    
    UITextField* userEmail = (UITextField *)[self.view viewWithTag:Tag_PhoneTextField];
    UITextField* userPSWord= (UITextField *)[self.view viewWithTag:Tag_TempPasswordTextField];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //拿出用户名和密码
    if ([defaults objectForKey:@"userName"] && [defaults objectForKey:@"password"]) {
        userEmail.text = [defaults objectForKey:@"userName"];
        userPSWord.text = [defaults objectForKey:@"password"];
    }
    
    loginToken = nil;
}

-(void)initMianview {
    
    //登陆界面背景颜色
    UIImageView *bgImageView = [self ImageViewWithFrame:self.view.bounds Image:@"登录背景.png" In:self.view];
    [self.view addSubview:bgImageView];
   
    //创一个imageview来存放输入框
    inputBackground = [self ImageViewWithFrame:CGRectMake(20, kScreenWidth/4+30, kScreenWidth-40, kScreenWidth-80) Image:@"" In:bgImageView];
    inputBackground.backgroundColor=[UIColor colorWithRed:233 green:233 blue:233 alpha:0.4];
    inputBackground.layer.cornerRadius = 8;
    
    UIImageView *imageView2 = [self ImageViewWithFrame:CGRectMake(20, 30, inputBackground.frame.size.width-40, 120) Image:@"" In:inputBackground];
    imageView2.backgroundColor = [UIColor colorWithRed:233 green:233 blue:233 alpha:0.4];
    
    [self ImageViewWithFrame:CGRectMake(15, 10+5, 35, 35) Image:@"登录-人头@2x" In:imageView2];
    
    [self ImageViewWithFrame:CGRectMake(15, 10+40+20+5, 30, 30) Image:@"锁@2x" In:imageView2];
   
    //账号输入框
    usernameTextField = [[UITextField alloc] init];
    usernameTextField.tag = Tag_PhoneTextField;
    usernameTextField.frame = CGRectMake(20+50, 10, imageView2.frame.size.width-90, 40);
    usernameTextField.returnKeyType = UIReturnKeyNext;
    usernameTextField.keyboardType = UIKeyboardTypeNumberPad;
    usernameTextField.borderStyle = UITextBorderStyleNone;
    if ([usernameTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = HEXCOLOR(0xffffff);
        usernameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"手机号码", nil)
                                                                                  attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        usernameTextField.placeholder = NSLocalizedString(@"用户名", nil);
    }
    //再次登陆时有默认账号
    usernameTextField.text = [self getDefaultUser];

    [imageView2 addSubview:usernameTextField];
    
    passwordTextField = [[UITextField alloc] init];
    passwordTextField.tag = Tag_TempPasswordTextField;
    passwordTextField.frame = CGRectMake(20+50, 10+40+20, imageView2.frame.size.width-90, 40);
    passwordTextField.returnKeyType = UIReturnKeyDone;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.delegate = self;
    
    //判断是否有文字输入
    if ([passwordTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"密码", nil)
                                                                                  attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        passwordTextField.placeholder = NSLocalizedString(@"密码", nil);
    }
    
    passwordTextField.text = [self getDefaultUserPwd];
    [imageView2 addSubview:passwordTextField];
    MyLog(@"密码：：%@",passwordTextField.text);
    MyLog(@"账号：：%@",usernameTextField.text);
    
    //分割线
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.frame = CGRectMake(0, 20+40, inputBackground.frame.size.width-40, 1);
    [imageView2 addSubview:lineLabel];
    lineLabel.backgroundColor = [UIColor whiteColor];
    
    //登陆按钮
    CGFloat inputWidth =inputBackground.frame.size.width;
    MyLog(@"nnn :%f",inputWidth);
    CGFloat buttonWidth = inputWidth *0.42;
    loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitle:@"登录中" forState:UIControlStateDisabled];
    
    loginButton.frame=CGRectMake((inputWidth/2-buttonWidth)/2+inputWidth/2, imageView2.frame.origin.y+150, buttonWidth, 40);
    
    loginButton.backgroundColor= [UIColor colorWithRed:(float)86/255 green:(float)186/255 blue:(float)219/255 alpha:1.0];
    loginButton.layer.cornerRadius = 4;
      [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [inputBackground addSubview:loginButton];
    
    //注册按钮
    signupButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [signupButton setTitle:@"注册" forState:UIControlStateNormal];
    signupButton.frame=CGRectMake((inputWidth/2-buttonWidth)/2, imageView2.frame.origin.y+150, buttonWidth, 40);
    signupButton.backgroundColor= [UIColor colorWithRed:(float)86/255 green:(float)186/255 blue:(float)219/255 alpha:1.0];
    signupButton.layer.cornerRadius = 4;
    [signupButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [signupButton addTarget:self action:@selector(prepareForSignup:) forControlEvents:UIControlEventTouchUpInside];
    [inputBackground addSubview:signupButton];
    
    forgetPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPassword setFrame:CGRectMake(kScreenWidth-120, inputBackground.frame.origin.y+kScreenWidth-80+30, 120, 25)];
    [forgetPassword setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetPassword setTitleColor:[UIColor colorWithRed:(float)86/255 green:(float)186/255 blue:(float)219/255 alpha:1.0] forState:UIControlStateNormal];
    [forgetPassword addTarget:self action:@selector(forgetPasswordClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPassword];

}

//默认账号
-(NSString*)getDefaultUser
{
    NSString* defaultUser = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    return defaultUser;
}

//默认密码
-(NSString*)getDefaultUserPwd
{
    NSString* defaultUserPwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    return defaultUserPwd;
}

#pragma mark - button action
- (void)login:(id)sender  {
    //获取用户输入的用户名和密码
    NSString* userEmail = [(UITextField *)[self.view viewWithTag:Tag_PhoneTextField] text];
    NSString* userPSWord= [(UITextField *)[self.view viewWithTag:Tag_TempPasswordTextField] text];
    
    //结束编辑
    [self.view endEditing:YES];
    
    //判断用户名和密码是否为空
    if ([userEmail isEqual:@"" ]|| [userPSWord isEqual:@"" ]) {
        //用户名或密码为空
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或密码不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else
    {
        //添加指示器
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
        [MMProgressHUD showWithTitle:@"" status:@"正在登录…" cancelBlock:nil];
        
        //发送登录请求
        NSDictionary *param =  @{@"account":userEmail,
                                 @"password":userPSWord};
        [TXDataService POST:_login param:param isCache:NO caChetime:0 completionBlock:^(id responseObject, NSError *error) {
            if (error || ![[responseObject objectForKey:@"success"] isEqual:@(1)]) {
                //登录失败
                [MMProgressHUD dismissWithError:@"登录失败！"];
                return ;
            }
            //注册融云
//            [self registerRongYun];
            [[TXLoginRCIM shareLoginRCIM] connectRCIM];
            
            //登录成功保存信息
            NSDictionary *data = [responseObject objectForKey:@"data"];
            TXUserModel *userModel = [[TXUserModel alloc] initWithDataDic:data];
            [userModel save];
            [self setDefaultUser:userEmail  pwd:userPSWord];
            //进入主页面
            MainViewController *mainview=[[MainViewController alloc]init];
            [self.navigationController setNavigationBarHidden:YES];
            [self.navigationController pushViewController:mainview animated:YES];
            
            [MMProgressHUD dismiss];
            
        }];
    }
}

//拿到融云服务器token
-(void)registerRongYun {
    
    [TXDataService GET:GetRongyunToken param:nil isCache:NO caChetime:0 completionBlock:^(id responseObject, NSError *error) {
        MyLog(@"%@  %@",responseObject,error);
        if (error) {
            NSLog(@"***********%@",error);
            [MMProgressHUD dismissWithError:@"登录失败！"];
            return ;
        }
        //连接融云
        [self connectRongyunWithToken:[responseObject objectForKey:@"token"]];
    }];
}

- (void)connectRongyunWithToken:(NSString *)token {
    NSLog(@"------token:%@",token);
    [RCIM connectWithToken:token completion:^(NSString *userId) {
        //连接成功
        NSLog(@"********id:%@",userId);
    } error:^(RCConnectErrorCode status) {
        //连接失败
        NSLog(@"***********");
        [MMProgressHUD dismissWithError:@"登录失败！"];
        return ;
    }];
    NSLog(@"++++___+++");
}

-(void)setDefaultUser:(NSString*)user pwd:(NSString*)pwd
{
    if(user == nil)
    {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:user forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setUserDefaultValue:(id)value forKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
}

//用来请求本地服务器
-(void)loginToFakeServer
{
    NSString* userPhoneNumbers = [(UITextField *)[self.view viewWithTag:Tag_PhoneTextField] text];
    NSString* userPSWord= [(UITextField *)[self.view viewWithTag:Tag_TempPasswordTextField] text];
    NSString* deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceToken"];
    //----登录server----//
    NSString* strParams = [NSString stringWithFormat:@"%@=%@&%@=%@&%@=%@",@"PhoneNumbers",userPhoneNumbers,@"password",userPSWord, @"deviceid",(deviceToken==nil?@"":deviceToken)];
    
    self.loginRequest = [[RCHttpRequest alloc]init];
    self.loginRequest.tag = 1000;
    //登陆本地服务器地址（修改FAKE_SERVER）
    [self.loginRequest httpConnectionWithURL:[NSString stringWithFormat:@"%@login",FAKE_SERVER]
                                    bodyData:[strParams dataUsingEncoding:NSUTF8StringEncoding]
                                    delegate:self];
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showWithTitle:@"正在登录" status:@"……" cancelBlock:nil];
    NSLog(@"devicetoken:---->:%@",deviceToken);
    
    
}
#pragma mark - ForgetPassword method
//忘记密码方法
-(void)forgetPasswordClick
{
    self.navigationController.navigationBarHidden=NO;
    TXMessageAuthenticationController *CheckMessage =[[TXMessageAuthenticationController alloc]init];
    [CheckMessage pushTo:VCChangePasswordController];
    [self.navigationController pushViewController:CheckMessage animated:YES];
    
}
#pragma mark checkValidityTextField Null
//检查文本框输入是否为空
- (BOOL)checkValidityTextField
{
    if ([(UITextField *)[self.view viewWithTag:Tag_PhoneTextField] text] == nil || [[(UITextField *)[self.view viewWithTag:Tag_PhoneTextField] text] isEqualToString:@""]) {
        
        [self alertTitle:@"提示" message:@"手机号码不能为空！" delegate:self cancelBtn:@"取消" otherBtnName:nil];
        
        return NO;
    }
    if ([(UITextField *)[self.view viewWithTag:Tag_TempPasswordTextField] text] == nil || [[(UITextField *)[self.view viewWithTag:Tag_TempPasswordTextField] text] isEqualToString:@""]) {
        
        [self alertTitle:@"提示" message:@"用户密码不能为空" delegate:self cancelBtn:@"取消" otherBtnName:nil];
        
        return NO;
    }
    if (![self isValidatePhone:[(UITextField *)[self.view viewWithTag:Tag_PhoneTextField] text]]) {
        
        [self alertTitle:@"提示" message:@"手机号码格式不正确" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
        return NO;
    }
    //#if CHECK_PASSWORD_ENABLE
    NSUInteger length=[(UITextField *)[self.view viewWithTag:Tag_TempPasswordTextField] text].length;
    if (length< 6) {
        
        [self alertTitle:@"提示" message:@"用户密码小于6位！" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
        return NO;
    }
    //#endif//CHECK_PASSWORD_ENABLE
    
    return YES;
    
}
#pragma mark - RegisterBtnClicked Method
//注册按钮方法
- (void)prepareForSignup:(id)sender {
    
    
    self.navigationController.navigationBarHidden =NO;
    
    
    TXMessageAuthenticationController *message =[[TXMessageAuthenticationController alloc]init];
    [message pushTo:VCSetingPassWord];
    message.Cool = @"yes";
    [self.navigationController pushViewController:message animated:YES];
    
    }
#pragma mark - UITextField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case Tag_PhoneTextField:
        {
            if ([textField text] != nil && [[textField text] length]!= 0) {
                
                if (![self isValidatePhone:textField.text]) {
                    
                    [self alertTitle:@"提示" message:@"手机号码格式不正确" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
                    return;
                }
                
            }
        }
            break;
        case Tag_TempPasswordTextField:
        {
            if ([textField text] != nil && [[textField text] length]!= 0) {
#if CHECK_PASSWORD_ENABLE
                if ([[textField text] length] < 6) {
                    
                    [self alertTitle:@"提示" message:@"用户密码小于6位！" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
                    return;
                }
#endif//CHECK_PASSWORD_ENABLE
            }
        }
            break;
            
        default:
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

//触摸手势方法
#pragma mark - touchMethod
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    
    [self invalidateFirstResponders];
}
#pragma mark - PrivateMethod
- (UIImageView *)ImageViewWithFrame:(CGRect)frame Image:(NSString *)image In:(UIView *)view
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = frame;
    imageView.image = [UIImage imageNamed:image];
    imageView.userInteractionEnabled = YES;
    [view addSubview:imageView];
    return imageView;
}

//利用正则表达式检查手机号码的合法性
-(BOOL)isValidatePhone :(NSString *)mobileNum {
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//设置textfield的第一响应者
- (void)invalidateFirstResponders{
    
    //用户名
    [[self.view viewWithTag:Tag_PhoneTextField] resignFirstResponder];
    //密码
    [[self.view viewWithTag:Tag_TempPasswordTextField] resignFirstResponder];
}

-(UIAlertView *)alertTitle:(NSString *)title message:(NSString *)msg delegate:(id)aDeleagte cancelBtn:(NSString *)cancelName otherBtnName:(NSString *)otherbuttonName{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:aDeleagte cancelButtonTitle:cancelName otherButtonTitles:otherbuttonName, nil];
    [alert show];
    return alert;
}

//接收本地服务器数据
#pragma mark - HttpConnectionDelegate
- (void)responseHttpConnectionSuccess:(RCHttpRequest *)request
{
    
    if (1000 == request.tag) {
        if(request.response.statusCode == 200)
        {
            NSError* error = nil;
            NSDictionary * regDataDict = [NSJSONSerialization JSONObjectWithData:request.responseData options:kNilOptions error:&error];
            
            NSString* token = regDataDict[@"token"];
            //NSLog(@"token is ::::%@",token);
            loginToken = token;
            
            UserDataModel *curUser = [[UserDataModel alloc] initWithUserData:[NSString stringWithFormat:@"%d",[regDataDict[KUserDataModel_Key_UserID] intValue]] userName:regDataDict[KUserDataModel_Key_UserName] userNamePY:@"" portrait:@"" user_PhoneNumbers:regDataDict[KUserDataModel_Key_UserPhoneNumbers]];
            [UserManager shareMainUser].mainUser = curUser;
            
            RCUserInfo *userInfo = [RCUserInfo new];
            userInfo.userId = regDataDict[KUserDataModel_Key_UserID];
            userInfo.name = regDataDict[KUserDataModel_Key_UserName];
            [self requestFriendsList];
        }
        else
        {
            [MMProgressHUD dismiss];
            DebugLog(@"Connection Result:%@",request.response);
            [self alertTitle:@"提示"
                     message:[NSString stringWithFormat:@"帐号或密码错误，无法登录 : %d",(int)request.response.statusCode ]
                    delegate:nil
                   cancelBtn:@"确定"
                otherBtnName:nil];
        }
    }
    
    else{
        
        if(request.response.statusCode == 200)
        {
            NSError* error = nil;
            NSArray * regDataArray = [NSJSONSerialization JSONObjectWithData:request.responseData options:kNilOptions error:&error];
            
            // DebugLog(@"jjjjjjjjj：%@//kkkkkkkkk",regDataArray);
            
            self.allFriendsArray = [[NSMutableArray alloc]initWithCapacity:0];
            for(int i= 0;i <regDataArray.count;i++){
                
                NSDictionary *dic = regDataArray[i];
                RCUserInfo *userInfo = [RCUserInfo new];
                NSNumber *idNum = dic[@"id"];
                userInfo.userId = [NSString stringWithFormat:@"%d",idNum.intValue];
                userInfo.portraitUri = dic[@"portrait"];
                userInfo.name = dic[@"username"];
                //----好友列表中将自己排除掉。
                if([[UserManager shareMainUser].mainUser.userId isEqualToString:userInfo.userId])
                {
                    continue;
                }
                [self.allFriendsArray addObject:userInfo];
            }
            
            //----为刘备or吕蒙不同环境预留。----//
            typeof(self) __weak weakSelf = self;
            
            //使用DEMO注意：更换appkey，一定要更换对应的连接token，如果token未做变化，默认会从融云测试环境获取，照成appkey和token不一致
            [RCIM connectWithToken:loginToken completion:^(NSString *userId) {
                
                NSLog(@",,,,,,,,,%@的token为%@",userId,loginToken);
                [MMProgressHUD dismissWithSuccess:@"登录成功!"];
                //登陆成功后跳转的界面
                //功能主界面
                MainViewController *temp=[[MainViewController alloc]init];
                temp.currentUserId = userId;
                [weakSelf.navigationController pushViewController:temp animated:YES];
            } error:^(RCConnectErrorCode status) {
                if(status == 0)
                {
                    [MMProgressHUD dismissWithSuccess:@"登录成功!"];
                    MainViewController *temp=[[MainViewController alloc]init];
                    [weakSelf.navigationController pushViewController:temp animated:YES];
                }
                else
                {
                    [MMProgressHUD dismissWithSuccess:[NSString stringWithFormat:@"登录失败！\n Code: %d！", (int)status]];
                }
            }];
            [RCIM setFriendsFetcherWithDelegate:self];
            [RCIM setUserInfoFetcherWithDelegate:self isCacheUserInfo:NO];
        }
        else
        {
            self.allFriendsArray = nil;
        }
    }
    
}

- (void)responseHttpConnectionFailed:(RCHttpRequest *)connection didFailWithError:(NSError *)error
{
    if (1000 == connection.tag) {
        [MMProgressHUD dismiss];
        [self alertTitle:@"提示" message:@"网络原因，登录失败" delegate:nil cancelBtn:@"确定" otherBtnName:nil];
    }
    
}

#pragma mark - RCConnectFinishedDelegate
-(void)responseConnectSuccess:(NSString *)userId
{
    DebugLog(@"DEMO: currerntUserId: %@",userId);
    [MMProgressHUD dismissWithSuccess:@"登录成功!"];
    
    
    MainViewController *temp = [[MainViewController alloc]init];
    
    [self.navigationController pushViewController:temp animated:YES];
}

-(void)responseConnectError:(RCConnectErrorCode)status
{
    if(status == 0)
    {
        [MMProgressHUD dismissWithSuccess:@"登录成功!"];
        MainViewController *temp = [[MainViewController alloc]init];
        [self.navigationController pushViewController:temp animated:YES];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MMProgressHUD dismissWithSuccess:[NSString stringWithFormat:@"登录失败！\n Code: %d！",(int)status]];
        });
    }
}

-(void)requestFriendsList
{
    //获取好友列表
    NSString *url = [NSString stringWithFormat:@"%@%@",FAKE_SERVER,@"friends"];
    
    NSString* strParams = [NSString stringWithFormat:@"cookie=%@",[UserManager shareMainUser].mainUser.userPhoneNumbers];
    NSLog(@"http reuqest body %@",strParams);
    self.friendRquest = [[RCHttpRequest alloc]init];
    self.friendRquest.tag = 1001;
    [self.friendRquest httpConnectionWithURL:url bodyData:[strParams dataUsingEncoding:NSUTF8StringEncoding] delegate:self];
}

#pragma mark - RCIMFriendsFetcherDelegate method
// 获取好友列表的方法。
-(NSArray *)getFriends
{
    return self.allFriendsArray;
}

#pragma mark - RCIMUserInfoFetcherDelegagte method
// 获取用户信息的方法。（即显示在列表上用户）
-(RCUserInfo *)getUserInfoWithUserId:(NSString *)userId
{
    RCUserInfo *user  = nil;
    if([userId length] == 0)
        return nil;
    for(RCUserInfo *u in self.allFriendsArray)
    {
        if([u.userId isEqualToString:userId])
        {
            user = u;
            break;
        }
    }
    return user;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
