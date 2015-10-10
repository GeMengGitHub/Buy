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

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *adArray;//滚动广告图
@property (nonatomic, strong) NSArray *menuArray;//菜单按钮
@property (nonatomic, strong) NSMutableArray *dataArray;//列表数据

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setInit];
    [self getData];
    [self setCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    UIButton * searchButton = [[UIButton alloc]init];
    searchButton.frame = CGRectMake(0, 0, 24, 24);
    searchButton.tintColor = [UIColor whiteColor];
    UIImage *image = [[UIImage imageNamed:@"homeViewSearch_icon.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [searchButton setImage:image forState:UIControlStateNormal];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:searchButton];
    self.navigationItem.rightBarButtonItem = barButton;

    _dataArray = [[NSMutableArray alloc]init];
}

//获取数据
-(void)getData{
    [NetWoking getHomeData:^(NSDictionary *dic) {
        NSLog(@"%@", dic);
        _adArray = [BannerListModel setModelWithArray:dic[@"bannerList"]];
        _menuArray = [CategoryListModel setModelWithArray:dic[@"categoryList"]];
        [_dataArray setArray:[ShareListModel setModelWithArray:dic[@"shareList"]]];
        [_collectionView reloadData];
    } err:^{
        
    }];
}

//设置collectionView
-(void)setCollectionView{
    CGRect r = [UIScreen mainScreen].bounds;
    _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _flowLayout.itemSize = CGSizeMake((r.size.width-12)/2, 160);
    _flowLayout.minimumLineSpacing = 4;
    _flowLayout.minimumInteritemSpacing = 4;
    _flowLayout.sectionInset = UIEdgeInsetsMake(0.0f, 4.0f, 0.0f, 4.0f);
    _flowLayout.headerReferenceSize = CGSizeMake(r.size.width, 0.0f);
    _flowLayout.scrollDirection = UICollectionViewScrollPositionCenteredVertically;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, r.size.width, r.size.height - 64 - 49) collectionViewLayout:_flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = COLOR(240, 240, 240, 1);
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"homeCell"];
    [_collectionView registerClass:[HeaderCollectionReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    [self.view addSubview:_collectionView];
}

//Collection协议方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
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
    
}

//Collection HeaderView
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    HeaderCollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
         reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
    }
    if (_adArray.count > 0) {
        [reusableView setScrollViewWithArray:_adArray];
    }
    if (_menuArray.count > 0) {
        [reusableView setMenuWithArray:_menuArray];
    }
    [reusableView setCellHeader];
    return reusableView;
}

@end
