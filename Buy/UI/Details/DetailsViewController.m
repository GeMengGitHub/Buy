//
//  DetailsViewController.m
//  Buy
//
//  Created by qf on 15/10/12.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "DetailsViewController.h"
#import "DetailsCollectionReusableView.h"
#import "WebViewController.h"
#import "DetailsCollectionViewCell.h"

@interface DetailsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, DetailsCollectionReusableViewDelegate,UMSocialUIDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIView *bottomView;//底部view
@property (nonatomic, strong) UIButton *likeButton;//喜欢
@property (nonatomic, strong) UIButton *gotoButton;//去购买
@property (nonatomic, strong) NSMutableArray *dataArray;//数据源

@end

@implementation DetailsViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    [self setCollectionView];
    [self setBottomView];
    [self getData];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.tabBarController.tabBar.userInteractionEnabled = YES;
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//获取数据
-(void)getData{
    [NetWoking getPerhapsDataWithShareId:_shareModel.share_id data:^(NSDictionary *dic) {
        if ([dic[@"recommends"] count] > 0) {
            [_dataArray setArray:[ShareListModel setModelWithArray:dic[@"recommends"]]];
            [_collectionView reloadData];
        }
    } err:^{
        
    }];
}


//设置导航栏
-(void)setNavigation{
    //标题
   
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 100, 44);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"详情页";
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
    
    //分享按钮
    UIButton *shareButton = [[UIButton alloc]init];
    shareButton.frame = CGRectMake(0, 0, 44, 44);
    shareButton.tag = 222;
    [shareButton addTarget:self action:@selector(navButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setImage:[UIImage imageNamed:@"icon_share_normal.png"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"icon_share_highlight.png"] forState:UIControlStateHighlighted];
    UIBarButtonItem *shareButtonItem = [[UIBarButtonItem alloc]initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItem = shareButtonItem;
    
    //初始化数据
    _dataArray = [[NSMutableArray alloc]init];
}

-(void)navButtonClick:(UIButton *)button{
    switch (button.tag) {
        case 111: //返回上一页
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        case 222: //分享
        {
            [self shareWithContent:[NSString stringWithFormat:@"%@%@",_shareModel.url,_shareModel.name] title:_shareModel.name image:_shareModel.icon];
        }
            break;
            
        default:
            break;
    }
}

/**
 *  分享
 */
-(void)shareWithContent:(NSString *)content title:(NSString *)title image:(NSString *)image{
    //微信好友分享时显示的标题
    [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
    //QQ好友分享title
    [UMSocialData defaultData].extConfig.qqData.title = title;
    //QQ空间分享title
    [UMSocialData defaultData].extConfig.qzoneData.title = title;
    //图片分享
    if (image) {
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:image];
    }
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UM_APPKEY
                                      shareText:content
                                     shareImage:nil
                                shareToSnsNames:UM_SHARE
                                       delegate:self];
}

/**
 *  设置collectionView
 */
-(void)setCollectionView{
    CGRect r = [UIScreen mainScreen].bounds;
    _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _flowLayout.itemSize = CGSizeMake((r.size.width-12)/2, 200);
    _flowLayout.minimumLineSpacing = 4;
    _flowLayout.minimumInteritemSpacing = 4;
    _flowLayout.sectionInset = UIEdgeInsetsMake(0.0f, 4.0f, 0.0f, 4.0f);
    _flowLayout.headerReferenceSize = CGSizeMake(470.0f, 0.0f);
    _flowLayout.scrollDirection = UICollectionViewScrollPositionCenteredVertically;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, r.size.width, r.size.height - 64 - 50) collectionViewLayout:_flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = COLOR(240, 240, 240, 1);
    [_collectionView registerClass:[DetailsCollectionViewCell class] forCellWithReuseIdentifier:@"PerhapsLikeCell"];
    [_collectionView registerClass:[DetailsCollectionReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    [self.view addSubview:_collectionView];
}

//Collection协议方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PerhapsLikeCell" forIndexPath:indexPath];
    [cell setCellWithModel:_dataArray[indexPath.row]];
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

//Collection HeaderView
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    DetailsCollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor whiteColor];
        reusableView.delegate = self;
        [reusableView setHeaderWithModel:_shareModel];
    }
    return reusableView;
}

//协议方法修改headerView高度
-(void)collectionHeaderViewheight:(CGFloat)height{
    _flowLayout.headerReferenceSize = CGSizeMake(470 + height, 0);
}

