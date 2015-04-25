//
//  TXUserModel.h
//  TXTeam
//
//  Created by yezejiang on 15-4-10.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXBaseModel.h"

@interface TXUserModel : TXBaseModel

@property (nonatomic ,copy) NSString *account;      //账号
@property (nonatomic ,copy) NSString *Birthday;     //生日
@property (nonatomic ,copy) NSString *sex;          //性别

@property (nonatomic ,copy) NSString *area_id;      //家乡ID
@property (nonatomic ,copy) NSString *home_province;//家乡省份
@property (nonatomic ,copy) NSString *home_city;    //家乡城市
@property (nonatomic ,copy) NSString *home_area;    //家乡地域

@property (nonatomic ,copy) NSString *workplace;    //工作地域
@property (nonatomic ,copy) NSString *work_province;//工作省份
@property (nonatomic ,copy) NSString *work_city;    //工作城市
@property (nonatomic ,copy) NSString *work_area;    //工作地域

@property (nonatomic ,copy) NSString *protrait_url; //头像URL
@property (nonatomic ,copy) NSString *name;         //姓名
@property (nonatomic ,copy) NSString *tel;          //电话
@property (nonatomic ,strong) NSNumber *user_id;    //用户ID
@property (nonatomic ,copy) NSString *code;         //融云ID前缀
@property (nonatomic ,copy) NSString *password;     //密码
@property (nonatomic ,copy) NSString *introduction; //简介
@property (nonatomic ,strong) NSNumber *isvalid;    //是否可用

- (void)save;

@end
