//
//  TXRegisterViewController.m
//  TXTeam
//
//  Created by 吖银 on 15-1-12.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//
#import "TXRegisterViewController.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@interface TXRegisterViewController ()

@end

@implementation TXRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.font = [UIFont systemFontOfSize:18];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = NSLocalizedString(@"注册", nil);
    
    self.navigationItem.titleView = title;
    [self.view setBackgroundColor:RGBCOLOR(230, 230, 230)];
    [self configureNavigationBar];
    [self initView];
    
}

-(void)initView {
    
    
}

-(void)configureNavigationBar {
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"取消", nil)
                                                                     style:UIBarButtonItemStylePlain target:self
                                                                    action:@selector(cancelSignup)];
    cancelButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = cancelButton;
   // self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Title bar.png"] forBarMetrics:UIBarMetricsDefault];
}

-(void)cancelSignup {
    // [self invalidateFirstResponders];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
