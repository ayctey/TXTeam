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
#import "NSString+Addition.h"
#import "Common.h"
#import "RCIM.h"

@implementation TXCarDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [[NSString alloc] initWithFormat:@"%@<-->%@",_carInfoModel.begin_city,_carInfoModel.end_city];
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
    
    //汽车班次信息
    [self departureTimeTableView];
    
    //乘务员和运营公司信息视图
    [self staffAndCompanyView];
    
    //发送按钮
    CGFloat sendMessageButtonWidth = kScreenWidth-2*kSpacing;
    CGFloat sendMessageButtonHeigth = 44;
    CGFloat sendMessageButton_x = kSpacing;
    CGFloat sendMessageButton_y = TimeTableViewHeigth+3*kSpacing+kScreenWidth*0.5+staffAndCompanyViewHeigth;
    
    //发送消息button
    UIButton *sendMessageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sendMessageButton setTitle:@"发  消  息" forState:UIControlStateNormal];
    [sendMessageButton setBackgroundColor:[UIColor redColor]];
    [sendMessageButton setTintColor:[UIColor whiteColor]];
    sendMessageButton.titleLabel.font = [UIFont systemFontOfSize:20];
    sendMessageButton.layer.cornerRadius = 5;
    [sendMessageButton setFrame:CGRectMake(sendMessageButton_x, sendMessageButton_y, sendMessageButtonWidth, sendMessageButtonHeigth)];
    [sendMessageButton addTarget:self action:@selector(huihua) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:sendMessageButton];
    
    //
    
    //拨打乘务员电话按钮
    CGFloat callStaffButtonWidth = kScreenWidth-2*kSpacing;
    CGFloat callStaffButtonHeigth = 44;
    CGFloat callStaffButton_x = kSpacing;
    CGFloat callStaffButton_y = TimeTableViewHeigth+4*kSpacing+kScreenWidth*0.5+staffAndCompanyViewHeigth+sendMessageButtonHeigth;
    
    //拨打电话button
    UIButton *callStaffButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [callStaffButton setTitle:@"拨 打 电 话" forState:UIControlStateNormal];
    [callStaffButton setBackgroundColor:[UIColor redColor]];
    [callStaffButton setTintColor:[UIColor whiteColor]];
    callStaffButton.titleLabel.font = [UIFont systemFontOfSize:20];
    callStaffButton.layer.cornerRadius = 5;
    [callStaffButton setFrame:CGRectMake(callStaffButton_x, callStaffButton_y, callStaffButtonWidth, callStaffButtonHeigth)];
    [callStaffButton addTarget:self action:@selector(callStaff) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:callStaffButton];
    
    //设置ScrollView 内容长度
    scrollView.contentSize = CGSizeMake(kScreenWidth, callStaffButton_y+callStaffButtonHeigth+kSpacing);
}

