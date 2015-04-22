//
//  TXPerfetOersonalViewController.m
//  TXTeam
//
//  Created by 吖银 on 15-1-14.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//
#define ktextfiekdHeight 50
#import "TXPerfetOersonalViewController.h"
#import "Common.h"
#import "TXTool.h"
#import "TXAreaModel.h"
#import "TXDataService.h"
#import "TXProvinceController.h"
#import "MainViewController.h"
@interface TXPerfetOersonalViewController ()

@end

@implementation TXPerfetOersonalViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UITextField *text = (UITextField *)[self.view viewWithTag:3];
    text.placeholder = @"（选填）";
    UITextField *text2 = (UITextField *)[self.view viewWithTag:6];
    text2.placeholder = @"（选填）";
    
    TXTool *tool = [TXTool sharedTXTool];
    if (tool.areaModel != nil) {
         NSString *area = [NSString stringWithFormat:@"%@ %@ %@",tool.selectProvince,tool.selectCity,tool.areaModel.area];
        if (tool.WhetherHometown !=nil) {
            UITextField *hometown  = (UITextField *)[self.view viewWithTag:4];
            hometown.text = area;
        }
        else {
            UITextField *work  = (UITextField *)[self.view viewWithTag:5];
            work.text = area;
        
        }
        
        _area_id = tool.selectAreaID;
       // NSLog(@"ddsa:%@",tool.WhetherHometown);
        tool.areaModel = nil;
    }

    
}
- (void)viewDidLoad
  {
    
       [super viewDidLoad];
       [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Title bar.png"] forBarMetrics:UIBarMetricsDefault];
    self.title =@"完善个人资料";
    self.view.backgroundColor=[UIColor whiteColor];
      
      
    //初始化scrolview
    self.scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
      
      self.scrollView.delegate=self;
    CGFloat ScrollH=kScreenHeight*1.2;
    self.scrollView.contentSize=CGSizeMake(kScreenWidth, ScrollH);
    [self.view addSubview:self.scrollView];
    HeaderView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    HeaderView.backgroundColor=kBackgroundColor;
      self.scrollView.showsHorizontalScrollIndicator=NO;
      self.scrollView.showsVerticalScrollIndicator=NO;
    [self.scrollView addSubview:HeaderView];
      [self initHeaderView];
    textView = [[UIView alloc]initWithFrame:CGRectMake(0, 115, kScreenWidth, ScrollH-110)];
    textView.backgroundColor=[UIColor whiteColor];
    [self.scrollView addSubview:textView];
    [self initTextfield];
      //在scrollview上加一个点击事件
     UITapGestureRecognizer   *singletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
      [singletap setNumberOfTapsRequired:1];
     
      [self.scrollView addGestureRecognizer:singletap];
     
      
}

-(void)initTextfield{
    NSArray *arrayname=@[@"真实姓名:",@"性别:",@"生日:",@"家乡:",@"工作所在地:",@"企业名称:"];
    for (int index=0; index<6; index ++) {
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 8+index*ktextfiekdHeight, 85, ktextfiekdHeight-6)];
        lab.backgroundColor= kBackgroundColor;
        lab.font = [UIFont boldSystemFontOfSize:15.8];
        lab.text = arrayname[index];
        [textView addSubview:lab];

        
        _textField=[[UITextField alloc]initWithFrame:CGRectMake(82, 8+index*ktextfiekdHeight, kScreenWidth-85, ktextfiekdHeight-6)];
        _textField.backgroundColor=kBackgroundColor;
        _textField.tag=index+1;
       // _textField.backgroundColor = [UIColor redColor];
        _textField.textAlignment=NSTextAlignmentCenter;
        //_textField.placeholder=arrayname[index];
        _textField.delegate=self;
       // _textField.alpha=1;
             //  _textField.textAlignment
    
        [textView addSubview:_textField];
        
    
    }
    
