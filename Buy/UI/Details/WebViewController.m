//
//  WebViewController.m
//  Buy
//
//  Created by qf on 15/10/12.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate,UMSocialUIDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *activity;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UITapGestureRecognizer *tap;// 单点手势

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    [self netLinsting];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name: UIKeyboardWillShowNotification object:nil];
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
        [self setWebView];
    }];
}

/**
 *  重新加载
 */
-(void)reLoad{
    [self netLinsting];
}

/**
 *  设置导航
 */
-(void)setNavigation{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.navigationController.navigationBar addSubview:_activity];
    self.navigationItem.titleView = _activity;
    [_activity startAnimating];
    
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
    _shareButton = [[UIButton alloc]init];
    _shareButton.hidden = YES;
    _shareButton.frame = CGRectMake(0, 0, 44, 44);
    _shareButton.tag = 222;
    [_shareButton addTarget:self action:@selector(navButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_shareButton setImage:[UIImage imageNamed:@"icon_share_normal.png"] forState:UIControlStateNormal];
    [_shareButton setImage:[UIImage imageNamed:@"icon_share_highlight.png"] forState:UIControlStateHighlighted];
    UIBarButtonItem *shareButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_shareButton];
    self.navigationItem.rightBarButtonItem = shareButtonItem;
}

-(void)navButtonClick:(UIButton *)button{
    switch (button.tag) {
        case 111:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        case 222:
        {
            [self shareWithContent:[NSString stringWithFormat:@"%@%@",_url,_myTitle] title:_myTitle image:nil];
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
 *  设置WebView
 */
-(void)setWebView{
    CGRect r = [UIScreen mainScreen].bounds;
    _webView = [[UIWebView alloc]init];
    _webView.frame = CGRectMake(0, 0, r.size.width, r.size.height - 64);
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    //关闭弹簧
    [[_webView subviews][0] setBounces:NO];
    _webView.keyboardDisplayRequiresUserAction = NO;
    _webView.delegate = self;
    [self.view addSubview:_webView];
}

-(void)keyboardWillShow:(NSNotification *)notification{
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [_activity removeFromSuperview];
    //标题
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, 0, 100, 44);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = _myTitle;
    self.navigationItem.titleView = titleLabel;
    
    if (_showShareButton) {
        _shareButton.hidden = NO;
    } else {
        _shareButton.hidden = YES;
    }
}




@end
