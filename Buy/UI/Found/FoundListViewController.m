//
//  FoundListViewController.m
//  Buy
//
//  Created by qf on 15/10/16.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "FoundListViewController.h"
#import "HomeCollectionViewCell.h"
#import "DetailsViewController.h"

@interface FoundListViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *dataArray;//数据源
@property (nonatomic, assign) int page;//当前页

@end

@implementation FoundListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setInit];
    [self setNavigation];
    [self getData];
    [self setCollectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//初始化
-(void)setInit{
    _dataArray = [[NSMutableArray alloc]init];
    _page = 0;
}

//获取数据
-(void)getData{
    if (!_model) return;
    [NetWoking getFoundListDataWith:_page cat_id:_model.parent_id category_id:_model.cat_id price_filter:@"" data:^(NSDictionary *dic) {
        if ([dic[@"shareList"] count] > 0) {
            if (_page == 0) {
                [_dataArray setArray:[ShareListModel setModelWithArray:dic[@"shareList"]]];
            } else {
                NSArray *array = [ShareListModel setModelWithArray:dic[@"shareList"]];
                for (ShareListModel *model in array) {
                    [_dataArray addObject:model];
                }
            }
        }
        
        //收起下拉刷新
        [_collectionView headerEndRefreshingWithResult:JHRefreshResultSuccess];
        //收起上拉加载更多
        [_collectionView footerEndRefreshing];
        //刷新页面
        [_collectionView reloadData];
        [AlertManager dismiss];
        
    } err:^{
        //收起下拉刷新
        [_collectionView headerEndRefreshingWithResult:JHRefreshResultSuccess];
        //收起上拉加载更多
        [_collectionView footerEndRefreshing];
        [AlertManager dismiss];
    }];
}

//设置navigation
-(void)setNavigation{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 20, 100, 44);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = _model.name;
    self.navigationItem.titleView = titleLabel;
    //返回按钮
    UIButton *backButton = [[UIButton alloc]init];
    backButton.frame = CGRectMake(0, 0, 44, 44);
    [backButton addTarget:self action:@selector(navButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *backImage = [[UIImage imageNamed:@"black_back.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    backButton.tintColor = [UIColor whiteColor];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton setImage:backImage forState:UIControlStateHighlighted];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

//返回上一页
-(void)navButtonClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

//设置collectionView
-(void)setCollectionView{
    CGRect r = [UIScreen mainScreen].bounds;
    _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _flowLayout.itemSize = CGSizeMake((r.size.width-12)/2, 200);
    _flowLayout.minimumLineSpacing = 4;
    _flowLayout.minimumInteritemSpacing = 4;
    _flowLayout.sectionInset = UIEdgeInsetsMake(0.0f, 4.0f, 0.0f, 4.0f);
    _flowLayout.scrollDirection = UICollectionViewScrollPositionCenteredVertically;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, r.size.width, r.size.height - 64 - 49) collectionViewLayout:_flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = COLOR(240, 240, 240, 1);
    [_collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"homeCell"];
    [self.view addSubview:_collectionView];
    
    //下拉刷新
    __block FoundListViewController *mySelf = self;
    [_collectionView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        mySelf.page = 0;
        [mySelf getData];
    }];
    
    //上拉获取更多
    [_collectionView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        mySelf.page ++;
        [mySelf getData];
    }];
    
    //显示滚动
    [AlertManager showForView:self.view show:NO];
}

//Collection协议方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell" forIndexPath:indexPath];
    if (_dataArray.count > 0) {
        [cell setCellWithModel:_dataArray[indexPath.row]];
    }
    return cell;
}

//Collection个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//Collection点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *detailsViewController = [[DetailsViewController alloc]init];
    detailsViewController.shareModel = _dataArray[indexPath.row];
    [self.navigationController pushViewController:detailsViewController animated:YES];
}

@end
