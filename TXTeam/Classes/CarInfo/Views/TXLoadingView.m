//
//  TXLoadingView.m
//  TXTeam
//
//  Created by yezejiang on 15-3-19.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXLoadingView.h"
#import "Common.h"

@implementation TXLoadingView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBackgroundColor;
        //self.alpha = 0.8;
        
        
        UIView *bgView = [[UIView alloc] init];
        bgView.frame = CGRectMake(kScreenWidth/2-50, kScreenHeight/3-20, 100, 30);
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.4;
        bgView.layer.cornerRadius = 6;
        [self addSubview:bgView];
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
        indicator.frame = CGRectMake(17, 15, 0, 0);
        [bgView addSubview:indicator];
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.text = @"加载中...";
        textLabel.textColor = [UIColor whiteColor];
        textLabel.frame = CGRectMake(27, 0, 70, 30);
        textLabel.font = [UIFont systemFontOfSize:15.0f];
        textLabel.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:textLabel];
        
        [indicator startAnimating];
        
    }
    return self;
}


@end
