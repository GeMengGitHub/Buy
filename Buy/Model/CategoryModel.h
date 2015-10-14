//
//  CategoryModel.h
//  Buy
//
//  Created by qf on 15/10/13.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject
@property (nonatomic,copy) NSString *parent_id;
@property (nonatomic,copy) NSString *is_list;
@property (nonatomic,copy) NSString *cat_id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *logo;
@property (nonatomic,strong) NSArray *subList;

+(CategoryModel *)setModelWithDic:(NSDictionary *)dic;
+(NSArray *)setModelWithArray:(NSArray *)array;

@end
