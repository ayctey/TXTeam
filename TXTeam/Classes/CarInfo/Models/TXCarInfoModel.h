//
//  TXCarInfoModel.h
//  TXTeam
//
//  Created by yezejiang on 15-2-12.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//车辆班次模型

#import "TXBaseModel.h"

@interface TXCarInfoModel : TXBaseModel

@property (nonatomic,strong) NSNumber *trainman_id;      //乘务员ID
@property (nonatomic,strong) NSNumber *departure_Timetable_id;    //发车时刻记录ID
@property (nonatomic,copy) NSString *end_area_id;        //到达区域ID
@property (nonatomic,copy) NSString *end_area;           //到达区域(如天河)
@property (nonatomic,copy) NSString *end_area_detail;    //到达详细区域(如天河客运站)
@property (nonatomic,strong) NSString *end_province_id;  //的地省份ID
@property (nonatomic,copy) NSString *end_province;       //目的地省份
@property (nonatomic,copy) NSString *end_city_id;        //目的地城市ID
@property (nonatomic,copy) NSString *end_city;           //目的地城市
@property (nonatomic,copy) NSString *begin_province_id;  //出发地省份ID
@property (nonatomic,copy) NSString *begin_province;     //出发地省份
@property (nonatomic,copy) NSString *begin_city_id;      //出发地城市ID
@property (nonatomic,strong) NSString *begin_city;       //出发地城市
@property (nonatomic,copy) NSString *begin_area_id;      //出发区域ID
@property (nonatomic,strong) NSString *begin_area;       //出发区域
@property (nonatomic,strong) NSString *begin_area_detail;//出发详细区域
@property (nonatomic,strong) NSString *remark;           //备注
@property (nonatomic,strong) NSString *departure_time;   //发车时间
@property (nonatomic,strong) NSString *arrive_time;      //到达时间
@property (nonatomic,strong) NSNumber *vehicle_id;       //车辆ID
@property (nonatomic,strong) NSString *plate_number;     //车牌号
@property (nonatomic,strong) NSNumber *price;            //票价

@end
