//
//  MenuDataListTableViewCell.m
//  Buy
//
//  Created by qf on 15/10/19.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "MenuDataListTableViewCell.h"

@interface MenuDataListTableViewCell ()
@property (nonatomic, strong) UIImageView *headImageView;//大图
@property (nonatomic, strong) UILabel *nameLabel;//标题
@property (nonatomic, strong) UILabel *priceLabel;//价格
@property (nonatomic, strong) UILabel *freeLabel;//包邮
@property (nonatomic, strong) UILabel *oldPrice;//原价
@property (nonatomic, strong) UILabel *discountLabel;//折扣
@property (nonatomic, strong) UILabel *fromLabel;//商品来源
@property (nonatomic, strong) UIView *lineView;//横线

@end

@implementation MenuDataListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCellView];
    }
    return self;
}

/**
 *  设置Cell
 *
 *  @param model
 */
-(void)setCellWithModel:(ShareListModel *)model{
    [_headImageView setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"bg_default.png"]];
    _nameLabel.text = model.name;
    _priceLabel.text = [NSString stringWithFormat:@"¥ %@", model.price];
    _oldPrice.text = [NSString stringWithFormat:@"¥ %@", model.original_price];
    if (model.is_free_shipping.intValue > 0) {
        _freeLabel.hidden = NO;
    } else {
        _freeLabel.hidden = YES;
    }
    if (model.original_price.floatValue > 0 && model.price.floatValue > 0) {
        CGFloat oldPrice = model.original_price.floatValue;
        CGFloat newPrice = model.price.floatValue;
        CGFloat discount = (newPrice / oldPrice) * 10;
        _discountLabel.hidden = NO;
        _discountLabel.text = [NSString stringWithFormat:@"%.1f折", discount];
    } else {
        _discountLabel.hidden = YES;
    }
    _fromLabel.text = model.source_title;
}

/**
 *  设置Cell的UI
 */
-(void)setCellView{
    //大图
    _headImageView = [[UIImageView alloc]init];
    _headImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_headImageView];
    
    //标题
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_nameLabel];
    
    //价格
    _priceLabel = [[UILabel alloc]init];
    [_priceLabel sizeToFit];
    _priceLabel.textColor = COLOR(234, 53, 59, 1);
    _priceLabel.font = [UIFont systemFontOfSize:18];
    _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_priceLabel];
    
    //包邮
    _freeLabel = [[UILabel alloc]init];
    _freeLabel.text = @"包邮";
    _freeLabel.textAlignment = NSTextAlignmentCenter;
    _freeLabel.font = [UIFont systemFontOfSize:10.0f];
    _freeLabel.textColor = COLOR(234, 53, 59, 1);
    _freeLabel.layer.borderWidth = 0.2f;
    _freeLabel.layer.cornerRadius = 2.0f;
    _freeLabel.layer.borderColor = [COLOR(234, 53, 59, 1) CGColor];
    _freeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_freeLabel];
    
    //原价
    _oldPrice = [[UILabel alloc]init];
    [_oldPrice sizeToFit];
    _oldPrice.textColor = [UIColor grayColor];
    _oldPrice.textAlignment = NSTextAlignmentCenter;
    _oldPrice.font = [UIFont systemFontOfSize:12];
    _oldPrice.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_oldPrice];
    
    //横线
    if (_lineView) {
        [_lineView removeFromSuperview];
    }
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor grayColor];
    _lineView.translatesAutoresizingMaskIntoConstraints = NO;
    [_oldPrice addSubview:_lineView];
    
    //折扣
    _discountLabel = [[UILabel alloc]init];
    [_discountLabel sizeToFit];
    _discountLabel.textColor = [UIColor grayColor];
    _discountLabel.textAlignment = NSTextAlignmentCenter;
    _discountLabel.font = [UIFont systemFontOfSize:12];
    _discountLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_discountLabel];
    
    //来源
    _fromLabel = [[UILabel alloc]init];
    [_fromLabel sizeToFit];
    _fromLabel.textColor = [UIColor grayColor];
    _fromLabel.textAlignment = NSTextAlignmentCenter;
    _fromLabel.font = [UIFont systemFontOfSize:14];
    _fromLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_fromLabel];
    
    //----------------------------- 设置约束 -------------------------------//
    //大图
    NSArray *layout = nil;
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[_headImageView(100)]" options:0 metrics:nil views:@{@"_headImageView":_headImageView}];
    [self addConstraints:layout];
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_headImageView]-8-|" options:0 metrics:nil views:@{@"_headImageView":_headImageView}];
    [self addConstraints:layout];
    
    //标题
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_headImageView]-4-[_nameLabel]-10-|" options:0 metrics:nil views:@{@"_nameLabel":_nameLabel,@"_headImageView":_headImageView}];
    [self addConstraints:layout];
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_nameLabel(20)]" options:0 metrics:nil views:@{@"_nameLabel":_nameLabel}];
    [self addConstraints:layout];
    
    //价格
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_headImageView]-4-[_priceLabel(>=0)]" options:0 metrics:nil views:@{@"_priceLabel":_priceLabel,@"_headImageView":_headImageView}];
    [self addConstraints:layout];
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_nameLabel]-24-[_priceLabel(20)]" options:0 metrics:nil views:@{@"_priceLabel":_priceLabel,@"_nameLabel":_nameLabel}];
    [self addConstraints:layout];
    
    //包邮
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_priceLabel]-4-[_freeLabel(24)]" options:0 metrics:nil views:@{@"_freeLabel":_freeLabel,@"_priceLabel":_priceLabel}];
    [self addConstraints:layout];
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_nameLabel]-24-[_freeLabel(20)]" options:0 metrics:nil views:@{@"_freeLabel":_freeLabel,@"_nameLabel":_nameLabel}];
    [self addConstraints:layout];
    
    //原价
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_headImageView]-4-[_oldPrice(>=0)]" options:0 metrics:nil views:@{@"_oldPrice":_oldPrice,@"_headImageView":_headImageView}];
    [self addConstraints:layout];
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_freeLabel]-4-[_oldPrice(18)]" options:0 metrics:nil views:@{@"_oldPrice":_oldPrice,@"_freeLabel":_freeLabel}];
    [self addConstraints:layout];
    
    //横线
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_lineView]-0-|" options:0 metrics:nil views:@{@"_lineView":_lineView}];
    [_oldPrice addConstraints:layout];
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_lineView(1)]" options:0 metrics:nil views:@{@"_lineView":_lineView}];
    [_oldPrice addConstraints:layout];
    
    //折扣
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_oldPrice]-10-[_discountLabel(>=0)]" options:0 metrics:nil views:@{@"_discountLabel":_discountLabel,@"_oldPrice":_oldPrice}];
    [self addConstraints:layout];
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_freeLabel]-4-[_discountLabel(18)]" options:0 metrics:nil views:@{@"_discountLabel":_discountLabel,@"_freeLabel":_freeLabel}];
    [self addConstraints:layout];
    
    //来源
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_fromLabel(>=0)]-10-|" options:0 metrics:nil views:@{@"_fromLabel":_fromLabel}];
    [self addConstraints:layout];
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_freeLabel]-4-[_fromLabel(18)]" options:0 metrics:nil views:@{@"_fromLabel":_fromLabel,@"_freeLabel":_freeLabel}];
    [self addConstraints:layout];
}
@end
