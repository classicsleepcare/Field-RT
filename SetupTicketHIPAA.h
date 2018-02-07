//
//  SetupTicketHIPAA.h
//  RT APP
//
//  Created by Anil Prasad on 09/08/16.
//  Copyright © 2016 ankit gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"

@interface SetupTicketHIPAA : UIViewController{
    
    __weak IBOutlet UITextField *txt_email;
    __weak IBOutlet UITextField *txt_phone;
    __weak IBOutlet UITextField *txt_name;
    __weak IBOutlet UITextField *txt_date;
    
    __weak IBOutlet UIButton *btn_email;
    __weak IBOutlet UIButton *btn_text;
    __weak IBOutlet UIButton *btn_voice;
    
    __weak IBOutlet UIImageView *img_signature;
    __weak IBOutlet UIScrollView *d_scrollView;
    
    UITextField *universalTextField;

    UIImage *img_initial1;
    UIImage *img_initial2;
    UIImage *img_initial3;
    UIImage *img_signature1;

}

@property (nonatomic) BOOL isNewTicket;
@property (nonatomic) BOOL isNotSubmitted;

@property (strong, nonatomic) UIImage *initial1;
@property (strong, nonatomic) UIImage *initial2;
@property (strong, nonatomic) UIImage *initial3;
@property (strong, nonatomic) UIImage *signature;
@property (strong, nonatomic) NSString *patient_name;

@property (strong, nonatomic) UIImage *mrr_legal_auth_sign;
@property (strong, nonatomic) UIImage *mrr_witness_sign;

@property (strong, nonatomic) NSMutableDictionary *formOneData;
@property (strong, nonatomic) NSDictionary *dict_form;


@end
