//
//  CacheManager.m
//  Buy
//
//  Created by qf on 15/10/17.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "CacheManager.h"

@implementation CacheManager
//获取缓存大小
+(CGFloat)getCacheSize{
    __block CGFloat totalSize = 0;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"ImageCache"];
    __block NSFileManager *ma = [NSFileManager defaultManager];
    NSArray *array = [ma contentsOfDirectoryAtPath:path error:nil];
    
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic = [ma attributesOfItemAtPath:[path stringByAppendingPathComponent:obj] error:nil];
        totalSize += [dic fileSize] / 1024.0 / 1024.0;
    }];
    
    return totalSize;
}

//清理缓存
+(void)clearCache{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"ImageCache"];
    NSFileManager *ma = [NSFileManager defaultManager];
    NSArray *array = [ma contentsOfDirectoryAtPath:path error:nil];
    
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [ma removeItemAtPath:[path stringByAppendingPathComponent:obj] error:nil];
    }];
}

@end
