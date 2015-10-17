//
//  NetWoking.m
//  Buy
//
//  Created by qf on 15/10/10.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "NetWoking.h"

@implementation NetWoking

//版本号
+(void)getVersion:(strBlock)block{
    //网络管理者对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //发送GET请求
    [manager GET:VERSION_UPDATE parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"results"][0][@"version"]) {
            block(dic[@"results"][0][@"version"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}


+(void)getHomeDataWithPage:(int)page data:(dicBlock)block err:(errBlock)err{
    //post请求的body
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:APPINFO forKey:@"appinfo"];
    [dic setObject:[DeviceManager deviceinfo] forKey:@"deviceinfo"];
    [dic setObject:[DeviceManager timeStamp] forKey:@"time_stamp"];
    [dic setObject:[NSString stringWithFormat:@"%d", page*20] forKey:@"start"];
    [dic setObject:@"20" forKey:@"count"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:API_HOME parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        block(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        err();
        
    }];
}

+(void)getPerhapsDataWithShareId:(NSString *)shareId data:(dicBlock)block err:(errBlock)err{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:APPINFO forKey:@"appinfo"];
    [dic setObject:[DeviceManager deviceinfo] forKey:@"deviceinfo"];
    [dic setObject:[DeviceManager timeStamp] forKey:@"time_stamp"];
    [dic setObject:shareId forKey:@"share_id"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:API_PERHAPS parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        block(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        err();
        
    }];
}

+(void)getCategoryData:(dicBlock)block err:(errBlock)err{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:APPINFO forKey:@"appinfo"];
    [dic setObject:[DeviceManager deviceinfo] forKey:@"deviceinfo"];
    [dic setObject:[DeviceManager timeStamp] forKey:@"time_stamp"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:API_CATEGORY parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        block(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        err();
        
    }];
}


+(void)getCategoryDataWithPage:(int)page categoryId:(NSString *)categoryId data:(dicBlock)block err:(errBlock)err{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:APPINFO forKey:@"appinfo"];
    [dic setObject:[DeviceManager deviceinfo] forKey:@"deviceinfo"];
    [dic setObject:[DeviceManager timeStamp] forKey:@"time_stamp"];
    [dic setObject:[NSString stringWithFormat:@"%d", page*20] forKey:@"start"];
    [dic setObject:@"20" forKey:@"count"];
    [dic setObject:categoryId forKey:@"category_id"];
    [dic setObject:@"-1" forKey:@"tag_id"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:API_CATEGORY_DATA parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        block(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        err();
        
    }];
}


+(void)getFoundData:(dicBlock)dicBlock err:(errBlock)err{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:APPINFO forKey:@"appinfo"];
    [dic setObject:[DeviceManager deviceinfo] forKey:@"deviceinfo"];
    [dic setObject:[DeviceManager timeStamp] forKey:@"time_stamp"];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:API_FOUND parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        dicBlock(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        err();
        
    }];
}


+(void)getFoundListDataWith:(int)page cat_id:(NSString *)cat_id category_id:(NSString *)category_id price_filter:(NSString *)price_filter data:(dicBlock)dicBlock err:(errBlock)err{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:APPINFO forKey:@"appinfo"];
    [dic setObject:[DeviceManager deviceinfo] forKey:@"deviceinfo"];
    [dic setObject:[DeviceManager timeStamp] forKey:@"time_stamp"];
    [dic setObject:[NSString stringWithFormat:@"%d", page*20] forKey:@"start"];
    [dic setObject:@"20" forKey:@"count"];
    [dic setObject:price_filter forKey:@"price_filter"];
    [dic setObject:cat_id forKey:@"cat_id"];
    [dic setObject:category_id forKey:@"category_id"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:API_FOUND_LIST parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        dicBlock(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        err();
        
    }];
}

@end
