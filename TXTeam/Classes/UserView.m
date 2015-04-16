//
//  UserView.m
//  CARPeer
//
//  Created by yezejiang on 15-1-12.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "UserView.h"
#import "Common.h"

@implementation UserView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
        
    }
    return self;
}

- (void)initViews
{
    _headImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    _headImage.frame =  CGRectMake(kSpacing, kSpacing, 60, 60);
    _headImage.backgroundColor  = [UIColor redColor];
    [self addSubview:_headImage];
    
    UILabel *user = [[UILabel alloc]init];
    user.text = @"用户名";
    user.frame = CGRectMake(90, 10, 60, 30);
    [self addSubview:user];
    //用户名
    _userName = [[UILabel alloc] init];
    //_userName.text = @"用户名";
    _userName.frame = CGRectMake(150, 10, 150, 30);
    [self addSubview:_userName];
    
    _accout = [[UILabel alloc] init];
    _accout.text = @"18300072733";
    _accout.frame = CGRectMake(170, 50, 120, 20);
    _accout.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:_accout];
    
    UILabel *accoutTitle = [[UILabel alloc] init];
    accoutTitle.text = @"账号:";
    accoutTitle.frame = CGRectMake(90, 50, 80, 20);
    accoutTitle.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:accoutTitle];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *key = @[@"account",@"tel",@"protrait_url"];
    _userName.text = [defaults objectForKey:key[0]];
    _accout.text = [defaults objectForKey:key[1]];
}

@end
