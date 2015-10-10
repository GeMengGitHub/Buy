//
//  CategoryListModel.h
//  Buy
//
//  Created by qf on 15/10/10.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryListModel : NSObject

@property (nonatomic,copy) NSString *id2;
@property (nonatomic,strong) NSDictionary *category;
@property (nonatomic,copy) NSString *cat_id;
@property (nonatomic,copy) NSString *m_index_id;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *type2;
@property (nonatomic,copy) NSString *logo;
@property (nonatomic,copy) NSString *is_list;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,strong) NSNumber *is_red;
@property (nonatomic,copy) NSString *name;

+(CategoryListModel *)setModelWithDic:(NSDictionary *)dic;
+(NSArray *)setModelWithArray:(NSArray *)array;

@end
