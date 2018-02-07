//
//  SetUpTicketFormTwo.h
//  RT APP
//
//  Created by Anil Prasad on 16/12/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignatureView.h"
#import "SetUpTicketFormThree.h"
#import "RadioButton.h"
#import "Utils.h"

@interface SetUpTicketFormTwo : UIViewController<UIPopoverControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>{
    
    IBOutlet UIScrollView *d_scrollView;
    
    IBOutlet UIImageView *img_signature1;
    IBOutlet UIImageView *img_signature2;
    IBOutlet UIImageView *img_signature3;
    IBOutlet UIImageView *img_signature4;
    
    IBOutlet UIButton *btn_sign1;
    IBOutlet UIButton *btn_sign2;
    IBOutlet UIButton *btn_sign3;
    IBOutlet UIButton *btn_sign4;
    
    IBOutlet UITextField *txt_date;
    IBOutlet UITextField *txt_fName;
    IBOutlet UITextField *txt_lName;
    IBOutlet UITextField *txt_address;
    IBOutlet UITextField *txt_city;
    IBOutlet UITextField *txt_state;
    IBOutlet UITextField *txt_zip;
    IBOutlet UITextField *txt_hPhone;
    IBOutlet UITextField *txt_email;
    
    IBOutlet UIButton *btn_date;
    IBOutlet UIButton *btn_state;
    
    IBOutlet UIButton *btn_delete;
    IBOutlet UIButton *btn_submit;
    IBOutlet UIButton *btn_save;
    IBOutlet UILabel *lbl_readOnly;

    UIViewController *popoverViewCon;
    UIPopoverController *popoverCon;
    UITableViewController *dropdownsTableviewCon;
    
    UIViewController *popoverViewConDate;
    UIPopoverController *popoverConDate;
    UIDatePicker *datePicker;
    
    UITextField *universalTextField;
    CGPoint d_point;
    NSMutableArray *arryDate;
    
    UIView *signatureBackgroundView;
    UIView *signatureVw;
    
    SignatureView *signaturePanel;
    NSString *userGeoLocation;
    UIImage *signImg;
    IBOutlet UIView *disableFormView;
    IBOutlet UILabel *lbl_ticketId;
    
    NSString *format_Date;

    IBOutlet UIView *view_one;
    IBOutlet UIView *view_two;

    
    __weak IBOutlet UITextField *auth_patient_name;

    __weak IBOutlet UITextField *auth_other_name;
    __weak IBOutlet UIView *auth_view;
}

@property (strong, nonatomic) IBOutletCollection(RadioButton) NSArray *yesNoRadio;

@property (strong, nonatomic) NSArray *arr_rt_states;
@property (strong, nonatomic) NSDictionary *dict_form;

@property (strong, nonatomic) NSMutableDictionary *formOneData;

@property (nonatomic) BOOL isNewTicket;
@property (nonatomic) BOOL isFromInventory;
@property (nonatomic) BOOL isFromSchedule;
@property (nonatomic) BOOL isNotSubmitted;

@end
