//
//  HomeViewController.m
//  Buy
//
//  Created by qf on 15/10/9.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "HomeViewController.h"
#import "HeaderCollectionReusableView.h"
#import "BannerListModel.h"
#import "CategoryListModel.h"
#import "ShareListModel.h"
#import "HomeCollectionViewCell.h"
#import "DetailsViewController.h"
#import "MenuDataListViewController.h"

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,HeaderCollectionReusableViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *adArray;//滚动广告图
@property (nonatomic, strong) NSArray *menuArray;//菜单按钮
@property (nonatomic, strong) NSMutableArray *dataArray;//列表数据
@property (nonatomic, assign) int page;//第几页
@property (nonatomic, strong) UIButton *topButton;//返回顶部
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setInit];
    [self setCollectionView];
    [self setScrollViewTopView];
    [self getLocalData];
    [self getData];
    //[self netLinstening];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)netLinstening{
    [NetWoking netWokListeningWithOffTheNetForView:self.view off:^{
        if (!_tap) {
            _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reLoadView)];
            [self.view addGestureRecognizer:_tap];
        }
        
    } on:^{
        [self.view removeGestureRecognizer:_tap];
        
        
    }];
}

-(void)reLoadView{
    [self netLinstening];
}

//初始化
-(void)setInit{
    self.view.backgroundColor = [UIColor whiteColor];
    //设置navigation
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 20, 100, 44);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"首页";
    self.navigationItem.titleView = titleLabel;
    //搜索按钮
//    UIButton * searchButton = [[UIButton alloc]init];
//    searchButton.frame = CGRectMake(0, 0, 24, 24);
//    searchButton.tintColor = [UIColor whiteColor];
//    UIImage *image = [[UIImage imageNamed:@"homeViewSearch_icon.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [searchButton setImage:image forState:UIControlStateNormal];
//    [searchButton setImage:image forState:UIControlStateHighlighted];
//    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:searchButton];
//    self.navigationItem.rightBarButtonItem = barButton;

    _dataArray = [[NSMutableArray alloc]init];
    _page = 0;
}

//获取数据
-(void)getData{
    
    [NetWoking getHomeDataWithPage:_page data:^(NSDictionary *dic) {
        if ([dic[@"bannerList"] count] > 0) {
            _adArray = [BannerListModel setModelWithArray:dic[@"bannerList"]];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [DBManager writeBannerListWithArray:_adArray];
            });
        }
        if ([dic[@"categoryList"] count] > 0) {
            _menuArray = [CategoryListModel setModelWithArray:dic[@"categoryList"]];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [DBManager writeCategoryListWithArray:_menuArray];
            });
        }
        if ([dic[@"shareList"] count] > 0) {
            if (_page == 0) {
                [_dataArray setArray:[ShareListModel setModelWithArray:dic[@"shareList"]]];
            } else {
                NSArray *array = [ShareListModel setModelWithArray:dic[@"shareList"]];
                for (ShareListModel *model in array) {
                    [_dataArray addObject:model];
                }
            }
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [DBManager writeShareListWithArray:_dataArray];
            });
        }
        
        //收起下拉刷新
        [_collectionView headerEndRefreshingWithResult:JHRefreshResultSuccess];
        //收起上拉加载更多
        [_collectionView footerEndRefreshing];
        //刷新页面
        [_collectionView reloadData];
        
    } err:^{
        //收起下拉刷新
        [_collectionView headerEndRefreshingWithResult:JHRefreshResultSuccess];
        //收起上拉加载更多
        [_collectionView footerEndRefreshing];
    }];
}

//获取本地数据
-(void)getLocalData{
    _adArray = [BannerListModel setModelWithArray:[DBManager readBannerListWithWhere:nil]];
    if (_adArray.count > 0) {
        [_collectionView reloadData];
    }
    
    _menuArray = [CategoryListModel setModelWithArray:[DBManager readCategoryListWithWhere:nil]];
    if (_menuArray.count > 0) {
        [_collectionView reloadData];
    }
    
    [_dataArray setArray:[ShareListModel setModelWithArray:[DBManager readShareListWithWhere:nil]]];
    if (_dataArray.count > 0) {
        [_collectionView reloadData];
    }
}