//汽车班次信息视图
-(void)departureTimeTableView
{
    //时刻表信息视图
    CGFloat TimeTableViewWidth = kScreenWidth-2*kSpacing;
    TimeTableViewHeigth = kScreenWidth;
    
    UIView *TimeTableView = [[UIView alloc] initWithFrame:CGRectMake(kSpacing, kScreenWidth*0.5+kSpacing, TimeTableViewWidth, TimeTableViewHeigth)];
    
    //设置圆角
    TimeTableView.layer.cornerRadius = 5;
    TimeTableView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:TimeTableView];
    
    //时刻表信息视图头视图
    CGFloat headViewWidth = TimeTableViewWidth;
    CGFloat headViewHeigth = 30;
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, headViewWidth, headViewHeigth)];
    headView.backgroundColor = [UIColor redColor];
    headView.layer.cornerRadius = 5;
    [TimeTableView addSubview:headView];
    
    //车辆类型label
    UILabel *carTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSpacing, 0, headViewWidth/2, headViewHeigth)];
    #warning ResetText
    [carTypeLabel setText:@"大型卧铺"];
    [carTypeLabel setTextColor:[UIColor whiteColor]];
    carTypeLabel.textAlignment = NSTextAlignmentLeft;
    [headView addSubview:carTypeLabel];
    
    //发车日期label
    UILabel *departureDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(headViewWidth/2,0 , headViewWidth/2-kSpacing, headViewHeigth)];
    [departureDateLabel setText:self.departureDate];
    [departureDateLabel setTextColor:[UIColor whiteColor]];
    departureDateLabel.textAlignment = NSTextAlignmentRight;
    [headView addSubview:departureDateLabel];
    
    //出发地区label
    //label高和宽
    CGFloat departureAreaLabelHeigth = 30;
    CGFloat departureAreaLabelWidth = TimeTableViewWidth/3;
    CGFloat departureAreaLabel_y = headViewHeigth+kSpacing;
    
    UILabel *departureAreaLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,departureAreaLabel_y, departureAreaLabelWidth, departureAreaLabelHeigth)];
    [departureAreaLabel setText:self.carInfoModel.begin_area];
    
    departureAreaLabel.font = [UIFont fontWithName:@ "Arial Rounded MT Bold"  size:(25.0)];
    departureAreaLabel.textAlignment = NSTextAlignmentCenter;
    [TimeTableView addSubview:departureAreaLabel];
    
    //到达地区label
    CGFloat arriveAreaLabel_x = TimeTableViewWidth/3*2;
    
    UILabel *arriveAreaLabel = [[UILabel alloc]initWithFrame:CGRectMake(arriveAreaLabel_x,departureAreaLabel_y, departureAreaLabelWidth, departureAreaLabelHeigth)];
    [arriveAreaLabel setText:self.carInfoModel.end_area];
     arriveAreaLabel.font = [UIFont fontWithName:@ "Arial Rounded MT Bold"  size:(25.0)];
    arriveAreaLabel.textAlignment = NSTextAlignmentCenter;
    [TimeTableView addSubview:arriveAreaLabel];
    
    //出发车站label
    CGFloat departureDetailLabelWidth = 60;
    CGFloat departureDetailLabelHeigth = 30;
    CGFloat departureDetailLabel_x = (departureAreaLabelWidth-departureDetailLabelWidth)/2;
    CGFloat departureDetailLabel_y = departureAreaLabel_y+departureAreaLabelHeigth;
    
    UILabel *departureDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(departureDetailLabel_x,departureDetailLabel_y, departureDetailLabelWidth, departureDetailLabelHeigth)];
    [departureDetailLabel setText:self.carInfoModel.begin_area_detail];
    departureDetailLabel.font = [UIFont systemFontOfSize:14];
    departureDetailLabel.textAlignment = NSTextAlignmentCenter;
    [TimeTableView addSubview:departureDetailLabel];
    
    //到达车站label
    CGFloat arriveDetailLabel_x = departureAreaLabelWidth/2+arriveAreaLabel_x-departureDetailLabelWidth/2;
    CGFloat arriveDetailLabel_y = departureAreaLabel_y+departureAreaLabelHeigth;
    
    UILabel *arriveDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(arriveDetailLabel_x,arriveDetailLabel_y, departureDetailLabelWidth, departureDetailLabelHeigth)];
    [arriveDetailLabel setText:self.carInfoModel.end_area_detail];
    arriveDetailLabel.font = [UIFont systemFontOfSize:14];
    arriveDetailLabel.textAlignment = NSTextAlignmentCenter;
    [TimeTableView addSubview:arriveDetailLabel];
    
    //发车时间label
    CGFloat departureTimeLabelWidth = 100;
    CGFloat departureTimeLabelHeigth = 20;
    CGFloat departureTimeLabel_x = (TimeTableViewWidth-departureTimeLabelWidth)/2;
    CGFloat departureTimeLabel_y = departureAreaLabel_y+departureAreaLabelHeigth-departureTimeLabelHeigth;
    
    UILabel *departureTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(departureTimeLabel_x, departureTimeLabel_y, departureTimeLabelWidth, departureTimeLabelHeigth)];
    NSString *departureTime = [NSString getTimeFormString:self.carInfoModel.departure_time];
    
    [departureTimeLabel setText:[NSString stringWithFormat:@"发车：%@",departureTime]];
    departureTimeLabel.textColor = [UIColor redColor];
    departureTimeLabel.font = [UIFont systemFontOfSize:12];
    departureTimeLabel.textAlignment = NSTextAlignmentCenter;
    [TimeTableView addSubview:departureTimeLabel];
    
    //箭头arrowsUIimageView
    CGFloat arrowsUIimageViewWidth = 100;
    CGFloat arrowsUIimageViewHeigth = 15;
    CGFloat arrowsUIimageView_x = (TimeTableViewWidth-arrowsUIimageViewWidth)/2;
    CGFloat arrowsUIimageView_y = departureTimeLabel_y+departureTimeLabelHeigth;
    
    UIImageView *arrowsUIimageView = [[UIImageView alloc] initWithFrame:CGRectMake(arrowsUIimageView_x, arrowsUIimageView_y, arrowsUIimageViewWidth, arrowsUIimageViewHeigth)];
    [arrowsUIimageView setImage:[UIImage imageNamed:@"arrows.png"]];
    [TimeTableView addSubview:arrowsUIimageView];
    
    //分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, arriveDetailLabel_y+departureDetailLabelHeigth+kSpacing, kScreenWidth, 2)];
    lineView.backgroundColor = kBackgroundColor;
    [TimeTableView addSubview:lineView];
    
    //车牌号plate
    CGFloat plateLabel_x = 0;
    CGFloat plateLabel_y = arriveDetailLabel_y+departureDetailLabelHeigth+kSpacing;
    CGFloat plateLabelWidth = 100;
    CGFloat ticketLabelHeigth = 44;
    
    UILabel *plateLabel = [[UILabel alloc]initWithFrame:CGRectMake(plateLabel_x,plateLabel_y, plateLabelWidth, ticketLabelHeigth)];
    [plateLabel setText:[NSString stringWithFormat:@"%@",_carInfoModel.plate_number]];
    plateLabel.font = [UIFont systemFontOfSize:20];
    plateLabel.textAlignment = NSTextAlignmentCenter;
    [TimeTableView addSubview:plateLabel];
    
    //票价Label
    CGFloat priceLabelWidth = 100;
    CGFloat priceLabelHeigth = 44;
    CGFloat priceLabel_x = kScreenWidth-priceLabelWidth-3*kSpacing;
    CGFloat priceLabel_y = arriveDetailLabel_y+departureDetailLabelHeigth+kSpacing;
    
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(priceLabel_x,priceLabel_y, priceLabelWidth, priceLabelHeigth)];
    [priceLabel setText:[NSString stringWithFormat:@"￥：%@",self.carInfoModel.price]];
    priceLabel.textColor = [UIColor orangeColor];
    priceLabel.font = [UIFont systemFontOfSize:25];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    [TimeTableView addSubview:priceLabel];
    
    //票价briefLabel
    CGFloat briefLabel_x = kSpacing;
    CGFloat briefLabel_y = priceLabel_y+priceLabelHeigth+kSpacing;
    
    UILabel *briefLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,0,0)];
    //备注
    NSString *brief = [NSString stringWithFormat:@"备注：%@",_carInfoModel.remark];
    
    briefLabel.numberOfLines = 0;
    UIFont *briefFont = [UIFont systemFontOfSize:17];
    briefLabel.font = briefFont;
    briefLabel.lineBreakMode =NSLineBreakByTruncatingTail ;
    briefLabel.text = brief ;
    briefLabel.textAlignment = NSTextAlignmentLeft;
    [TimeTableView addSubview:briefLabel];
    
    CGSize size = CGSizeMake(TimeTableViewWidth-2*kSpacing, MAXFLOAT);
    NSDictionary *fontdic = [NSDictionary dictionaryWithObjectsAndKeys:briefFont,NSFontAttributeName,nil];
    //计算文本高度
    CGSize   actualsize=[brief boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:fontdic context:nil].size;
    //自适应高度
    [briefLabel setFrame:CGRectMake(briefLabel_x, briefLabel_y, actualsize.width, actualsize.height)];
    
    //重新设置TimeTableView高度
    CGFloat ReTimeTableViewHeigth = briefLabel_y+actualsize.height+kSpacing;
    [TimeTableView setFrame:CGRectMake(kSpacing, kScreenWidth*0.5+kSpacing, TimeTableViewWidth, ReTimeTableViewHeigth)];
    
    TimeTableViewHeigth = ReTimeTableViewHeigth;
}

