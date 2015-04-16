//
//  TXAreaController.h
//  CARPeer

//区域选择控制器

//  Created by yezejiang on 15-2-5.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//


#import "TXProvinceController.h"
@interface TXAreaController : TXProvinceController
{
    NSMutableArray *areaData;
    
}
@property (nonatomic,strong) NSString *city_id;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong)  NSString *_province;
@property (nonatomic,strong)  NSString *Area_WheatherHome;
@end


