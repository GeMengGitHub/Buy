//
//  CGYScrollView.h
//  CGYScrollView
//
//  Created by qf on 8/31/15.
//  Copyright (c) 2015 Chakery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGYScrollView : UIViewController
/**
 *  滚动视图
 *
 *  @param imageArray 需要滚动的图片数组（图片名）
 *  @param mainFrame  当前view的CGRect
 *  @param time       定时滚动的时间
 */
- (instancetype)initWithImages:(NSMutableArray *)imageArray withFrame:(CGRect)mainFrame withTime:(NSInteger)time;

@end
