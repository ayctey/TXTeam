//
//  TXPerfetOersonalViewController.h
//  TXTeam
//
//  Created by 吖银 on 15-1-14.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//
//个人资料完善页


#import <UIKit/UIKit.h>
#import "TXDatePicker.h"
@interface TXPerfetOersonalViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UIPickerViewDelegate,TXDatePickerdelegate,UIActionSheetDelegate>
{
    //放label、image等
    UIImageView *HeaderView;
    //放text、按钮
    UIView *textView;
    UITextField *_textField;
    NSInteger TextTag;
    //用户性别
    NSString *Sex;
       //生日
    NSString *Birthday;
}
@property (strong,nonatomic) UIScrollView *scrollView;
//显示省、市、区
@property (strong, nonatomic) NSString *areaValue;
//地区id
@property (strong ,nonatomic) NSString *area_id;
@property (strong, nonatomic) NSString *Name;//用户姓名
@end
