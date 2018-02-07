//
//  PDFViewController.m
//  RAP APP
//
//  Created by Anil Prasad on 4/23/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "PDFViewController.h"

#import "HistoryViewController.h"
#import "PatientViewController.h"
#import "AppDelegate.h"

@interface PDFViewController ()

{
    NSString *tempURL;
}
@end

@implementation PDFViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

#pragma mark -


-(void)DidCompleteWithIndex:(NSIndexPath *)indexPath
                    andData:(NSData *)data
{
    
    
    NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString  *documentsDirectory = [paths objectAtIndex:0];
    
    NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,[_str_pdf lastPathComponent]];
    [data writeToFile:filePath atomically:YES];
    NSLog(@"filePath: %@", filePath);
    NSLog(@"File Saved !");
    NSURL *url = [NSURL URLWithString:[filePath stringByAddingPercentEscapesUsingEncoding:4]];
    
    
    NSURLRequest *request= [NSURLRequest requestWithURL:url];
    [web_view loadRequest:request];
    
}

-(void)loadPDF{
    [[AppDelegate sharedInstance] showCustomLoader:self];

    OperationMarketingPDF *operation = [[OperationMarketingPDF alloc] init];
    operation.delegate = self;
    //operation.name = @"";
    operation.indexPath = 0;
    operation.urlStr = _str_pdf;
    
    if ([[[NSOperationQueue currentQueue] operations] count] >=1)
    {
        [operation addDependency:[NSOperationQueue currentQueue].operations[[NSOperationQueue currentQueue].operations.count - 1]];
    }
    
    [[NSOperationQueue currentQueue] addOperation:operation];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(_str_pdfName) lbl_title.text = _str_pdfName;
//    NSURL *url = [NSURL URLWithString:[_str_pdf stringByAddingPercentEscapesUsingEncoding:4]];
//    NSURLRequest *request= [NSURLRequest requestWithURL:url];
//    [web_view loadRequest:request];
    

    //tempURL = @"http://www.catalyst.org/uploads/annual_report_2012.pdf";
//    tempURL = @"http://209.160.65.49:1012/test/72765/Preauth/Singer, Genevieve preauth1.pdf";


    if (self.isPrivacyPolicy) {
        NSString *urlPath = [[NSBundle mainBundle] pathForResource:@"Setup ticket additions" ofType:@"pdf"];
        NSURL *url = [NSURL fileURLWithPath:urlPath];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [web_view loadRequest:urlRequest];
    }
    else if (self.isDMEPOS) {
        NSString *urlPath = [[NSBundle mainBundle] pathForResource:@"DMEPOS" ofType:@"pdf"];
        NSURL *url = [NSURL fileURLWithPath:urlPath];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [web_view loadRequest:urlRequest];
    }
    else{
        [self loadPDF];
        /*
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", [_str_pdf lastPathComponent]] ofType:@"pdf"];
        NSURL *url = [NSURL fileURLWithPath:path];
        
        NSURLRequest *request= [NSURLRequest requestWithURL:url];
        [web_view loadRequest:request];
         */
    }
}

- (void)deleteFile:(NSString *)fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
    if (success) {
        NSLog(@"Deleted file: %@ ",[error localizedDescription]);
    }
    else
    {
        NSLog(@"Could not delete file: %@ ",[error localizedDescription]);
    }
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
   
    [[AppDelegate sharedInstance] showCustomLoader:self];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [[AppDelegate sharedInstance] removeCustomLoader];
    [self deleteFile:[_str_pdf lastPathComponent]];
   
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[AppDelegate sharedInstance] removeCustomLoader];
    [self deleteFile:[_str_pdf lastPathComponent]];
    NSLog(@"errrrrr-------%@",error);
}

-(void)action_Back:(id)sender
{
    
//    if ([[self.navigationController.viewControllers firstObject] isKindOfClass:[HistoryViewController class]])
//    {
//      [self.navigationController popToViewController:[[self.navigationController viewControllers]objectAtIndex:1] animated:YES];
//    }
//    else if([[self.navigationController.viewControllers firstObject] isKindOfClass:[PatientViewController class]])
//    {
//        [self.navigationController popToViewController:[[self.navigationController viewControllers]objectAtIndex:2] animated:YES];
//    }
//    else{
//         [self.navigationController popToViewController:[[self.navigationController viewControllers]objectAtIndex:3] animated:YES];
//    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
