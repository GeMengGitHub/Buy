//
//  DetailsCollectionReusableView.m
//  Buy
//
//  Created by qf on 15/10/12.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "DetailsCollectionReusableView.h"

@interface DetailsCollectionReusableView ()
@property (nonatomic, strong) UIImageView *headerImageView;//大图
@property (nonatomic, strong) UILabel *titleLabel;//标题
@property (nonatomic, strong) UIButton *baikeButton;//百度百科
@property (nonatomic, strong) UILabel *priceLabel;//现价
@property (nonatomic, strong) UILabel *oldPriceLabel;//原价
@property (nonatomic, strong) UILabel *discountLabel;//打折
@property (nonatomic, strong) UILabel *freeShippingLabel;//包邮
@property (nonatomic, strong) UILabel *contentTextView;//简介
@property (nonatomic, strong) UILabel *lineLabel;//横线

@property (nonatomic, strong) UIView *bgview;//猜你喜欢
@property (nonatomic, strong) UILabel *liekNameLable;//猜你喜欢
@property (nonatomic, strong) UILabel *leftLineLabel;//左边横线
@property (nonatomic, strong) UILabel *rightLineLabel;//左边横线

@end

@implementation DetailsCollectionReusableView

-(void)setHeaderWithModel:(ShareListModel *)model{
    if (!_lineLabel) {
        [self setView];
        
        //设置文本简介
        static TQRichTextView *text = nil;
        if (!text) {
            text = [[TQRichTextView alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 10)];
            text.font = [UIFont systemFontOfSize:14];
        }
        text.text = model.best_desc;
        CGRect r = self.frame;
        r.size.height = r.size.height + text.drawheigth;
        self.frame = r;
        NSArray *layoutArray = [self constraints];
        for (NSLayoutConstraint *con in layoutArray) {
            if ([con.firstItem isEqual:_contentTextView]) {
                if (con.firstAttribute == NSLayoutAttributeHeight) {
                    con.constant = text.drawheigth;
                }
            }
        }
        [_delegate collectionHeaderViewheight:text.drawheigth];
        _contentTextView.text = model.best_desc;
    }
    
    [_headerImageView setImageWithURL:[NSURL URLWithString:model.detail_logo]];
    _titleLabel.text = model.name;
    _priceLabel.text = [NSString stringWithFormat:@"¥ %@", model.price];
    _oldPriceLabel.text = [NSString stringWithFormat:@"¥ %@", model.original_price];
    
    if (model.original_price.floatValue > 0 && model.price.floatValue > 0) {
        CGFloat oldPrice = model.original_price.floatValue;
        CGFloat newPrice = model.price.floatValue;
        CGFloat discount = (newPrice / oldPrice) * 10;
        _discountLabel.hidden = NO;
        _discountLabel.text = [NSString stringWithFormat:@"%.1f折", discount];
    } else {
        _discountLabel.hidden = YES;
    }
    if (model.is_free_shipping.intValue > 0) {
        _freeShippingLabel.hidden = NO;
    } else {
        _freeShippingLabel.hidden = YES;
    }
    
    //才你喜欢
    [self setPerhapsLikeView];
}

