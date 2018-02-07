//
//  NIVPatientProg.h
//  RT APP
//
//  Created by Anil Prasad on 14/11/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSCalendarView.h"
#import "Utils.h"
#import "SignatureView.h"
#import "NIVTakeCOPD.h"
#import "APRadioButton.h"
#import "NIVTIcketView.h"
#import "NIVTIcketModel.h"

@interface NIVPatientProg : UIViewController<UIPopoverControllerDelegate, WSCalendarViewDelegate>{
    __weak IBOutlet UIScrollView *d_scrollView;
    
    WSCalendarView *calendarView;
    WSCalendarView *calendarViewEvent;
    NSMutableArray *eventArray;
    
    UIPopoverController *popoverCon;
    UIViewController *popoverViewCon;
    UIView *calendarViewController;
    
    int dateTag;
    
    UIView *signatureBackgroundView;
    UIView *signatureVw;
    SignatureView *signaturePanel;
    
    CGPoint d_point;
    
    UITextField *universalTextField;
    UITextView *universalTextView;

    
    __weak IBOutlet UITextField *txt_pt_name;
    __weak IBOutlet UITextField *txt_therapist_name;
    __weak IBOutlet UITextField *txt_date;
    
    __weak IBOutlet UITextField *txt_obj_bp;
    __weak IBOutlet UITextField *txt_obj_pulse;
    __weak IBOutlet UITextField *txt_obj_resp;
    __weak IBOutlet UITextField *txt_obj_fev1;
    __weak IBOutlet UITextField *txt_obj_fev2;
    __weak IBOutlet UITextField *txt_obj_fevfvc1;
    __weak IBOutlet UITextField *txt_obj_fevfvc2;
    __weak IBOutlet UITextField *txt_obj_pef1;
    __weak IBOutlet UITextField *txt_obj_pef2;
    __weak IBOutlet UITextField *txt_obj_weight;
    __weak IBOutlet UITextField *txt_obj_lpm1;
    __weak IBOutlet UITextField *txt_obj_lpm2;

    __weak IBOutlet UITextField *txt_auscu_location;
    
    __weak IBOutlet UITextField *txt_others;
    __weak IBOutlet UITextField *txt_nextVisit_date;
    
    __weak IBOutlet UITextView *txt_reason;
    __weak IBOutlet UITextView *txt_notes;
    __weak IBOutlet UITextView *txt_careTeam;

    
    __weak IBOutlet UIImageView *img_patient;
    __weak IBOutlet UIImageView *img_caregiver;
    __weak IBOutlet UIImageView *img_therapist;
    
    
    __weak IBOutlet APRadioButton *apr_rates;
    __weak IBOutlet APRadioButton *apr_crepitant;
    __weak IBOutlet APRadioButton *apr_wheezing_aus;
    __weak IBOutlet APRadioButton *apr_diminished;
    __weak IBOutlet APRadioButton *apr_edema;
    __weak IBOutlet APRadioButton *apr_crepitant_skin;
    __weak IBOutlet APRadioButton *apr_wheezing_skin;
    __weak IBOutlet APRadioButton *apr_diminished_skin;

    
    __weak IBOutlet UIButton *btn_clear_bilateral;
    __weak IBOutlet UIButton *btn_ventilator;
    __weak IBOutlet UIButton *btn_cpap;
    __weak IBOutlet UIButton *btn_oxy_concen;
    __weak IBOutlet UIButton *btn_suction;
    __weak IBOutlet UIButton *btn_other;
    __weak IBOutlet UIButton *btn_nebulizer;
    __weak IBOutlet UIButton *btn_bipap;
    __weak IBOutlet UIButton *btn_oxy_cylinders;
    __weak IBOutlet UIButton *btn_cough;
    __weak IBOutlet UIButton *btn_cleanliness;
    __weak IBOutlet UIButton *btn_alarm_set;
    __weak IBOutlet UIButton *btn_event;
    __weak IBOutlet UIButton *btn_no_visible;
    __weak IBOutlet UIButton *btn_alarm_history;
    __weak IBOutlet UIButton *btn_date_time;

    NSString *str_date;
    NSString *str_nextVisit_date;
}

@property (nonatomic, strong) NSMutableDictionary *formData;
@property (nonatomic, strong) NSMutableDictionary *prevFormData;


@end
