//
//  NetWoking.h
//  Buy
//
//  Created by qf on 15/10/10.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^errBlock)(void);
typedef void(^dicBlock)(NSDictionary *dic);

@interface NetWoking : NSObject

+(void)getHomeData:(dicBlock)block err:(errBlock)err;

@end
