//
//  CSCWebViewController.h
//  RAP APP
//
//  Created by Anil Prasad on 6/16/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSCWebViewController : UIViewController
{
    
    __weak IBOutlet UIWebView *mWebview;
    __weak IBOutlet UIButton *btn_next;
    __weak IBOutlet UIButton *btn_back;
    
    IBOutlet UIProgressView *progressBar;
}
- (IBAction)actionCloseWebview:(id)sender;
@end
