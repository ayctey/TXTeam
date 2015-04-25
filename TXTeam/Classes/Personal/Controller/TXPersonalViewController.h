//
//  TXPersonalViewController.h
//  TXTeam
//
//  Created by 吖银 on 15-1-17.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXBaseViewController.h"

@interface TXPersonalViewController : TXBaseViewController<UIAlertViewDelegate,UITextFieldDelegate>
{
    NSInteger textfieldTag;
    //修改后的家乡、工作地点、公司名称
    NSString *newhometown;
    NSString *newworkplace;
    NSString *newcomplyname;
   }

-(void)getnewHometown: (NSString *)homename;
-(void)getnewWorkPlace: (NSString *)workplace;
-(void)getnewComply: (NSString *)comply;
@end
