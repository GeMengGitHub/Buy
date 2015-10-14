//
//  WebViewController.h
//  Buy
//
//  Created by qf on 15/10/12.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareListModel.h"

@interface WebViewController : UIViewController
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *myTitle;
@property (nonatomic, assign) BOOL showShareButton;

@end