//
//  WebViewController.m
//  baseFramework
//
//  Created by chenangel on 16/7/4.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "WebViewController.h"
#import "LoadProgressAnimationView.h"

@interface WebViewController()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,copy)NSString *urlStr;
@property(nonatomic,strong)LoadProgressAnimationView *loadProgressAnimationView;

@end
@implementation WebViewController
-(UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc]init];
    }
    return _webView;
}
-(LoadProgressAnimationView*)loadProgressAnimationView{
    if (_loadProgressAnimationView == nil) {
        _loadProgressAnimationView = [[LoadProgressAnimationView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 3)];
        _loadProgressAnimationView.backgroundColor = [UIColor orangeColor];
    }
    return _loadProgressAnimationView;
}
//XIB加载的情况
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self.view addSubview:self.webView];
        [self.webView addSubview:self.loadProgressAnimationView];
    }
    return self;
}

-(instancetype)initWithNavTitle:(NSString*)navigationTitle urlStr:(NSString*)urlStr{
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.navigationItem.title = navigationTitle;
        self.urlStr = urlStr;
        [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]]];
    }
    return self;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    [self buildRightItemButton];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:249 green:250 blue:253 alpha:1.0];
}
- (void)buildRightItemButton{
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [rightButton setImage:[UIImage imageNamed:@"v2_refresh"] forState:UIControlStateNormal];
    rightButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -53);
    [rightButton addTarget:self action:@selector(refreshClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}
- (void)refreshClick{
    if (self.urlStr != nil && self.urlStr.length > 0) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.loadProgressAnimationView startLoadProgressAnimation];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.loadProgressAnimationView endLoadProgressAnimation];
}

@end
