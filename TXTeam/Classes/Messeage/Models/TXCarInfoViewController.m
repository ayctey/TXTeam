//
//  TXCarInfoViewController.m
//  TXTeam
//
//  Created by 吖银 on 15-1-17.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXCarInfoViewController.h"
#import "Common.h"
#import "TXSelectCarViewController.h"
#import "TXCarTableViewCell.h"
#import "TXBaseNavController.h"
#import "TXCarDetailController.h"
#import "TXCarInfoCell.h"
#import "TXDataService.h"
#import "TXCarInfoModel.h"
#import "TXTool.h"
#import "TXBaseTableView.h"
#import "MJRefresh.h"
#import "TXNoDataIndicateView.h"
#import "TXReloadView.h"
#import "TXLoadingView.h"

@interface TXCarInfoViewController ()

@end

@implementation TXCarInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    //添加搜索按钮
    UIButton *SearchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [SearchBtn setImage:[UIImage imageNamed:@"放大镜@3x.png"] forState:UIControlStateNormal];
    [SearchBtn addTarget:self action:@selector(SearClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchBarbtn = [[UIBarButtonItem alloc]initWithCustomView:SearchBtn];
    self.navigationItem.rightBarButtonItem =searchBarbtn ;
    
    dateIndex = 0;
    pullToRefresh = NO;
    //loadingView.frame = _tableView.frame;
    
    //初始化子视图
    [self initSubView];
    //获取当前时间，并将值传给TXTool
    [self getDate];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    TXTool *tool =[TXTool sharedTXTool];
    if (tool.beginSearch == YES) {//查询后获取TXTool的参数再请求班次信息
        _segment.selectedSegmentIndex = 1;
        [_segment setTitle:tool.departure_time forSegmentAtIndex:1];
        
        if (viewHaveBeAddFlag) {
            [noDataIndicate removeFromSuperview];
            viewHaveBeAddFlag = NO;
        }
        
        //请求数据
        [self searchWithNewDeparture_time];
        tool.beginSearch = NO;
    }
}

#pragma mark - 加载数据
- (BOOL)searchWithNewDeparture_time {//根据新日期请求班次信息
    
    TXTool *tool = [TXTool sharedTXTool];
    if (tool.begin_area_id !=nil && tool.end_area_id != nil && tool.departure_time != nil) {
        NSDictionary *params =@{@"begin_area_id":tool.begin_area_id,
                                @"end_area_id":tool.end_area_id,
                                @"date":tool.departure_time};
        if (_segment.selectedSegmentIndex == 1) {
            [_segment setTitle:tool.departure_time forSegmentAtIndex:1];
        }
        //请求数据
        [self getCarInfoData:params];
        return NO;
    }
    return YES;
}

- (void)getDate {
    //获取当前时间
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSTimeInterval interval = 24*60*60;
    //日期加一
    NSString *dateString = [formatter stringFromDate:[date initWithTimeInterval:interval sinceDate:date]];
    MyLog(@"dateString%@",dateString);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *homeTown_ID = [defaults objectForKey:@"area_id"];
    NSString *workPlace_ID = [defaults objectForKey:@"workplace"];
    MyLog(@"homeTown:%@,workPlace:%@",homeTown_ID,workPlace_ID);
    
    //将值传给TXTool
    [TXTool sharedTXTool].begin_area_id = workPlace_ID;
    [TXTool sharedTXTool].end_area_id = homeTown_ID;
    [TXTool sharedTXTool].departure_time =dateString;
    //请求数据
    [self searchWithNewDeparture_time];
}

- (void)getCarInfoData:(NSDictionary *)params
{
    if (!pullToRefresh) {
        
        //判断是否联网
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([[defaults objectForKey:@"reachable"] boolValue]) {
            //添加“加载中”视图
            [_tableView addSubview:loadingView];
        }
    }
    
    //查询汽车班次
    [TXDataService POST:getDeparture_Timetable param:params isCache:NO caChetime:0 completionBlock:^(id responseObject, NSError *error) {
        if (error) {//请求错误，提示信息
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络请求失败！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return ;
        }
        //请求数据成功
        //将数据存入数组
        NSArray *data = [responseObject objectForKey:@"rows"];
        
        if ([data isEqual:@[]]) {//如果数据为空，显示“暂无班次信息”，并返回
            [_tableView addSubview:noDataIndicate];
            viewHaveBeAddFlag = YES;
            return;
        }
        dataArray = [[NSMutableArray alloc] init];
        //字典转模型
        for (NSDictionary *row in data) {
            TXCarInfoModel *carInfoModel = [[TXCarInfoModel alloc] initWithDataDic:row];
            [dataArray addObject:carInfoModel];
        }
        //刷新列表
        [_tableView reloadData];
        if (!pullToRefresh) {
            [loadingView removeFromSuperview];
        }else {
            pullToRefresh = NO;
        }
    }];
}

#pragma mark - 添加视图
- (void)initSubView {
    
    //获取当前日期
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *month = [formatter stringFromDate:date];
    //1.添加SegmentControl
    NSArray *datename =@[@"前一天",month,@"后一天"];
    _segment = [[UISegmentedControl alloc]initWithItems:datename];
    _segment.frame =CGRectMake(30, kNavigationH+10, kScreenWidth-60, 40);
    _segment.backgroundColor =[UIColor whiteColor];
    _segment.selectedSegmentIndex = 1;
    _segment.tintColor = [UIColor redColor];
    [_segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segment];
    
    //2.添加tableView
    _tableView = [[TXBaseTableView alloc] initWithFrame:CGRectMake(0, kNavigationH+10+40, kScreenWidth, kScreenHeight-kNavigationH-50-kTabBarH) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 120;
    _tableView.backgroundColor = kBackgroundColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    //设置下拉刷新titile
    _tableView.headerPullToRefreshText = @"下拉可以刷新了";
    _tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    _tableView.headerRefreshingText = @"正在帮你刷新中";
    [self.view addSubview:_tableView];
    
    //初始化view
    noDataIndicate = [[TXNoDataIndicateView alloc] initWithFrame:_tableView.bounds];
    viewHaveBeAddFlag = NO;
    
    //初始化加载视图
    loadingView = [[TXLoadingView alloc] initWithFrame:_tableView.bounds];
    
}

- (void)headerRereshing {
    pullToRefresh = YES;
    //下拉刷新
    [self searchWithNewDeparture_time];
    [_tableView headerEndRefreshing];
}

#pragma mark - 点击事件
-(void)SearClick
{
    //跳转至查询班次页面
    TXSelectCarViewController *select =[[TXSelectCarViewController alloc]init];
    TXBaseNavController *navi = [[TXBaseNavController alloc]initWithRootViewController:select];
    [self.navigationController presentViewController:navi animated:YES completion:nil];
    
}

-(void)segmentChange:(UISegmentedControl *)segment
{
    if (viewHaveBeAddFlag == YES) {//移除“暂无班次信息”View
        [noDataIndicate removeFromSuperview];
        viewHaveBeAddFlag = NO;
    }
    //获取当前时间
    TXTool *tool = [TXTool sharedTXTool];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:tool.departure_time];
    
    if(segment.selectedSegmentIndex == 1)//"今天"
    {
        
        //判断前一次segment的索引
        if (dateIndex == 1 || dateIndex == -1) {
            
            NSDate *nowDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date timeIntervalSinceReferenceDate] - 24*3600*dateIndex)];
            NSString *nowString = [formatter stringFromDate:nowDate];
            tool.departure_time = nowString;
            dateIndex = 0;
        }
        
    }else if (segment.selectedSegmentIndex == 0)//“前一天”
    {
        //判断前一个选中的segment的索引
        NSInteger index;
        if (dateIndex == 0) {
            index = 24*3600;
        }else if (dateIndex == 1) {
            index = 24*3600*2;
        }
        dateIndex = -1;
        //获取“前一天”的日期
        NSDate *lastDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date timeIntervalSinceReferenceDate] - index)];
        NSString *lastString = [formatter stringFromDate:lastDate];
        tool.departure_time = lastString;
        
    }else if (segment.selectedSegmentIndex == 2)//“后一天”
    {
        //判断前一个选中的segment的索引
        NSInteger index;
        if (dateIndex == 0) {
            index = 24*3600;
        }else if (dateIndex == -1) {
            index = 24*3600*2;
        }
        dateIndex = 1;
        //获取“后一天”的日期
        NSDate *nextDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date timeIntervalSinceReferenceDate] + index)];
        NSString *nextString = [formatter stringFromDate:nextDate];
        tool.departure_time = nextString;
        
    }
    //请求数据
    [self searchWithNewDeparture_time];
    
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ListViewCellId = @"ListViewCellId";
    TXCarInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ListViewCellId];
    if (cell == nil) {
        cell = [[TXCarInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ListViewCellId];
    }
    //传递模型数据给cell
    cell.carInfoModel = dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //跳转到班次详情控制器
    TXCarDetailController *detail = [[TXCarDetailController alloc] init];
    detail.hidesBottomBarWhenPushed = YES;
    detail.carInfoModel = dataArray[indexPath.row];
    detail.departureDate = [TXTool sharedTXTool].departure_time;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
