//
//  TXReviseCompanyViewController.m
//  TXTeam
//
//  Created by 吖银 on 15-1-18.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXReviseCompanyViewController.h"
#import "Common.h"
#import "TXPersonalViewController.h"
#import "TXDataService.h"
@interface TXReviseCompanyViewController ()

@end

@implementation TXReviseCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"企业名称";
    self.view.backgroundColor = [UIColor whiteColor];
    [self reserveBarbutton];
    [self initView];
}

-(void)reserveBarbutton {
    
    UIBarButtonItem *reserve = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(Comply_reservebutton)];
    self.navigationItem.rightBarButtonItem = reserve;
    
}

-(void)initView
{
    UIView *homeview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    homeview.backgroundColor = kBackgroundColor;
    [self.view addSubview:homeview];
    UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth*0.3+30, 30)];
    lab.text = @"企业名称：";
    [homeview addSubview:lab];
    
    complyTextfield = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth*0.31, 0, kScreenWidth*0.8, 50)];
    complyTextfield.tag =202;
    complyTextfield.placeholder =_formalcomply;
    [homeview addSubview:complyTextfield];
    

    
    
    
}
//按钮 保存 的方法
-(void)Comply_reservebutton
{
    
    UITextField *text =(UITextField *)[self.view viewWithTag:202];
    _newcomply = text.text;
    [self.navigationController popViewControllerAnimated:YES];
    
    TXPersonalViewController *person = [[TXPersonalViewController alloc]init];
    [person getnewComply:_newcomply];
    [self reviseComply];
    
    //有待继续
    
    //发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"newcomplyname" object:_newcomply];
    //修改后的企业重新存入单例
    // NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // [ defaults setValue:_newcomply forKey:@""];
    
}
#pragma mark -- 加载数据
-(void)reviseComply
{


}
- (void)didReceiveMemoryWarning {
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
