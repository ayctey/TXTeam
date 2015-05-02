//
//  TXCarInfoCell.h
//  TXTeam
//
//  Created by yezejiang on 15-2-9.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXCarInfoModel.h"

@protocol CellPushSendMessageDelegate;


@interface TXCarInfoCell : UITableViewCell
{
    UIView *cellContentView;
}

@property (nonatomic,strong) TXCarInfoModel *carInfoModel;//汽车模型
@property (nonatomic,assign) id<CellPushSendMessageDelegate> pushSendMessageDelegate;

@end

@protocol CellPushSendMessageDelegate <NSObject>

//push to 单聊界面
- (void)PushToSendMessage:(NSString *)rongYunID;

-(void)shareWeixinSDK;


@end
