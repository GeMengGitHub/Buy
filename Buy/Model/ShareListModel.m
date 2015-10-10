//
//  ShareListModel.m
//  Buy
//
//  Created by qf on 15/10/10.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "ShareListModel.h"

@implementation ShareListModel

+(ShareListModel *)setModelWithDic:(NSDictionary *)dic{
    ShareListModel *model = [[ShareListModel alloc]init];
    [model setValue:dic[@"width2"] forKey:@"width2"];
    [model setValue:dic[@"source"] forKey:@"source"];
    [model setValue:dic[@"url"] forKey:@"url"];
    [model setValue:dic[@"low"] forKey:@"low"];
    [model setValue:dic[@"@type"] forKey:@"type"];
    [model setValue:dic[@"best_desc"] forKey:@"best_desc"];
    [model setValue:dic[@"share_id"] forKey:@"share_id"];
    [model setValue:dic[@"icon"] forKey:@"icon"];
    [model setValue:dic[@"baike_url"] forKey:@"baike_url"];
    [model setValue:dic[@"name"] forKey:@"name"];
    [model setValue:dic[@"source_title"] forKey:@"source_title"];
    [model setValue:dic[@"is_strategy"] forKey:@"is_strategy"];
    [model setValue:dic[@"detail_logo2"] forKey:@"detail_logo2"];
    [model setValue:dic[@"height"] forKey:@"height"];
    [model setValue:dic[@"external_id"] forKey:@"external_id"];
    [model setValue:dic[@"width"] forKey:@"width"];
    [model setValue:dic[@"original_price"] forKey:@"original_price"];
    [model setValue:dic[@"height2"] forKey:@"height2"];
    [model setValue:dic[@"is_free_shipping"] forKey:@"is_free_shipping"];
    [model setValue:dic[@"desc"] forKey:@"desc"];
    [model setValue:dic[@"price"] forKey:@"price"];
    [model setValue:dic[@"like"] forKey:@"like"];
    [model setValue:dic[@"goods_url"] forKey:@"goods_url"];
    [model setValue:dic[@"detail_logo"] forKey:@"detail_logo"];
    return model;
}

+(NSArray *)setModelWithArray:(NSArray *)array{
    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in array) {
        ShareListModel *model = [ShareListModel setModelWithDic:dic];
        [modelArray addObject:model];
    }
    return modelArray;
}

@end
