//
//  TXTool.m
//  TXTeam
//
//  Created by yezejiang on 15-3-12.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXTool.h"

@implementation TXTool
singleton_implementation(TXTool)


- (void)setCurrentDate:(NSString *)currentDate {
    
    
    //获取当前时间
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];
    _currentDate = dateString;
}

@end
