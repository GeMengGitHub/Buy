//
//  HeaderCollectionReusableView.m
//  Buy
//
//  Created by qf on 15/10/10.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "HeaderCollectionReusableView.h"
#import "BannerListModel.h"

@interface HeaderCollectionReusableView ()
@property (nonatomic, strong) CGYScrollView *scrollView;
@property (nonatomic, strong) NSArray  *menuArray;

@end

@implementation HeaderCollectionReusableView

//设置滚动图片
-(void)setScrollViewWithArray:(NSArray *)array{
    //设置HeaderView背景色
    self.backgroundColor = [UIColor whiteColor];
//    CGRect mianR = self.frame;
//    mianR.size.height = 320;
//    self.frame = mianR;
    
    //获取图片数组
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    for (BannerListModel *model in array) {
        [imageArray addObject:model.logo2];
    }
    CGRect main = [UIScreen mainScreen].bounds;
    CGRect r = CGRectMake(0.0f, 0.0f, main.size.width, 140.0f);
    _scrollView = [[CGYScrollView alloc]initWithImages:imageArray withFrame:r withTime:4];
    [self addSubview:_scrollView.view];
}

//设置菜单按钮
-(void)setMenuWithArray:(NSArray *)array{
    _menuArray = array;
    CGRect main = [UIScreen mainScreen].bounds;
    CGFloat f = (main.size.width - (44 * 4)) / 5;
    
    for (int i = 0; i < array.count; i ++) {
        CategoryListModel *model = (CategoryListModel *)array[i];
        //按钮
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(f + (f + 44) * (i % 4), 130 + 80 * (i / 4), 44, 44);
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 22;
        [button setImageWithURL:[NSURL URLWithString:model.logo]];
        button.tag = 1000 + i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        //标题
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(button.frame.origin.x - (f / 2), button.frame.origin.y + button.frame.size.height + 4, button.frame.size.width + f, 18);
        label.textAlignment = NSTextAlignmentCenter;
        if ([model.name isEqualToString:@"禾禾有礼"]) {
            label.text = @"每日精选";
        } else {
            label.text = model.name;
        }
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textColor = [UIColor grayColor];
        
        [self addSubview:label];
        [self addSubview:button];
    }
}

//设置内容提示栏
-(void)setCellHeader{
    CGRect r = [UIScreen mainScreen].bounds;
    UIView *cellHeaderview = [[UIView alloc]init];
    cellHeaderview.frame = CGRectMake(0.0f, 290.0f, r.size.width, 30.0f);
    cellHeaderview.backgroundColor = COLOR(240, 240, 240, 1);
    [self addSubview:cellHeaderview];
    
    UIImage *image = [[UIImage imageNamed:@"icon_time.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIButton *button = [[UIButton alloc]init];
    button.frame = CGRectMake(4.0f, 6.0f, 100.0f, 18.0f);
    [button setImage:image forState:UIControlStateNormal];
    //[button setTitle:[NSString stringWithFormat:@"%@更新",[self nowTime]] forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"每日推荐"] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, -4.0f)];
    [button setTitleColor:COLOR(65, 181, 55, 1) forState:UIControlStateNormal];
    [cellHeaderview addSubview:button];
}

//获取当前时间
-(NSString *)nowTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:ss"];
    return [formatter stringFromDate:date];
}

//按钮点击事件
-(void)buttonClick:(UIButton *)button{
    [_delegate didSelectedMenu:_menuArray[button.tag % 1000] index:button.tag % 1000];
}

@end