-(void)setView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc]init];
    }
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
    }
    if (!_baikeButton) {
        _baikeButton = [[UIButton alloc]init];
    }
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
    }
    if (!_oldPriceLabel) {
        _oldPriceLabel = [[UILabel alloc]init];
    }
    if (!_discountLabel) {
        _discountLabel = [[UILabel alloc]init];
    }
    if (!_freeShippingLabel) {
        _freeShippingLabel = [[UILabel alloc]init];
    }
    if (!_contentTextView) {
        _contentTextView = [[UILabel alloc]init];
    }
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
    }

    _headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _baikeButton.translatesAutoresizingMaskIntoConstraints = NO;
    _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _oldPriceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _discountLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _freeShippingLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _contentTextView.translatesAutoresizingMaskIntoConstraints = NO;
    _lineLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:_headerImageView];
    [self addSubview:_titleLabel];
    [self addSubview:_baikeButton];
    [self addSubview:_priceLabel];
    [self addSubview:_oldPriceLabel];
    [_oldPriceLabel addSubview:_lineLabel];
    [self addSubview:_discountLabel];
    [self addSubview:_freeShippingLabel];
    [self addSubview:_contentTextView];
    
    //------------------------------------ 属性 --------------------------------------------
    
    //大图
    _headerImageView.userInteractionEnabled = YES;
    
    //标题
    [_titleLabel sizeToFit];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    
    //百科
    [_baikeButton addTarget:self action:@selector(baikeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_baikeButton setImage:[UIImage imageNamed:@"icon_eye.png"] forState:UIControlStateNormal];
    
    //价格
    [_priceLabel sizeToFit];
    _priceLabel.textColor = COLOR(234, 53, 59, 1);
    _priceLabel.font = [UIFont systemFontOfSize:18];
    
    //原价
    [_oldPriceLabel sizeToFit];
    _oldPriceLabel.textColor = [UIColor grayColor];
    _oldPriceLabel.textAlignment = NSTextAlignmentCenter;
    _oldPriceLabel.font = [UIFont systemFontOfSize:12];
    
    //横线
    _lineLabel.backgroundColor = COLOR(200, 200, 200, 1);
    
    //打折
    [_discountLabel sizeToFit];
    _discountLabel.backgroundColor = COLOR(234, 53, 59, 1);
    _discountLabel.textColor = [UIColor whiteColor];
    _discountLabel.layer.masksToBounds = YES;
    _discountLabel.layer.cornerRadius = 2;
    _discountLabel.font = [UIFont systemFontOfSize:12];
    
    //包邮
    _freeShippingLabel.hidden = YES;
    _freeShippingLabel.text = @"包邮";
    _freeShippingLabel.textAlignment = NSTextAlignmentCenter;
    _freeShippingLabel.textColor = COLOR(234, 53, 59, 1);
    _freeShippingLabel.font = [UIFont systemFontOfSize:12.0f];
    _freeShippingLabel.layer.cornerRadius = 2;
    _freeShippingLabel.layer.borderWidth = 0.5f;
    _freeShippingLabel.layer.borderColor = [COLOR(234, 53, 59, 1)CGColor];
    
    //简介
    [_contentTextView sizeToFit];
    _contentTextView.numberOfLines = 0;
    _contentTextView.font = [UIFont systemFontOfSize:14];
    
    //------------------------------------ 约束 --------------------------------------------
    NSArray *layoutArray = nil;
    
    // _headerImageView 大图约束
    layoutArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_headerImageView]-0-|" options:0 metrics:nil views:@{@"_headerImageView":_headerImageView}];
    [self addConstraints:layoutArray];
    layoutArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_headerImageView(350)]" options:0 metrics:nil views:@{@"_headerImageView":_headerImageView}];
    [self addConstraints:layoutArray];
    
    // _titleLabel 标题约束
    layoutArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_titleLabel(>=0)]" options:0 metrics:nil views:@{@"_titleLabel":_titleLabel}];
    [self addConstraints:layoutArray];
    layoutArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_headerImageView]-10-[_titleLabel(22)]" options:0 metrics:nil views:@{@"_headerImageView":_headerImageView, @"_titleLabel":_titleLabel}];
    [self addConstraints:layoutArray];
    
    // _baikeButton 百科约束
    layoutArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_baikeButton(26)]-10-|" options:0 metrics:nil views:@{@"_baikeButton":_baikeButton}];
    [self addConstraints:layoutArray];
    layoutArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_headerImageView]-10-[_baikeButton(==_titleLabel)]" options:0 metrics:nil views:@{@"_baikeButton":_baikeButton, @"_titleLabel":_titleLabel,@"_headerImageView":_headerImageView}];
    [self addConstraints:layoutArray];
    
    // _priceLabel 价格约束
    layoutArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_priceLabel(>=0)]" options:0 metrics:nil views:@{@"_priceLabel":_priceLabel}];
    [self addConstraints:layoutArray];
    layoutArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_titleLabel]-10-[_priceLabel(22)]" options:0 metrics:nil views:@{@"_priceLabel":_priceLabel, @"_titleLabel":_titleLabel}];
    [self addConstraints:layoutArray];
    
    // _oldPriceLabel 原价约束
    layoutArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_priceLabel]-6-[_oldPriceLabel(>=0)]" options:0 metrics:nil views:@{@"_oldPriceLabel":_oldPriceLabel, @"_priceLabel":_priceLabel}];
    [self addConstraints:layoutArray];
    layoutArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_titleLabel]-12-[_oldPriceLabel(==_priceLabel)]" options:0 metrics:nil views:@{@"_oldPriceLabel":_oldPriceLabel, @"_priceLabel":_priceLabel, @"_titleLabel":_titleLabel}];
    [self addConstraints:layoutArray];
    
    // _lineLabel 横线约束
    layoutArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_lineLabel]-0-|" options:0 metrics:nil views:@{@"_lineLabel":_lineLabel}];
    [self addConstraints:layoutArray];
    layoutArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[_lineLabel(1)]" options:0 metrics:nil views:@{@"_lineLabel":_lineLabel}];
    [self addConstraints:layoutArray];
    
    // _freeShippingLabel 打折约束
    layoutArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_oldPriceLabel]-6-[_discountLabel(>=28)]" options:0 metrics:nil views:@{@"_oldPriceLabel":_oldPriceLabel, @"_discountLabel":_discountLabel}];
    [self addConstraints:layoutArray];
    layoutArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_titleLabel]-12-[_discountLabel(16)]" options:0 metrics:nil views:@{@"_discountLabel":_discountLabel,@"_titleLabel":_titleLabel}];
    [self addConstraints:layoutArray];
    
    // _freeShippingLabel 包邮约束
    layoutArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_discountLabel]-6-[_freeShippingLabel(28)]" options:0 metrics:nil views:@{@"_freeShippingLabel":_freeShippingLabel, @"_discountLabel":_discountLabel}];
    [self addConstraints:layoutArray];
    layoutArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_titleLabel]-12-[_freeShippingLabel(16)]" options:0 metrics:nil views:@{@"_freeShippingLabel":_freeShippingLabel, @"_titleLabel":_titleLabel}];
    [self addConstraints:layoutArray];
    
    // _contentTextView 简介约束
    layoutArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_contentTextView]-8-|" options:0 metrics:nil views:@{@"_contentTextView":_contentTextView}];
    [self addConstraints:layoutArray];
    layoutArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_priceLabel]-10-[_contentTextView(10)]" options:0 metrics:nil views:@{@"_contentTextView":_contentTextView, @"_priceLabel":_priceLabel}];
    [self addConstraints:layoutArray];
}

