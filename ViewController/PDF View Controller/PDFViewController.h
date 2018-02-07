//
//  PDFViewController.h
//  RAP APP
//
//  Created by Anil Prasad on 4/23/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OperationMarketingPDF.h"

@interface PDFViewController : UIViewController<UIWebViewDelegate, OperationMarketingPDFDelegate, NSURLSessionDelegate>
{
    __weak IBOutlet UIWebView *web_view;
    __weak IBOutlet UILabel *lbl_title;
    CGRect framePDF;
}
@property(nonatomic,weak)UIViewController *previewController;
@property (nonatomic, strong)NSString *str_pdf, *str_pdfName;
-(IBAction)action_Back:(id)sender;

@property (nonatomic) BOOL isPrivacyPolicy;
@property (nonatomic) BOOL isDMEPOS;


@end
