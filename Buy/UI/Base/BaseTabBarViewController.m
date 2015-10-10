//
//  BaseTabBarViewController.m
//  Buy
//
//  Created by qf on 15/10/9.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "HomeViewController.h"
#import "CategoryViewController.h"
#import "FoundViewController.h"
#import "MeViewController.h"

@interface BaseTabBarViewController ()
@property (nonatomic, strong) UINavigationController *homeNVC;
@property (nonatomic, strong) UINavigationController *categoryNVC;
@property (nonatomic, strong) UINavigationController *foundNVC;
@property (nonatomic, strong) UINavigationController *meNVC;

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//添加视图 65 181 55
-(void)addView{
    //设置状态栏颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //默认选中第一个
    self.selectedIndex = 0;
    self.tabBar.tintColor = COLOR(65, 181, 55, 1);
    
    HomeViewController *home = [[HomeViewController alloc]init];
    CategoryViewController *category = [[CategoryViewController alloc]init];
    FoundViewController *found = [[FoundViewController alloc]init];
    MeViewController *me = [[MeViewController alloc]init];
    
    _homeNVC = [[UINavigationController alloc]initWithRootViewController:home];
    _categoryNVC = [[UINavigationController alloc]initWithRootViewController:category];
    _foundNVC = [[UINavigationController alloc]initWithRootViewController:found];
    _meNVC = [[UINavigationController alloc]initWithRootViewController:me];
    
    _homeNVC.navigationBar.translucent = NO;
    _categoryNVC.navigationBar.translucent = NO;
    _foundNVC.navigationBar.translucent = NO;
    _meNVC.navigationBar.translucent = NO;
    
    //tabBar的图标标题
    _homeNVC.tabBarItem.image = [UIImage imageNamed:TABBAR_IMAGE[0]];
    _homeNVC.tabBarItem.title = TABBAR_NAME[0];
    _categoryNVC.tabBarItem.image = [UIImage imageNamed:TABBAR_IMAGE[1]];
    _categoryNVC.tabBarItem.title = TABBAR_NAME[1];
    _foundNVC.tabBarItem.image = [UIImage imageNamed:TABBAR_IMAGE[2]];
    _foundNVC.tabBarItem.title = TABBAR_NAME[2];
    _meNVC.tabBarItem.image = [UIImage imageNamed:TABBAR_IMAGE[3]];
    _meNVC.tabBarItem.title = TABBAR_NAME[3];
    
    //tabBar选中后的颜色
    _homeNVC.tabBarItem.selectedImage = [[UIImage imageNamed:TABBAR_IMAGE2[0]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _categoryNVC.tabBarItem.selectedImage = [[UIImage imageNamed:TABBAR_IMAGE2[1]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _foundNVC.tabBarItem.selectedImage = [[UIImage imageNamed:TABBAR_IMAGE2[2]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _meNVC.tabBarItem.selectedImage = [[UIImage imageNamed:TABBAR_IMAGE2[3]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //navigation颜色
    home.navigationController.navigationBar.barTintColor = COLOR(65, 181, 55, 1);
    category.navigationController.navigationBar.barTintColor = COLOR(65, 181, 55, 1);
    found.navigationController.navigationBar.barTintColor = COLOR(65, 181, 55, 1);
    me.navigationController.navigationBar.barTintColor = COLOR(65, 181, 55, 1);
    
    self.tabBar.translucent = NO;
    self.viewControllers = @[_homeNVC, _categoryNVC, _foundNVC, _meNVC];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
}

@end
