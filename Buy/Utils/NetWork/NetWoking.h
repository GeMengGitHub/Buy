//
//  NetWoking.h
//  Buy
//
//  Created by qf on 15/10/10.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^errBlock)(void);
typedef void(^dicBlock)(NSDictionary *dic);
typedef void(^strBlock)(NSString *str);

@interface NetWoking : NSObject

//获取新版本
+(void)getVersion:(strBlock)block;

//获取主页数据
+(void)getHomeDataWithPage:(int)page data:(dicBlock)block err:(errBlock)err;

//猜你喜欢数据
+(void)getPerhapsDataWithShareId:(NSString *)shareId data:(dicBlock)block err:(errBlock)err;

//分类
+(void)getCategoryData:(dicBlock)block err:(errBlock)err;

//分类数据
+(void)getCategoryDataWithPage:(int)page categoryId:(NSString *)categoryId data:(dicBlock)block err:(errBlock)err;

//发现
+(void)getFoundData:(dicBlock)dicBlock err:(errBlock)err;

//发现详情页
+(void)getFoundListDataWith:(int)page cat_id:(NSString *)cat_id category_id:(NSString *)category_id price_filter:(NSString *)price_filter data:(dicBlock)dicBlock err:(errBlock)err;

@end
