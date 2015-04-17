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
#define RONGCLOUD_IM_APPKEY    @"k51hidwq1fxnb" //这个AppKey值RongCloud实例。
//短信验证
#define appKey @"5542fb9d0a79"
#define appSecret @"cf5c8690534f02f196c0139218209c08"
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize rechable;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOption
{
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    //实施网络状况监听
    rechable = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [rechable startNotifier];
    
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:8 * 1024 * 1024 diskCapacity:0 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    //连接短信验证码
    [self connectSMS];
    
    //连接融云即时通讯
    [self connectRCIM:application];
    
    TXLoginViewController *loginController=[[TXLoginViewController alloc]init];
    TXBaseNavController *navigotioncontroller =[[TXBaseNavController alloc]initWithRootViewController:loginController];
    // 设置背景颜色为黑色。
    [navigotioncontroller.navigationBar setBackgroundColor:[UIColor blackColor]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = navigotioncontroller;
    return YES;
}



- (void)connectSMS {
    //
    [SMS_SDK registerApp:appKey
              withSecret:appSecret];
}

- (void)connectRCIM:(UIApplication *)application {
    //初始化融云 SDk,传入app key,deviceToken 暂时胃口，等待获取权限
    [RCIM initWithAppKey:RONGCLOUD_IM_APPKEY deviceToken:nil];
    
        
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    //设置苹果push通知
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge
                                                                                             |UIRemoteNotificationTypeSound
                                                                                             |UIRemoteNotificationTypeAlert) categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    
    [[RCIM sharedRCIM]setReceiveMessageDelegate:self];
}
- (void)dealloc {
    //停止监听网络状况
    [rechable stopNotifier];
    // 删除通知对象
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
//#endif
-(void)didReceivedMessage:(RCMessage *)message left:(int)nLeft
{
    if (0 == nLeft) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber+1;
        });
    }
    
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"error:%@",error);
    //[RCIM initWithAppKey:RONGCLOUD_IM_APPKEY deviceToken:nil];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSLog(@"RemoteNote userInfo:%@",userInfo);
    NSLog(@" 收到推送消息： %@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSLog(@"deviceToken:%@",deviceToken);
    [[RCIM sharedRCIM]setDeviceToken:deviceToken];
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

@end
