//
//  TXProvinceController.m
//  CARPeer
//
//  Created by yezejiang on 15-2-5.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXProvinceController.h"
#import "TXDataService.h"
#import "TXProvinceModel.h"
#import "TXCitierController.h"
#import "TXAreaController.h"
#import "Common.h"
@implementation TXProvinceController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTableView];
    [self getData];
}

- (void)initTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationH) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)getData
{
    //[MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    [MMProgressHUD showWithTitle:nil status:@"加载中..."];
    //[MMProgressHUD showProgressWithStyle:MMProgressHUDProgressStyleLinear title:nil status:@"dddd"];
    
    [TXDataService GET:getProvince param:nil completionBlock:^(id responseObject, NSError *error) {
        if (error) {
            [MMProgressHUD dismissWithError:@"加载失败！"];
            return ;
            
        }
        NSArray *data = responseObject;
        dataArray = [NSMutableArray array];
        for (NSDictionary *row in data) {
            TXProvinceModel *provinceModel = [[TXProvinceModel alloc] initWithDataDic:row];
            [dataArray addObject:provinceModel];
        }
        [_tableView reloadData];
        [MMProgressHUD dismiss];
    }];
}


#pragma mark - 表视图协议

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        
    }
    TXProvinceModel *provinceModel = dataArray[indexPath.row];
    cell.textLabel.text = provinceModel.province;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TXProvinceModel *provinceModel = dataArray[indexPath.row];
    TXCitierController *cities = [[TXCitierController alloc] init];
    cities.province_id = provinceModel.province_id;
    cities.province  = provinceModel.province;
    cities.WheatherHometown= _wheatherHometown;
    [self.navigationController pushViewController:cities animated:YES];
}

@end
