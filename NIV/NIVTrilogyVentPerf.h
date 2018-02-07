//
//  NIVTrilogyVentPerf.h
//  RT APP
//
//  Created by Anil Prasad on 11/30/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSCalendarView.h"
#import "Utils.h"
#import "SignatureView.h"
#import "NIVPatientProg.h"
#import "NIVTIcketView.h"
#import "NIVTIcketModel.h"

@interface NIVTrilogyVentPerf : UIViewController<UIPopoverControllerDelegate, WSCalendarViewDelegate>{
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
    
    NSString *str_pt_dob;
    NSString *str_today_date;
    NSString *str_clini_date;
    
    UITextField *universalTextField;
    
    __weak IBOutlet UITextField *txt_pt_name;
    __weak IBOutlet UITextField *txt_pt_dob;
    __weak IBOutlet UITextField *txt_today_date;
    __weak IBOutlet UITextField *txt_vent_type1;
    __weak IBOutlet UITextField *txt_vent_type2;
    __weak IBOutlet UITextField *txt_vent_serial1;
    __weak IBOutlet UITextField *txt_vent_serial2;
    __weak IBOutlet UITextField *txt_vent_hours1;
    __weak IBOutlet UITextField *txt_vent_hours2;
    __weak IBOutlet UITextField *txt_vent_due1;
    __weak IBOutlet UITextField *txt_vent_due2;
    __weak IBOutlet UITextField *txt_vent_hours_of_use;
    __weak IBOutlet UITextField *txt_vent_pip;
    __weak IBOutlet UITextField *txt_vent_rr;
    __weak IBOutlet UITextField *txt_vent_vte_vti;
    __weak IBOutlet UITextField *txt_vent_leak;
    __weak IBOutlet UITextField *txt_vent_ve;
    __weak IBOutlet UITextField *txt_vent_ie;
    __weak IBOutlet UITextField *txt_vent_map;
    __weak IBOutlet UITextField *txt_vent_peakFlow;
    
    __weak IBOutlet UIView *view_mode_avaps;
    __weak IBOutlet UITextField *txt_mode_avaps_vtTarget;
    __weak IBOutlet UITextField *txt_mode_avaps_breath;
    __weak IBOutlet UITextField *txt_mode_avaps_inspir;
    __weak IBOutlet UITextField *txt_mode_avaps_maxIPAP;
    __weak IBOutlet UITextField *txt_mode_avaps_minIPAP;
    __weak IBOutlet UITextField *txt_mode_avaps_epap;
    __weak IBOutlet UITextField *txt_mode_avaps_O2;
    __weak IBOutlet UITextField *txt_mode_avaps_avapsRate;
    __weak IBOutlet UITextField *txt_mode_avaps_riseTIme;

    __weak IBOutlet UIView *view_mode_avaps_ae;
    __weak IBOutlet UITextField *txt_mode_avaps_ae_vtTarget;
    __weak IBOutlet UITextField *txt_mode_avaps_ae_breath;
    __weak IBOutlet UITextField *txt_mode_avaps_ae_maxPreSupp;
    __weak IBOutlet UITextField *txt_mode_avaps_ae_minPreSupp;
    __weak IBOutlet UITextField *txt_mode_avaps_ae_maxPre;
    __weak IBOutlet UITextField *txt_mode_avaps_ae_maxEPAP;
    __weak IBOutlet UITextField *txt_mode_avaps_ae_minEPAP;
    __weak IBOutlet UITextField *txt_mode_avaps_ae_O2;
    __weak IBOutlet UITextField *txt_mode_avaps_ae_mpv;
    __weak IBOutlet UITextField *txt_mode_avaps_ae_avapsRate;
    __weak IBOutlet UITextField *txt_mode_avaps_ae_riseTime;
    __weak IBOutlet UIView *view_mode_avaps_ae_flow; //(Hide/Unhide)
    __weak IBOutlet UITextField *txt_mode_avaps_ae_flow_sen;
    __weak IBOutlet UITextField *txt_mode_avaps_ae_flow_cyc;

    __weak IBOutlet UITextField *txt_alarm_pri_circ;
    __weak IBOutlet UITextField *txt_alarm_pri_apnea;
    __weak IBOutlet UITextField *txt_alarm_pri_low_insp;
    __weak IBOutlet UITextField *txt_alarm_pri_high_insp;
    __weak IBOutlet UITextField *txt_alarm_pri_low_vte;
    __weak IBOutlet UITextField *txt_alarm_pri_high_vte;
    __weak IBOutlet UITextField *txt_alarm_pri_low_ve;
    __weak IBOutlet UITextField *txt_alarm_pri_high_ve;
    __weak IBOutlet UITextField *txt_alarm_pri_low_rr;
    __weak IBOutlet UITextField *txt_alarm_pri_high_rr;

    __weak IBOutlet UITextField *txt_alarm_sec_circ;
    __weak IBOutlet UITextField *txt_alarm_sec_apnea;
    __weak IBOutlet UITextField *txt_alarm_sec_low_insp;
    __weak IBOutlet UITextField *txt_alarm_sec_high_insp;
    __weak IBOutlet UITextField *txt_alarm_sec_low_vte;
    __weak IBOutlet UITextField *txt_alarm_sec_high_vte;
    __weak IBOutlet UITextField *txt_alarm_sec_low_ve;
    __weak IBOutlet UITextField *txt_alarm_sec_high_ve;
    __weak IBOutlet UITextField *txt_alarm_sec_low_rr;
    __weak IBOutlet UITextField *txt_alarm_sec_high_rr;
    
    __weak IBOutlet UITextField *txt_alarm_level;
    __weak IBOutlet UITextField *txt_alarm_number;
    __weak IBOutlet UITextField *txt_alarm_hum;
    __weak IBOutlet UITextField *txt_alarm_serial;
    
    __weak IBOutlet UITextField *txt_mpv_pc_ipap;
    __weak IBOutlet UITextField *txt_mpv_pc_epap;
    __weak IBOutlet UITextField *txt_mpv_pc_breath;
    __weak IBOutlet UITextField *txt_mpv_pc_return;
    
    __weak IBOutlet UITextField *txt_mpv_ac_target;
    __weak IBOutlet UITextField *txt_mpv_ac_peep;
    __weak IBOutlet UITextField *txt_mpv_ac_breath;
    __weak IBOutlet UITextField *txt_mpv_ac_return;

    __weak IBOutlet UITextField *txt_mpv_usage;
    
    __weak IBOutlet UITextField *txt_clini_date;
    
    __weak IBOutlet APRadioButton *rad_interface;
    __weak IBOutlet APRadioButton *rad_mode_avaps_ae;
    __weak IBOutlet APRadioButton *rad_mode_avaps;
    __weak IBOutlet APRadioButton *rad_trigger_avaps_ae;
    __weak IBOutlet APRadioButton *rad_trigger_avaps_ae1;
    __weak IBOutlet APRadioButton *rad_trigger_avaps_ae2;

    __weak IBOutlet APRadioButton *rad_trigger_avaps;
    __weak IBOutlet APRadioButton *rad_rampLenght_avaps_ae;
    __weak IBOutlet APRadioButton *rad_rampLenght_avaps;
    __weak IBOutlet APRadioButton *rad_resuscitation;
    __weak IBOutlet APRadioButton *rad_batteries;
    __weak IBOutlet APRadioButton *rad_nebulizer;
    __weak IBOutlet UIImageView *img_clinician;
}

@property (nonatomic, strong) NSMutableDictionary *formData;
@property (nonatomic, strong) NSMutableDictionary *prevFormData;

@end
