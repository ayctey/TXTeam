//
//  MainViewController.h
//  TXTeam
//
//  Created by 吖银 on 15-1-12.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//
//菜单控制器
#import <UIKit/UIKit.h>

@interface MainViewController : UITabBarController
{
    UIButton *selectedBtn;

}


@property (nonatomic,strong) NSString *currentUserId;

@end
