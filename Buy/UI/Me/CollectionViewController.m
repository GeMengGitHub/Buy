//
//  CollectionViewController.m
//  Buy
//
//  Created by qf on 15/10/20.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "CollectionViewController.h"
#import "DetailsViewController.h"
#import "MenuDataListTableViewCell.h"
#import "ShareListModel.h"

@interface CollectionViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    [self setTableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  设置导航栏
 */
-(void)setNavigation{
    //标题
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 100, 44);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"我的收藏";
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
    
    //清空按钮
    UIButton * searchButton = [[UIButton alloc]init];
    searchButton.frame = CGRectMake(0, 0, 24, 24);
    searchButton.tintColor = [UIColor whiteColor];
    [searchButton addTarget:self action:@selector(deleteButton) forControlEvents:UIControlEventTouchUpInside];
    UIImage *image = [[UIImage imageNamed:@"btn-trash.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [searchButton setImage:image forState:UIControlStateNormal];
    [searchButton setImage:image forState:UIControlStateHighlighted];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:searchButton];
    self.navigationItem.rightBarButtonItem = barButton;
    
    _dataArray = [[NSMutableArray alloc]init];
}

-(void)navButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)deleteButton{
    [[[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定清空收藏列表吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即清空", nil] show];
}

/**
 *  获取数据
 */
-(void)getData{
    NSArray *array = [DBManager collection];
    [_dataArray setArray:[ShareListModel setModelWithArray:array]];
    [_tableView reloadData];
}

/**
 *  设置tableview
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

/**
 *  tableView协议方法 --- 编辑类型
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return 删除
 */
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

/**
 *  tableView协议方法 --- 编辑操作
 *
 *  @param tableView
 *  @param editingStyle
 *  @param indexPath
 */
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        BOOL result = [DBManager disCollectionWithModel:_dataArray[indexPath.row]];
        if (result) {
            [_dataArray removeObjectAtIndex:indexPath.row];
            [_tableView reloadData];
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [DBManager disCollectionWithModel:nil];
        [_dataArray removeAllObjects];
        [_tableView reloadData];
    }
}

@end
