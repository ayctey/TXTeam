//
//  TXLoginRCIM.m
//  CARPeer
//
//  Created by ayctey on 15-4-10.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXLoginRCIM.h"
#import "TXDataService.h"
#import "SMS_SDK/SMS_SDK.h"
#import "Common.h"
#import "APIManage.h"

//#define RYAppKey @"mgb7ka1nbs6yg"
//#define appKey @"5542fb9d0a79"
//#define appSecret @"cf5c8690534f02f196c0139218209c08"

@implementation TXLoginRCIM

static id _instance;

+(id)shareLoginRCIM
{
    static dispatch_once_t onceLogin;
    dispatch_once(&onceLogin, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

-(id)init
{
    static id obj = nil;
    static dispatch_once_t onceLogin;
        dispatch_once(&onceLogin, ^{
            obj=[super init];
        });
    self = obj;
    return self;
}

//控制内存的分配，永远只分配一次存储空间
+(id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceAlloc;
    dispatch_once(&onceAlloc, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return _instance;
}

//登陆融云
-(void)connectRCIM
{
     NSString *token = [self getRCIMToken];
    
    //短信验证服务器连接
    [SMS_SDK registerApp:SMSAppKey
              withSecret:SMSAppSecret];
    
    //注册融云
    [RCIM initWithAppKey:RONGCLOUD_IM_APPKEY deviceToken:nil];
    
    MyLog(@"token:%@",token);
    if (![token length] == 0) {
        // 连接融云服务器。
        [RCIM connectWithToken:token completion:^(NSString *userId) {
            // 此处处理连接成功。
            MyLog(@"Login successfully with userId: %@.", userId);
        } error:^(RCConnectErrorCode status) {
            // 此处处理连接错误。
            MyLog(@"Login failed.");
        }];
    }
}

//获取融云Token
-(NSString *)getRCIMToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    MyLog(@"token:%@",token);
    //获取融云令牌
    if ([token length] == 0) {
        [TXDataService POST:GetRongyunToken param:nil isCache:NO caChetime:0 completionBlock:^(id responseObject, NSError *error) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSString *token = [dic objectForKey:@"token"];
            NSString *userRongYunID = [dic objectForKey:@"userId"];
            if (error==nil) {
                //保存token和融云ID在本地
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setValue:token forKey:@"token"];
                [defaults setValue:userRongYunID forKey:@"userRongYunID"];
                
                //登陆融云
                [RCIM connectWithToken:token completion:^(NSString *userId) {
                    // 此处处理连接成功。
                    MyLog(@"Login successfully with userId: %@.", userId);
                } error:^(RCConnectErrorCode status) {
                    // 此处处理连接错误。
                    MyLog(@"Login failed.");
                }];
            }
        } ];
    }

    return  token;
}


@end
