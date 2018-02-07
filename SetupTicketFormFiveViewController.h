//
//  SetupTicketFormFiveViewController.h
//  RT APP
//
//  Created by Anil Prasad on 29/06/16.
//  Copyright © 2016 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"

@interface SetupTicketFormFiveViewController : UIViewController

{
    __weak IBOutlet UIScrollView *d_scrollView;
    __weak IBOutlet UITextField *txt_pt_name;
    __weak IBOutlet UITextField *txt_pt_dob;
    __weak IBOutlet UITextField *txt_pt_id;
    __weak IBOutlet UITextField *txt_legal_auth_name;
    
    __weak IBOutlet UIImageView *img_legal_auth_sign;
    __weak IBOutlet UIImageView *img_witness_sign;
    
    __weak IBOutlet UITextField *txt_date1;
    __weak IBOutlet UITextField *txt_date2;
    
    __weak IBOutlet UIButton *btn_auth;
    
    UITextField *universalTextField;
    
    UIImage *img_initial1;
    UIImage *img_initial2;
    UIImage *img_initial3;
    UIImage *img_signature;

}

@property (strong, nonatomic) NSMutableDictionary *formOneData;
@property (strong, nonatomic) NSDictionary *dict_form;

@property (strong, nonatomic) UIImage *initial1;
@property (strong, nonatomic) UIImage *initial2;
@property (strong, nonatomic) UIImage *initial3;
@property (strong, nonatomic) UIImage *signature;
@property (strong, nonatomic) NSString *patient_name;

@property (nonatomic) BOOL isNewTicket;
@property (nonatomic) BOOL isNotSubmitted;

@end
