//
//  NetWoking.m
//  Buy
//
//  Created by qf on 15/10/10.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "NetWoking.h"

@interface NetWoking ()
@property (nonatomic, strong) UIImageView *netWokImageView;//没有网络的图片
@property (nonatomic, strong) UILabel *netLabel;//没有网络的标语

@end

@implementation NetWoking

+(NetWoking *)defaultNetWoking{
    static NetWoking *net = nil;
    if (!net) {
        net = [[NetWoking alloc]init];
    }
    return net;
}

/**
 *  获取版本号
 *
 *  @param block 获取成功时，返回版本号
 *  @param err   网络错误时执行的回调
 */
+(void)getVersion:(strBlock)block err:(errBlock)err{
    NSString *url = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",APP_STORE_ID];
    
    //网络管理者对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //发送GET请求
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"results"][0][@"version"]) {
            block(dic[@"results"][0][@"version"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        err();
    }];
}

/**
 *  网络监听
 *
 *  @param view 断网时，需要在哪个视图添加断网的标识
 *  @param off  没有网络执行的回调
 *  @param on   有网执行的回调
 */
+(void)netWokListeningWithOffTheNetForView:(UIView *)view off:(block)off on:(block)on{
    NetWoking *net = [NetWoking defaultNetWoking];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status <= AFNetworkReachabilityStatusNotReachable) {
            //每次都移除view上的所有视图控件
            NSArray *viewArray = view.subviews;
            [viewArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [obj removeFromSuperview];
            }];
            
            net.netWokImageView = [[UIImageView alloc]init];
            net.netWokImageView.center = CGPointMake([DeviceManager frameWidth]/2, [DeviceManager frameHeight]/3);
            net.netWokImageView.bounds = CGRectMake(0, 0, 86, 60);
            net.netWokImageView.image = [UIImage imageNamed:@"icon_network.png"];
            [view addSubview:net.netWokImageView];
            
            net.netLabel = [[UILabel alloc]init];
            net.netLabel.center = CGPointMake([DeviceManager frameWidth]/2, net.netWokImageView.frame.size.height + net.netWokImageView.frame.origin.y + 30);
            net.netLabel.bounds = CGRectMake(0, 0, 200, 18);
            net.netLabel.text = @"网络不给力，点击重新加载!";
            net.netLabel.textAlignment = NSTextAlignmentCenter;
            net.netLabel.font = [UIFont systemFontOfSize:16];
            net.netLabel.textColor = [UIColor grayColor];
            [view addSubview:net.netLabel];
            off();
            
        }else {
            [net.netWokImageView removeFromSuperview];
            [net.netLabel removeFromSuperview];
            on();
        }
    }];
    [manager.reachabilityManager startMonitoring];
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

/**
 *  首页菜单按钮数据
 *
 *  @param tag_id
 *  @param price_filter 价格
 *  @param category_id
 *  @param page         分页
 *  @param block
 *  @param err
 */
+(void)getMenuDataWithTagId:(NSString *)tag_id price_filter:(NSString *)price_filter category_id:(NSString *)category_id page:(int)page data:(dicBlock)block err:(errBlock)err{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:APPINFO forKey:@"appinfo"];
    [dic setObject:[DeviceManager deviceinfo] forKey:@"deviceinfo"];
    [dic setObject:[DeviceManager timeStamp] forKey:@"time_stamp"];
    [dic setObject:[NSString stringWithFormat:@"%d", page*20] forKey:@"start"];
    [dic setObject:@"20" forKey:@"count"];
    [dic setObject:price_filter forKey:@"price_filter"];
    [dic setObject:tag_id forKey:@"tag_id"];
    [dic setObject:category_id forKey:@"category_id"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:API_MENU parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        block(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        err();
        
    }];
}

@end
