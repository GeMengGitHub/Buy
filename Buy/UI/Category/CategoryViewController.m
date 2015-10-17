//
//  CategoryViewController.m
//  Buy
//
//  Created by qf on 15/10/9.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryModel.h"
#import "CategoryCollectionViewCell.h"
#import "CategotyListViewController.h"

@interface CategoryViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIView *leftView;//左侧栏
@property (nonatomic, strong) NSArray *dataArray;//数据源
@property (nonatomic, strong) NSArray *contentArray;//子类数据源


@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    [self setInit];
    [self getData];
    [self setLeftView];
    [self setCollectionView];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//设置导航
-(void)setNavigation{
    //设置navigation
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 20, 100, 44);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"分类";
    self.navigationItem.titleView = titleLabel;
}

//初始化
-(void)setInit{
    self.view.backgroundColor = [UIColor whiteColor];
}

//获取网络数据
-(void)getData{
    [NetWoking getCategoryData:^(NSDictionary *dic) {
        if ([dic[@"catList"] count] > 0) {
            _dataArray = [CategoryModel setModelWithArray:dic[@"catList"]];
            [self setLeftViewItem];
        }
    } err:^{
        
    }];
}

//设置左侧栏
-(void)setLeftView{
    _leftView = [[UIView alloc]init];
    _leftView.backgroundColor = COLOR(240, 240, 240, 1);
    _leftView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_leftView];
    
    NSArray *layout = nil;
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_leftView(100)]" options:0 metrics:nil views:@{@"_leftView":_leftView}];
    [self.view addConstraints:layout];
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_leftView]-0-|" options:0 metrics:nil views:@{@"_leftView":_leftView}];
    [self.view addConstraints:layout];
}

//设置左侧栏的按钮
-(void)setLeftViewItem{
    for (int i = 0; i < _dataArray.count; i ++) {
        static int j = 0;
        CategoryModel *model = _dataArray[i];
        if (model.subList.count == 0) {
            j ++;
            continue;
        }
        UIButton *itemButton = [[UIButton alloc]init];
        itemButton.frame = CGRectMake(0, 40*(i-j), _leftView.frame.size.width, 40);
        itemButton.backgroundColor = COLOR(240, 240, 240, 1);
        [itemButton setTitle:model.name forState:UIControlStateNormal];
        itemButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [itemButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        itemButton.tag = model.cat_id.intValue;
        [itemButton addTarget:self action:@selector(itemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_leftView addSubview:itemButton];
    }
    
    //默认选中第一个
    UIButton *button = _leftView.subviews[0];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:COLOR(65, 181, 55, 1) forState:UIControlStateNormal];
    
    //展示第一个选项的数据
    for (CategoryModel *model in _dataArray) {
        if (model.subList.count > 0) {
            _contentArray = model.subList;
            [_collectionView reloadData];
            break;
        }
    }
}

//左侧按钮点击事件
-(void)itemButtonClick:(UIButton *)button{
    NSArray *views = _leftView.subviews;
    [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *item = obj;
        item.backgroundColor = COLOR(240, 240, 240, 1);
        [item setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:COLOR(65, 181, 55, 1) forState:UIControlStateNormal];
    
    //点击按钮展示数据
    for (CategoryModel *model in _dataArray) {
        if (model.cat_id.intValue == button.tag) {
            _contentArray = model.subList;
            [_collectionView reloadData];
        }
    }
}

//设置setCollectionView
-(void)setCollectionView{
    CGRect r = [UIScreen mainScreen].bounds;
    _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _flowLayout.itemSize = CGSizeMake((r.size.width-112)/2, 100);
    _flowLayout.minimumLineSpacing = 4;
    _flowLayout.minimumInteritemSpacing = 4;
    _flowLayout.sectionInset = UIEdgeInsetsMake(4.0f, 4.0f, 0.0f, 4.0f);
    _flowLayout.scrollDirection = UICollectionViewScrollPositionCenteredVertically;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(100, 0, r.size.width-100, r.size.height-64-49) collectionViewLayout:_flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:@"contentCell"];
    [self.view addSubview:_collectionView];
}

//Collection协议方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"contentCell" forIndexPath:indexPath];
    [cell setCategoryCellWithModel:_contentArray[indexPath.row]];
    return cell;
}

//Collection个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _contentArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//Collection点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryModel *model = _dataArray[indexPath.section];
    CategotyListViewController *viewController = [[CategotyListViewController alloc]init];
    viewController.index = (int)indexPath.row;
    viewController.dataArray = _contentArray;
    viewController.myTitle = model.name;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
