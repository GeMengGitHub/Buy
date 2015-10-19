//
//  FoundViewController.m
//  Buy
//
//  Created by qf on 15/10/9.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "FoundViewController.h"
#import "DetailsViewController.h"
#import "FoundCatListModel.h"
#import "FoundSubListModel.h"
#import "FoundHeaderCollectionReusableView.h"
#import "FoundCollectionViewCell.h"
#import "FoundListViewController.h"

@interface FoundViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *dataArray;//数据源
@property (nonatomic, strong) UITapGestureRecognizer *tap;//单点手势

@end

@implementation FoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    [self setInit];
    [self netLinsting];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  网络监听
 */
-(void)netLinsting{
    [NetWoking netWokListeningWithOffTheNetForView:self.view off:^{
        if (!_tap) {
            _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reLoad)];
            [self.view addGestureRecognizer:_tap];
        }
        
    } on:^{
        [self.view removeGestureRecognizer:_tap];
        [self getData];
        [self setCollectionView];
        
    }];
}

/**
 *  重新加载
 */
-(void)reLoad{
    [self netLinsting];
}

//设置导航
-(void)setNavigation{
    //设置navigation
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 20, 100, 44);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"发现";
    self.navigationItem.titleView = titleLabel;
}

//初始化
-(void)setInit{
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [[NSMutableArray alloc]init];
}

//获取数据
-(void)getData{
    [NetWoking getFoundData:^(NSDictionary *dic) {
        if ([dic[@"catList"] count] > 0) {
            [_dataArray setArray:[FoundCatListModel setModelWithArray:dic[@"catList"]]];
            [_collectionView reloadData];
        }
    } err:^{
        
    }];
}

//设置 Collection View
-(void)setCollectionView{
    CGRect r = [UIScreen mainScreen].bounds;
    _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _flowLayout.itemSize = CGSizeMake(90, 90);
    _flowLayout.minimumLineSpacing = (r.size.width - 270) / 4;
    _flowLayout.minimumInteritemSpacing = (r.size.width - 270) / 4;
    _flowLayout.sectionInset = UIEdgeInsetsMake(0.0f, (r.size.width - 270) / 4, 0.0f, (r.size.width - 270) / 4);
    _flowLayout.headerReferenceSize = CGSizeMake(40.0f, 0.0f);
    _flowLayout.scrollDirection = UICollectionViewScrollPositionCenteredVertically;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, r.size.width, r.size.height - 64 - 49) collectionViewLayout:_flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[FoundCollectionViewCell class] forCellWithReuseIdentifier:@"foundCell"];
    [_collectionView registerClass:[FoundHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    [self.view addSubview:_collectionView];
}

//Collection协议方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FoundCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"foundCell" forIndexPath:indexPath];
    FoundCatListModel *model = _dataArray[indexPath.section];
    [cell setCellWithModel:model.subList[indexPath.row]];
    return cell;
}

//Collection个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    FoundCatListModel *model = _dataArray[section];
    return model.subList.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _dataArray.count;
}

//Collection点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FoundCatListModel *model = _dataArray[indexPath.section];
    FoundListViewController *foundListViewController = [[FoundListViewController alloc]init];
    foundListViewController.model = model.subList[indexPath.row];
    [self.navigationController pushViewController:foundListViewController animated:YES];
}

//Collection section HeaderView
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    FoundHeaderCollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
    }
    FoundCatListModel *model = _dataArray[indexPath.section];
    [reusableView setTitleWith:model.name];

    return reusableView;
}


@end
