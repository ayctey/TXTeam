//
//  TXCitierController.m
//  CARPeer
//
//  Created by yezejiang on 15-2-5.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXCitierController.h"
#import "TXDataService.h"
#import "TXAreaController.h"
#import "TXCitiesModel.h"
#import "Common.h"

@implementation TXCitierController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)getData
{
    [MMProgressHUD showWithTitle:nil status:@"加载中..."];
    
    NSDictionary *param = @{@"province_id":_province_id};
    [TXDataService GET:getCity param:param isCache:YES caChetime:0 completionBlock:^(id responseObject, NSError *error) {
        if (error) {
            [MMProgressHUD dismissWithError:@"加载失败！"];
            return ;
        }
        
        cityData = responseObject;
        NSArray *data = responseObject;
        cityData = [NSMutableArray array];
        for (NSDictionary *row in data) {
            TXCitiesModel *cityModel = [[TXCitiesModel alloc] initWithDataDic:row];
            [cityData addObject:cityModel];
        }
        [_tableView reloadData];
        [MMProgressHUD dismiss];
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cityData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        
    }
    TXCitiesModel *cityModel = cityData[indexPath.row];
    cell.textLabel.text = cityModel.city;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TXCitiesModel *cityModel = cityData[indexPath.row];
    TXAreaController *area = [[TXAreaController alloc] init];
    area.city_id = cityModel.city_id;
    area.city = cityModel.city;
    area._province =_province;
    area.Area_WheatherHome = _WheatherHometown;
    [self.navigationController pushViewController:area
                                         animated:YES];
}
@end
