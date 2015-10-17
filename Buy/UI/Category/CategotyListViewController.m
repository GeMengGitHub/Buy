//
//  CategotyListViewController.m
//  Buy
//
//  Created by qf on 15/10/13.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "CategotyListViewController.h"
#import "CategorySubModel.h"
#import "ShareListModel.h"
#import "DetailsViewController.h"
#import "CategotyListCollectionViewCell.h"

@interface CategotyListViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UIScrollView *headerScrollView;
@property (nonatomic, strong) UIScrollView *mainScrollView;//主要视图
@property (nonatomic, strong) UIButton *tempButton;//临时按钮保存
@property (nonatomic, strong) UIView *bottomLineView;//按钮底部红线
@property (nonatomic, strong) NSMutableArray *contentArray;//显示的内容
@property (nonatomic, assign) int page;//页面
@property (nonatomic, assign) int currentShow;//当前显示第几个界面
//@property (nonatomic, strong) UIActivityIndicatorView *activity;//转动的小菊花

@end

@implementation CategotyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    [self setInit];
    [self setHeaderView];
    [self getDataWith:[_dataArray[_currentShow] cat_id]];
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//获取数据
-(void)getDataWith:(NSString *)categoryId{
    //开启菊花
    [AlertManager showForView:self.view show:NO];
    
    //刷新界面
    UICollectionView *view = _mainScrollView.subviews[_currentShow];
    //网络请求
    [NetWoking getCategoryDataWithPage:_page categoryId:categoryId data:^(NSDictionary *dic) {
        if (_page == 0) {
            if ([dic[@"shareList"] count] > 0) {
                [_contentArray[_currentShow] setArray:[ShareListModel setModelWithArray:dic[@"shareList"]]];
            }
        } else {
            if ([dic[@"shareList"] count] > 0) {
                NSArray *array = [ShareListModel setModelWithArray:dic[@"shareList"]];
                for (ShareListModel *model in array) {
                    [_contentArray[_currentShow] addObject:model];
                }
            }
        }
        //刷新数据、隐藏刷新、加载
        [view reloadData];
        [view headerEndRefreshingWithResult:JHRefreshResultNone];
        [view footerEndRefreshing];
        [AlertManager dismiss];
        
    } err:^{
        [view reloadData];
        [view headerEndRefreshingWithResult:JHRefreshResultNone];
        [view footerEndRefreshing];
        [AlertManager dismiss];
        
    }];
    
}

//设置导航
-(void)setNavigation{
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
    
    //设置 navigation
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 20, 100, 44);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = _myTitle;
    self.navigationItem.titleView = titleLabel;
    
    //排序按钮
    UIButton * orderbyButton = [[UIButton alloc]init];
    orderbyButton.frame = CGRectMake(0, 0, 24, 24);
    orderbyButton.tintColor = [UIColor whiteColor];
    UIImage *image = [[UIImage imageNamed:@"icon_filter.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image2 = [[UIImage imageNamed:@"icon_filter_highlight.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [orderbyButton setImage:image forState:UIControlStateNormal];
    [orderbyButton setImage:image2 forState:UIControlStateHighlighted];
//    [orderbyButton addTarget:self action:@selector(fitleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:orderbyButton];
    self.navigationItem.rightBarButtonItem = barButton;
}

//初始化
-(void)setInit{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化 main scrollView
    _mainScrollView = [[UIScrollView alloc]init];
    _mainScrollView.frame = CGRectMake(0, 34, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 34);
    _mainScrollView.delegate = self;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.pagingEnabled = YES;
    [_mainScrollView setContentSize:CGSizeMake(_dataArray.count * self.view.frame.size.width, self.view.frame.size.height - 34)];
    [self.view addSubview:_mainScrollView];
    
    //初始化：转动的菊花
//    _activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    _activity.center = CGPointMake(self.view.frame.size.width/2, 200);
//    _activity.bounds = CGRectMake(0, 0, 100, 100);
//    _activity.backgroundColor = COLOR(0, 0, 0, 0.8);
//    _activity.layer.cornerRadius = 8;
//    [self.view addSubview:_activity];
    
    //初始化页面
    _currentShow = _index;
    
    //创建保存数据的数组
    _contentArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < _dataArray.count; i ++) {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        [_contentArray addObject:array];
    }
}

//返回按钮点击
-(void)navButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

//导航按钮底部红线
-(void)setBottomLineViewWithX:(CGFloat)x{
    //初始化按钮底部红线
    _bottomLineView = [[UIView alloc]init];
    _bottomLineView.frame = CGRectMake(x, 30, 80, 4);
    _bottomLineView.backgroundColor = [UIColor redColor];
    [_headerScrollView addSubview:_bottomLineView];
}

//动画改变“导航按钮底部红线”
-(void)changeBottomLineWithX:(CGFloat)x{
    [UIView animateWithDuration:0.1 animations:^{
        CGRect r = _bottomLineView.frame;
        r.origin.x = x;
        _bottomLineView.frame = r;
    }];
}

