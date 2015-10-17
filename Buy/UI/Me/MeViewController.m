//
//  MeViewController.m
//  Buy
//
//  Created by qf on 15/10/9.
//  Copyright (c) 2015年 Chakery. All rights reserved.
//

#import "MeViewController.h"
#import "MeTableViewCell.h"
#import "WebViewController.h"

@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    [self setInit];
    [self setTableView];
}

-(void)viewWillAppear:(BOOL)animated{
    if (_tableView) {
        [_tableView reloadData];
    }
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
    titleLabel.text = @"我的";
    self.navigationItem.titleView = titleLabel;
}

//初始化
-(void)setInit{
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [[NSMutableArray alloc]init];
    [_dataArray addObject:@{@"image":@"icon_like.png",@"name":@"我喜欢的"}];
    [_dataArray addObject:@{@"image":@"icon_taobao.png",@"name":@"淘宝订单"}];
    [_dataArray addObject:@{@"image":@"icon_jingdong.png",@"name":@"京东订单"}];
    [_dataArray addObject:@{@"image":@"icon_feedback.png",@"name":@"意见反馈"}];
    [_dataArray addObject:@{@"image":@"icon_cleanCache.png",@"name":@"清空缓存"}];
    [_dataArray addObject:@{@"image":@"icon_about.png",@"name":@"检查更新"}];
}

//设置tableView
-(void)setTableView{
    _tableView = [[UITableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.backgroundColor = COLOR(240, 240, 240, 1);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    NSArray *layout = nil;
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_tableView]-0-|" options:0 metrics:nil views:@{@"_tableView":_tableView}];
    [self.view addConstraints:layout];
    layout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_tableView]-0-|" options:0 metrics:nil views:@{@"_tableView":_tableView}];
    [self.view addConstraints:layout];
}

//tableview协议
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"meCell"];
    if (!cell) {
        cell = [[MeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"meCell"];
    }
    [cell setCellWithDic:_dataArray[indexPath.section] withIndex:indexPath.section];
    return cell;
}

//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

//组头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, self.view.frame.size.width, 14);
    view.backgroundColor = COLOR(240, 240, 240, 1);
    return view;
}

//组高
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 14;
}

//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            [AlertManager showForView:self.view show:NO];
            WebViewController *web = [[WebViewController alloc]init];
            web.myTitle = @"我的淘宝";
            web.url = API_TAOBAO;
            web.showShareButton = NO;
            [self.navigationController pushViewController:web animated:YES];
            [AlertManager dismiss];
        }
            break;
        case 2:
        {
            [AlertManager showForView:self.view show:NO];
            WebViewController *web = [[WebViewController alloc]init];
            web.myTitle = @"我的京东";
            web.url = API_JINGDONG;
            web.showShareButton = NO;
            [self.navigationController pushViewController:web animated:YES];
            [AlertManager dismiss];
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"清空缓存后可能对程序造成卡顿。\n确定清空吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"清空", nil];
            view.tag = 999;
            [view show];
        }
            break;
        case 5:
        {
            [AlertManager showForView:self.view show:NO];
            [self updateVersion];
        }
            break;
        default:
            break;
    }
}

//提示框
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1 && alertView.tag == 999) {
        [CacheManager clearCache];
        [_tableView reloadData];
    }
}

//检查新版本
-(void)updateVersion{
    [NetWoking getVersion:^(NSString *str) {
        [AlertManager dismiss];
        
        //获取app当前版本号
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        float v1 = version.floatValue;
        float v2 = str.floatValue;
        if (v2 > v1) {
           UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"版本提示" message:@"发现新版本！" delegate:self cancelButtonTitle:@"下次提醒" otherButtonTitles:@"现在更新", nil];
            view.tag = 888;
            [view show];
        } else {
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"版本提示" message:@"当前已是最新版本！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            view.tag = 888;
            [view show];
        }
    }];
}

//提示框 itms-apps://itunes.apple.com/app/id1044488392
-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1 && alertView.tag == 888) {
        NSString * url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/%@", APP_STORE_ID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

//loading

@end
