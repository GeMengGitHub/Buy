//
//  HeaderCollectionReusableView.h
//  Buy
//
//  Created by qf on 15/10/10.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderCollectionReusableViewDelegate <NSObject>
//scrollView点击
-(void)didSelectedScrollView:(NSInteger)index;
//菜单点击
-(void)didSelectedMenu:(NSInteger)index;
@end



@interface HeaderCollectionReusableView : UICollectionReusableView
@property (nonatomic, strong) id<HeaderCollectionReusableViewDelegate> delegate;

//设置滚动图片
-(void)setScrollViewWithArray:(NSArray *)array;

//设置菜单按钮
-(void)setMenuWithArray:(NSArray *)array;

//设置 Cell Header
-(void)setCellHeader;

@end
