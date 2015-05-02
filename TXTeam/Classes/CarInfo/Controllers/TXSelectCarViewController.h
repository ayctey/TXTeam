//
//  TXSelectCarViewController.h
//  TXTeam
//
//  Created by 吖银 on 15-1-17.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//查询班次控制器



#import "TXBaseViewController.h"
#import "TXDatePicker.h"
#import "HZAreaPickerView.h"
#import "TXAreaModel.h"

@protocol TXSelectCarViewDelegation;

@interface TXSelectCarViewController : TXBaseViewController<UITextFieldDelegate,TXDatePickerdelegate,HZAreaPickerDelegate>
{
    UIScrollView *scrollview;
    NSInteger TextTag;
    
    NSString *begin_area_id;
    NSString *end_area_id;
}

@property (copy, nonatomic) NSString *areaValue;
@property (nonatomic,assign) NSInteger areaIndex;
@property (nonatomic,assign) id <TXSelectCarViewDelegation> delegate;

@end

@protocol  TXSelectCarViewDelegation<NSObject>

- (void)changeTitle;

@end
