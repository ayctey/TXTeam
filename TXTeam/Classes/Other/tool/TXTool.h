//
//  TXTool.h
//  TXTeam
//
//  Created by yezejiang on 15-3-12.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class TXAreaModel;

@interface TXTool : NSObject
singleton_interface(TXTool)

@property (nonatomic,copy) NSString *begin_area_id;   //发车区域id
@property (nonatomic,copy) NSString *end_area_id;     //终点区域id
@property (nonatomic,copy) NSString *departure_time;  //发车日期

@property (nonatomic,copy) NSString *currentDate;
@property (nonatomic,assign) NSInteger areaIndex;     //区域索引
@property (nonatomic,assign) BOOL beginSearch;        //搜索索引

@property (nonatomic,strong) TXAreaModel *areaModel;
@property (nonatomic,copy) NSString *selectCity;
@property (nonatomic,copy) NSString *selectProvince;
@property (nonatomic,copy) NSString *selectAreaID;
@property (nonatomic,copy) NSString *WhetherHometown; //是哪个控制器选择
@end
