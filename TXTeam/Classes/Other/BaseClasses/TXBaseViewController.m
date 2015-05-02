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
    //更改全部tittle颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.view.backgroundColor = [UIColor blueColor];
    
    //navigation tittle 颜色
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    [backItem setTitle:@"返回"];
    self.navigationItem.backBarButtonItem = backItem;
}

//添加导航栏返回button
-(void)addbackButton
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"<返回" style:UIBarButtonItemStylePlain target:self action:@selector(backSuperController)];
    [button setTintColor:[UIColor whiteColor]];
      self.navigationItem.leftBarButtonItem = button;
}

//设置返回按钮样式
-(void)setBackButton
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.backBarButtonItem = backItem;
    backItem.tintColor = [UIColor whiteColor];
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

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
