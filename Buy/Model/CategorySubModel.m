//
//  CategorySubModel.m
//  Buy
//
//  Created by qf on 15/10/13.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "CategorySubModel.h"

@implementation CategorySubModel
+(CategorySubModel *)setModelWithDic:(NSDictionary *)dic{
    CategorySubModel *model = [[CategorySubModel alloc]init];
    [model setValue:dic[@"parent_id"] forKey:@"parent_id"];
    [model setValue:dic[@"cat_id"] forKey:@"cat_id"];
    [model setValue:dic[@"name"] forKey:@"name"];
    [model setValue:dic[@"logo"] forKey:@"logo"];
    return model;
}

+(NSArray *)setModelWithArray:(NSArray *)array{
    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in array) {
        CategorySubModel *model = [CategorySubModel setModelWithDic:dic];
        [modelArray addObject:model];
    }
    return modelArray;
}
@end
