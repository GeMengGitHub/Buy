//
//  CategorySubModel.h
//  Buy
//
//  Created by qf on 15/10/13.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategorySubModel : NSObject
@property (nonatomic,copy) NSString *parent_id;
@property (nonatomic,copy) NSString *cat_id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *logo;

+(CategorySubModel *)setModelWithDic:(NSDictionary *)dic;
+(NSArray *)setModelWithArray:(NSArray *)array;
@end
