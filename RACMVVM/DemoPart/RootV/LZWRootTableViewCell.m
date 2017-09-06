//
//  LZWRootTableViewCell.m
//  RACMVVM
//
//  Created by 刘志武 on 2017/9/5.
//  Copyright © 2017年 zhiwuLiu. All rights reserved.
//

#import "LZWRootTableViewCell.h"

@interface LZWRootTableViewCell ()

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIImageView *imageView_url;

@end

@implementation LZWRootTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatLZWRootTableViewCellSubViews];
    }
    return self;
}
#pragma mark -- 创建cell子视图
- (void)creatLZWRootTableViewCellSubViews
{
    UILabel *labelTop = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 375, 0.5)];
    labelTop.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:labelTop];
    
    self.imageView_url = [[UIImageView alloc]init];
    [self.contentView addSubview:_imageView_url];
    [_imageView_url mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@10);
        make.width.height.equalTo(@100);
    }];
    
    self.name = [[UILabel alloc]init];
    _name.textAlignment = NSTextAlignmentCenter;
    _name.font = [UIFont systemFontOfSize:13.0];
    _name.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:_name];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_imageView_url);
        make.left.equalTo(_imageView_url.mas_right).offset(10);
        make.width.equalTo(@200);
        make.height.equalTo(@25);
    }];
    
}
#pragma mark -- 数据复制
-(void)setModel:(LZWModel *)model
{
    _model = model;
    NSString *goodName = [NSString stringWithFormat:@"%@", _model.goods_main_title];
    NSString *imageUrl = [NSString stringWithFormat:@"%@", _model.goods_logo];
    _name.text = goodName;
    [_imageView_url sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
