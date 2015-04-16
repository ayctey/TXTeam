//
//  TXUserMessageViewController.h
//  TXTeam
//
//  Created by 吖银 on 15-1-18.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//
//用户资料 控制器

#import "TXBaseViewController.h"

@interface TXUserMessageViewController : TXBaseViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{

    
    UITableView *_tableview ;
    NSArray *dataArray ;
    NSString *sex;

}
@end
