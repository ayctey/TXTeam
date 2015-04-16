//
//  TXReviseWorkPlaceViewController.h
//  TXTeam
//
//  Created by 吖银 on 15-1-18.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//修改工作地点控制器

#import "TXBaseViewController.h"
@interface TXReviseWorkPlaceViewController : TXBaseViewController

{

    UIButton *workbtn;
    NSString *_area_id;
}

@property (nonatomic,strong) NSString *formalworkplace;
//修改后的工作地点
@property (strong, nonatomic) NSString *newworkplace;

@end
