//
//  CategotyListViewController.h
//  Buy
//
//  Created by qf on 15/10/13.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"

@interface CategotyListViewController : UIViewController
@property (nonatomic, strong) NSArray *dataArray;//数据源
@property (nonatomic, assign) int index;//第几个被选中
@property (nonatomic, copy) NSString *myTitle;//标题

@end
