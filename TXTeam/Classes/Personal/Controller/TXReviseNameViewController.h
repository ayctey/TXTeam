//
//  TXReviseNameViewController.h
//  TXTeam
//
//  Created by 吖银 on 15-3-20.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

//修改姓名

#import "TXBaseViewController.h"

@interface TXReviseNameViewController : TXBaseViewController
{
    UITextField *nameText;
}

@property (nonatomic,copy) NSString *fomalname;
@property (nonatomic,copy)NSString *newname;
-(void)getname: (NSString *)namelabe;
@end
