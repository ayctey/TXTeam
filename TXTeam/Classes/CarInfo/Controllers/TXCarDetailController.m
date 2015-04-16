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
    self.title = @"班次详细信息";
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
}

- (void)huihua{
    RCChatViewController *chatViewController = [[RCIM sharedRCIM]createPrivateChat:[_carInfoModel.trainman_id stringValue] title:@"自问自答" completion:^(){
        // 创建 ViewController 后，调用的 Block，可以用来实现自定义行为。
        
    }];
    chatViewController.hidesBottomBarWhenPushed = YES;
    // 把单聊视图控制器添加到导航栈。
    [self.navigationController pushViewController:chatViewController animated:YES];
}

@end
