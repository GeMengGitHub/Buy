//
//  DeviceManager.m
//  Buy
//
//  Created by qf on 15/10/10.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "DeviceManager.h"

@implementation DeviceManager

+(NSDictionary *)deviceinfo{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[DeviceManager denstiy] forKey:@"denstiy"];
    [dic setObject:@"iphoneos" forKey:@"model"];
    [dic setObject:@"6.0" forKey:@"platform"];
    return dic;
}

+(NSDictionary *)timeStamp{
    double timeStamp = ceil([[NSDate date] timeIntervalSince1970] * 1000);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[NSString stringWithFormat:@"%.f", timeStamp] forKey:@"time_stamp"];
    return dic;
}

+(NSString *)denstiy{
    CGRect rx = [ UIScreen mainScreen ].bounds;
    return [NSString stringWithFormat:@"%f", rx.size.width];
}

+(NSString *)name{
    UIDevice *device = [[UIDevice alloc]init];
    return device.name;
}

+(NSString *)category{
    UIDevice *device = [[UIDevice alloc]init];
    return device.model;
}

+(NSString *)type{
    UIDevice *device = [[UIDevice alloc]init];
    return device.localizedModel;
}

+(NSString *)systemName{
    UIDevice *device = [[UIDevice alloc]init];
    return device.systemName;
}

+(NSString *)systemVersion{
    UIDevice *device = [[UIDevice alloc]init];
    return device.systemVersion;
}

+(NSString *)identifier{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+(CGFloat)width{
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat scale = [[UIScreen mainScreen] scale];
    return rect.size.width * scale;
}

+(CGFloat)height{
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat scale = [[UIScreen mainScreen] scale];
    return rect.size.height * scale;
}

@end
