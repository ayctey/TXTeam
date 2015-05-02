//
//  TXMessageListViewController.m
//  TXTeam
//
//  Created by 吖银 on 15-1-14.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXMessageListViewController.h"
#import "TXChatViewController.h"
@interface TXMessageListViewController ()

@end

@implementation TXMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"会话" textColor:[UIColor whiteColor]];
    // 隐藏融云导航左右按钮
       self.navigationItem.leftBarButtonItem = nil;
       self.navigationItem.rightBarButtonItem = nil;
}
////隐藏了无会话列表的背景图
//-(BOOL)showCustomEmptyBackView {
//    
//    return YES;
//}

//-(void)leftBarButtonItemPressed:(id)sender
//{
//    [super leftBarButtonItemPressed:sender];
//}

//-(void)rightBarButtonItemPressed:(id)sender
//{
//    // 跳转好友列表界面，可是是融云提供的 UI 组件，也可以是自己实现的UI
//    RCSelectPersonViewController *temp = [[RCSelectPersonViewController alloc]init];
//    // 控制多选
//    temp.isMultiSelect = YES;
//    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:temp];
//    
//    // 导航和的配色保持一直
//    UIImage *image= [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
//    [nav.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    temp.navigationController.navigationBar.barTintColor=[UIColor redColor];
//    temp.delegate = self;
//    // [self presentModalViewController:nav animated:YES];
//    [self presentViewController:nav animated:YES completion:nil];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//重载 TableView 表格点击事件
-(void)onSelectedTableRow:(RCConversation*)conversation{
    
    /*
     if(conversation.conversationType == ConversationType_GROUP)
     {
     DemoGroupListViewController* groupVC = [[DemoGroupListViewController alloc] init];
     self.currentGroupListView = groupVC;
     [self.navigationController pushViewController:groupVC animated:YES];
     return;
     }
     */
    // 该方法目的延长会话聊天 UI 的生命周期
    TXChatViewController* chat = [self getChatController:conversation.targetId conversationType:conversation.conversationType];
    
    if (nil == chat) {
        chat =[[TXChatViewController alloc]init];
        [self addChatController:chat];
    }
    chat.currentTarget = conversation.targetId;
    chat.conversationType = conversation.conversationType;
    //chat.currentTargetName = curCell.userNameLabel.text;
    chat.currentTargetName = conversation.conversationTitle;
    chat.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chat animated:YES];
}

@end
