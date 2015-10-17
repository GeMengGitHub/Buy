//
//  CategoryCollectionViewCell.m
//  Buy
//
//  Created by qf on 15/10/13.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "CategoryCollectionViewCell.h"

@interface CategoryCollectionViewCell()
@property (nonatomic, strong) UIImageView *bgimageView;//大图
@property (nonatomic, strong) UIView *bgView;//遮罩
@property (nonatomic, strong) UILabel *nameLabel;//名字

@end



@implementation CategoryCollectionViewCell

-(void)setCategoryCellWithModel:(CategorySubModel *)model{
    [self setView];
    [_bgimageView setImageWithURL:[NSURL URLWithString:model.logo]];
    _nameLabel.text = model.name;
}

-(void)setView{
    self.layer.cornerRadius = 50;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    
    if (!_bgimageView) {
        _bgimageView = [[UIImageView alloc]init];
        _bgimageView.userInteractionEnabled = YES;
        _bgimageView.layer.cornerRadius = 50;
        _bgimageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_bgimageView];
        
        NSArray *layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_bgimageView]-0-|" options:0 metrics:nil views:@{@"_bgimageView":_bgimageView}];
        [self addConstraints:layout];
        layout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_bgimageView]-0-|" options:0 metrics:nil views:@{@"_bgimageView":_bgimageView}];
        [self addConstraints:layout];
        
    }
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.userInteractionEnabled = YES;
        _bgView.translatesAutoresizingMaskIntoConstraints = NO;
        _bgView.backgroundColor = COLOR(0, 0, 0, 0.4);
        [_bgimageView addSubview:_bgView];
        
        NSArray *layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_bgView]-0-|" options:0 metrics:nil views:@{@"_bgView":_bgView}];
        [_bgimageView addConstraints:layout];
        layout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_bgView]-0-|" options:0 metrics:nil views:@{@"_bgView":_bgView}];
        [_bgimageView addConstraints:layout];
        
        //单点手势
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTouch)];
//        [_bgView addGestureRecognizer:tap];
    }
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.userInteractionEnabled = YES;
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:16.0f];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_bgView addSubview:_nameLabel];
        
        NSLayoutConstraint *layout = nil;
        layout = [NSLayoutConstraint constraintWithItem:_nameLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_bgView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
        [_bgView addConstraint:layout];
        layout = [NSLayoutConstraint constraintWithItem:_nameLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_bgView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f];
        [_bgView addConstraint:layout];
        layout = [NSLayoutConstraint constraintWithItem:_nameLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_bgView attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f];
        [_bgView addConstraint:layout];
        layout = [NSLayoutConstraint constraintWithItem:_nameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil  attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:18.0f];
        [_bgView addConstraint:layout];
        
        //单点手势
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTouch)];
//        [_nameLabel addGestureRecognizer:tap];
    }
}

//单点事件
-(void)tapTouch{
    [self setAnimation];
}

//设置动画
-(void)setAnimation{
    _bgimageView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    [UIView animateWithDuration:0.2
                     animations:^{
                         _bgimageView.alpha=1;
                         _bgView.alpha=0.3;
                     }];
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _bgimageView.transform = CGAffineTransformMakeScale(1,1);
                         _bgimageView.alpha=0.5;
                         _bgView.alpha=0.5;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.2 animations:^{
                             _bgimageView.alpha=1;
                             _bgView.alpha=1;
                         }];
                     }];
}

@end
