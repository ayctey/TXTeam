//
//  TXDatePicker.h
//  TXTeam
//
//  Created by 吖银 on 15-1-15.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TXDatePicker;

@protocol TXDatePickerdelegate <NSObject>

@optional
- (void)pickerDidSelect:(NSString *)Datestring;

@end

@interface TXDatePicker :UIView
{

    UIDatePicker *datepicker;
}
@property (assign, nonatomic) id <TXDatePickerdelegate> delegate;
- (id)initWithDatepicker: (id <TXDatePickerdelegate>)delegate;
- (void)showInView:(UIView *)view;
-(void)DateSincenow: (NSTimeInterval)timeinrval;
@end
