//
//  TXMessageAuthenticationController.h
//  CARPeer
//
//  Created by yezejiang on 15-1-12.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//
//注册短信验证控制器


#import "UIKit/UIKit.h"
#import "TXBaseViewController.h"

enum WhichViewController{
    VCChangePasswordController = 1,
    VCSetingPassWord,
};

@interface TXMessageAuthenticationController : TXBaseViewController
{
    enum WhichViewController viewController;
   
}
@property (nonatomic,strong) NSString *phonenumbs;
@property(nonatomic,strong)  NSString *Cool;
- (void)pushTo:(enum WhichViewController)vc;
-(void)getUserPhonenums:(NSString *)numbers;
@end
