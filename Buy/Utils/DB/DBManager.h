//
//  DBManager.h
//  Buy
//
//  Created by qf on 15/10/17.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareListModel.h"

typedef void(^block)(void);
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

//分类页面
+(void)writeCategoryWithArray:(NSArray *)array;
+(NSArray *)readCategoryWithWhere:(NSDictionary *)dic;

//分类子类
+(void)writeCategorySubWithArray:(NSArray *)array;
+(NSArray *)readCategorySubWithWhere:(NSDictionary *)dic;

//收藏
+(BOOL)collectionWithModel:(ShareListModel *)model insert:(block)insert delete:(block)del;
+(BOOL)collectionWithModel:(ShareListModel *)model;
+(BOOL)disCollectionWithModel:(ShareListModel *)model;
+(NSArray *)collection;

@end
