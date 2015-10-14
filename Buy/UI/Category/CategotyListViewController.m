//
//  CategotyListViewController.m
//  Buy
//
//  Created by qf on 15/10/13.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "CategotyListViewController.h"
#import "CategorySubModel.h"

@interface CategotyListViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *headerScrollView;
@property (nonatomic, strong) UIButton *tempButton;

@end

@implementation CategotyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setInit];
    [self setHeaderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setInit{
    self.view.backgroundColor = [UIColor whiteColor];
    //返回按钮
    UIButton *backButton = [[UIButton alloc]init];
    backButton.frame = CGRectMake(0, 0, 44, 44);
    backButton.tag = 111;
    [backButton addTarget:self action:@selector(navButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *backImage = [[UIImage imageNamed:@"black_back.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    backButton.tintColor = [UIColor whiteColor];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton setImage:backImage forState:UIControlStateHighlighted];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

//返回按钮点击
-(void)navButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

//设置顶部菜单栏
-(void)setHeaderView{
    CGRect main = [UIScreen mainScreen].bounds;
    _headerScrollView = [[UIScrollView alloc]init];
    _headerScrollView.delegate = self;
    _headerScrollView.showsHorizontalScrollIndicator = NO;
    _headerScrollView.showsVerticalScrollIndicator = NO;
    _headerScrollView.frame = CGRectMake(0, 0, main.size.width, 30);
    [_headerScrollView setContentSize:CGSizeMake(_dataArray.count * 82, 30)];
    [self.view addSubview:_headerScrollView];
    
    for (int i = 0; i < _dataArray.count; i ++) {
        CategorySubModel *model = _dataArray[i];
        
        UIButton *itemButton = [[UIButton alloc]init];
        itemButton.frame = CGRectMake(i * 82, 0, 80, 30);
        itemButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [itemButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [itemButton setTitle:model.name forState:UIControlStateNormal];
        [itemButton addTarget:self action:@selector(itemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headerScrollView addSubview:itemButton];
    }
}

-(void)itemButtonClick:(UIButton *)button{

}

@end
