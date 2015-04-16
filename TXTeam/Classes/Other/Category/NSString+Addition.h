//
//  NSString+Addition.h
//  TXTeam
//
//  Created by yezejiang on 15-3-11.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addition)

+ (NSString *)getTimeFormString:(NSString *)dateString;

+ (NSString *)getNextDate:(NSString *)dateString;

@end
