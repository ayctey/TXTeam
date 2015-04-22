//
//  TXReviseHometownViewController.h
//  TXTeam
//
//  Created by 吖银 on 15-1-18.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//
//修改家乡控制器

#import "TXBaseViewController.h"
#import "TXAreaController.h"
@interface TXReviseHometownViewController : TXBaseViewController
{
    NSString *hometownname;
    UIButton *homebtn;
    
   
}

//选择的区id
@property (strong ,nonatomic)NSString *area_id;
//显示省、市、区
@property (strong, nonatomic) NSString *formalhometown;
//修改后的家乡
@property (strong , nonatomic) NSString *newhometown;

@end
