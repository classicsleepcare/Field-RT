//
//  CSCWebViewController.m
//  RAP APP
//
//  Created by Anil Prasad on 6/16/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "CSCWebViewController.h"

@interface CSCWebViewController ()<UIWebViewDelegate>

@end

static float progressValue = 0.0;

@implementation CSCWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [btn_back addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [btn_next addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
    //close_btn.png
    
    NSString *url=@"http://www.classicsleepcare.com";
    NSURL *nsurl=[NSURL URLWithString:url];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [mWebview loadRequest:nsrequest];
    
    mWebview.scalesPageToFit=YES;
    
    progressBar.progress = 0.0;
    
    
}


-(void)goBack
{
    progressValue = 0.0;
    [mWebview goBack];
    
}
-(void)goNext
{
    progressValue = 0.0;
    [mWebview goForward];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    progressBar.hidden = NO;
    
    
    if(progressValue>=1) progressValue = 0.0;
    progressValue+=0.2;
    
    
    [progressBar setProgress:progressValue animated:YES];
    
    [UIApplication sharedApplication].NetworkActivityIndicatorVisible =YES ;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    progressValue = 1.0;
    [progressBar setProgress:2.0 animated:YES];
    
    
    [UIApplication sharedApplication].NetworkActivityIndicatorVisible =NO ;
    
    
    progressBar.hidden = YES;
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionCloseWebview:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
