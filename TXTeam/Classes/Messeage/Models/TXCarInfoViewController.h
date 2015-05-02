//
//  TXCarInfoViewController.h
//  TXTeam
//
//  Created by 吖银 on 15-1-17.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//汽车班次控制器



#import "TXBaseViewController.h"
#import "TXSelectCarViewController.h"

@class TXCarTableController;
@class TXBaseTableView;
@class TXNoDataIndicateView;
@class TXLoadingView;

@interface TXCarInfoViewController : TXBaseViewController
<UITableViewDataSource,UITableViewDelegate,TXSelectCarViewDelegation>
{
    UISegmentedControl *datesegment;
    TXBaseTableView *_tableView;
    NSMutableArray *dataArray;      //数据数组
    UISegmentedControl *_segment;   //
    NSInteger dateIndex;   //前一个segment的索引
    TXNoDataIndicateView *noDataIndicate;   //数据为空是显示的View
    BOOL viewHaveBeAddFlag;     //判断有无班次信息
    TXLoadingView *loadingView;
    BOOL pullToRefresh;
}

@end
