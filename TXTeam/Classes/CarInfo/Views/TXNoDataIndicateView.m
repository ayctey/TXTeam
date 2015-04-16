//
//  TXNoDataIndicateView.m
//  TXTeam
//
//  Created by yezejiang on 15-3-16.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXNoDataIndicateView.h"
#import "Common.h"

@implementation TXNoDataIndicateView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBackgroundColor;
        UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/2-80, frame.size.height/3-20, 160, 40)];
        text.textAlignment  = NSTextAlignmentCenter;
        text.text = @"暂无班次信息";
        [self addSubview:text];
        
        
        
    }
    return self;
}

@end
