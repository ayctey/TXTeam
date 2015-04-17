//
//  TXDataService.m
//  CARPeer
//
//  Created by yezejiang on 15-1-17.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXDataService.h"
#import "APIManage.h"

@implementation TXDataService

+ (void)POST:(NSString *)urlString param:(NSDictionary *)param completionBlock:(CompletionBlock)block
{
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,urlString];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    
    [manager POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block(nil,error);
    }];
}

+ (void)GET:(NSString *)urlString param:(NSDictionary *)param completionBlock:(CompletionBlock)block
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,urlString];
    
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:url parameters:param success:^(AFHTTPRequestOperation *operation, id    responseObject) {
            block(responseObject,nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            block(nil,error);
        }];
}

+ (void)tongbuGET:(NSString *)urlString param:(id)param completionBlock:(CompletionBlock)block
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,urlString];
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    NSMutableURLRequest *request = [requestSerializer requestWithMethod:@"GET" URLString:url parameters:param error:nil];
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    
    [requestOperation setResponseSerializer:responseSerializer];
    [requestOperation start];
    [requestOperation waitUntilFinished];
    block([requestOperation responseObject],nil);
    
}


@end
