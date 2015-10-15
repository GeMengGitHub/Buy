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

@interface NetWoking : NSObject

//获取主页数据
+(void)getHomeDataWithPage:(int)page data:(dicBlock)block err:(errBlock)err;

//猜你喜欢数据
+(void)getPerhapsDataWithShareId:(NSString *)shareId data:(dicBlock)block err:(errBlock)err;

//分类
+(void)getCategoryData:(dicBlock)block err:(errBlock)err;

//分类数据
+(void)getCategoryDataWithPage:(int)page categoryId:(NSString *)categoryId data:(dicBlock)block err:(errBlock)err;

@end
