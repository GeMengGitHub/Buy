//
//  NetWoking.m
//  Buy
//
//  Created by qf on 15/10/10.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "NetWoking.h"

@implementation NetWoking

+(void)getHomeData:(dicBlock)block err:(errBlock)err{
    //post请求的body
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:APPINFO forKey:@"appinfo"];
    [dic setObject:[DeviceManager deviceinfo] forKey:@"deviceinfo"];
    [dic setObject:[DeviceManager timeStamp] forKey:@"time_stamp"];
    [dic setObject:@"0" forKey:@"start"];
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

@end
