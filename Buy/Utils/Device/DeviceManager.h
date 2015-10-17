//
//  DeviceManager.h
//  Buy
//
//  Created by qf on 15/10/10.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceManager : NSObject

+(NSDictionary *)deviceinfo;

+(NSDictionary *)timeStamp;

+(NSString *)name;

+(NSString *)category;

+(NSString *)type;

+(NSString *)systemName;

+(NSString *)systemVersion;

+(NSString *)identifier;

+(CGFloat)width;

+(CGFloat)height;

+(CGFloat)frameWidth;

+(CGFloat)frameHeight;

@end
