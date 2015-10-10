//
//  BannerListModel.m
//  Buy
//
//  Created by qf on 15/10/10.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "BannerListModel.h"

@implementation BannerListModel

+(BannerListModel *)setModelWithDic:(NSDictionary *)dic{
    BannerListModel *model = [[BannerListModel alloc]init];
    [model setValue:dic[@"name"] forKey:@"name"];
    [model setValue:dic[@"desc"] forKey:@"desc"];
    [model setValue:dic[@"category"] forKey:@"category"];
    [model setValue:dic[@"@type"] forKey:@"type2"];
    [model setValue:dic[@"id"] forKey:@"id2"];
    [model setValue:dic[@"is_list"] forKey:@"is_list"];
    [model setValue:dic[@"type"] forKey:@"type"];
    [model setValue:dic[@"logo"] forKey:@"logo"];
    [model setValue:dic[@"logo2"] forKey:@"logo2"];
    return model;
}

+(NSArray *)setModelWithArray:(NSArray *)array{
    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in array) {
        BannerListModel *model = [BannerListModel setModelWithDic:dic];
        [modelArray addObject:model];
    }
    return modelArray;
}

@end
