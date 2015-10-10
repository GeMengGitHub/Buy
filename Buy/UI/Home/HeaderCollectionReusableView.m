//
//  HeaderCollectionReusableView.m
//  Buy
//
//  Created by qf on 15/10/10.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "HeaderCollectionReusableView.h"
#import "BannerListModel.h"
#import "CategoryListModel.h"

@interface HeaderCollectionReusableView ()
@property (nonatomic, strong) CGYScrollView *scrollView;

@end

@implementation HeaderCollectionReusableView

//设置滚动图片
-(void)setScrollViewWithArray:(NSArray *)array{
    //设置HeaderView背景色
    self.backgroundColor = [UIColor whiteColor];
    
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
        label.text = model.name;
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textColor = [UIColor grayColor];
        
        [self addSubview:label];
        [self addSubview:button];
    }
}

//设置内容提示栏
-(void)setCellHeader{
    CGRect r = [UIScreen mainScreen].bounds;
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0.0f, 290.0f, r.size.width, 30.0f);
    view.backgroundColor = COLOR(240, 240, 240, 1);
    [self addSubview:view];
    
    UIImage *image = [[UIImage imageNamed:@"icon_time.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIButton *button = [[UIButton alloc]init];
    button.frame = CGRectMake(0.0f, 4.0f, 80.0f, 18.0f);
    [button setImage:image forState:UIControlStateNormal];
    [view addSubview:button];
}

//按钮点击事件
-(void)buttonClick:(UIButton *)button{
    [_delegate didSelectedMenu:button.tag % 1000];
}

@end
