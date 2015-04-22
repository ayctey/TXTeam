//
//  TXReviseNameViewController.m
//  TXTeam
//
//  Created by 吖银 on 15-3-20.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXReviseNameViewController.h"
#import "Common.h"
#import "TXDataService.h"
@interface TXReviseNameViewController ()

@end

@implementation TXReviseNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"姓名修改";
    self.view.backgroundColor = [UIColor whiteColor];
    [self reserveBarbutton];
    [self initMainview];
}

-(void)reserveBarbutton {
    
    UIBarButtonItem *reserve = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(Name_reservebutton)];
    self.navigationItem.rightBarButtonItem = reserve;
    
}
-(void)initMainview{

    UIView *homeview = [[UIView alloc]initWithFrame:CGRectMake(0, kNavigationH, kScreenWidth, 50)];
    homeview.backgroundColor = kBackgroundColor;
    [self.view addSubview:homeview];
    UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth*0.3+30, 30)];
    lab.text = @"姓名：";
    [homeview addSubview:lab];
    
    nameText = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth*0.31, 0, kScreenWidth*0.8, 50)];
    nameText.tag =201;
    nameText.placeholder =_fomalname;
    [homeview addSubview:nameText];
}

-(void)getname: (NSString *)namelabe{
    
    _fomalname = namelabe;

}

//按钮 保存 的方法
-(void)Name_reservebutton
{
    UITextField *text =(UITextField *)[self.view viewWithTag:201];
    //修改姓名框不为空时才能显示修改后的内容
    if (![text.text isEqual:@""]) {

        _newname = text.text;
        [self reviseName];
        
        //发送通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"name" object:_newname];
        //修改后的姓名重新存入单例
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [ defaults setValue:_newname forKey:@"name"];
    }
    else{
        
    [self reviseName];
        
    }
    
}
#pragma mark -- 加载数据
-(void)reviseName
{
    NSDictionary *param = @{@"name":nameText.text};
    [TXDataService POST:updateName param:param isCache:NO caChetime:0 completionBlock:^(id responseObject, NSError *error) {
        
           if ([responseObject objectForKey:@"success"]) {
            NSLog(@"responseobject:%@",[responseObject objectForKey:@"success"]);
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
