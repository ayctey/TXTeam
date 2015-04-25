//
//  TXCarInfoCell.m
//  TXTeam
//
//  Created by yezejiang on 15-2-9.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXCarInfoCell.h"
#import "TXCarInfoModel.h"
#import "NSString+Addition.h"
#import "Common.h"

@implementation TXCarInfoCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kBackgroundColor;
        [self initMainview];
    }
    return self;
}
-(void)initMainview{
    
    self.departure_time = [self setLabeFrame:CGRectMake(kSpacing, 5, 200, 30)];
    self.begin_area_detail =[self setLabeFrame:CGRectMake(kSpacing, 40, 200, 30)];
    self.end_area_detail =[self setLabeFrame:CGRectMake(kSpacing, 40+30, 200, 30)];
    //票价
    self.price = [self setLabeFrame:CGRectMake(kScreenWidth*0.6, 60, kScreenWidth*0.4, 40)];
    self.price.font = [UIFont systemFontOfSize:18.0f];
    self.price.textColor = [UIColor redColor];
    //出发城市
    self.begin_city = [self setLabeFrame:CGRectMake(kScreenWidth*0.45, 30, 80, 30)];
    self.end_city = [self setLabeFrame:CGRectMake(kScreenWidth*0.75, 30, 80, 30)];

    UILabel *line1 = [self setLabeFrame:CGRectMake(kScreenWidth*0.645, 45, 30, 1.5)];
    line1.backgroundColor = [UIColor grayColor];
    
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(0, 124, kScreenWidth, 1);
    line.backgroundColor = [UIColor whiteColor];
    [self addSubview:line];
}

- (void)setCarInfoModel:(TXCarInfoModel *)carInfoModel
{
    _carInfoModel = carInfoModel;
    NSString *timeString = [NSString getTimeFormString:carInfoModel.departure_time];
    self.departure_time.text = [NSString stringWithFormat:@"发车时间: %@",timeString];
    self.begin_area.text = carInfoModel.begin_area;
    self.end_area.text = carInfoModel.end_area;
    self.begin_area_detail.text = [NSString stringWithFormat:@"始: %@",carInfoModel.begin_area_detail];
    self.end_area_detail.text = [NSString stringWithFormat:@"终: %@",carInfoModel.end_area_detail];
    self.price.text = [NSString stringWithFormat:@"￥ %@",carInfoModel.price];
    self.begin_city.text = [NSString stringWithFormat:@"%@",carInfoModel.begin_city];
    self.begin_city.font = [UIFont systemFontOfSize:20.0f];
    self.end_city.text = [NSString stringWithFormat:@"%@",carInfoModel.end_city];
    self.end_city.font = [UIFont systemFontOfSize:20.0f];
}

- (UILabel *)setLabeFrame:(CGRect)frame {
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    label.font = [UIFont systemFontOfSize:16.0f];
    label.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:label];
    return label;
}

@end
