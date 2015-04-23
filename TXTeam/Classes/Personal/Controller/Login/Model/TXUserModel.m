//
//  TXUserModel.m
//  TXTeam
//
//  Created by yezejiang on 15-4-10.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXUserModel.h"

@implementation TXUserModel

- (void)save {
    //将数据存到系统自带的单例中
    NSUserDefaults *defaults = [NSUserDefaults  standardUserDefaults];
    [defaults setValue:self.account forKey:@"account"];
    //家乡
    [defaults setValue:self.area forKey:@"area"];
    //头像
    [defaults setValue:self.protrait_url forKey:@"protrait_url"];
    //工作地区
    [defaults setValue:self.workplace forKey:@"workplace"];
    //性别
    [defaults setValue:self.sex forKey:@"sex"];
    //姓名
    [defaults setValue:self.name forKey:@"name"];
    //手机号码
    [defaults setValue:self.tel forKey:@"tel"];
    //用户id
    [defaults setValue:self.user_id forKey:@"user_id"];
    //密码
    [defaults setValue:self.password forKey:@"password"];
    //个人简介
    [defaults setValue:self.introduction forKey:@"introduction"];
    //有效否
    [defaults setValue:self.isvalid forKey:@"isvalid"];
   
}

@end
