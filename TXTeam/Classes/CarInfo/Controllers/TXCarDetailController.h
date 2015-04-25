//
//  TXCarDetailController.h
//  TXTeam
//
//  Created by yezejiang on 15-3-10.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//  汽车班次详情控制器

#import "TXBaseViewController.h"
@class TXCarInfoModel;

enum LabelTag {
    labelTag_price = 10,
    labelTag_begin_area_detail,
    labelTag_end_area_detail,
    labelTag_departure_time,
};
@interface TXCarDetailController : TXBaseViewController
{
    UIScrollView *scrollView;
}

@property (nonatomic,strong) TXCarInfoModel *carInfoModel;//时刻表模型
@property (nonatomic,strong) NSString *departureDate;

@end
