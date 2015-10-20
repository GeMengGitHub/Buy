//
//  MenuDataListViewController.m
//  Buy
//
//  Created by qf on 15/10/19.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "MenuDataListViewController.h"
#import "DetailsViewController.h"
#import "MenuDataListTableViewCell.h"
#import "ShareListModel.h"
#import "DetailsViewController.h"

@interface MenuDataListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) int page;

@end

@implementation MenuDataListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setInit];
    [self setNavigation];
    [self getData];
    [self setTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  设置导航
 */
-(void)setNavigation{
    //标题
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 100, 44);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    if ([_model.name isEqualToString:@"禾禾有礼"]) {
        titleLabel.text = @"每日精选";
    } else {
        titleLabel.text = _model.name;
    }
        
    self.navigationItem.titleView = titleLabel;
    
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

-(void)navButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  初始化
 */
-(void)setInit{
    _page = 0;
    _dataArray = [[NSMutableArray alloc]init];
}

/**
 *  获取数据
 */
-(void)getData{
    [NetWoking getMenuDataWithTagId:@"-1" price_filter:@"0" category_id:_model.cat_id page:_page data:^(NSDictionary *dic) {
        if (_page == 0) {
            [_dataArray setArray:[ShareListModel setModelWithArray:dic[@"shareList"]]];
        } else {
            [_dataArray addObjectsFromArray:[ShareListModel setModelWithArray:dic[@"shareList"]]];
        }
        [AlertManager dismiss];
        [_tableView reloadData];
        
    } err:^{
        [AlertManager dismiss];
        
    }];
}

/**
 *  设置tableView
 */
-(void)setTableView{
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_tableView];
    NSArray *layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_tableView]-0-|" options:0 metrics:nil views:@{@"_tableView":_tableView}];
    [self.view addConstraints:layout];
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_tableView]-0-|" options:0 metrics:nil views:@{@"_tableView":_tableView}];
    [self.view addConstraints:layout];
    [AlertManager showForView:_tableView show:NO];
}

/**
 *  tableView协议方法 --- 创建Cell
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    MenuDataListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MenuDataListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    if (_dataArray.count > 0) {
        [cell setCellWithModel:_dataArray[indexPath.row]];
    }
    return cell;
}

/**
 *  tableView协议方法 --- 行数
 *
 *  @param tableView
 *  @param section
 *
 *  @return
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

/**
 *  tableview协议方法 --- cell点击事件
 *
 *  @param tableView
 *  @param indexPath
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *detail = [[DetailsViewController alloc]init];
    detail.shareModel = _dataArray[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

/**
 *  tableview协议方法 --- 行高
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


@end