//设置顶部菜单栏
-(void)setHeaderView{
    CGRect main = [UIScreen mainScreen].bounds;
    _headerScrollView = [[UIScrollView alloc]init];
    _headerScrollView.showsHorizontalScrollIndicator = NO;
    _headerScrollView.showsVerticalScrollIndicator = NO;
    _headerScrollView.frame = CGRectMake(0, 0, main.size.width, 34);
    [_headerScrollView setContentSize:CGSizeMake(_dataArray.count * 82, 30)];
    [self.view addSubview:_headerScrollView];
    
    for (int i = 0; i < _dataArray.count; i ++) {
        CategorySubModel *model = _dataArray[i];
        
        UIButton *itemButton = [[UIButton alloc]init];
        itemButton.tag = model.cat_id.intValue;
        itemButton.frame = CGRectMake(i * 82, 0, 80, 30);
        itemButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [itemButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [itemButton setTitle:model.name forState:UIControlStateNormal];
        [itemButton addTarget:self action:@selector(itemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headerScrollView addSubview:itemButton];
        
        //设置collectionView
        CGRect r = [UIScreen mainScreen].bounds;
        CGRect collectionFrame = CGRectMake(i * r.size.width, 0, r.size.width, r.size.height - 34 - 64);
        [self setCollectionView:model.cat_id.intValue frame:collectionFrame];
    }
    
    //设置默认选中被点击按钮
    CategorySubModel *model = _dataArray[_index];
    UIButton *button = (UIButton *)[_headerScrollView viewWithTag:model.cat_id.intValue];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _tempButton = button;
    [self setBottomLineViewWithX:button.frame.origin.x];
    //初始化进来的时候显示的collectionView
    [_mainScrollView setContentOffset:CGPointMake(_index * main.size.width, 0)];
    //初始化header位置
    [_headerScrollView setContentOffset:CGPointMake(_index * 80 - 30, 0)];

}

//顶部item点击事件
-(void)itemButtonClick:(UIButton *)button{
    [_tempButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _tempButton = button;
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self changeBottomLineWithX:button.frame.origin.x];
    
    NSArray *collectionViews =  _mainScrollView.subviews;
    [collectionViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UICollectionView *view = obj;
        //滚动到被点击的按钮对应的collectionview
        if (view.tag == button.tag) {
            [_mainScrollView scrollRectToVisible:view.frame animated:YES];
            *stop = YES;
        }
    }];
    
    _currentShow = button.frame.origin.x / 80;
    [self getDataWith:[_dataArray[_currentShow] cat_id]];
}

//设置collectionview
-(void)setCollectionView:(int)viewTag frame:(CGRect)frame{
    CGRect r = [UIScreen mainScreen].bounds;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake((r.size.width-12)/2, 200);
    flowLayout.minimumLineSpacing = 4;
    flowLayout.minimumInteritemSpacing = 4;
    flowLayout.sectionInset = UIEdgeInsetsMake(0.0f, 4.0f, 0.0f, 4.0f);
    flowLayout.scrollDirection = UICollectionViewScrollPositionCenteredVertically;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.tag = viewTag;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.backgroundColor = COLOR(240, 240, 240, 1);
    [collectionView registerClass:[CategotyListCollectionViewCell class] forCellWithReuseIdentifier:@"categoryCell"];
    [_mainScrollView addSubview:collectionView];
    
    //下拉刷新
    __block CategotyListViewController *mySelf = self;
    [collectionView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        mySelf.page = 0;
        [mySelf getDataWith:[_dataArray[_currentShow] cat_id]];
    }];
    //上拉获取更多
    [collectionView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        mySelf.page ++;
        [mySelf getDataWith:[_dataArray[_currentShow] cat_id]];
    }];
}

//Collection协议方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CategotyListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"categoryCell" forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor greenColor];
    if ([_contentArray[_currentShow] count] > 0) {
        [cell setCellWithModel:_contentArray[_currentShow][indexPath.row]];
    }
    return cell;
}

//Collection个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_contentArray[_currentShow] count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//Collection点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *detailsViewController = [[DetailsViewController alloc]init];
    ShareListModel *model = _contentArray[_currentShow][indexPath.row];
    detailsViewController.shareModel = model;
    [self.navigationController pushViewController:detailsViewController animated:YES];
}

//scrollView结束滚动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point = _mainScrollView.contentOffset;
    CGRect main = [UIScreen mainScreen].bounds;
    NSInteger index = point.x / main.size.width;
    _currentShow = (int)index;
    [_tempButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    UIButton *button = (UIButton *)_headerScrollView.subviews[index];
    _tempButton = button;
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self changeBottomLineWithX:button.frame.origin.x];
    [_headerScrollView scrollRectToVisible:CGRectMake(button.frame.origin.x - 30, 0, main.size.width, 34) animated:YES];
    [self getDataWith:[_dataArray[_currentShow] cat_id]];
}


@end
