//
//  SetUpTicketFormThree.h
//  RT APP
//
//  Created by Anil Prasad on 04/06/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignatureView.h"
#import "HistoryView.h"
#import "HistoryModel.h"
#import "Utils.h"

@interface SetUpTicketFormThree : UIViewController<UIPopoverControllerDelegate, UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

{
    
    IBOutlet UIScrollView *d_scrollView;

    UITextField *universalTextField;
    CGPoint d_point;

    UIView *signatureBackgroundView;
    UIView *signatureVw;
    SignatureView *signaturePanel;
    IBOutlet UIImageView *img_sign;
    IBOutlet UIButton *btn_sign;
    
    IBOutlet UIImageView *img_signPatient;
    IBOutlet UIButton *btn_signPatient;

    
    IBOutlet UIButton *btn_1;
    IBOutlet UIButton *btn_2;
    IBOutlet UIButton *btn_3;
    IBOutlet UIButton *btn_3_1;
    IBOutlet UIButton *btn_4;
    IBOutlet UIButton *btn_5;
    IBOutlet UIButton *btn_6;
    IBOutlet UIButton *btn_7;
    IBOutlet UIButton *btn_8;
    IBOutlet UIButton *btn_8_1;
    IBOutlet UIButton *btn_9;
    IBOutlet UIButton *btn_10;
    IBOutlet UIButton *btn_10_1;
    IBOutlet UIButton *btn_11;
    IBOutlet UIButton *btn_12;
    IBOutlet UIButton *btn_13;
    IBOutlet UIButton *btn_14;
    IBOutlet UIButton *btn_15;
    IBOutlet UIButton *btn_16;
    IBOutlet UIButton *btn_17;
    IBOutlet UIButton *btn_18;
    IBOutlet UIButton *btn_19;
    IBOutlet UIButton *btn_20;
    IBOutlet UIButton *btn_21;

    
    //-------27 June 2017
    IBOutlet UIButton *btn_chk_home;
    IBOutlet UIButton *btn_chk_office;
    IBOutlet UIButton *btn_chk_other;
    IBOutlet UIButton *btn_chk_full_setup;
    IBOutlet UIButton *btn_chk_resupply_only;
   
    IBOutlet UITextField *txt_date_of_setup;
    IBOutlet UITextField *txt_other;
    IBOutlet UITextField *txt_serial_number;
    IBOutlet UITextField *txt_mask_interface;
    IBOutlet UITextField *txt_size;
    IBOutlet UITextField *txt_csc_clinician;
    IBOutlet UITextField *txt_ordering_physician;
    IBOutlet UITextField *txt_machine_model;
    
    IBOutlet UITextField *txt_patient_id;

    NSArray *arr_mask_size;
    
    UIPopoverController *popoverCon;
    UIViewController *popoverViewCon;
    UITableViewController *dropdownsTableviewCon;
    
    //--------------------------//
    
    IBOutlet UITextField *txt_patientName;
    
    IBOutlet UITextField *txt_patientCaregiver;
    IBOutlet UITextField *txt_relationship;

    IBOutlet UITextView *txt_summary;

    IBOutlet UIButton *btn_date;
    IBOutlet UITextField *txt_date;
    IBOutlet UITextField *txt_datePatient;

    UIViewController *popoverViewConDate;
    UIPopoverController *popoverConDate;
    UIDatePicker *datePicker;
    NSMutableArray *arryDate;

    UIImage *signImg;
    UIImage *img_initial1;
    UIImage *img_initial2;
    UIImage *img_initial3;
    UIImage *img_signature;
    UIImage *img_mrr_legal_auth_sign;
    UIImage *img_mrr_witness_sign;
    
    NSString *format_Date;
    IBOutlet UIView *view_one;
    IBOutlet UIView *view_two;
    IBOutlet UIView *view_three;
    
    IBOutlet UIView *disableFormView;

    IBOutlet UILabel *lbl_additional_Items;
    IBOutlet UITextView *txt_additional_supplies;

}

@property (strong, nonatomic) NSMutableDictionary *formOneData;
@property (strong, nonatomic) NSDictionary *dict_form;

@property (strong, nonatomic) UIImage *initial1;
@property (strong, nonatomic) UIImage *initial2;
@property (strong, nonatomic) UIImage *initial3;
@property (strong, nonatomic) UIImage *signature;
@property (strong, nonatomic) NSString *patient_name;
@property (strong, nonatomic) UIImage *legal_auth_rep_sign;

@property (strong, nonatomic) UIImage *mrr_legal_auth_sign;
@property (strong, nonatomic) UIImage *mrr_witness_sign;
@property (strong, nonatomic) UIImage *pip_legal_auth_rep_sign;

@property (nonatomic) BOOL isNewTicket;
@property (nonatomic) BOOL isNotSubmitted;


@end
