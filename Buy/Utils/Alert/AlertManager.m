//
//  AlertManager.m
//  Buy
//
//  Created by qf on 15/10/17.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "AlertManager.h"

@interface AlertManager ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
@property (nonatomic, strong) UILabel *label;
@end

@implementation AlertManager

+(AlertManager *)defaultAlert{
    static AlertManager *manager = nil;
    if (!manager) {
        manager = [[AlertManager alloc]init];
        [manager setView];
    }
    return manager;
}

-(void)setView{
    AlertManager *manager = [AlertManager defaultAlert];
    //遮罩层
    manager.bgView = [[UIView alloc]init];
    manager.bgView.frame = [UIScreen mainScreen].bounds;
    manager.bgView.backgroundColor = COLOR(0, 0, 0, 1);

    
    //转动的菊花
    manager.loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [manager.loadingView startAnimating];
    manager.loadingView.frame = CGRectMake((manager.bgView.frame.size.width - 100) / 2, (manager.bgView.frame.size.height - 100) / 3, 100.0f, 100.0f);
    manager.loadingView.layer.cornerRadius = 8;
    manager.loadingView.layer.borderWidth = 0.1;
    manager.loadingView.layer.borderColor = [COLOR(220, 220, 220, 1)CGColor];
    manager.loadingView.backgroundColor = COLOR(255, 255, 255, 0.9);
    [manager.bgView addSubview:manager.loadingView];
    
    //文字
    manager.label = [[UILabel alloc]init];
    manager.label.text = @"Loading";
    manager.label.frame = CGRectMake(0, 75, 100, 18);
    manager.label.textAlignment = NSTextAlignmentCenter;
    manager.label.font = [UIFont systemFontOfSize:16];
    manager.label.textColor = [UIColor grayColor];
    [manager.loadingView addSubview:manager.label];
}

+(void)showForView:(UIView *)view show:(BOOL)isShow{
    AlertManager *manager = [AlertManager defaultAlert];
    if (isShow) {
        manager.bgView.backgroundColor = COLOR(0, 0, 0, 0.4);
    } else {
        manager.bgView.backgroundColor = COLOR(0, 0, 0, 0);
    }
    manager.bgView.hidden = NO;
    [view addSubview:manager.bgView];
    [view bringSubviewToFront:manager.bgView];
}

+(void)hidden{
    AlertManager *manager = [AlertManager defaultAlert];
    manager.bgView.hidden = YES;
}

@end
