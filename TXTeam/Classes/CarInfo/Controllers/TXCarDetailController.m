//
//  TXCarDetailController.m
//  TXTeam
//
//  Created by yezejiang on 15-3-10.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXCarDetailController.h"
#import "TXCarInfoModel.h"
#import "TXChatViewController.h"
#import "Common.h"
#import "RCIM.h"

@implementation TXCarDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [[NSString alloc] initWithFormat:@"%@<->%@",_carInfoModel.begin_area,_carInfoModel.end_area];
    self.view.backgroundColor = kBackgroundColor;
    [self initSubView];
    
    NSArray *dataArr = @[[NSString stringWithFormat:@"%@.00元",_carInfoModel.price],_carInfoModel.begin_area_detail,_carInfoModel.end_area_detail,_carInfoModel.departure_time];
    int i = 10;
    for (NSString *data in dataArr) {
        UILabel *label = (UILabel *)[self.view viewWithTag:i];
        label.text = data;
        i++;
    }
}

- (void)initSubView {
    scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight+100);
    scrollView.backgroundColor = kBackgroundColor;
    [self.view addSubview:scrollView];
    
    float image_height = kScreenWidth*0.5;
    UIImageView *carImageView = [[UIImageView alloc] init];
    carImageView.frame = CGRectMake(0, 0, kScreenWidth, image_height);
    [carImageView setImage:[UIImage imageNamed:@"car"]];
    carImageView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:carImageView];
    
    NSArray *labelArr = @[@"票价:",@"出发车站:",@"到达车站:",@"出发时间:",@"历时:",@"乘务员:"];
    //创建label
    for (int i = 0; i < labelArr.count; i++) {
        float y = image_height+i*30;
        //创建显示labelArr的数据的label
        UILabel *label = [[UILabel alloc] init];
        label.text = labelArr[i];
        label.frame = CGRectMake(10, y, 80, 40);
        [scrollView addSubview:label];
        //创建接收请求数据的label
        UILabel *text = [[UILabel alloc] init];
        text.tag = 10+i;
        text.textAlignment = NSTextAlignmentRight;
        text.frame = CGRectMake(kScreenWidth-210, y, 200, 40);
        [scrollView addSubview:text];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"会话" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(kScreenWidth-210, 400, 200, 40)];
    [button addTarget:self action:@selector(huihua) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    [self departureTimeTableView];
}

-(void)departureTimeTableView
{
    //时刻表信息视图
    CGFloat TimeTableViewWidth = kScreenWidth-2*kSpacing;
    CGFloat TimeTableViewHeigth = kScreenWidth;
    
    UIView *TimeTableView = [[UIView alloc] initWithFrame:CGRectMake(kSpacing, kScreenWidth*0.5+kSpacing, TimeTableViewWidth, TimeTableViewHeigth)];
    TimeTableView.backgroundColor = kBackgroundColor;
    [scrollView addSubview:TimeTableView];
    
    //时刻表信息视图头视图
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TimeTableViewWidth, 44)];
    headView.backgroundColor = [UIColor redColor];
    headView.layer.cornerRadius = 5;
    [TimeTableView addSubview:headView];
    
    //车辆类型label
    UILabel *carTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, TimeTableViewWidth/2, 44)];
    #warning ResetText
    [carTypeLabel setText:@"大型卧铺"];
    carTypeLabel.textAlignment = NSTextAlignmentLeft;
    [headView addSubview:carTypeLabel];
    
    //发车日期label
    UILabel *departureDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(TimeTableViewWidth/2,0 , TimeTableViewWidth/2, 44)];
    [departureDateLabel setText:self.departureDate];
    departureDateLabel.textAlignment = NSTextAlignmentRight;
    [headView addSubview:departureDateLabel];
    
}

- (void)huihua{
    //融云id
    NSString *rongYunID =[[NSString alloc] initWithFormat:@"T%@",[_carInfoModel.trainman_id stringValue]];
    //会话主题
    NSString *chatTittle = [[NSString alloc] initWithFormat:@"%@-%@",_carInfoModel.begin_area,_carInfoModel.end_area];
    MyLog(@"rongyunID:%@",rongYunID);
    RCChatViewController *chatViewController = [[RCIM sharedRCIM]createPrivateChat:rongYunID title:chatTittle completion:^(){
        // 创建 ViewController 后，调用的 Block，可以用来实现自定义行为。
        
    }];
    chatViewController.hidesBottomBarWhenPushed = YES;
    // 把单聊视图控制器添加到导航栈。
    [self.navigationController pushViewController:chatViewController animated:YES];
}

@end
