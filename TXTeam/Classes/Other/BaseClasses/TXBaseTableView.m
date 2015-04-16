//
//  TXBaseTableView.m
//  TXTeam
//
//  Created by yezejiang on 15-3-13.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXBaseTableView.h"
#import "MJRefresh.h"

@implementation TXBaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        //[self registerClass:[UITableViewCell class] forCellReuseIdentifier:MJTableViewCellIdentifier];
        [self setupRefresh];
    }
    return self;
}

- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    //[self addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
//#warning 自动刷新(一进入程序就下拉刷新)
    //[self headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    //[self addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.headerPullToRefreshText = @"baby,下拉可以刷新了";
    self.headerReleaseToRefreshText = @"baby,松开马上刷新了";
    self.headerRefreshingText = @"正在帮你刷新中,不客气";
    
    self.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.footerRefreshingText = @"正在帮你加载中,不客气";
}


@end
