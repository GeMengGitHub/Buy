//
//  ShareListModel.h
//  Buy
//
//  Created by qf on 15/10/10.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareListModel : NSObject

@property (nonatomic,copy) NSNumber *width2;
@property (nonatomic,copy) NSString *source;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSNumber *low;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *best_desc;
@property (nonatomic,copy) NSString *share_id;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *baike_url;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *source_title;
@property (nonatomic,copy) NSNumber *is_strategy;
@property (nonatomic,copy) NSString *detail_logo2;
@property (nonatomic,copy) NSNumber *height;
@property (nonatomic,copy) NSString *external_id;
@property (nonatomic,copy) NSNumber *width;
@property (nonatomic,copy) NSString *original_price;
@property (nonatomic,copy) NSNumber *height2;
@property (nonatomic,copy) NSNumber *is_free_shipping;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *like;
@property (nonatomic,copy) NSString *goods_url;
@property (nonatomic,copy) NSString *detail_logo;

+(ShareListModel *)setModelWithDic:(NSDictionary *)dic;
+(NSArray *)setModelWithArray:(NSArray *)array;

@end
