//
//  MeTableViewCell.m
//  Buy
//
//  Created by qf on 15/10/16.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "MeTableViewCell.h"

@interface MeTableViewCell ()
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *nameLabel;
//@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UILabel *rightLabel;
//@property (nonatomic, strong) UIView *bottomLineView;
//@property (nonatomic, strong) UIView *topLineView;

@end

@implementation MeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setView];
    }
    return self;
}


-(void)setCellWithDic:(NSDictionary *)dic withIndex:(NSInteger)index{
    [_headerImageView setImage:[UIImage imageNamed:dic[@"image"]]];
    [_nameLabel setText:dic[@"name"]];
    if (index == 4) {
        _rightLabel.text = [NSString stringWithFormat:@"%.2fMB", [CacheManager getCacheSize]];
        _rightLabel.hidden = NO;
    }
    if (index == 5) {
        NSString *str = [NSString stringWithFormat:@"v %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        _rightLabel.text = str;
        _rightLabel.hidden = NO;
    }
    if (index >= 4) {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

//设置UI
-(void)setView{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    _headerImageView = [[UIImageView alloc]init];
    _headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_headerImageView];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_nameLabel];
    
//    _rightImageView = [[UIImageView alloc]init];
//    [_rightImageView setImage:[UIImage imageNamed:@"icon_cell_arraw.png"]];
//    _rightImageView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self addSubview:_rightImageView];
    
//    _bottomLineView = [[UIView alloc]init];
//    _bottomLineView.backgroundColor = COLOR(220, 220, 220, 1);
//    _bottomLineView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self addSubview:_bottomLineView];
    
    
//    _topLineView = [[UILabel alloc]init];
//    _topLineView.backgroundColor = COLOR(220, 220, 220, 1);
//    _topLineView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self addSubview:_topLineView];
    
    _rightLabel = [[UILabel alloc]init];
    _rightLabel.hidden = YES;
    _rightLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _rightLabel.textColor = [UIColor grayColor];
    _rightLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_rightLabel];
    
    //左边小图标
    NSArray *layout = nil;
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_headerImageView(24)]" options:0 metrics:nil views:@{@"_headerImageView":_headerImageView}];
    [self addConstraints:layout];
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_headerImageView(24)]" options:0 metrics:nil views:@{@"_headerImageView":_headerImageView}];
    [self addConstraints:layout];
    
    //标题
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_headerImageView]-10-[_nameLabel(<=200)]" options:0 metrics:nil views:@{@"_nameLabel":_nameLabel,@"_headerImageView":_headerImageView}];
    [self addConstraints:layout];
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-11-[_nameLabel(20)]" options:0 metrics:nil views:@{@"_nameLabel":_nameLabel}];
    [self addConstraints:layout];
    
    //右边箭头
//    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_rightImageView(11)]-10-|" options:0 metrics:nil views:@{@"_rightImageView":_rightImageView}];
//    [self addConstraints:layout];
//    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-9-[_rightImageView(20)]" options:0 metrics:nil views:@{@"_rightImageView":_rightImageView}];
//    [self addConstraints:layout];
    
    //底部横线
//    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_bottomLineView]-0-|" options:0 metrics:nil views:@{@"_bottomLineView":_bottomLineView}];
//    [self addConstraints:layout];
//    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomLineView(1)]-0-|" options:0 metrics:nil views:@{@"_bottomLineView":_bottomLineView}];
//    [self addConstraints:layout];
    
    //顶部线条
//    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_topLineView]-0-|" options:0 metrics:nil views:@{@"_topLineView":_topLineView}];
//    [self addConstraints:layout];
//    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_topLineView(1)]" options:0 metrics:nil views:@{@"_topLineView":_topLineView}];
//    [self addConstraints:layout];
    
    //右边内容栏
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_rightLabel(>=0)]-20-|" options:0 metrics:nil views:@{@"_rightLabel":_rightLabel}];
    [self addConstraints:layout];
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-14-[_rightLabel(14)]" options:0 metrics:nil views:@{@"_rightLabel":_rightLabel}];
    [self addConstraints:layout];
}
@end
