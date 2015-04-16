//
//  TXDatePicker.m
//  TXTeam
//
//  Created by 吖银 on 15-1-15.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXDatePicker.h"
#import "Common.h"
@implementation TXDatePicker
@synthesize delegate=_delegate;

-(id) initWithDatepicker:(id<TXDatePickerdelegate>)delegate
{
    CGRect frame=CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self= [super initWithFrame:frame];
    if (self) {
        
        self.delegate=delegate;
        self.backgroundColor=[UIColor colorWithRed:0. green:0. blue:0. alpha:0.4];
     
        UITapGestureRecognizer   *singletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        //[singletap setNumberOfTapsRequired:1];
        //singletap.delegate = self;
        [self addGestureRecognizer:singletap];
        
        UIView *_view =[[UIView alloc]init];
            _view.frame =CGRectMake(0, kScreenHeight-225, kScreenWidth, 220);
        _view.backgroundColor=[UIColor grayColor];
        [self addSubview:_view];
        
        
        
        datepicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, kScreenHeight/2, kScreenWidth, 216)];
        datepicker.frame=CGRectMake((kScreenWidth-320)/2, 0, 320, 216);
        datepicker.backgroundColor=kBackgroundColor;
        //datepicker.datePickerMode=UIDatePickerModeDate;
        [datepicker setDatePickerMode:UIDatePickerModeDate];
        datepicker.date=[NSDate dateWithTimeIntervalSinceNow:-900000000];
        datepicker.tag=10;
        datepicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
        [_view addSubview:datepicker];
    }
    
    return self;


}
-(void)DateSincenow: (NSTimeInterval)timeinrval
{

    datepicker.date=[NSDate dateWithTimeIntervalSinceNow:timeinrval];


}
- (void)showInView:(UIView *) view
{
    self.frame = CGRectMake(0, view.frame.size.height, self.frame.size.width, self.frame.size.height);
   // [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    [view addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];

    
}
-(void)handleSingleTap: (UITapGestureRecognizer *) tapgusture{
    
    //[Clearview removeFromSuperview];
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){

    if([self.delegate respondsToSelector:@selector(pickerDidSelect:)]) {
    
        UIDatePicker *_datepick =(UIDatePicker *)[self viewWithTag:10];
        NSDate *_date =_datepick.date;
        NSDateFormatter *dateformater=[[NSDateFormatter alloc]init];
        [dateformater setDateFormat:@"yyyy-MM-dd"];
        NSString *_now =[dateformater stringFromDate:_date];
        
        [self.delegate pickerDidSelect:_now];
        
        
    }
                     
     
                         [self removeFromSuperview];
                     }];

}


@end
