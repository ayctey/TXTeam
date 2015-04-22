//
//  TXUserModel.h
//  TXTeam
//
//  Created by yezejiang on 15-4-10.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXBaseModel.h"

@interface TXUserModel : TXBaseModel

@property (nonatomic ,copy) NSString *area_id;
@property (nonatomic ,copy) NSString *workplace;
@property (nonatomic ,copy) NSString *sex;
@property (nonatomic ,copy) NSString *area;
@property (nonatomic ,copy) NSString *protrait_url;
@property (nonatomic ,copy) NSString *name;
@property (nonatomic ,copy) NSString *tel;
@property (nonatomic ,copy) NSString *account;
@property (nonatomic ,strong) NSNumber *user_id;
@property (nonatomic ,copy) NSString *code;
@property (nonatomic ,copy) NSString *password;
@property (nonatomic ,copy) NSString *introduction;
@property (nonatomic ,strong) NSNumber *isvalid;

- (void)save;

@end
