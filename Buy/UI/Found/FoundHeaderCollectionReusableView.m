//
//  FoundHeaderCollectionReusableView.m
//  Buy
//
//  Created by qf on 15/10/16.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "FoundHeaderCollectionReusableView.h"

@interface FoundHeaderCollectionReusableView ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation FoundHeaderCollectionReusableView

-(void)setTitleWith:(NSString *)str{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.frame = CGRectMake(10, 16, self.frame.size.width - 10, 20);
        [self addSubview:_titleLabel];
    }
    _titleLabel.text = str;
}

@end
