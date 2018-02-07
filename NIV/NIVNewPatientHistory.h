//
//  NIVNewPatientHistory.h
//  RT APP
//
//  Created by Anil Prasad on 14/11/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSCalendarView.h"
#import "Utils.h"
#import "SignatureView.h"
#import "APRadioButton.h"
#import "NIVPatientDis.h"
#import "NTMonthYearPicker.h"
#import "NIVTIcketView.h"
#import "NIVTIcketModel.h"

@interface NIVNewPatientHistory : UIViewController<UIPopoverControllerDelegate, WSCalendarViewDelegate>{
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
    
    UITextField *universalTextField;
    CGPoint d_point;
    
    NTMonthYearPicker *picker;
    UIPopoverController *popoverCalendar;
    UIViewController *pickerController;

    
    __weak IBOutlet UIButton *btn_diagno_pri;
    __weak IBOutlet UIButton *btn_diagno_sec;
    __weak IBOutlet UIButton *btn_eyes_np;
    __weak IBOutlet UIButton *btn_eyes_blind;
    __weak IBOutlet UIButton *btn_eyes_decre;
    __weak IBOutlet UIButton *btn_ears_np;
    __weak IBOutlet UIButton *btn_ears_deaf;
    __weak IBOutlet UIButton *btn_ears_decre;
    __weak IBOutlet UIButton *btn_neuro_np;
    __weak IBOutlet UIButton *btn_neuro_day;
    __weak IBOutlet UIButton *btn_neuro_head;
    __weak IBOutlet UIButton *btn_neuro_fat;
    __weak IBOutlet UIButton *btn_neuro_numb;
    __weak IBOutlet UIButton *btn_mental_alert;
    __weak IBOutlet UIButton *btn_mental_com;
    __weak IBOutlet UIButton *btn_mental_dis;
    __weak IBOutlet UIButton *btn_mental_mem;
    __weak IBOutlet UIButton *btn_func_np;
    __weak IBOutlet UIButton *btn_func_exec;
    __weak IBOutlet UIButton *btn_func_dysp;
    __weak IBOutlet UIButton *btn_func_slurr;
    __weak IBOutlet UIButton *btn_respi_np;
    __weak IBOutlet UIButton *btn_respi_dysOnExer;
    __weak IBOutlet UIButton *btn_respi_dyspAtRest;
    __weak IBOutlet UIButton *btn_respi_tachy;
    __weak IBOutlet UIButton *btn_respi_sob;
    __weak IBOutlet UIButton *btn_cough_dry;
    __weak IBOutlet UIButton *btn_cough_pro;
    __weak IBOutlet UIButton *btn_cardio_np;
    __weak IBOutlet UIButton *btn_cardio_ortho;
    __weak IBOutlet UIButton *btn_cardio_chest;
    __weak IBOutlet UIButton *btn_cardio_tachy;
    __weak IBOutlet UIButton *btn_cardio_dia;
    __weak IBOutlet UIButton *btn_cardio_sob;
    __weak IBOutlet UIButton *btn_edema_noEd;
    __weak IBOutlet UIButton *btn_edema_noPi;
    __weak IBOutlet UIButton *btn_edema_pi;
    __weak IBOutlet UIButton *btn_musc_np;
    __weak IBOutlet UIButton *btn_musc_amp;
    __weak IBOutlet UIButton *btn_musc_para;
    __weak IBOutlet UIButton *btn_musc_quad;
    __weak IBOutlet UIButton *btn_musc_poor;
    __weak IBOutlet UIButton *btn_musc_men;
    __weak IBOutlet UIButton *btn_adl_inde;
    __weak IBOutlet UIButton *btn_adl_assi;
    __weak IBOutlet UIButton *btn_adl_depe;
    __weak IBOutlet UIButton *btn_activi_noRes;
    __weak IBOutlet UIButton *btn_activi_comp;
    __weak IBOutlet UIButton *btn_activi_bed;
    __weak IBOutlet UIButton *btn_activi_up;
    __weak IBOutlet UIButton *btn_activi_trans;
    __weak IBOutlet UIButton *btn_activi_part;
    __weak IBOutlet UIButton *btn_activi_other;
    __weak IBOutlet UIButton *btn_activi_crut;
    __weak IBOutlet UIButton *btn_activi_cane;
    __weak IBOutlet UIButton *btn_activi_pros;
    __weak IBOutlet UIButton *btn_activi_wheel;
    __weak IBOutlet UIButton *btn_activi_walker;
    __weak IBOutlet UIButton *btn_activi_indepe;
    __weak IBOutlet UIButton *btn_spec_ann_pnx;
    __weak IBOutlet UIButton *btn_spec_ann_flu;
    __weak IBOutlet UIButton *btn_nutri_has;
    __weak IBOutlet UIButton *btn_nutri_bodLess;
    __weak IBOutlet UIButton *btn_nutri_bodMore;

    
    
    
    
    __weak IBOutlet UITextField *txt_pt_first;
    __weak IBOutlet UITextField *txt_pt_middle;
    __weak IBOutlet UITextField *txt_pt_last;
    __weak IBOutlet UITextField *txt_diag_primary;
    __weak IBOutlet UITextField *txt_diag_secondary;
    __weak IBOutlet UITextView *txt_activity_other;
    __weak IBOutlet UITextField *txt_resp_ft;
    __weak IBOutlet UITextField *txt_resp_amt;
    __weak IBOutlet UITextField *txt_resp_order;
    __weak IBOutlet UITextField *txt_spec_pnx_date;
    __weak IBOutlet UITextField *txt_spec_flu_date;
    __weak IBOutlet UITextField *txt_bmi;

}

@property (nonatomic, strong) NSMutableDictionary *formData;
@property (nonatomic, strong) NSMutableDictionary *prevFormData;


@end
