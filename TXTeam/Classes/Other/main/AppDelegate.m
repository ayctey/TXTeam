//
//  AppDelegate.m
//  TXTeam
//
//  Created by ayctey on 15-1-2.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "AppDelegate.h"
#import "TXLoginViewController.h"
#import "SMS_SDK/SMS_SDK.h"
#import "TXBaseNavController.h"
#import "MainViewController.h"
#import "TXLoginViewController.h"
#import "TXDataService.h"
#import "TXLoginRCIM.h"
#import "TXUserModel.h"
#import "Common.h"

@interface AppDelegate ()
{
    BOOL isLogined;
}

@end

@implementation AppDelegate
@synthesize rechable;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOption
{
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    //实施网络状况监听
    [self setNetworkMonitor];
    
    if (!isLogined) {
        //登陆
        [self isLogin];
    }
    
    //设置缓存大小
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:8 * 1024 * 1024 diskCapacity:0 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    //连接融云即时通讯
    [self connectRCIM:application];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)connectRCIM:(UIApplication *)application {
    //初始化融云 SDk,传入app key,deviceToken 暂时胃口，等待获取权限
    [RCIM initWithAppKey:RONGCLOUD_IM_APPKEY deviceToken:nil];
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    //设置苹果push通知
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert) categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    
    [[RCIM sharedRCIM]setReceiveMessageDelegate:self];
}

//#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}

-(void)didReceivedMessage:(RCMessage *)message left:(int)nLeft
{
    if (0 == nLeft) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber+1;
        });
    }
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"error:%@",error);
    [RCIM initWithAppKey:RONGCLOUD_IM_APPKEY deviceToken:nil];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSLog(@"RemoteNote userInfo:%@",userInfo);
    NSLog(@" 收到推送消息： %@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSLog(@"deviceToken:%@",deviceToken);
    [[RCIM sharedRCIM]setDeviceToken:deviceToken];
}

#pragma mark 进入前台后设置消息信息
-(void)applicationWillEnterForeground:(UIApplication *)application{
    //进入前台取消应用消息图标
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
}

-(UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

#pragma mark - 网络状况监听
-(void)setNetworkMonitor
{
    //实施网络状况监听
    rechable = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    //延时进行网络监测通知
    [self performSelector:@selector(startNotifier) withObject:nil afterDelay:0.01f];
}

//开始网络监测通知
-(void)startNotifier
{
    [rechable startNotifier];
}

//监控网络状态的变化
-(void)networkStateChange
{
    // 检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    // 判断网络状态
    if ([conn currentReachabilityStatus] != NotReachable) {
        [self isLogin];
    } else {
        //把登陆状态设置为NO
        isLogined = NO;
        
        // 没有网络
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"断网啦！" delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)dealloc {
    //停止监听网络状况
    [rechable stopNotifier];
    // 删除通知对象
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//判断是否曾经已经成功登陆，没有就重新登录
-(void)isLogin
{
    //获取本地账号密码
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //本地账号密码登陆
    if ([defaults objectForKey:@"account"] && [defaults objectForKey:@"password"]) {
        //是否有网络连接
        
        if (!rechable.isReachable) {
            //进入网络
            MyLog(@"recable:%d",rechable.isReachable);
            [self pushMaincomtroller];
        }else
        {
            NSDictionary *param = @{@"account":[defaults objectForKey:@"account"],@"password":[defaults objectForKey:@"password"]};
            [TXDataService POST:_login param:param isCache:NO caChetime:0 completionBlock:^(id responseObject, NSError *error) {
                NSDictionary *dic = responseObject;
                int success = [[dic objectForKey:@"success"] intValue];
                if (success) {
                    //把登陆状态设置为Yes
                    isLogined = YES;
                    
                    //链接融云
                    [[TXLoginRCIM shareLoginRCIM] connectRCIM];
                    
                    MyLog(@"%@",[responseObject objectForKey:@"data"]);
                    NSDictionary *data = [responseObject objectForKey:@"data"];
                    
                    //保存用户信息
                    TXUserModel *userModel = [[TXUserModel alloc] initWithDataDic:data];
                    [userModel save];
                    
                    //进入主页
                    [self pushMaincomtroller];
                }
            }];
        }
    }
    else
    {
        //进入登陆界面
        TXLoginViewController *login = [[TXLoginViewController alloc] init];
        TXBaseNavController *nav = [[TXBaseNavController alloc] initWithRootViewController:login];
        nav.navigationBarHidden = YES;
        self.window.rootViewController = nav;
    }
}

#pragma mark - LoginDelegate

//进入主页
-(void)pushMaincomtroller
{
    self.window.rootViewController = nil;
    MainViewController *mainCtrl = [[MainViewController alloc] init];
    self.window.rootViewController = mainCtrl;
}

//进入登陆界面
-(void)pushToLoginViewcontroller
{
    self.window.rootViewController = nil;
    TXLoginViewController *loginViewController = [[TXLoginViewController alloc] init];
    self.window.rootViewController = loginViewController;
}

@end
