//
//  TXAreaController.m
//  CARPeer
//
//  Created by yezejiang on 15-2-5.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXAreaController.h"
#import "TXDataService.h"
#import "TXAreaModel.h"
#import "TXSelectCarViewController.h"
#import "TXTool.h"
#import "Common.h"

@implementation TXAreaController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)getData
{
    [MMProgressHUD showWithTitle:nil status:@"加载中..."];
    
    NSDictionary *param = @{@"city_id":_city_id};
    [TXDataService GET:getArea param:param isCache:YES caChetime:10*24*60*60 completionBlock:^(id responseObject, NSError *error) {
        if (error) {
            [MMProgressHUD dismissWithError:@"加载失败！"];
        }
        
        NSArray *data = responseObject;
        areaData = [NSMutableArray array];
        for (NSDictionary *row in data) {
           TXAreaModel *areaModel = [[TXAreaModel alloc] initWithDataDic:row];
            [areaData addObject:areaModel];
        }
        [_tableView reloadData];
        [MMProgressHUD dismiss];
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return areaData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        
    }
    TXAreaModel *areaModel = areaData[indexPath.row];
    cell.textLabel.text = areaModel.area;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int viewController_index =self.navigationController.viewControllers.count-4;
    UIViewController *selectCar = self.navigationController.viewControllers[viewController_index];
    
    [TXTool sharedTXTool].areaModel = areaData[indexPath.row];
    [TXTool sharedTXTool].selectCity = _city;
    [TXTool sharedTXTool].selectProvince =self._province;
    TXAreaModel *areaModel = areaData[indexPath.row];
    [TXTool sharedTXTool].selectAreaID =areaModel.area_id;
    [TXTool sharedTXTool].WhetherHometown = _Area_WheatherHome;
    [self.navigationController popToViewController:selectCar animated:YES];
}

@end