//设置collectionView
-(void)setCollectionView{
    CGRect r = [UIScreen mainScreen].bounds;
    _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _flowLayout.itemSize = CGSizeMake((r.size.width-12)/2, 200);
    _flowLayout.minimumLineSpacing = 4;
    _flowLayout.minimumInteritemSpacing = 4;
    _flowLayout.sectionInset = UIEdgeInsetsMake(0.0f, 4.0f, 0.0f, 4.0f);
    _flowLayout.headerReferenceSize = CGSizeMake(320.0f, 0.0f);
    _flowLayout.scrollDirection = UICollectionViewScrollPositionCenteredVertically;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, r.size.width, r.size.height - 64 - 49) collectionViewLayout:_flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = COLOR(240, 240, 240, 1);
    [_collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"homeCell"];
    [_collectionView registerClass:[HeaderCollectionReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    [self.view addSubview:_collectionView];
    
    //下拉刷新
    __block HomeViewController *mySelf = self;
    [_collectionView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        mySelf.page = 0;
        [mySelf getData];
    }];
    
    //上拉获取更多
    [_collectionView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        mySelf.page ++;
        [mySelf getData];
    }];

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
    ShareListModel *model = _dataArray[indexPath.row];
    detailsViewController.shareModel = model;
    [self.navigationController pushViewController:detailsViewController animated:YES];
}

//Collection HeaderView
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    HeaderCollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
         reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
    }
    reusableView.delegate = self;
    if (_adArray.count > 0) {
        [reusableView setScrollViewWithArray:_adArray];
    }
    if (_menuArray.count > 0) {
        [reusableView setMenuWithArray:_menuArray];
    }
    [reusableView setCellHeader];
    return reusableView;
}

//设置返回顶部的按钮
-(void)setScrollViewTopView{
    _topButton = [[UIButton alloc]init];
    _topButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_topButton setBackgroundImage:[UIImage imageNamed:@"scroll_top.png"] forState:UIControlStateNormal];
    _topButton.layer.cornerRadius = 18;
    _topButton.layer.masksToBounds = YES;
    _topButton.alpha = 0.9;
    _topButton.hidden = YES;
    [_topButton addTarget:self action:@selector(scrollTop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topButton];
    [self.view bringSubviewToFront:_topButton];
    
    NSArray *topArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_topButton(36)]-10-|" options:0 metrics:nil views:@{@"_topButton":_topButton}];
    [self.view addConstraints:topArray];
    topArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_topButton(36)]-10-|" options:0 metrics:nil views:@{@"_topButton":_topButton}];
    [self.view addConstraints:topArray];
}

//滚动监听
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > [UIScreen mainScreen].bounds.size.height) {
        _topButton.hidden = NO;
    } else {
        _topButton.hidden = YES;
    }
}

//返回顶部按钮点击事件
-(void)scrollTop{
    [_collectionView scrollRectToVisible:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) animated:YES];
}

//HeaderCollectionReusableView协议方法（菜单按钮、滚动图片点击事件）
-(void)didSelectedMenu:(CategoryListModel *)model index:(NSInteger)index{
    NSLog(@"%@", model.cat_id);
    
    MenuDataListViewController *vc = [[MenuDataListViewController alloc]init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
//    switch (index) {
//        case 0: // 天天特价
//        {
//            MenuDataListViewController *vc = [[MenuDataListViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//            
//        case 1: // 禾禾有礼
//        {
//            
//        }
//            break;
//            
//        case 2: // 进口优选
//        {
//            
//        }
//            break;
//            
//        case 3: // 坚果零食
//        {
//            
//        }
//            break;
//            
//        case 4: // 滋补养生
//        {
//            
//        }
//            break;
//            
//        case 5: // 风味特产
//        {
//            
//        }
//            break;
//            
//        case 6: // 名茶名饮
//        {
//            
//        }
//            break;
//            
//        case 7: // 百宝箱
//        {
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
}

/**
 *  滚动图片点击
 *
 *  @param index 被点击的是第几个图片
 */
-(void)didSelectedScrollView:(NSInteger)index{
    
}


@end
