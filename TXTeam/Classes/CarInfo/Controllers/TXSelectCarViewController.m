//
//  TXSelectCarViewController.m
//  TXTeam
//
//  Created by 吖银 on 15-1-17.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXSelectCarViewController.h"
#import "Common.h"
#import "InputHelper.h"
#import "TXTool.h"
#import "TXProvinceController.h"

@interface TXSelectCarViewController ()

@end

@implementation TXSelectCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"查询班次";
    //自定义barbutton 按钮
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"<返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backbuttonclick)];
    [back setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem =back;
    
    self.view.backgroundColor = kBackgroundColor;
    scrollview =[[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    scrollview.backgroundColor = kBackgroundColor;
    scrollview.contentSize = CGSizeMake(kScreenWidth, kScreenHeight*1.2);
    [self.view addSubview:scrollview];
    //在scrollview 上创建一个点击事件
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(taghandle:)];
    [scrollview addGestureRecognizer:tapgesture];

    [self initMainview];
    /*
    //用类inputhelper 解决键盘遮挡问题
     [inputHelper setupInputHelperForView:self.view withDismissType:InputHelperDismissTypeTapGusture];
    */
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //获取发车区域id和终点区域id
    TXTool *tool = [TXTool sharedTXTool];
    if (tool.areaIndex == 1 || tool.areaIndex == 2) {
        if (tool.areaModel != nil) {
            UITextField *areaField = (UITextField *)[self.view viewWithTag:tool.areaIndex];
            areaField.text = [NSString stringWithFormat:@"%@ %@",tool.selectCity,tool.areaModel.area];
        }
        
    }

    if (tool.areaIndex == 1) {
        begin_area_id = tool.areaModel.area_id;
    }else if(tool.areaIndex == 2) {
        end_area_id = tool.areaModel.area_id;
    }
    tool.areaIndex = 0;
    tool.areaModel = nil;
    tool.selectCity = nil;

}

-(void)initMainview{
    NSArray *SelectName =[[NSArray alloc]initWithObjects:@"出发城市：",@"到达城市：",@"乘车日期：",nil];
    float viewheight=kScreenHeight*0.1;
    for (int index =0; index <SelectName.count; index ++) {
        UIView *selectView =[[UIView alloc]initWithFrame:CGRectMake(0, 10 +viewheight*index, kScreenWidth,viewheight -10 )];
        selectView.backgroundColor = [UIColor whiteColor];
        [scrollview addSubview:selectView];
        UILabel *showlabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth*0.3, viewheight -10-20)];
        showlabel.text = SelectName[index];
        showlabel.adjustsFontSizeToFitWidth =YES;
        showlabel.textAlignment =NSTextAlignmentCenter;
       // showlabel.backgroundColor =[UIColor redColor];
        [selectView addSubview:showlabel];
        
        UITextField *Cartext = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth*0.3-5, 10, kScreenWidth*0.7, viewheight -10-20)];
        Cartext.tag = index +1;
        Cartext.delegate =self;
       // Cartext.backgroundColor = [UIColor redColor];
        [selectView addSubview:Cartext];
        
        UIButton *selectButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 10 +viewheight*3+10, kScreenWidth-60, 44)];
        [selectButton setBackgroundColor:[UIColor redColor]];
        [selectButton setTitle:@"查  询" forState:UIControlStateNormal];
        [selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        selectButton.layer.cornerRadius = 5;
        [selectButton addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:selectButton];
    }
}
//back barbutton 方法
-(void)backbuttonclick
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITextField *textfield =(UITextField *)[self.view viewWithTag:TextTag];
    [textfield resignFirstResponder];
}

-(void)taghandle: (UITapGestureRecognizer *)tap
{
    [scrollview endEditing:YES];
}

//查询按钮方法
- (void)searchClick {
    if ([self checkTextField]) {
        UITextField *departure_time = (UITextField *)[self.view viewWithTag:3];
        [TXTool sharedTXTool].begin_area_id = begin_area_id;
        [TXTool sharedTXTool].end_area_id = end_area_id;
        [TXTool sharedTXTool].departure_time = departure_time.text;
        [TXTool sharedTXTool].beginSearch = YES;
        [self dismissViewControllerAnimated:YES completion:nil];
        
        if ([self.delegate respondsToSelector:@selector(changeTitle:)]) {
            [self.delegate changeTitle];
        }
    }
}

- (BOOL)checkTextField {
    //检查textField为不为空
    UITextField *textField1 = (UITextField *)[self.view viewWithTag:1];
    UITextField *textField2 = (UITextField *)[self.view viewWithTag:2];
    UITextField *textField3 = (UITextField *)[self.view viewWithTag:3];
    NSLog(@"textf%@",textField1.text);
    if ([textField1.text isEqualToString:@""] || [textField2.text isEqualToString:@""] || [textField3.text isEqualToString:@""]) {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alerView show];
        return NO;
    }
    return YES;
}

#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        self.areaValue = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
        UITextField *text =(UITextField *)[self.view viewWithTag:TextTag];
        text.text = self.areaValue;
    }
    //    else{
    //        self.cityValue = [NSString stringWithFormat:@"%@ %@", picker.locate.state, picker.locate.city];}
}

- (void)pickerDidSelect:(NSString *)Datestring
{
    UITextField *te =(UITextField *)[self.view viewWithTag:TextTag];
    te.text=Datestring;
}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    TextTag = textField.tag;
    if (textField.tag ==1 ||textField.tag ==2) {
        
        [TXTool sharedTXTool].areaIndex = textField.tag;
        [scrollview endEditing:YES];
        TXProvinceController *province = [[TXProvinceController alloc] init];
        [self.navigationController pushViewController:province animated:YES];
        
        return NO;
    }
    //if (textField.tag ==5)
    else if (textField.tag == 3){
        
        [scrollview endEditing:YES];
        TXDatePicker *datepiick=[[TXDatePicker alloc]initWithDatepicker:self];
        
        [datepiick showInView:scrollview];
        [datepiick DateSincenow:0];
        return NO;
    }
    return YES ;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