//百科按钮点击事件
-(void)baikeButtonClick:(UIButton *)button{
    [_delegate DetailsCollectionReusableViewDidselectedButton:button];
}

//猜你喜欢
-(void)setPerhapsLikeView{
    if (!_bgview) {
        _bgview = [[UIView alloc]init];
    }
    _bgview.translatesAutoresizingMaskIntoConstraints = NO;
    _bgview.backgroundColor = COLOR(240, 240, 240, 1);
    [self addSubview:_bgview];
    
    NSArray *layout = nil;
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_bgview]-0-|" options:0 metrics:nil views:@{@"_bgview":_bgview}];
    [self addConstraints:layout];
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bgview(40)]-0-|" options:0 metrics:nil views:@{@"_bgview":_bgview}];
    [self addConstraints:layout];
    
    //名字
    if (!_liekNameLable) {
        _liekNameLable = [[UILabel alloc]init];
    }
    _liekNameLable.translatesAutoresizingMaskIntoConstraints = NO;
    _liekNameLable.textAlignment = NSTextAlignmentCenter;
    _liekNameLable.font = [UIFont systemFontOfSize:16];
    _liekNameLable.textColor = [UIColor grayColor];
    _liekNameLable.text = @"猜猜你喜欢";
    [_bgview addSubview:_liekNameLable];
    
    NSLayoutConstraint *la = [NSLayoutConstraint constraintWithItem:_liekNameLable attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_bgview attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
    [_bgview addConstraint:la];
    la = [NSLayoutConstraint constraintWithItem:_liekNameLable attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100.0f];
    [_bgview addConstraint:la];
    la = [NSLayoutConstraint constraintWithItem:_liekNameLable attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_bgview attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f];
    [_bgview addConstraint:la];
    la = [NSLayoutConstraint constraintWithItem:_liekNameLable attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:18.0f];
    [_bgview addConstraint:la];
    
    
    
    
    
    
    
    
    
    
    
    
}

@end
