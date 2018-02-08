//
//  NIVAstralVentPerf.h
//  RT APP
//
//  Created by Anil Prasad on 11/30/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIVPatientProg.h"
#import "NIVTIcketView.h"
#import "NIVTIcketModel.h"

@interface NIVAstralVentPerf : UIViewController<UIPopoverControllerDelegate, WSCalendarViewDelegate>{
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
    __weak IBOutlet UITextField *txt_vent_DN1;
    __weak IBOutlet UITextField *txt_vent_DN2;
    __weak IBOutlet UITextField *txt_vent_hours1;
    __weak IBOutlet UITextField *txt_vent_hours2;
    __weak IBOutlet UITextField *txt_vent_due1;
    __weak IBOutlet UITextField *txt_vent_due2;
    __weak IBOutlet UITextField *txt_vent_hours_of_use;
    
    __weak IBOutlet UITextField *txt_ivap_height;
    __weak IBOutlet UITextField *txt_ivap_average;
    __weak IBOutlet UITextField *txt_ivap_targetPtRate;
    __weak IBOutlet UITextField *txt_ivap_targetVa;
    __weak IBOutlet UITextField *txt_ivap_epap;
    __weak IBOutlet UITextField *txt_ivap_min_press;
    __weak IBOutlet UITextField *txt_ivap_max_press;
    __weak IBOutlet UITextField *txt_ivap_rise_time;
    __weak IBOutlet UITextField *txt_ivap_ti_min;
    __weak IBOutlet UITextField *txt_ivap_ti_max;
    __weak IBOutlet UITextField *txt_ivap_cycle;
    __weak IBOutlet UITextField *txt_ivap_O2;
    
    __weak IBOutlet UITextField *txt_ps_height;
    __weak IBOutlet UITextField *txt_ps_press;
    __weak IBOutlet UITextField *txt_ps_safety;
    __weak IBOutlet UITextField *txt_ps_peep;
    __weak IBOutlet UITextField *txt_ps_resp;
    __weak IBOutlet UITextField *txt_ps_max_press;
    __weak IBOutlet UITextField *txt_ps_rise_time;
    __weak IBOutlet UITextField *txt_ps_ti_min;
    __weak IBOutlet UITextField *txt_ps_ti_max;
    __weak IBOutlet UITextField *txt_ps_cycle;
    
    __weak IBOutlet UITextField *txt_alarm_vte_low;
    __weak IBOutlet UITextField *txt_alarm_vte_high;
    __weak IBOutlet UITextField *txt_alarm_mve_low;
    __weak IBOutlet UITextField *txt_alarm_mve_high;
    __weak IBOutlet UITextField *txt_alarm_press_low;
    __weak IBOutlet UITextField *txt_alarm_press_high;
    __weak IBOutlet UITextField *txt_alarm_resp_low;
    __weak IBOutlet UITextField *txt_alarm_resp_high;
    __weak IBOutlet UITextField *txt_alarm_apnea;
    __weak IBOutlet UITextField *txt_alarm_leak;
    
    __weak IBOutlet UITextField *txt_alarm_hum;
    __weak IBOutlet UITextField *txt_alarm_serial;
    
    __weak IBOutlet UITextField *txt_obs_press;
    __weak IBOutlet UITextField *txt_obs_pip;
    __weak IBOutlet UITextField *txt_obs_peep;
    __weak IBOutlet UITextField *txt_obs_mve;
    __weak IBOutlet UITextField *txt_obs_rr;
    __weak IBOutlet UITextField *txt_obs_vte;
    __weak IBOutlet UITextField *txt_obs_leak;
    __weak IBOutlet UITextField *txt_obs_rise;
    __weak IBOutlet UITextField *txt_obs_ti;
    __weak IBOutlet UITextField *txt_obs_spont_trig;
    __weak IBOutlet UITextField *txt_obs_spont_cyc;
    __weak IBOutlet UITextField *txt_obs_ave_vt;
    __weak IBOutlet UITextField *txt_obs_ave_vtkg;
    __weak IBOutlet UITextField *txt_obs_target;
    
    __weak IBOutlet UITextField *txt_mpv_itime;
    __weak IBOutlet UITextField *txt_mpv_vol;
    __weak IBOutlet UITextField *txt_mpv_resp;
    
    __weak IBOutlet UITextField *txt_mpv_usage;
    
    __weak IBOutlet UIImageView *img_clinician;
    
    __weak IBOutlet UITextField *txt_clini_date;
    
    __weak IBOutlet UIView *view_mode_ivap;
    __weak IBOutlet UIView *view_mode_ps;
    
    __weak IBOutlet APRadioButton *rad_interface;
    __weak IBOutlet APRadioButton *rad_mode_ivap;
    __weak IBOutlet APRadioButton *rad_mode_ps;
    __weak IBOutlet APRadioButton *rad_trigger_ivap;
    __weak IBOutlet APRadioButton *rad_trigger_ps;
    __weak IBOutlet APRadioButton *rad_disconnect_alarm;
    __weak IBOutlet APRadioButton *rad_low_peep_alarm;
    __weak IBOutlet APRadioButton *rad_nebulizer;
    __weak IBOutlet APRadioButton *rad_resuscitation;
    
}

@property (nonatomic, strong) NSMutableDictionary *formData;
@property (nonatomic, strong) NSMutableDictionary *prevFormData;
@property (strong, nonatomic) NSDictionary *dict_retrivedData, *dict_retrivedData_local;

@end
