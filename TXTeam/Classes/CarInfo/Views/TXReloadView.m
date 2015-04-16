//
//  TXReloadView.m
//  TXTeam
//
//  Created by yezejiang on 15-3-16.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXReloadView.h"

@implementation TXReloadView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.8;
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
        indicator.center = self.center;
        [self addSubview:indicator];
        
        [indicator startAnimating];
        
    }
    return self;
}

@end
