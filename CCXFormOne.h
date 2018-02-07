//
//  CCXFormOne.h
//  RT APP
//
//  Created by Anil Prasad on 06/07/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignatureView.h"
#import "CCXFormTwo.h"
#import "Utils.h"

@interface CCXFormOne : UIViewController<UIPopoverControllerDelegate, UITextFieldDelegate>
{
    IBOutlet UIScrollView *d_scrollView;
    
    UITextField *universalTextField;
    CGPoint d_point;
    
    UIView *signatureBackgroundView;
    UIView *signatureVw;
    SignatureView *signaturePanel;

    UIImage *img_patient_sign;
    UIImage *img_company_rep_sign;
    
    NSString *format_Date;
    NSMutableArray *arryDate;

    
    __weak IBOutlet UIImageView *img_patient_sign_view;
    __weak IBOutlet UIImageView *img_company_rep_sign_view;
    
    __weak IBOutlet UITextField *txt_date_setup;
    __weak IBOutlet UITextField *txt_setup_performed_at;
    __weak IBOutlet UITextField *txt_patient_name;
    __weak IBOutlet UITextField *txt_dob;
    __weak IBOutlet UITextField *txt_physician_name;
    __weak IBOutlet UITextField *txt_physician_phone;
    __weak IBOutlet UITextField *txt_address;
    __weak IBOutlet UITextField *txt_primary_contact;
    __weak IBOutlet UITextField *txt_secondary_contact;
    __weak IBOutlet UITextField *txt_patient_email;
    __weak IBOutlet UITextField *txt_patient_emergency_contact;
    __weak IBOutlet UITextField *txt_epap;
    __weak IBOutlet UITextField *txt_auto_pap_min;
    __weak IBOutlet UITextField *txt_auto_pap_max;
    __weak IBOutlet UITextField *txt_bi_level_epap;
    __weak IBOutlet UITextField *txt_bi_level_ipap;
    __weak IBOutlet UITextField *txt_auto_bi_level_epap;
    __weak IBOutlet UITextField *txt_auto_bi_level_ipap;
    __weak IBOutlet UITextField *txt_bi_level_st_min;
    __weak IBOutlet UITextField *txt_bi_level_st_max;
    __weak IBOutlet UITextField *txt_bi_level_st_rr;
    __weak IBOutlet UITextField *txt_auto_sv_min;
    __weak IBOutlet UITextField *txt_auto_sv_max;
    __weak IBOutlet UITextField *txt_auto_sv_epap;
    __weak IBOutlet UITextField *txt_rate_other;
    __weak IBOutlet UITextField *txt_make_model;
    __weak IBOutlet UITextField *txt_serial;
    __weak IBOutlet UITextField *txt_mask_type_name;
    __weak IBOutlet UITextField *txt_mask_size_other;
    __weak IBOutlet UITextField *txt_wireless_id;
    __weak IBOutlet UITextField *txt_patient_email_in_monitoring_site;
    __weak IBOutlet UITextField *txt_provider_name;
    __weak IBOutlet UITextField *txt_patient_sign_date;
    __weak IBOutlet UITextField *txt_company_rep_sign_date;

    __weak IBOutlet UIButton *btn_cpap;
    __weak IBOutlet UIButton *btn_auto_pap;
    __weak IBOutlet UIButton *btn_bi_level;
    __weak IBOutlet UIButton *btn_auto_bi_level;
    __weak IBOutlet UIButton *btn_bi_level_st;
    __weak IBOutlet UIButton *btn_auto_sv;
    __weak IBOutlet UIButton *btn_initial_unit;
    __weak IBOutlet UIButton *btn_replacement_unit;
    __weak IBOutlet UIButton *btn_heated;
    __weak IBOutlet UIButton *btn_cool_passover;
    __weak IBOutlet UIButton *btn_nasal_pillows;
    __weak IBOutlet UIButton *btn_nasal;
    __weak IBOutlet UIButton *btn_full;
    __weak IBOutlet UIButton *btn_mask_size_s;
    __weak IBOutlet UIButton *btn_mask_size_m;
    __weak IBOutlet UIButton *btn_mask_size_l;
    __weak IBOutlet UIButton *btn_mask_size_xl;
    __weak IBOutlet UIButton *btn_mask_size_other;
    __weak IBOutlet UIButton *btn_rate_off;
    __weak IBOutlet UIButton *btn_rate_auto;
    __weak IBOutlet UIButton *btn_rate_other;
    __weak IBOutlet UIButton *btn_card;
    __weak IBOutlet UIButton *btn_modem_wireless;
    __weak IBOutlet UIButton *btn_usb;
    __weak IBOutlet UIButton *btn_sms_yes;
    __weak IBOutlet UIButton *btn_sms_no;
    __weak IBOutlet UIButton *btn_sms_unknown;
    __weak IBOutlet UIButton *btn_agreement_accept;
   
    __weak IBOutlet UITextView *txt_comments;

}

@property (strong, nonatomic) NSMutableDictionary *formOneData;
@property (strong, nonatomic) UIImage *trainer_signature;
@property (strong, nonatomic) UIImage *patient_signature;

@property (strong, nonatomic) UIImage *initial1;
@property (strong, nonatomic) UIImage *initial2;
@property (strong, nonatomic) UIImage *initial3;
@property (strong, nonatomic) UIImage *signature;

@property (strong, nonatomic) UIImage *legal_auth_sign;
@property (strong, nonatomic) UIImage *witness_sign;
@property (strong, nonatomic) UIImage *legal_auth_rep_sign;

@property (strong, nonatomic) UIImage *mrr_legal_auth_sign;
@property (strong, nonatomic) UIImage *mrr_witness_sign;
@property (strong, nonatomic) UIImage *pip_legal_auth_rep_sign;
@property (strong, nonatomic) UIImage *final_signature;

@property (strong, nonatomic) NSDictionary *dict_form;
@property (strong, nonatomic) NSString *patient_name;

@property (nonatomic) BOOL isNewTicket;
@property (nonatomic) BOOL isNotSubmitted;

@end
