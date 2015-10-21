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
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //友盟分享
    [self umShare];
    
    //初始化数据库
    [self setInitDatabase];
    
    BaseTabBarViewController *tabBar = [[BaseTabBarViewController alloc]init];
    self.window.rootViewController = tabBar;
    
    return YES;
}

/**
 *  友盟分享
 */
-(void)umShare{
    //注册友盟
    [UMSocialData setAppKey:UM_APPKEY];
    
    //微信分享
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    
    //QQ
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    
    //由于苹果审核政策需求，在设置QQ、微信AppID之后调用下面的方法
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
}

/**
 *  首次运行时，创建数据库
 */
-(void)setInitDatabase{
    if ([self firstRun]) {
        CGYDB *db = [[CGYDB alloc]init];
        BOOL open = [db openDatabaseWithName:DATABASE_NAME];
        if (open) {
            [db createTabelWithName:TABLE_BANNERLIST withArray:TABLE_BANNERLIST_ARRAY];
            [db createTabelWithName:TABLE_CATEGORYLIST withArray:TABLE_CATEGORYLIST_ARRAY];
            [db createTabelWithName:TABLE_SHARELIST withArray:TABLE_SHARELIST_ARRAY];
//            [db createTabelWithName:TABLE_CATEGORY withArray:TABLE_CATEGORY_ARRAY];
//            [db createTabelWithName:TABLE_CATEGORYSUB withArray:TABLE_CATEGORYSUB_ARRAY];
            [db createTabelWithName:TABLE_LIKE withArray:TABLE_LIKE_ARRAY];
            [db closeDatabase];
        }
    }
}

/**
 *  判断是不是首次运行
 *
 *  @return 如果是首次运行，返回YES，否则返回NO
 */
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

/**
 *  微信分享（协议方法）
 *
 *  @param application
 *  @param url
 *
 *  @return
 */
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [UMSocialSnsService handleOpenURL:url];
}

/**
 *  微信分享（协议方法）
 *
 *  @param application
 *  @param url
 *  @param sourceApplication
 *  @param annotation
 *
 *  @return
 */
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return  [UMSocialSnsService handleOpenURL:url];
}

@end
