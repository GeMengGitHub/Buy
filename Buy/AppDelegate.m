//
//  AppDelegate.m
//  Buy
//
//  Created by qf on 15/10/9.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "AppDelegate.h"
#import "CGYDB.h"
#import "BaseTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //初始化数据库
    [self setInitDatabase];
    
    BaseTabBarViewController *tabBar = [[BaseTabBarViewController alloc]init];
    self.window.rootViewController = tabBar;
    
    return YES;
}

//首次运行、创建数据库和表
-(void)setInitDatabase{
    if ([self firstRun]) {
        CGYDB *db = [[CGYDB alloc]init];
        BOOL open = [db openDatabaseWithName:DATABASE_NAME];
        if (open) {
            [db createTabelWithName:TABLE_BANNERLIST withArray:TABLE_BANNERLIST_ARRAY];
            [db createTabelWithName:TABLE_CATEGORYLIST withArray:TABLE_CATEGORYLIST_ARRAY];
            [db createTabelWithName:TABLE_SHARELIST withArray:TABLE_SHARELIST_ARRAY];
            [db createTabelWithName:TABLE_CATEGORY withArray:TABLE_CATEGORY_ARRAY];
            [db createTabelWithName:TABLE_CATEGORYSUB withArray:TABLE_CATEGORYSUB_ARRAY];
            [db closeDatabase];
        }
    }
}

//判断是不是首次运行
-(BOOL)firstRun{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *str = [user objectForKey:@"firstRun"];
    if ([str isEqualToString:@"1"]) {
        return NO;
    } else {
        [user setObject:@"1" forKey:@"firstRun"];
        [user synchronize];
        return YES;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
