//
//  APIManage.h
//  TXTeam
//
//  Created by yezejiang on 15-2-9.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#ifndef TXTeam_APIManage_h
#define TXTeam_APIManage_h

#define BASE_URL @"http://112.74.111.134:8080/tongxiang/"

//获取融云用户令牌 http://112.74.111.134:8080/tongxiang/rongcloud/getToken
#define GetRongyunToken @"user/getToken"
//检测账号是否已注册
#define existAccount @"user/existAccount"
//检测手机号是否已注册
#define existTel @"user/existTel"
//注册
#define register @"user/register"
//登录
#define _login @"user/login"
//根据手机号码修改密码(忘记密码)
#define updatePassByTel @"user/updatePassByTel"
//修改密码
#define updataPass @"user/updataPass"
//修改姓名
#define updateName @"user/updateName"
//修改性别
#define updateSex @"user/updateSex"
//修改出生日期
#define updateBirthday @"user/updateBirthday"
//修改家乡
#define updateArea @"user/updateArea"
//修改工作所在地
#define updateWorkplace @"user/updateWorkplace"
//修改个人简介
#define updateIntro @"user/updateIntro"
//查询汽车
#define getDeparture_Timetable @"user/getDeparture_Timetable"

//公共API
//1.提取省份列表
#define getProvince @"public/getProvince"
//2.提取城市列表
#define getCity @"public/getCity"
//3.提取区域列表
#define getArea @"public/getArea"

#endif
