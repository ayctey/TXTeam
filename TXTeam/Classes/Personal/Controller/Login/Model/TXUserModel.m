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
    //生日
    [defaults setValue:self.Birthday forKey:@"Birthday"];
    
    //家乡id
    [defaults setValue:self.area_id forKey:@"area_id"];
    //家乡省份
    [defaults setValue:self.home_province forKey:@"home_province"];
    //家乡省份
    [defaults setValue:self.home_city forKey:@"home_city"];
    //家乡省份
    [defaults setValue:self.home_area forKey:@"home_area"];
    
    //工作地区id
    [defaults setValue:self.workplace forKey:@"workplace"];
    //工作省份
    [defaults setValue:self.work_province forKey:@"work_province"];
    //工作城市
    [defaults setValue:self.work_city forKey:@"work_city"];
    //工作地域
    [defaults setValue:self.work_area forKey:@"work_area"];
    
    //头像URL
    [defaults setValue:self.protrait_url forKey:@"protrait_url"];
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
