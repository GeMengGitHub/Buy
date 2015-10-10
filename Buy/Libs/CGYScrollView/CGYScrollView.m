//
//  CGYScrollView.m
//  CGYScrollView
//
//  Created by qf on 8/31/15.
//  Copyright (c) 2015 Chakery. All rights reserved.
//

#import "CGYScrollView.h"

@interface CGYScrollView()<UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *imageArray;//未处理的图片数组
@property (nonatomic, strong) NSMutableArray *processedImageArray;//处理后的图片数组
@property (nonatomic, assign) CGRect mainFrame;//frame
@property (nonatomic, assign) NSInteger time;//时间
@property (nonatomic, strong) UIScrollView *scrollView;//滚动视图
@property (nonatomic, strong) NSTimer *timer;//定时器

@end

@implementation CGYScrollView

- (instancetype)initWithImages:(NSMutableArray *)imageArray withFrame:(CGRect)mainFrame withTime:(NSInteger)time{
    self = [super init];
    if (self) {
        _imageArray = [[NSMutableArray alloc]init];
        _scrollView = [[UIScrollView alloc]init];
        _processedImageArray = [[NSMutableArray alloc]init];
        
        _imageArray = imageArray;
        _mainFrame = mainFrame;
        _time = time;
        
        [self create];
    }
    return self;
}

#pragma mark --- 创建
-(void)create{
    [self setData];
    [self setScrollView];
    [self setcontent];
    [self setTimer];
}

#pragma mark --- 创建ScrollView
-(void)setScrollView{
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    [_scrollView setContentOffset:CGPointMake(_mainFrame.size.width, 0)];
    _scrollView.frame = CGRectMake(_mainFrame.origin.x, _mainFrame.origin.y, _mainFrame.size.width, _mainFrame.size.height - 20);
    [self.view addSubview:_scrollView];
    
}

#pragma mark ---  图片处理
-(void)setData{
    //如果只有一张图片，不用处理
    if (_imageArray.count == 1) {
        _processedImageArray = _imageArray;
    } else if (_imageArray.count > 1) {
        [_processedImageArray addObject:_imageArray[_imageArray.count-1]];
        for (int i = 0; i < _imageArray.count; i ++) {
            [_processedImageArray addObject:_imageArray[i]];
        }
        [_processedImageArray addObject:_imageArray[0]];
    }
}

#pragma mark ---  给滚动视图加上图片
-(void)setcontent{
    [_scrollView setContentSize:CGSizeMake(_mainFrame.size.width * _processedImageArray.count, _mainFrame.size.height - 20)];
    for (int i = 0; i < _processedImageArray.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(_mainFrame.size.width * i, _mainFrame.origin.y, _mainFrame.size.width, _mainFrame.size.height - 20);
        imageView.image = [UIImage imageNamed:_processedImageArray[i]];
        [_scrollView addSubview:imageView];
    }
}

#pragma mark --- 定时滚动
-(void)setTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:_time target:self selector:@selector(scrollChange) userInfo:nil repeats:YES];
}

#pragma mark --- 滚动
-(void)scrollChange{
    //当前x坐标
    float currentX = _scrollView.contentOffset.x + _mainFrame.size.width;
    //滚动都下一页
    [_scrollView scrollRectToVisible:CGRectMake(currentX, 0, _mainFrame.size.width, _mainFrame.size.height) animated:YES];
    
    //滚动到最后一张图片就返回
    if (currentX >= _mainFrame.size.width * (_processedImageArray.count-1)) {
        [_scrollView setContentOffset:CGPointMake(0, 0)];
    }
}

#pragma mark --------------------------------------------------- 计算当前页码
-(int)currentNumber{
    int page = _scrollView.contentOffset.x / _mainFrame.size.width;
    if (page == 0) {
        page = (int)_processedImageArray.count - 2;
    } else if (page == _processedImageArray.count - 1) {
        page = 0;
    } else {
        page --;
    }
    return page;
}

#pragma mark --------------------------------------------------- 协议方法
//将要被拖拽时回调(没放手)
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //在拖拽时，销毁滚动视图的时间timer
    [_timer invalidate];
}
//结束惯性滚动（惯性停止后，执行）
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //回到第一个界面
    if (scrollView.contentOffset.x >= _mainFrame.size.width * (_processedImageArray.count - 1)) {
        [scrollView setContentOffset:CGPointMake(_mainFrame.size.width, 0)];
    }
    
    //回到最后一个界面
    if (scrollView.contentOffset.x <= 0) {
        [scrollView setContentOffset:CGPointMake(_mainFrame.size.width * (_processedImageArray.count - 2), 0)];
    }
    
    //重新启动定时器
    [self setTimer];
}

@end
