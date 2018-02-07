//
//  SetUpTicketFormFour.h
//  RT APP
//
//  Created by Anil Prasad on 04/06/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignatureView.h"
#import "PDFViewController.h"
#import "CCXFormOne.h"
#import "Utils.h"

@interface SetUpTicketFormFour : UIViewController<UIPopoverControllerDelegate>{
    
    IBOutlet UIScrollView *d_scrollView;
    IBOutlet UIView *disableFormView;
    IBOutlet UIButton *btn_save;
    IBOutlet UIButton *btn_submit;
    
    IBOutlet UITextField *txt_patientName;
    
    UIAlertView *submitAlert;
    UIAlertView *ticketSubmittedAlert;
    
    UITextField *universalTextField;
    CGPoint d_point;
    
    UIView *signatureBackgroundView;
    UIView *signatureVw;
    SignatureView *signaturePanel;
    IBOutlet UIImageView *img_sign;
    IBOutlet UIButton *btn_sign;
    IBOutlet UIButton *btn_terms;
    
    IBOutlet UIButton *btn_date;
    IBOutlet UITextField *txt_date;
    
    UIViewController *popoverViewConDate;
    UIPopoverController *popoverConDate;
    UIDatePicker *datePicker;
    NSMutableArray *arryDate;
    
    UIImage *img_initial1;
    UIImage *img_initial2;
    UIImage *img_initial3;
    UIImage *img_signature;
    
    UIImage *rt_trainer_signature;
    UIImage *rt_patient_signature;
    UIImage *final_signature;
    
    UIImage *signImg;
    NSString *format_Date;

    IBOutlet UIView *view_one;
    IBOutlet UIView *view_two;

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


@property (strong, nonatomic) NSDictionary *dict_form;
@property (strong, nonatomic) NSString *patient_name;

@property (nonatomic) BOOL isNewTicket;
@property (nonatomic) BOOL isNotSubmitted;

@end
