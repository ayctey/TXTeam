//
//  TXCarInfoCell.m
//  TXTeam
//
//  Created by yezejiang on 15-2-9.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXCarInfoCell.h"
#import "TXCarInfoModel.h"
#import "RCIM.h"
#import "NSString+Addition.h"
#import "Common.h"

@implementation TXCarInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kBackgroundColor;
//        [self initMainview];
    }
    return self;
}

-(void)initMainview{
   NSArray *cellsubviews = [self.contentView subviews];
    
    [cellContentView removeFromSuperview];
    //cell 内容View
    cellContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)];
    cellContentView.backgroundColor = kBackgroundColor;
    [self.contentView addSubview:cellContentView];
    
    //发车时间标示Label
    CGFloat timeSignLabel_x = 15 ;
    CGFloat timeSignLabel_y = 0;
    CGFloat timeSignLabelWidth = 70;
    CGFloat timeSignLabelHeigth = 25;
    
    UILabel *timeSignLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeSignLabel_x, timeSignLabel_y, timeSignLabelWidth, timeSignLabelHeigth)];
    timeSignLabel.text = @"发车时间:";
    timeSignLabel.font = [UIFont systemFontOfSize:14];
    [cellContentView addSubview:timeSignLabel];
    
    //发车时间Label
    CGFloat timeLabel_x = timeSignLabel_x+timeSignLabelWidth ;
    CGFloat timeLabel_y = 0;
    CGFloat timeLabelWidth = 100;
    CGFloat timeLabelHeigth = 25;
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeLabel_x, timeLabel_y, timeLabelWidth, timeLabelHeigth)];
    //发车时间
    NSString *departureTime = [NSString getTimeFormString:_carInfoModel.departure_time];
    timeLabel.text = departureTime;
    timeLabel.font = [UIFont fontWithName:@ "Arial Rounded MT Bold"  size:(14.0)];
    [cellContentView addSubview:timeLabel];
    
    //微信分享班次button
    CGFloat shareButtonWidth = 30;
    CGFloat shareButtonHeigth = 30;
    CGFloat shareButton_x = kScreenWidth-shareButtonWidth-kSpacing;
    CGFloat shareButton_y = 0;
    
    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(shareButton_x, shareButton_y, shareButtonWidth, shareButtonHeigth)];
