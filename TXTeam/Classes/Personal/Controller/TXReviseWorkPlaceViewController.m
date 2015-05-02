//
//  TXReviseWorkPlaceViewController.m
//  TXTeam
//
//  Created by 吖银 on 15-1-18.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXReviseWorkPlaceViewController.h"
#import "Common.h"
#import "TXPersonalViewController.h"
#import "TXProvinceController.h"
#import "TXDataService.h"
#import "TXTool.h"
#import "TXAreaModel.h"

@interface TXReviseWorkPlaceViewController ()

@end

@implementation TXReviseWorkPlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作所在地";
    self.view.backgroundColor = [UIColor whiteColor];
    [self reserveBarbutton];
    [self initView];
}
-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];
    
    TXTool *tool = [TXTool sharedTXTool];
    if (tool.areaModel != nil) {
        NSString *area = [NSString stringWithFormat:@"%@ %@ %@",tool.selectProvince,tool.selectCity,tool.areaModel.area];
        [workbtn setTitle:area forState:UIControlStateNormal];
        _newworkplace = area;
        _area_id = tool.selectAreaID;
        
        tool.areaModel = nil;
    }
}

-(void)reserveBarbutton {
    
    UIBarButtonItem *reserve = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(reservebutton)];
    reserve.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = reserve;
    
}

-(void)initView
{
    UIView *homeview = [[UIView alloc]initWithFrame:CGRectMake(0, kNavigationH, kScreenWidth, 50)];
    homeview.backgroundColor = kBackgroundColor;
    [self.view addSubview:homeview];
    UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth*0.33, 30)];
    lab.text = @"工作所在地：";
    [homeview addSubview:lab];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *province = [defaults objectForKey:@"work_province"];
    NSString *city = [defaults objectForKey:@"work_city"];
    NSString *area = [defaults objectForKey:@"work_area"];
    NSString *workPlace = [[NSString alloc] initWithFormat:@"%@ %@ %@",province,city,area];
    
     workbtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth*0.32, 0, kScreenWidth*0.6, 50)];
    [workbtn addTarget:self action:@selector(workbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [workbtn setTitle:workPlace forState:UIControlStateNormal];
    [workbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // homebtn.backgroundColor =[UIColor redColor];
    workbtn.tag = 101;
    [homeview addSubview:workbtn];
}

-(void)reservebutton
{
    [self.navigationController popViewControllerAnimated:YES];
    
    TXPersonalViewController *person = [[TXPersonalViewController alloc]init];
   [person getnewWorkPlace:_newworkplace];
    [self reviseWorkplace];
    
    //发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"newworkplace" object:_newworkplace];
    //修改后的家乡重新存入单例
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [ defaults setValue:_newworkplace forKey:@"workplace"];
}

-(void)workbtnClick
{
    TXProvinceController *province = [[TXProvinceController alloc] init];
    [self.navigationController pushViewController:province animated:YES];
}

#pragma mark- 加载数据
-(void)reviseWorkplace {

    [MMProgressHUD showWithStatus:@"加载中..."];
    
    NSDictionary *dic  = @{@"area_id":_area_id};
    [TXDataService POST:updateWorkplace param:dic isCache:NO caChetime:0 completionBlock:^(id responseObject, NSError *error) {
        if (error) {
            [MMProgressHUD dismissWithError:@"修改失败！"];
            return ;
        }
        
        if (![[responseObject objectForKey:@"success"] isEqual:@(1)]) {
            [MMProgressHUD dismissWithError:@"修改失败！"];
            return ;
        }
        MyLog(@"修改成功！");
        [MMProgressHUD dismiss];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
