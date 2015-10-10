//
//  HeaderCollectionReusableView.h
//  Buy
//
//  Created by qf on 15/10/10.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderCollectionReusableView : UICollectionReusableView

-(void)setHeaderView;

//设置滚动图片
-(void)setScrollViewWithArray:(NSArray *)array;

@end
