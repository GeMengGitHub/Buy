//
//  HomeCollectionViewCell.m
//  Buy
//
//  Created by qf on 15/10/11.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "CategotyListCollectionViewCell.h"

@interface CategotyListCollectionViewCell ()
@property (nonatomic, strong) UIImageView *headerImageView;//图片
@property (nonatomic, strong) UILabel *titleLabel;//标题
@property (nonatomic, strong) UILabel *priceLabel;//价格
@property (nonatomic, strong) UIButton *likeButton;//点赞
@property (nonatomic, strong) UILabel *freeLabel;//包邮
@property (nonatomic, strong) UIImageView *hotImageView;//火热产品
@property (nonatomic, strong) UILabel *discountLabel;//打折
@end



@implementation CategotyListCollectionViewCell

-(void)setCellWithModel:(ShareListModel *)model{
    [self setView];
    [_headerImageView setImageWithURL:[NSURL URLWithString:model.icon]];
    _titleLabel.text = model.name;
    _priceLabel.text = [NSString stringWithFormat:@"¥ %@", model.price];
    [_likeButton setTitle:model.like forState:UIControlStateNormal];
    //是否包邮
    if (model.is_free_shipping.intValue > 0) {
        _freeLabel.hidden = NO;
    } else {
        _freeLabel.hidden = YES;
    }
    //是否是推荐产品
    if (model.low.intValue > 0) {
        _hotImageView.hidden = NO;
        
        CGFloat oldPrice = model.original_price.floatValue;
        CGFloat newPrice = model.price.floatValue;
        CGFloat discount = (newPrice / oldPrice) * 10;
        _discountLabel.text = [NSString stringWithFormat:@"%.1f折", discount];
    } else {
        _hotImageView.hidden = YES;
    }
}

-(void)setView{
//    self.layer.cornerRadius = 8;
//    self.clipsToBounds = YES;
    self.layer.borderWidth = 0.5f;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [COLOR(220, 220, 220, 1) CGColor];
    
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc]init];
    }
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
    }
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
    }
    if (!_likeButton) {
        _likeButton = [[UIButton alloc]init];
    }
    if (!_freeLabel) {
        _freeLabel = [[UILabel alloc]init];
    }
    if (!_hotImageView) {
        _hotImageView = [[UIImageView alloc]init];
    }
    if (!_discountLabel) {
        _discountLabel = [[UILabel alloc]init];
    }
    
    _headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _likeButton.translatesAutoresizingMaskIntoConstraints = NO;
    _freeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    _titleLabel.font = [UIFont systemFontOfSize:12];
    
    [_priceLabel sizeToFit];
    _priceLabel.textColor = COLOR(234, 53, 59, 1);
    _priceLabel.font = [UIFont systemFontOfSize:16.0f];
    
    _likeButton.hidden = YES;
    _likeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_likeButton addTarget:self action:@selector(likeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_likeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_likeButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, -10.0f)];
    [_likeButton setImage:[UIImage imageNamed:@"icon_prise.png"] forState:UIControlStateNormal];
    
    _freeLabel.hidden = YES;
    _freeLabel.text = @"包邮";
    _freeLabel.textAlignment = NSTextAlignmentCenter;
    _freeLabel.font = [UIFont systemFontOfSize:10.0f];
    _freeLabel.textColor = COLOR(234, 53, 59, 1);
    _freeLabel.layer.borderWidth = 0.2f;
    _freeLabel.layer.cornerRadius = 2.0f;
    _freeLabel.layer.borderColor = [COLOR(234, 53, 59, 1) CGColor];
    
    _hotImageView.hidden = NO;
    _hotImageView.frame = CGRectMake(10, 0, 30, 34);
    _hotImageView.image = [UIImage imageNamed:@"icon_god.png"];
    
    _discountLabel.hidden = _hotImageView.hidden;
    _discountLabel.frame = CGRectMake(2, 15, 26, 18);
    _discountLabel.textAlignment = NSTextAlignmentCenter;
    _discountLabel.font = [UIFont systemFontOfSize:8];
    _discountLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:_headerImageView];
    [self addSubview:_titleLabel];
    [self addSubview:_priceLabel];
    [self addSubview:_likeButton];
    [self addSubview:_freeLabel];
    [_headerImageView addSubview:_hotImageView];
    [_hotImageView addSubview:_discountLabel];
    
    //headerImageView约束
    NSArray *layoutArray1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_headerImageView]-0-|" options:0 metrics:nil views:@{@"_headerImageView":_headerImageView}];
    [self addConstraints:layoutArray1];
    NSArray *layoutArray2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_headerImageView(150)]" options:0 metrics:nil views:@{@"_headerImageView":_headerImageView}];
    [self addConstraints:layoutArray2];
    
    //titleLabel约束
    NSArray *titleArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-4-[_titleLabel]-4-|" options:0 metrics:nil views:@{@"_titleLabel":_titleLabel}];
    [self addConstraints:titleArray];
    titleArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-154-[_titleLabel(18)]" options:0 metrics:nil views:@{@"_titleLabel":_titleLabel}];
    [self addConstraints:titleArray];
    
    //价格约束
    NSArray *priceArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-4-[_priceLabel(>=10)]" options:0 metrics:nil views:@{@"_priceLabel":_priceLabel}];
    [self addConstraints:priceArray];
    priceArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-176-[_priceLabel(20)]" options:0 metrics:nil views:@{@"_priceLabel":_priceLabel}];
    [self addConstraints:priceArray];
    
    //包邮约束
    NSArray *freeArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_priceLabel]-4-[_freeLabel(24)]" options:0 metrics:nil views:@{@"_freeLabel":_freeLabel,@"_priceLabel":_priceLabel}];
    [self addConstraints:freeArray];
    freeArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-176-[_freeLabel(16)]" options:0 metrics:nil views:@{@"_freeLabel":_freeLabel}];
    [self addConstraints:freeArray];
    
    //点赞约束
    NSArray *likeArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_likeButton(56)]-4-|" options:0 metrics:nil views:@{@"_likeButton":_likeButton}];
    [self addConstraints:likeArray];
    likeArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-176-[_likeButton(20)]" options:0 metrics:nil views:@{@"_likeButton":_likeButton}];
    [self addConstraints:likeArray];
}

//点赞点击事件
-(void)likeButtonClick:(UIButton *)button {
    NSLog(@"点赞");
}

@end
