//
//  TXChatViewController.m
//  TXTeam
//
//  Created by 吖银 on 15-1-14.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXChatViewController.h"
#define DebugLog( fmt, ... ) NSLog( @"[%@:(%d)] %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(fmt), ##__VA_ARGS__] )

@interface TXChatViewController ()

@end

@implementation TXChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewWillDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
