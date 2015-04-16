//
//  TXCarInfoCell.h
//  TXTeam
//
//  Created by yezejiang on 15-2-9.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TXCarInfoModel;

@interface TXCarInfoCell : UITableViewCell
{
    
    UILabel *Carlab;
    
    
}

@property (nonatomic,strong) UILabel *departure_time;    //发车时间
@property (nonatomic,strong) UILabel *begin_area_detail;  //出发站
@property (nonatomic,strong) UILabel *end_area_detail; //终点站
@property (nonatomic,strong) UILabel *begin_area;     //出发城市
@property (nonatomic,strong) UILabel *end_area;    //到达城市
@property (nonatomic,strong) UILabel *price;         //价格
@property (nonatomic,strong) UILabel *CarStyle;      //汽车类型
@property (nonatomic,strong) UILabel *begin_city;
@property (nonatomic,strong) UILabel *end_city;
@property (nonatomic,strong) TXCarInfoModel *carInfoModel;//汽车模型

@end
