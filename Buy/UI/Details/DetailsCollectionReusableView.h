//
//  DetailsCollectionReusableView.h
//  Buy
//
//  Created by qf on 15/10/12.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareListModel.h"

@protocol DetailsCollectionReusableViewDelegate <NSObject>
//按钮点击事件
-(void)DetailsCollectionReusableViewDidselectedButton:(UIButton *)button;
//高度
-(void)collectionHeaderViewheight:(CGFloat)height;
@end


@interface DetailsCollectionReusableView : UICollectionReusableView
@property (nonatomic, assign) id<DetailsCollectionReusableViewDelegate> delegate;

-(void)setHeaderWithModel:(ShareListModel *)model;

@end
