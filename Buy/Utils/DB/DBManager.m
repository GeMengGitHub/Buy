//
//  DBManager.m
//  Buy
//
//  Created by qf on 15/10/17.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "DBManager.h"
#import "CGYDB.h"
#import "BannerListModel.h"
#import "CategoryListModel.h"
#import "ShareListModel.h"

@implementation DBManager

//滚动图片
+(void)writeBannerListWithArray:(NSArray *)array{
    CGYDB *db = [[CGYDB alloc]init];
    BOOL open = [db openDatabaseWithName:DATABASE_NAME];
    if (open) {
        [db del:TABLE_BANNERLIST withWhere:nil];
        for (BannerListModel *model in array) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setValue:model.name ? model.name : @" " forKey:@"name"];
            [dic setValue:model.desc ? model.desc : @" " forKey:@"desc"];
            [dic setValue:model.category ? model.category : @" " forKey:@"category"];
            [dic setValue:model.type2 ? model.type2 : @" " forKey:@"type2"];
            [dic setValue:model.id2 ? model.id2 : @" " forKey:@"id2"];
            [dic setValue:model.is_list ? model.is_list : @"" forKey:@"is_list"];
            [dic setValue:model.type ? model.type : @" " forKey:@"type"];
            [dic setValue:model.logo ? model.logo : @" " forKey:@"logo"];
            [dic setValue:model.logo2 ? model.logo2 : @" " forKey:@"logo2"];
            
            //如果已经存在、就删除后重新插入
            [db insertInto:TABLE_BANNERLIST WithDictionary:dic];
        }
        [db closeDatabase];
    }
}

+(NSArray *)readBannerListWithWhere:(NSDictionary *)dic{
    NSArray *array = nil;
    CGYDB *db = [[CGYDB alloc]init];
    BOOL open = [db openDatabaseWithName:DATABASE_NAME];
    if (open) {
        array = [db select:TABLE_BANNERLIST withWhere:nil];
        [db closeDatabase];
    }
    return array;
}


//菜单
+(void)writeCategoryListWithArray:(NSArray *)array{
    CGYDB *db = [[CGYDB alloc]init];
    BOOL open = [db openDatabaseWithName:DATABASE_NAME];
    if (open) {
        [db del:TABLE_CATEGORYLIST withWhere:nil];
        for (CategoryListModel *model in array) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setValue:model.id2 ? model.id2 : @" " forKey:@"id2"];
            [dic setValue:model.category ?model.category :@" " forKey:@"category"];
            [dic setValue:model.cat_id ?model.cat_id :@" " forKey:@"cat_id"];
            [dic setValue:model.m_index_id ?model.m_index_id : @" " forKey:@"m_index_id"];
            [dic setValue:model.type ? model.type :@" " forKey:@"type"];
            [dic setValue:model.type2 ?model.type2 :@" " forKey:@"type2"];
            [dic setValue:model.logo ?model.logo :@" " forKey:@"logo"];
            [dic setValue:model.is_list ?model.is_list :@" " forKey:@"is_list"];
            [dic setValue:model.icon ?model.icon :@" " forKey:@"icon"];
            [dic setValue:model.desc ?model.desc :@" " forKey:@"desc"];
            [dic setValue:model.is_red ?model.is_red :@" " forKey:@"is_red"];
            [dic setValue:model.name ?model.name :@" " forKey:@"name"];
        
            //如果已经存在、就删除后重新插入
            [db insertInto:TABLE_CATEGORYLIST WithDictionary:dic];
        }
        [db closeDatabase];
    }
}
+(NSArray *)readCategoryListWithWhere:(NSDictionary *)dic{
    NSArray *array = nil;
    CGYDB *db = [[CGYDB alloc]init];
    BOOL open = [db openDatabaseWithName:DATABASE_NAME];
    if (open) {
        array = [db select:TABLE_CATEGORYLIST withWhere:nil];
        [db closeDatabase];
    }
    return array;
}



//首页数据
+(void)writeShareListWithArray:(NSArray *)array{
    CGYDB *db = [[CGYDB alloc]init];
    BOOL open = [db openDatabaseWithName:DATABASE_NAME];
    if (open) {
        for (ShareListModel *model in array) {
           NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setValue:model.width2 ? model.width2 : @" " forKey:@"width2"];
            [dic setValue:model.source ? model.source : @" " forKey:@"source"];
            [dic setValue:model.url ? model.url : @" " forKey:@"url"];
            [dic setValue:model.low ? model.low : @" " forKey:@"low"];
            [dic setValue:model.type ? model.type : @" " forKey:@"type"];
            [dic setValue:model.best_desc ? model.best_desc : @" " forKey:@"best_desc"];
            [dic setValue:model.share_id ? model.share_id : @" " forKey:@"share_id"];
            [dic setValue:model.icon ? model.icon : @" " forKey:@"icon"];
            [dic setValue:model.baike_url ? model.baike_url : @" " forKey:@"baike_url"];
            [dic setValue:model.name ? model.name : @" " forKey:@"name"];
            [dic setValue:model.source_title ? model.source_title : @" " forKey:@"source_title"];
            [dic setValue:model.is_strategy ? model.is_strategy : @" " forKey:@"is_strategy"];
            [dic setValue:model.detail_logo2 ? model.detail_logo2 : @" " forKey:@"detail_logo2"];
            [dic setValue:model.height ? model.height : @" " forKey:@"height"];
            [dic setValue:model.external_id ? model.external_id : @" " forKey:@"external_id"];
            [dic setValue:model.width ? model.width : @" " forKey:@"width"];
            [dic setValue:model.original_price ? model.original_price : @" " forKey:@"original_price"];
            [dic setValue:model.height2 ? model.height2 : @" " forKey:@"height2"];
            [dic setValue:model.is_free_shipping ? model.is_free_shipping : @" " forKey:@"is_free_shipping"];
            [dic setValue:model.desc ? model.desc : @" " forKey:@"desc"];
            [dic setValue:model.price ? model.price : @" " forKey:@"price"];
            [dic setValue:model.like ? model.like : @" " forKey:@"like"];
            [dic setValue:model.goods_url ? model.goods_url : @" " forKey:@"goods_url"];
            [dic setValue:model.detail_logo ? model.detail_logo : @" " forKey:@"detail_logo"];
            
            NSArray *arr = [db select:TABLE_SHARELIST withWhere:@{@"share_id":model.share_id ? model.share_id : @" "}];
            if (arr.count > 0) {
                [db update:TABLE_SHARELIST WithSetValue:dic withWhere:@{@"share_id":model.share_id ? model.share_id : @" "}];
            } else {
                [db insertInto:TABLE_SHARELIST WithDictionary:dic];
            }
            
        }
        [db closeDatabase];
    }
}
+(NSArray *)readShareListWithWhere:(NSDictionary *)dic{
    NSArray *array = nil;
    CGYDB *db = [[CGYDB alloc]init];
    BOOL open = [db openDatabaseWithName:DATABASE_NAME];
    if (open) {
        array = [db select:TABLE_SHARELIST withWhere:nil];
        [db closeDatabase];
    }
    return array;
}

@end