/**
 *  底部：我的喜欢、立即购买
 */
-(void)setBottomView{
    CGRect main = [UIScreen mainScreen].bounds;
    _bottomView = [[UIView alloc]init];
    _bottomView.frame = CGRectMake(0, main.size.height-50-64, main.size.width, 50);
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    
    UILabel *topLine = [[UILabel alloc]init];
    topLine.frame = CGRectMake(0, 0, _bottomView.frame.size.width, 1);
    topLine.backgroundColor = COLOR(220, 220, 220, 1);
    [_bottomView addSubview:topLine];
    
    _likeButton = [[UIButton alloc]init];
    _likeButton.frame = CGRectMake(8, 8, (_bottomView.frame.size.width - 34)/2, _bottomView.frame.size.height - 16);
    _likeButton.tag = 101;
    _likeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _likeButton.layer.cornerRadius = 2;
    _likeButton.layer.borderWidth = 1;
    _likeButton.layer.borderColor = [COLOR(65, 181, 55, 1) CGColor];
    _likeButton.backgroundColor = [UIColor whiteColor];
    [_likeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    UIImage *image = [[UIImage imageNamed:@"icon_prise.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_likeButton setImage:image forState:UIControlStateNormal];
    [_likeButton setImageEdgeInsets:UIEdgeInsetsMake(0.0f, -10.0f, 0.0f, 0.0f)];
    //[_likeButton setTitle:_shareModel.like forState:UIControlStateNormal];
    BOOL result = [DBManager collectionWithModel:_shareModel];
    if (result) {
        _likeButton.tintColor = COLOR(65, 181, 55, 1);
        [_likeButton setTitleColor:COLOR(65, 181, 55, 1) forState:UIControlStateNormal];
        [_likeButton setTitle:@"已收藏" forState:UIControlStateNormal];
    } else {
        _likeButton.tintColor = [UIColor grayColor];
        [_likeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_likeButton setTitle:@"未收藏" forState:UIControlStateNormal];
    }
    [_likeButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_likeButton];
    
    
    _gotoButton = [[UIButton alloc]init];
    _gotoButton.frame = CGRectMake(_bottomView.frame.size.width -
                                   _likeButton.frame.size.width -
                                   _likeButton.frame.origin.x - 10, 8, (_bottomView.frame.size.width - 34)/2, _bottomView.frame.size.height - 16);
    _gotoButton.tag = 102;
    _gotoButton.titleLabel.font = [UIFont systemFontOfSize:16];
    _gotoButton.layer.cornerRadius = 2;
    _gotoButton.backgroundColor = COLOR(65, 181, 55, 1);
    [_gotoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_gotoButton setTitle:@"立即购买" forState:UIControlStateNormal];
    [_gotoButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_gotoButton];
}

//底部按钮点击事件
-(void)bottomButtonClick:(UIButton *)button{
    switch (button.tag) {
        case 101:
        {
            [DBManager collectionWithModel:_shareModel insert:^{
                [_likeButton setTitle:@"已收藏" forState:UIControlStateNormal];
                _likeButton.tintColor = COLOR(65, 181, 55, 1);
                [_likeButton setTitleColor:COLOR(65, 181, 55, 1) forState:UIControlStateNormal];
            } delete:^{
                [_likeButton setTitle:@"未收藏" forState:UIControlStateNormal];
                _likeButton.tintColor = [UIColor grayColor];
                [_likeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }];
        }
            break;
            
        case 102:
        {
            WebViewController *webView = [[WebViewController alloc]init];
            webView.myTitle = _shareModel.source_title;
            webView.url = _shareModel.url;
            [self.navigationController pushViewController:webView animated:YES];
        }
            break;
            
        default:
            break;
    }
}

//百度百科点击事件
-(void)DetailsCollectionReusableViewDidselectedButton:(UIButton *)button{
    WebViewController *webView = [[WebViewController alloc]init];
    webView.showShareButton = YES;
    webView.myTitle = @"百度百科";
    webView.url = _shareModel.baike_url;
    [self.navigationController pushViewController:webView animated:YES];
}

/**
 *  弹出列表方法presentSnsIconSheetView需要设置delegate为self
 *
 *  @return
 */
//-(BOOL)isDirectShareInIconActionSheet
//{
//    return YES;
//}

/**
 *  分享完成时执行的回调
 *
 *  @param response 
 */
//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    //根据`responseCode`得到发送结果,如果分享成功
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        //得到分享到的微博平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//    }
//}

@end
