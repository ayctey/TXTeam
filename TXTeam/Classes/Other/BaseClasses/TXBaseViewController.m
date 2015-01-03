//
//  YCYBaseViewController.m
//  YCYmall
//
//  Created by ayctey on 14-10-27.
//  Copyright (c) 2014年 ayctey. All rights reserved.
//

#import "TXBaseViewController.h"
#import "Common.h"

@interface TXBaseViewController ()

@end

@implementation TXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
}

//添加导航栏返回button
-(void)addbackButton
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backSuperController)];
    self.navigationItem.leftBarButtonItem = button;
}

//设置返回按钮样式
-(void)setBackButton
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.backBarButtonItem = backItem;
    if (IsIOS6) {
        backItem.title = @"返回";
    }
    else
    {
        backItem.title = @"";
    }
}

//返回父控制器
-(void)backSuperController
{
    [self.navigationController.view removeFromSuperview];

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
