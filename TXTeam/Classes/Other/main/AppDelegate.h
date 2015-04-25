//
//  AppDelegate.h
//  TXTeam
//
//  Created by ayctey on 15-1-2.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import <UIKit/UIKit.h>
// 引用 IMKit 头文件。
#import "RCIM.h"
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,RCIMReceiveMessageDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Reachability *rechable;
@property BOOL isInMainView;  //主页面是否已经加载

-(void)pushToLoginViewcontroller;
-(void)pushMaincomtroller;

@end

