//
//  TXReviseHometownViewController.m
//  TXTeam
//
//  Created by 吖银 on 15-1-18.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXReviseHometownViewController.h"
#import "Common.h"
#import "TXProvinceController.h"
#import "TXPersonalViewController.h"
#import "TXTool.h"
#import "TXAreaModel.h"
#import "TXDataService.h"
@interface TXReviseHometownViewController ()

@end

@implementation TXReviseHometownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的家乡";
    self.view.backgroundColor = [UIColor whiteColor];
    [self reserveBarbutton];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    TXTool *tool = [TXTool sharedTXTool];
    if (tool.areaModel != nil) {
        NSString *area = [NSString stringWithFormat:@"%@ %@ %@",tool.selectProvince,tool.selectCity,tool.areaModel.area];
        [homebtn setTitle:area forState:UIControlStateNormal];
        _newhometown = area;
        _area_id = tool.selectAreaID;

        tool.areaModel = nil;
    }
}

-(void)reserveBarbutton {

    UIBarButtonItem *reserve = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(reservebutton)];
    self.navigationItem.rightBarButtonItem = reserve;

}
-(void)initView
{
  
    UIView *homeview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    homeview.backgroundColor = kBackgroundColor;
    [self.view addSubview:homeview];
    UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth*0.2, 30)];
    lab.text = @"家乡：";
    [homeview addSubview:lab];
    
    homebtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth*0.2, 0, kScreenWidth*0.8, 50)];
    [homebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [homebtn setTitle:_formalhometown forState:UIControlStateNormal];
    [homebtn addTarget:self action:@selector(homebtnClick) forControlEvents:UIControlEventTouchUpInside];
   // homebtn.backgroundColor =[UIColor redColor];
    homebtn.tag = 101;
    [homeview addSubview:homebtn];
}

-(void)reservebutton
{

    [self.navigationController popViewControllerAnimated:YES];
   
    TXPersonalViewController *person = [[TXPersonalViewController alloc]init];
    [person getnewHometown:_newhometown];
    //NSLog(@"after:%@",_newhometown);
    [self reviseHomeTown];
    //发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"newhometown" object:_newhometown];
    //修改后的家乡重新存入单例
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   [ defaults setValue:_newhometown forKey:@"area"];
    
}
-(void)homebtnClick
{
    TXProvinceController *province = [[TXProvinceController alloc] init];
    [self.navigationController pushViewController:province animated:YES];
}

#pragma mark - 加载数据
-(void)reviseHomeTown {
    
    [MMProgressHUD showWithStatus:@"加载中..."];
    
    NSDictionary *dic= @{@"area_id":_area_id};
    [TXDataService POST:updateArea param:dic completionBlock:^(id responseObject, NSError *error) {
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

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
