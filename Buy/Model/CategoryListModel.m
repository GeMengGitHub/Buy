//
//  CategoryListModel.m
//  Buy
//
//  Created by qf on 15/10/10.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "CategoryListModel.h"

@implementation CategoryListModel

+(CategoryListModel *)setModelWithDic:(NSDictionary *)dic{
    CategoryListModel *model = [[CategoryListModel alloc]init];
    [model setValue:dic[@"id"] forKey:@"id2"];
    [model setValue:dic[@"category"] forKey:@"category"];
    [model setValue:dic[@"cat_id"] forKey:@"cat_id"];
    [model setValue:dic[@"m_index_id"] forKey:@"m_index_id"];
    [model setValue:dic[@"type"] forKey:@"type"];
    [model setValue:dic[@"@type"] forKey:@"type2"];
    [model setValue:dic[@"logo"] forKey:@"logo"];
    [model setValue:dic[@"is_list"] forKey:@"is_list"];
    [model setValue:dic[@"icon"] forKey:@"icon"];
    [model setValue:dic[@"desc"] forKey:@"desc"];
    [model setValue:dic[@"is_red"] forKey:@"is_red"];
    [model setValue:dic[@"name"] forKey:@"name"];
    return model;
}

+(NSArray *)setModelWithArray:(NSArray *)array{
    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in array) {
        CategoryListModel *model = [CategoryListModel setModelWithDic:dic];
        [modelArray addObject:model];
    }
    return modelArray;
}

@end
