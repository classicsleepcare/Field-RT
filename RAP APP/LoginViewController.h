//
//  LoginViewController.h
//  RAP APP
//
//  Created by Anil Prasad on 4/5/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface LoginViewController : UIViewController<UITextFieldDelegate>

{
    IBOutlet UITextField *txt_username;
    IBOutlet UITextField *txt_password;
    BOOL isLoginValid;
    IBOutlet UISwitch *btn_switch;
    IBOutlet UIButton *btn_remember;

}
-(IBAction)login_method:(id)sender;
//-(IBAction)action_switch:(id)sender;

-(IBAction)rememberMe:(UIButton*)sender;

- (IBAction)go:(id)sender;

@end