#warning mark - 添加背景图片
    [shareButton setTitle:@"..." forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareDepartureTimeTable) forControlEvents:UIControlEventTouchUpInside];
    [cellContentView addSubview:shareButton];
    
    
    //发车车站标示Label
    CGFloat departureSignLabel_x = 15 ;
    CGFloat departureSignLabel_y = timeSignLabel_y+timeSignLabelHeigth+kSpacing;
    CGFloat departureSignLabelWidth = 15;
    CGFloat departureSignLabelHeigth = 15;
    
    UILabel *departureSignLabel = [[UILabel alloc] initWithFrame:CGRectMake(departureSignLabel_x, departureSignLabel_y, departureSignLabelWidth, departureSignLabelHeigth)];
    departureSignLabel.textColor = [UIColor whiteColor];
    departureSignLabel.text = @"始";
    departureSignLabel.font = [UIFont systemFontOfSize:14];
    departureSignLabel.backgroundColor = [UIColor greenColor];
    departureSignLabel.textAlignment = NSTextAlignmentCenter;
    departureSignLabel.layer.cornerRadius = 5;
    [cellContentView addSubview:departureSignLabel];
    
    //发车车站Label
    CGFloat departureAreaLabelWidth = 120;
    CGFloat departureAreaLabelHeigth = 20;
    CGFloat departureAreaLabel_x = departureSignLabel_x+departureSignLabelWidth+kSpacing ;
    CGFloat departureAreaLabel_y = departureSignLabel_y+departureSignLabelHeigth/2-departureAreaLabelHeigth/2;

    
    UILabel *departureAreaLabel = [[UILabel alloc] initWithFrame:CGRectMake(departureAreaLabel_x, departureAreaLabel_y, departureAreaLabelWidth, departureAreaLabelHeigth)];
    departureAreaLabel.text = _carInfoModel.begin_area_detail;
    [cellContentView addSubview:departureAreaLabel];
    
    //票价Label
    CGFloat priceLabelWidth = 60;
    CGFloat priceLabelHeigth = 20;
    CGFloat priceLabel_x = kScreenWidth-priceLabelWidth ;
    CGFloat priceLabel_y = departureAreaLabel_y;
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(priceLabel_x, priceLabel_y, priceLabelWidth, priceLabelHeigth)];
    priceLabel.text = [NSString stringWithFormat:@"￥%@",_carInfoModel.price];
    priceLabel.font = [UIFont systemFontOfSize:20];
    priceLabel.textColor = [UIColor orangeColor];
    [cellContentView addSubview:priceLabel];
    
    //到达车站标示Label
    CGFloat arriveSignLabel_x = 15 ;
    CGFloat arriveSignLabel_y = departureAreaLabel_y+departureAreaLabelHeigth+kSpacing/4*3;
    CGFloat arriveSignLabelWidth = 15;
    CGFloat arriveSignLabelHeigth = 15;
    
    UILabel *arriveSignLabel = [[UILabel alloc] initWithFrame:CGRectMake(arriveSignLabel_x, arriveSignLabel_y, arriveSignLabelWidth, arriveSignLabelHeigth)];
    arriveSignLabel.textColor = [UIColor whiteColor];
    arriveSignLabel.text = @"终";
    arriveSignLabel.backgroundColor = [UIColor redColor];
    arriveSignLabel.textAlignment = NSTextAlignmentCenter;
    arriveSignLabel.layer.cornerRadius = 5;
    arriveSignLabel.font = [UIFont systemFontOfSize:14];
    [cellContentView addSubview:arriveSignLabel];
    
    //发车车站Label
    CGFloat arriveAreaLabelWidth = 120;
    CGFloat arriveAreaLabelHeigth = 20;
    CGFloat arriveAreaLabel_x = departureSignLabel_x+departureSignLabelWidth+kSpacing ;
    CGFloat arriveAreaLabel_y = arriveSignLabel_y+arriveSignLabelHeigth/2-arriveAreaLabelHeigth/2;

    UILabel *arriveAreaLabel = [[UILabel alloc] initWithFrame:CGRectMake(arriveAreaLabel_x, arriveAreaLabel_y, arriveAreaLabelWidth, arriveAreaLabelHeigth)];
    arriveAreaLabel.text = _carInfoModel.end_area_detail;
    [cellContentView addSubview:arriveAreaLabel];
    
    //车辆类型Label
    CGFloat carTypeLabelWidth = 60;
    CGFloat carTypeLabelHeigth = 20;
    CGFloat carTypeLabel_x = kScreenWidth-120 ;
    CGFloat carTypeLabel_y = arriveAreaLabel_y+arriveAreaLabelHeigth/2-carTypeLabelHeigth/2;
   
    
    UILabel *carTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(carTypeLabel_x, carTypeLabel_y, carTypeLabelWidth, carTypeLabelHeigth)];
#warning setCarType
    carTypeLabel.text = @"大型坐席";
    carTypeLabel.font = [UIFont systemFontOfSize:14];
    carTypeLabel.textColor = [UIColor grayColor];
    [cellContentView addSubview:carTypeLabel];

    //会话按钮
    CGFloat sengMessageButtonWidth = 40;
    CGFloat sengMessageButtonHeigth = 15;
    CGFloat sengMessageButton_x = kScreenWidth-50 ;
    CGFloat sengMessageButton_y = arriveAreaLabel_y+arriveAreaLabelHeigth/2-sengMessageButtonHeigth/2;

    UIButton *sengMessageButton = [[UIButton alloc] initWithFrame:CGRectMake(sengMessageButton_x, sengMessageButton_y, sengMessageButtonWidth, sengMessageButtonHeigth)];
    [sengMessageButton setTitle:@"发消息" forState:UIControlStateNormal];
    [sengMessageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sengMessageButton setBackgroundColor:[UIColor redColor]];
    [sengMessageButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
    sengMessageButton.layer.cornerRadius = 3;
    [sengMessageButton addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [cellContentView addSubview:sengMessageButton];
    
}

//发送消息
- (void)sendMessage
{
    //融云id
    NSString *rongYunID =[[NSString alloc] initWithFormat:@"T%@",[_carInfoModel.trainman_id stringValue]];
    if ([self.pushSendMessageDelegate respondsToSelector:@selector(PushToSendMessage:)]) {
        [self.pushSendMessageDelegate PushToSendMessage:rongYunID];
    }
}

//微信分享
-(void)shareDepartureTimeTable
{
    if ([self.pushSendMessageDelegate respondsToSelector:@selector(shareWeixinSDK)]) {
        [self.pushSendMessageDelegate shareWeixinSDK];
    }
}

- (void)setCarInfoModel:(TXCarInfoModel *)carInfoModel
{
    _carInfoModel = carInfoModel;
    [self initMainview];
}

- (UILabel *)setLabeFrame:(CGRect)frame {
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    label.font = [UIFont systemFontOfSize:16.0f];
    label.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:label];
    return label;
}

@end
