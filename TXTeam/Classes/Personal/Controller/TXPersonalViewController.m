//
//  TXPersonalViewController.m
//  TXTeam
//
//  Created by 吖银 on 15-1-17.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXPersonalViewController.h"
#import "UserView.h"
#import "Common.h"
#import "TXUserMessageViewController.h"
#import "TXReviseHometownViewController.h"
#import "TXReviseWorkPlaceViewController.h"
#import "TXReviseCompanyViewController.h"
#import "TXAboutViewController.h"
#import "TXLoginViewController.h"
#import "EGOCache.h"

#define userView_height 80

@interface TXPersonalViewController ()
{
    NSArray *userData;
}

@end

@implementation TXPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBarItem];
    [self initViews];
}
-(void)viewWillAppear:(BOOL)animated {

    //为家乡添加通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(modifyHometown:) name:@"newhometown" object:nil];
    //为工作地点添加通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(modifyWorkPlace:) name:@"newworkplace" object:nil];
    //为企业添加通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(modifyComply:) name:@"newcomplyname" object:nil];
}

//添加注销按钮
- (void)addBarItem
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStyleDone target:self action:@selector(barButtonClick)];
    item.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)initViews
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapClick:)];
    
    UserView *userView = [[UserView alloc] init];
    userView.frame = CGRectMake(0, kNavigationH, kScreenWidth, userView_height);
    userView.backgroundColor = kBackgroundColor;
    [userView addGestureRecognizer:tapGesture];
    
    //获取数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:@"name"];
    NSString *tel = [defaults objectForKey:@"tel"];
    NSString *url = [defaults objectForKey:@"protrait_url"];
    
    //填充数据
    userView.userName.text = userName;
    userView.accout.text = tel;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    userView.headImage.image = [UIImage imageWithData:imageData];
    [self.view addSubview:userView];
    
    //获取用户数据
    [self getUserDefaultData];
    
    NSArray *title_arr = @[@"家乡",@"工作所在地",@"企业",@"帮助",@"关于"];
    for (int i = 0; i < 5; i++) {
        UIView *view = [[UIView alloc] init];
        // view.tag = 100+i;
        view.backgroundColor = kBackgroundColor;
        view.frame = CGRectMake(0, userView_height+kSpacing+kNavigationH+45*i, kScreenWidth, 40);
        [self.view addSubview:view];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(10, 5, kScreenWidth*0.3, 30);
        titleLabel.text = title_arr[i];
        [view addSubview:titleLabel];
        
        UITextField *hometowntextfield = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth*0.3, 0, kScreenWidth*0.7, 40)];
        hometowntextfield.textAlignment=NSTextAlignmentRight;
        hometowntextfield.borderStyle =UITextBorderStyleNone;
        hometowntextfield.tag = 100+i;
        textfieldTag = hometowntextfield.tag;
        MyLog(@"userdata:%@",userData);
        hometowntextfield.text = userData[i];
        hometowntextfield.delegate =self;
        [view addSubview: hometowntextfield];
    }
}

//点击用户头像方法
-(void)userTapClick: (UITapGestureRecognizer *)ViewTapgesture
{
    TXUserMessageViewController *usermessage = [[TXUserMessageViewController alloc]init];
    usermessage.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:usermessage animated:YES];

}

//注销按钮 方法
-(void)barButtonClick
{
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"提示" message:@"亲，注销后要重新登录哦！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertview show];
}

//获取默认个人信息
-(void)getUserDefaultData
{
    //获取用户数据
    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
    
    //家乡
    NSString *homeTown = [[NSString alloc] initWithFormat:@"%@ %@",[defaultUser objectForKey:@"home_city"],[defaultUser objectForKey:@"home_area"]];
    
    //工作地
    NSString *workPlace = [[NSString alloc] initWithFormat:@"%@ %@",[defaultUser objectForKey:@"work_city"],[defaultUser objectForKey:@"work_area"]];
    MyLog(@"homeTown:%@ workPlace%@",homeTown,workPlace);
    
    userData =
     @[homeTown,workPlace,@"",@"",@""];
}

-(void)getnewHometown: (NSString *)homename
{
    //homename =newhometown;
     newhometown =homename;
   // NSLog(@"chuang:%@",newhometown);
    
}

-(void)getnewWorkPlace: (NSString *)workplace{

    newworkplace = workplace;
}

-(void)getnewComply: (NSString *)comply{

    newcomplyname = comply;
}

#pragma mark --通知
-(void)modifyHometown:(NSNotification *)notification
{
    UITextField *text = (UITextField *)[self.view viewWithTag:100];
    [text setText:notification.object];
   // NSLog(@"set: %@",text.text);

}

-(void)modifyWorkPlace: (NSNotification *)notification
{
  UITextField *text = (UITextField *)[self.view viewWithTag:101];
  [text setText:notification.object];
}

-(void)modifyComply: (NSNotification *)notification
{
    UITextField *text = (UITextField *)[self.view viewWithTag:102];
    [text setText:notification.object];
}

#pragma mark  - UITextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    if (textField.tag ==100 ||textField.tag ==101 ||textField.tag ==102) {
        if (textField.tag ==100) {
            TXReviseHometownViewController *revisehometown = [[TXReviseHometownViewController alloc]init];
            revisehometown.hidesBottomBarWhenPushed =YES;
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            //先把已经下载好的地区传过去，保证点击后能看到以前所选择的地区
            revisehometown.formalhometown=[defaults objectForKey:@"area"];
            [self.navigationController pushViewController:revisehometown animated:YES];
            
        }
        if (textField.tag ==101) {
            TXReviseWorkPlaceViewController *work = [[TXReviseWorkPlaceViewController alloc]init];
            work.hidesBottomBarWhenPushed = YES;
            
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
            work.formalworkplace=[defaults objectForKey:@"workplace"];
            
            [self.navigationController pushViewController:work animated:YES];
        }
        if (textField.tag ==102) {
            TXReviseCompanyViewController *company = [[TXReviseCompanyViewController alloc]init];
            company.hidesBottomBarWhenPushed  =YES;
            
           // NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            //此处等后台跟新后再补上
           // company.newcomply=[defaults objectForKey:@""];

            [self.navigationController pushViewController:company animated:YES];
        }
        return NO;
    }
    else{
        if (textField.tag ==104) {
            TXAboutViewController *about =[[TXAboutViewController alloc]init];
            about.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:about animated:YES];
        }
        return NO;
    }
   
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{

}

#pragma  mark  - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        //清空密码
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"password"];
        [defaults removeObjectForKey:@"token"];
        [defaults removeObjectForKey:@"isFirstLogin"];
        
        //清空所有缓存
        [[EGOCache globalCache] clearCache];
        
        TXLoginViewController *loginviewcntroller = [[TXLoginViewController alloc]init];
        loginviewcntroller.hidesBottomBarWhenPushed =  YES;
          [self.navigationController pushViewController:loginviewcntroller animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
