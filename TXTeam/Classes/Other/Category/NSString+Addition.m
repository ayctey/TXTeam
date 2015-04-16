//
//  NSString+Addition.m
//  TXTeam
//
//  Created by yezejiang on 15-3-11.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

//获取时间
+ (NSString *)getTimeFormString:(NSString *)dateString {
    NSString *date = [dateString substringFromIndex:11];
    NSString *time = [date substringToIndex:5];
    return time;
}

+ (NSString *)getNextDate:(NSString *)dateString {
    return nil;
}


@end
