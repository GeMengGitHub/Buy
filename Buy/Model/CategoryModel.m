//
//  CategoryModel.m
//  Buy
//
//  Created by qf on 15/10/13.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "CategoryModel.h"
#import "CategorySubModel.h"

@implementation CategoryModel
+(CategoryModel *)setModelWithDic:(NSDictionary *)dic{
    CategoryModel *model = [[CategoryModel alloc]init];
    [model setValue:dic[@"parent_id"] forKey:@"parent_id"];
    [model setValue:dic[@"is_list"] forKey:@"is_list"];
    [model setValue:dic[@"cat_id"] forKey:@"cat_id"];
    [model setValue:dic[@"name"] forKey:@"name"];
    [model setValue:dic[@"logo"] forKey:@"logo"];
    [model setValue:[CategorySubModel setModelWithArray:dic[@"subList"]] forKey:@"subList"];
    return model;
}

+(NSArray *)setModelWithArray:(NSArray *)array{
    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in array) {
        CategoryModel *model = [CategoryModel setModelWithDic:dic];
        [modelArray addObject:model];
    }
    return modelArray;
}

@end