//添加button
    UIButton *GoHomeButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    GoHomeButton.frame =CGRectMake(0, 325, kScreenWidth, 50);
    [GoHomeButton setTitle:@"找汽车回家过年" forState:UIControlStateNormal];
    [GoHomeButton setBackgroundImage:[UIImage imageNamed:@"Title bar.png"]  forState:UIControlStateNormal];
    [GoHomeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [GoHomeButton addTarget:self action:@selector(GohomeClick) forControlEvents:UIControlEventTouchUpInside];
    [textView addSubview:GoHomeButton];
}
-(void)initHeaderView {

    UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(10, 25, 50, 50)];
    lab.text=@"头像";
    //lab.backgroundColor=[UIColor redColor];
    [HeaderView addSubview:lab];
    UIImageView *headerview = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-90, 5, 100, 100)];
    headerview.image=[UIImage imageNamed:@"默认头像.png"];
    [HeaderView addSubview:headerview];

}
//设置性别
-(void)reviseSex {
    UIActionSheet *revisesex = [[UIActionSheet alloc]initWithTitle:@"性别" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"男" otherButtonTitles:@"女", nil];
    [revisesex showInView:self.view];
}


#pragma mark -- 加载数据

-(void)Name_data
{
    NSDictionary *parm = @{@"name":_Name};
    [TXDataService POST:updateName param:parm isCache:NO caChetime:0 completionBlock:^(id responseObject, NSError *error) {
        
        if ([responseObject objectForKey:@"success"]) {
            NSLog(@"responseobject:%@",[responseObject objectForKey:@"success"]);
        }
        
    }];
    
}
-(void)reviseData_Sex:(NSString *)_sex{
    
    
    
    NSDictionary *parm = @{@"sex":_sex};
    [TXDataService POST:updateSex param:parm isCache:YES caChetime:0 completionBlock:^(id responseObject, NSError *error) {
        if ([responseObject objectForKey:@"success"]) {
            NSLog(@"Revise Sex success: %@",[responseObject objectForKey:@"success"]);
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:Sex forKey:@"sex"];
            UITextField *textField = (UITextField *)[self.view viewWithTag:2];
            [textField setText:Sex];
        }
    }];
    
    
}
-(void)HomeTown_Data {
    //NSLog(@"dddddd:%@",_area_id);
    NSDictionary *dic= @{@"area_id":_area_id};
    [TXDataService POST:updateArea param:dic isCache:YES caChetime:0 completionBlock:^(id responseObject, NSError *error) {
        if ([responseObject objectForKey:@"success"]) {
            NSLog(@"responObject///:%@",[responseObject objectForKey:@"success"]);
        }
    }];
    
}
-(void)WorkPlace_Data {


}
-(void)Comply_Data  {

}
#pragma mark - UIActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex ==0) {
        Sex = @"男";
        [self reviseData_Sex:Sex];
    }
    else{
        Sex = @"女";
        [self reviseData_Sex:Sex];
    }
    
}
#pragma  mark ---private action
-(void)GohomeClick {
    //上传数据
    [self Name_data];
    [self HomeTown_Data];
    [self WorkPlace_Data];
    [self Comply_Data];
    MainViewController *mainview=[[MainViewController alloc]init];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:mainview animated:YES];


}
-(void)handleSingleTap:(UITapGestureRecognizer *)tap
{
    [self.scrollView endEditing:YES];
   
   // [datepicker removeFromSuperview];
    
}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    TextTag =textField.tag;
    
    if (textField.tag !=1  && textField.tag !=6) {
        
                if (textField.tag ==2) {
            [self.scrollView endEditing:YES];
                    [self reviseSex];
        }
        if (textField.tag ==3) {
                           
            TXDatePicker *datepiick=[[TXDatePicker alloc]initWithDatepicker:self];
            //datepiick.frame= self.view.bounds;
         //   [self.view];
            [datepiick showInView:self.scrollView];
            
            
            
        }
        if (textField.tag ==4 ||textField.tag ==5) {
            
            TXProvinceController *province = [[TXProvinceController alloc]init];
            if (textField.tag ==4) {
                province.wheatherHometown = @"yes";
                
            }
            [self.navigationController pushViewController:province animated:YES];
        }
        
        return NO;
    }
    return YES;

}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField.tag ==6) {
        self.view.frame=CGRectMake(0, -80, kScreenWidth, kScreenHeight);
    }
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag ==1) {
        _Name = textField.text;
      //  NSLog(@"ddd:%@",_Name);
    }
    if (textField.tag ==6) {
        self.view.frame=CGRectMake(0, 50, kScreenWidth, kScreenHeight);
    }
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    
}



- (void)pickerDidSelect:(NSString *)Datestring
{
    UITextField *te =(UITextField *)[self.view viewWithTag:TextTag];
    te.text=Datestring;

}



-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
