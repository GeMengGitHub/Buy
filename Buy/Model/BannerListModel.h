//
//  BannerListModel.h
//  Buy
//
//  Created by qf on 15/10/10.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerListModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *category;
@property (nonatomic,copy) NSString *type2;
@property (nonatomic,copy) NSString *id2;
@property (nonatomic,copy) NSString *is_list;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *logo;
@property (nonatomic,copy) NSString *logo2;

+(BannerListModel *)setModelWithDic:(NSDictionary *)dic;
+(NSArray *)setModelWithArray:(NSArray *)array;

@end