//乘务员和运营公司信息视图
-(void)staffAndCompanyView
{
    //staffAndCompanyView
    CGFloat staffAndCompanyViewWidth = kScreenWidth-2*kSpacing;
    staffAndCompanyViewHeigth = 90;
    CGFloat staffAndCompanyView_x = kSpacing;
    CGFloat staffAndCompanyView_y = TimeTableViewHeigth+2*kSpacing+kScreenWidth*0.5;
    
    UIView *staffAndCompanyView = [[UIView alloc] initWithFrame:CGRectMake(staffAndCompanyView_x, staffAndCompanyView_y, staffAndCompanyViewWidth, staffAndCompanyViewHeigth)];
    staffAndCompanyView.backgroundColor = [UIColor whiteColor];
    staffAndCompanyView.layer.cornerRadius = 5;
    [scrollView addSubview:staffAndCompanyView];
    
    //乘务员姓名Label
    CGFloat staffLabelWidth = 200;
    CGFloat staffLabelHeigth = 30;
    CGFloat staffLabel_x = kSpacing;
    CGFloat staffLabel_y = 0;
    
    UILabel *staffLabel = [[UILabel alloc]initWithFrame:CGRectMake(staffLabel_x,staffLabel_y, staffLabelWidth, staffLabelHeigth)];
    [staffLabel setText:[NSString stringWithFormat:@"乘务员：李总"]];
    staffLabel.textAlignment = NSTextAlignmentLeft;
    [staffAndCompanyView addSubview:staffLabel];
    
    //乘务员电话Label
    CGFloat phoneNumberLabelWidth = 200;
    CGFloat phoneNumberLabelHeigth = 30;
    CGFloat phoneNumberLabel_x = kSpacing;
    CGFloat phoneNumberLabel_y = 30;
    
    UILabel *phoneNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(phoneNumberLabel_x,phoneNumberLabel_y, phoneNumberLabelWidth, phoneNumberLabelHeigth)];
    [phoneNumberLabel setText:[NSString stringWithFormat:@"电话：18300072733"]];
    phoneNumberLabel.textAlignment = NSTextAlignmentLeft;
    [staffAndCompanyView addSubview:phoneNumberLabel];
    
    //车队Label
    CGFloat companyLabelWidth = 200;
    CGFloat companyLabelHeigth = 30;
    CGFloat companyLabel_x = kSpacing;
    CGFloat companyLabel_y = 60;
    
    UILabel *companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(companyLabel_x,companyLabel_y, companyLabelWidth, companyLabelHeigth)];
    [companyLabel setText:[NSString stringWithFormat:@"公司：李总客运"]];
    companyLabel.textAlignment = NSTextAlignmentLeft;
    [staffAndCompanyView addSubview:companyLabel];

}

//发送消息
- (void)huihua{
    //融云id
    NSString *rongYunID =[[NSString alloc] initWithFormat:@"T%@",[_carInfoModel.trainman_id stringValue]];
    //会话主题
    NSString *chatTittle = [[NSString alloc] initWithFormat:@"%@<-->%@",_carInfoModel.begin_area,_carInfoModel.end_area];
    MyLog(@"rongyunID:%@",rongYunID);
    RCChatViewController *chatViewController = [[RCIM sharedRCIM]createPrivateChat:rongYunID title:chatTittle completion:^(){
        // 创建 ViewController 后，调用的 Block，可以用来实现自定义行为。
        
    }];
    chatViewController.hidesBottomBarWhenPushed = YES;
    // 把单聊视图控制器添加到导航栈。
    [self.navigationController pushViewController:chatViewController animated:YES];
}

//拨打电话
-(void)callStaff
{
    UIWebView *callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:@"tel:612733"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
}

@end
