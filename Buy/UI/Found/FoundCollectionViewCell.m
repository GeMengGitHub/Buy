//
//  FoundCollectionViewCell.m
//  Buy
//
//  Created by qf on 15/10/16.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "FoundCollectionViewCell.h"

@interface FoundCollectionViewCell()
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation FoundCollectionViewCell

-(void)setCellWithModel:(FoundSubListModel *)model{
    [self setCellView];
    
    //给控件赋值
    [_headerImageView setImageWithURL:[NSURL URLWithString:model.logo]];
    [_nameLabel setText:model.name];
}

-(void)setCellView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc]init];
        _headerImageView.frame = CGRectMake(10, 0, 70, 70);
//        _headerImageView.backgroundColor = [UIColor greenColor];
        _headerImageView.layer.masksToBounds = YES;
        _headerImageView.layer.cornerRadius = 35;
        _headerImageView.layer.borderWidth = 0.5f;
        _headerImageView.layer.borderColor = [COLOR(230, 230, 230, 1)CGColor];
        _headerImageView.clipsToBounds = YES;
        [self addSubview:_headerImageView];
    }
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.frame = CGRectMake(0, 72, 90, 18);
//        _nameLabel.backgroundColor = [UIColor orangeColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor grayColor];
        [self addSubview:_nameLabel];
    }
    
}

@end
