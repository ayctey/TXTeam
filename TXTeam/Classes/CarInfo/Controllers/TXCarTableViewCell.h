//
//  TXCarTableViewCell.h
//  TXTeam
//
//  Created by 吖银 on 15-1-18.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//车辆班次cell

#import <UIKit/UIKit.h>

@interface TXCarTableViewCell : UITableViewCell
{
    
    UILabel *Carlab;
    

}

@property (nonatomic,strong) UILabel *CarGoTime;    //发车时间
@property (nonatomic,strong) UILabel *StartStation;  //出发站
@property (nonatomic,strong) UILabel *ArriveStation; //终点站
@property (nonatomic,strong) UILabel *StartCity;     //出发城市
@property (nonatomic,strong) UILabel *ArriveCity;    //到达城市
@property (nonatomic,strong) UILabel *price;         //价格
@property (nonatomic,strong) UILabel *CarStyle;      //汽车类型
@end
