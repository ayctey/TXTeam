//
//  TXCarTableViewCell.m
//  TXTeam
//
//  Created by 吖银 on 15-1-18.
//  Copyright (c) 2015年 ayctey. All rights reserved.
//

#import "TXCarTableViewCell.h"
#import "Common.h"
@implementation TXCarTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initmainview];
        self.CarGoTime.text =@"09:35";
        self.StartStation.text =@"茂名交委站";
        self.ArriveStation.text =@"深圳西乡站";
        self.StartCity.text =@"茂名";
        self.ArriveCity.text =@"深圳";
        self.price.text =@"100￥";
        self.CarStyle.text =@"大型高-卧";
    }
    return self;
}
-(void)initmainview{

    UIView *bgview =[[UIView alloc]initWithFrame:CGRectMake(0, 10, 375, 135)];
    bgview.backgroundColor =kBackgroundColor;
    [self.contentView addSubview:bgview];
    
    NSArray *array =[[NSArray alloc]initWithObjects:@"发车时间：",@"出发站：",@"终点站：", nil];
    for (int index=0; index<3; index++) {
        Carlab =[[UILabel alloc]initWithFrame:CGRectMake(10, index*40, 90, 30)];
        Carlab.text = array[index];
        if (index == 1) {
            Carlab.backgroundColor = [UIColor greenColor];
            Carlab.tintColor = [UIColor whiteColor];
        }
        if (index == 2) {
            Carlab.backgroundColor = [UIColor redColor];
            Carlab.tintColor = [UIColor whiteColor];
        }
        [bgview addSubview:Carlab];
    }
    
    self.CarGoTime = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 60, 30)];
    [bgview addSubview:self.CarGoTime];
    
    //
    self.StartStation =[[UILabel alloc]initWithFrame:CGRectMake(100-10-10, 40, 100, 30)];
    [bgview addSubview:self.StartStation];
    self.ArriveStation =[[UILabel alloc]initWithFrame:CGRectMake(100-10-10, 40*2, 100, 30)];
    [bgview addSubview:self.ArriveStation];

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
