//
//  TXDataService.h
//  CARPeer
//
//  Created by yezejiang on 15-1-17.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^CompletionBlock)(id responseObject,NSError *error);

@interface TXDataService : NSObject

//POST请求
+ (void)POST:(NSString *)urlString param:(NSDictionary *)param completionBlock:(CompletionBlock)block;
//GET请求
+ (void)GET:(NSString *)urlString param:(NSDictionary *)param completionBlock:(CompletionBlock)block;
+ (void)tongbuGET:(NSString *)urlString param:(id)param completionBlock:(CompletionBlock)block;

@end
