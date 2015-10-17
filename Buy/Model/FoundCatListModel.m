//
//  FoundCatListModel.m
//  Buy
//
//  Created by qf on 15/10/16.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "FoundCatListModel.h"
#import "FoundSubListModel.h"

@implementation FoundCatListModel
+(FoundCatListModel *)setModelWithDic:(NSDictionary *)dic{
    FoundCatListModel *model = [[FoundCatListModel alloc]init];
    [model setValue:dic[@"parent_id"] forKey:@"parent_id"];
    [model setValue:dic[@"is_list"] forKey:@"is_list"];
    [model setValue:dic[@"cat_id"] forKey:@"cat_id"];
    [model setValue:dic[@"name"] forKey:@"name"];
    [model setValue:[FoundSubListModel setModelWithArray:dic[@"subList"]] forKey:@"subList"];
    return model;
}

+(NSArray *)setModelWithArray:(NSArray *)array{
    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in array) {
        FoundCatListModel *model = [FoundCatListModel setModelWithDic:dic];
        [modelArray addObject:model];
    }
    return modelArray;
}
@end
