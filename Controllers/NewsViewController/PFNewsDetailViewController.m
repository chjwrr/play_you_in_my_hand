//
//  NewsDetailViewController.m
//  ModelProduct
//
//  Created by chj on 16/1/29.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "PFNewsDetailViewController.h"

@interface PFNewsDetailViewController ()<UIWebViewDelegate>{
    BOOL isloadURL;
}

@end

@implementation PFNewsDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"详情";

}

- (void)initSubViews {
    
    [self initLeftNavigationBarButtonWithImage:@"PF_back"];
    
    UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-kSTATUSBAR_HEIGHT-kNAVIGATIONBAR_HEIGHT)];
    [self.view addSubview:webview];
    webview.delegate=self;
    webview.scrollView.backgroundColor=[UIColor whiteColor];
    webview.backgroundColor=[UIColor whiteColor];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:_detailURL]];
    
    [webview loadRequest:request];
    
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[PFProgressHUB shareInstance] show];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[PFProgressHUB shareInstance] dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (error) {
        if (isloadURL) {
            [[PFProgressHUB shareInstance] dismiss];
        }else
            [[PFProgressHUB shareInstance] showWithContent:@"网页加载出错,请重试"];
    }else
        [[PFProgressHUB shareInstance] dismiss];
}
- (BOOL)webView:(UIWebView *)wv shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    // Determine if we want the system to handle it.
    NSURL *url = request.URL;
    if (![url.scheme isEqual:@"http"] && ![url.scheme isEqual:@"https"]) {
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            //[[UIApplication sharedApplication]openURL:url];
            isloadURL=YES;
            return NO;
        }
    }
    isloadURL=NO;
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
