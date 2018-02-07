//
//  ChangePWD.h
//  RAP APP
//
//  Created by prashant sharma on 9/4/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePWD : UIViewController<UIAlertViewDelegate,UITextFieldDelegate>
{
    
    __weak IBOutlet UITextField *txt_OldPwd;
    
    __weak IBOutlet UITextField *txt_NewPwd;
    
    __weak IBOutlet UITextField *txt_ConfirmPwd;
    
    
    __weak IBOutlet UIButton *btn_GO;
    
}

@property(nonatomic,strong)NSString * StrtitleName;
- (IBAction)actionGo:(UIButton *)sender;








@end
