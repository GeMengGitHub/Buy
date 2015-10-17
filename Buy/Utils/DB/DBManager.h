//
//  DBManager.h
//  Buy
//
//  Created by qf on 15/10/17.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

//滚动图片数据
+(void)writeBannerListWithArray:(NSArray *)array;
+(NSArray *)readBannerListWithWhere:(NSDictionary *)dic;

//首页菜单
+(void)writeCategoryListWithArray:(NSArray *)array;
+(NSArray *)readCategoryListWithWhere:(NSDictionary *)dic;

//首页数据
+(void)writeShareListWithArray:(NSArray *)array;
+(NSArray *)readShareListWithWhere:(NSDictionary *)dic;

@end