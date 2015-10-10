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

@end

@implementation HeaderCollectionReusableView

-(void)setHeaderView{
    self.backgroundColor = [UIColor whiteColor];
}

//设置滚动图片
-(void)setScrollViewWithArray:(NSArray *)array{
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    for (BannerListModel *model in array) {
        [imageArray addObject:model.logo2];
    }
    CGRect main = [UIScreen mainScreen].bounds;
    CGRect r = CGRectMake(0, 0, main.size.width, 150);
    _scrollView = [[CGYScrollView alloc]initWithImages:imageArray withFrame:r withTime:4];
    [self addSubview:_scrollView.view];
}

@end
