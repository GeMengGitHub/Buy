//
//  HeaderCollectionReusableView.m
//  Buy
//
//  Created by qf on 15/10/10.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "HeaderCollectionReusableView.h"

@interface HeaderCollectionReusableView ()
@property (nonatomic, strong) CGYScrollView *scrollView;

@end

@implementation HeaderCollectionReusableView

-(void)setHeaderView{
    self.backgroundColor = [UIColor whiteColor];
    [self setScrollViewWithArray:nil];
}

//设置滚动图片
-(void)setScrollViewWithArray:(NSMutableArray *)array{
    CGRect main = [UIScreen mainScreen].bounds;
    CGRect r = CGRectMake(0, 0, main.size.width, 100);
    _scrollView = [[CGYScrollView alloc]initWithImages:array withFrame:r withTime:4];
    [self addSubview:_scrollView.view];
}

@end
