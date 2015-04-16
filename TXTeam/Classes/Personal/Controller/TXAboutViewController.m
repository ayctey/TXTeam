//
//  TXAboutViewController.m
//  TXTeam
//
//  Created by 吖银 on 15-1-18.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXAboutViewController.h"
#import "Common.h"
@interface TXAboutViewController ()

@end

@implementation TXAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initMianview];
}
-(void)initMianview{
    
    UIImageView *logoimageview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*0.4)];
    logoimageview.image =[UIImage imageNamed:@"tuanxiangtuan@2x副本.png"];
   // logoimageview.backgroundColor =[UIColor redColor];
    [self.view addSubview:logoimageview];
  
    UIView *versionview =[[UIView alloc]initWithFrame:CGRectMake(0, logoimageview.frame.size.height +kSpacing, kScreenWidth, 50)];
    versionview.backgroundColor = kBackgroundColor;
    [self.view addSubview:versionview];
    UILabel *versionlabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 30)];
    versionlabel.text = @"版本号：";
    [versionview addSubview:versionlabel];
    
    versionNumberLabel = [[UILabel alloc] init];
    versionNumberLabel.frame = CGRectMake(kScreenWidth-80, 5, 80, 30);
    versionNumberLabel.text = @"1.0.1";
    [versionview addSubview:versionNumberLabel];
    
    UIView *aboutview =[[UIView alloc]initWithFrame:CGRectMake(0, versionview.frame.origin.y+50 +kSpacing, kScreenWidth, 50)];
    aboutview.backgroundColor = kBackgroundColor;
    [self.view addSubview:aboutview];
    UILabel *aboutUs =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    aboutUs.text = @"关于我们";
    [aboutview addSubview:aboutUs];
    
    UIButton *Checkbtn = [[UIButton alloc]initWithFrame:CGRectMake(30, aboutview.frame.origin.y+50+20, kScreenWidth-60, 40)];
    [Checkbtn setTitle:@"检查更新" forState:UIControlStateNormal];
    [Checkbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Checkbtn setBackgroundImage:[UIImage imageNamed:@"Title bar.png"] forState:UIControlStateNormal];
    [Checkbtn addTarget:self action:@selector(checkRenew) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Checkbtn];

}
-(void)checkRenew
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
