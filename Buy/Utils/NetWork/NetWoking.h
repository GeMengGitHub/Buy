//
//  NetWoking.h
//  Buy
//
//  Created by qf on 15/10/10.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^errBlock)(void);
typedef void(^block)(void);
typedef void(^dicBlock)(NSDictionary *dic);
typedef void(^strBlock)(NSString *str);

@interface NetWoking : NSObject

/**
 *  获取版本号
 *
 *  @param block 获取成功时，返回版本号
 *  @param err   网络错误时执行的回调
 */
+(void)getVersion:(strBlock)block err:(errBlock)err;

/**
 *  网络监听
 *
 *  @param view 断网时，需要在哪个视图添加断网的标识
 *  @param off  没有网络执行的回调
 *  @param on   有网执行的回调
 */
+(void)netWokListeningWithOffTheNetForView:(UIView *)view off:(block)off on:(block)on;

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


/**
 *  首页菜单按钮数据
 *
 *  @param tag_id
 *  @param price_filter 价格
 *  @param category_id
 *  @param page         分页
 *  @param block
 *  @param err
 */
+(void)getMenuDataWithTagId:(NSString *)tag_id price_filter:(NSString *)price_filter category_id:(NSString *)category_id page:(int)page data:(dicBlock)block err:(errBlock)err;

@end
