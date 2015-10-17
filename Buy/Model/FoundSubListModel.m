//
//  FoundSubListModel.m
//  Buy
//
//  Created by qf on 15/10/16.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "FoundSubListModel.h"

@implementation FoundSubListModel
+(FoundSubListModel *)setModelWithDic:(NSDictionary *)dic{
    FoundSubListModel *model = [[FoundSubListModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

+(NSArray *)setModelWithArray:(NSArray *)array{
    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in array) {
        FoundSubListModel *model = [FoundSubListModel setModelWithDic:dic];
        [modelArray addObject:model];
    }
    return modelArray;
}
@end
