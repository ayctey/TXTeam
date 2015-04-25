//
//  MainViewController.m
//  TXTeam
//
//  Created by 吖银 on 15-1-12.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "MainViewController.h"
#import "TXMessageListViewController.h"
#import "TXCarInfoViewController.h"
#import "TXRecruitViewController.h"
#import "TXReadViewController.h"
#import "TXPersonalViewController.h"
#import "TXBaseNavController.h"
#import "EAIntroPage.h"
#import "EAIntroView.h"
#import "Common.h"

#define TITLE @[@"会话",@"汽车班次查询推荐",@"招聘",@"阅读",@"我"]
#define BARITEM_WIDTH 16
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initControllers];
}

//加载引导页
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSNumber *isFirstLogin = [defaults objectForKey:@"isFirstLogin"];
    BOOL firstLogin = [isFirstLogin boolValue];
    NSLog(@"是否是第一次登陆：%d",firstLogin);
    if (!isFirstLogin) {
        [self showIntroWithCrossDissolve];
    }
}

- (void)showIntroWithCrossDissolve {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL firstLogin = 1;
    NSNumber *isFirstLogin = [NSNumber numberWithInteger:firstLogin];
    [defaults setObject:isFirstLogin forKey:@"isFirstLogin"];
    
    //引导页1
    EAIntroPage *page1 = [EAIntroPage page];
    page1.bgImage = [UIImage imageNamed:@"guidance1"];
    page1.titleImage = [UIImage imageNamed:@"original"];
    
    //引导页3
    EAIntroPage *page2 = [EAIntroPage page];
    page2.bgImage = [UIImage imageNamed:@"guidance2"];
    page2.titleImage = [UIImage imageNamed:@"supportcat"];
    
    //引导页3
    EAIntroPage *page3 = [EAIntroPage page];
    page3.bgImage = [UIImage imageNamed:@"guidance3"];
    page3.titleImage = [UIImage imageNamed:@"femalecodertocat"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3]];
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
}

//初始化控制器
- (void)initControllers
{
    //消息列表控制器
    TXMessageListViewController *messagecontroller =[[TXMessageListViewController alloc]init];
   // messagecontroller.portraitStyle = RCUserAvatarCycle;
    messagecontroller.title= TITLE[0];
    //汽车控制器
    TXCarInfoViewController *Carinfo=[[TXCarInfoViewController alloc]init];
    Carinfo.title= TITLE[1];
    //招聘控制器
    TXRecruitViewController *recruit=[[TXRecruitViewController alloc]init];
    recruit.title=TITLE[2];
    //阅读控制器
    TXReadViewController *read=[[TXReadViewController alloc]init];
    read.title=TITLE[3];
    //个人控制器
    TXPersonalViewController *personal=[[TXPersonalViewController alloc]init];
    personal.title=TITLE[4];
    
    NSArray *controllers = @[messagecontroller,Carinfo,personal];
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (UIViewController *contr in controllers) {
        TXBaseNavController *nav = [[TXBaseNavController alloc] initWithRootViewController:contr];
        [viewControllers addObject:nav];
    }
    self.viewControllers = viewControllers;
    self.selectedIndex = 1;
    [self initCustomTabbar];
}

//自定义TabBar
- (void)initCustomTabbar
{
    UIView *bottomBar = [[UIView alloc] init];
    bottomBar.frame = CGRectMake(0, 0, kScreenWidth, 49);
    bottomBar.backgroundColor = [UIColor colorWithRed:233.0/255 green:233.0/255 blue:233.0/255 alpha:1];
    [self.tabBar addSubview:bottomBar];
    NSArray *itemsImage_normal = @[@"信息@2x",@"信封@2x",@"用户@2x"];
    NSArray *itemsImage_selected=@[@"发光信息@2x",@"发亮信封@2x",@"发光用户@2x"];
    for (int i = 0; i < 3; i ++) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
               [item setImage:[UIImage imageNamed:itemsImage_normal[i]] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:itemsImage_selected[i]] forState:UIControlStateSelected];
        item.tag = i;
      //  CGFloat x = kScreenWidth/5-BARITEM_WIDTH;
        CGFloat x =kScreenWidth/3;
       // item.frame = CGRectMake(x/2+(x+BARITEM_WIDTH)*i, 0, BARITEM_WIDTH, 49);
        item.frame=CGRectMake(x*i , 0, x , 49);
        //item.imageEdgeInsets=UIEdgeInsetsMake(15, 15, 15, 15);
       // item.imageView.contentMode = UIViewContentModeTopLeft;
        [item addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
       // [item setTitle:@"fff" forState:UIControlStateNormal];
       // item.titleEdgeInsets=UIEdgeInsetsMake(0, 0, -20, 20);
        [bottomBar addSubview:item];
        
        if (1 == i) {
            selectedBtn = item;
            item.selected = YES;
        }
    }
}

- (void)buttonClick:(UIButton *)button
{
    //1.先将之前选中的按钮设置为未选中
    selectedBtn.selected = NO;
    //2.再将当前按钮设置为选中
    button.selected = YES;
    //3.最后把当前按钮赋值为之前选中的按钮
    selectedBtn = button;
    
    //4.跳转到相应的视图控制器. (通过selectIndex参数来设置选中了那个控制器)
    self.selectedIndex = button.tag;
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
