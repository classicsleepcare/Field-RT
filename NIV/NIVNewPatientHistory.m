//
//  NIVNewPatientHistory.m
//  RT APP
//
//  Created by Anil Prasad on 14/11/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import "NIVNewPatientHistory.h"

@interface NIVNewPatientHistory ()

@end

@implementation NIVNewPatientHistory
@synthesize formData;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCheckboxes];
   // [self autoFillDates];
    
    txt_pt_first.text = self.prevFormData[@"Pt_First"];
    txt_pt_middle.text = self.prevFormData[@"Pt_Middle"];
    txt_pt_last.text = self.prevFormData[@"Pt_Last"];
    
    
    d_scrollView.contentSize                    = CGSizeMake(880, 2100);
    d_scrollView.contentOffset                  = CGPointMake(0,0);
    
    popoverViewCon                              = [[UIViewController alloc]init];
    popoverViewCon.preferredContentSize         = CGSizeMake(320,298);
    calendarViewController.frame                = CGRectMake(0, 0, CGRectGetWidth(popoverViewCon.view.bounds),CGRectGetHeight(popoverViewCon.view.bounds));
    [popoverViewCon.view addSubview:calendarViewController];
    popoverCon                                  = [[UIPopoverController alloc] initWithContentViewController:popoverViewCon];
    
    [self setCustomCalendar];
    
    formData = [NSMutableDictionary new];

}

#pragma mark - Custom Calendar

-(void)setCustomCalendar{
    
    // Calendar
    pickerController            = [UIViewController new];
    pickerController.view.frame = CGRectMake(300, 200, 300, 530);
    
    picker                  = [[NTMonthYearPicker alloc] initWithFrame:CGRectMake (0, 0, 280, 280)];
    picker.datePickerMode   = UIDatePickerModeDate;
    pickerController.view       = picker;
    
    popoverCalendar             = [[UIPopoverController alloc] initWithContentViewController:pickerController];
    popoverCalendar.popoverContentSize = CGSizeMake(280, 280);
    popoverCalendar.delegate    = self;
    
    [picker addTarget:self action:@selector(onDatePicked:from:) forControlEvents:UIControlEventValueChanged];
    picker.datePickerMode = NTMonthYearPickerModeMonthAndYear;
}

-(void)createCalendarPopoverFrom:(UIButton*)sender{
    
    [popoverCalendar presentPopoverFromRect:CGRectMake(sender.frame.size.width/4-25, sender.frame.size.height/1-20, 1, 1)
                                     inView:sender
                   permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];

    pickerController.preferredContentSize         = CGSizeMake(280,280);
}

- (void)onDatePicked:(UITapGestureRecognizer *)gestureRecognizer from:(UIButton*)sender{
    [self setDateTextboxes:sender];
}

- (void)setDateTextboxes:(UIButton*)sender {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    if( picker.datePickerMode == NTMonthYearPickerModeMonthAndYear ) {
        [df setDateFormat:@"MMM YY"];
    } else {
        [df setDateFormat:@"yyyy"];
    }
    NSString *dateStr = [df stringFromDate:picker.date];
    
    if (dateTag == 1) txt_spec_pnx_date.text = dateStr;
    if (dateTag == 2) txt_spec_flu_date.text = dateStr;
}

#pragma mark -
#pragma mark -

-(void)saveFormData{
    [formData setObject:self.prevFormData[@"ticket_id"] forKey:@"ticket_id"];
    [formData setObject:RT_ID forKey:@"rt_id"];
    [formData setObject:self.prevFormData[@"pt_id"] forKey:@"pt_id"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_diagno_pri] ? @"1": @"0"] forKey:@"diagnosis_primary"];
    [formData setObject:NonNilString(txt_diag_primary.text) forKey:@"diagnosis_primary_text"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_diagno_sec] ? @"1": @"0"] forKey:@"diagnosis_secondary"]; // MISSING FROM API
    [formData setObject:NonNilString(txt_diag_secondary.text) forKey:@"diagnosis_secondary_text"]; // MISSING FROM API
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_eyes_np] ? @"1": @"0"] forKey:@"eyes_no_problem"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_eyes_blind] ? @"1": @"0"] forKey:@"eyes_blind"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_eyes_decre] ? @"1": @"0"] forKey:@"eyes_decreased_vision"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_ears_np] ? @"1": @"0"] forKey:@"ears_no_problem"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_ears_deaf] ? @"1": @"0"] forKey:@"ears_deaf"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_ears_decre] ? @"1": @"0"] forKey:@"ears_decreased_hearing"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_musc_np] ? @"1": @"0"] forKey:@"mus_no_problem"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_musc_amp] ? @"1": @"0"] forKey:@"mus_amputation"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_musc_poor] ? @"1": @"0"] forKey:@"mus_poor_coordination"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_musc_para] ? @"1": @"0"] forKey:@"mus_paraplegic"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_musc_men] ? @"1": @"0"] forKey:@"mus_meniplegic"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_musc_para] ? @"1": @"0"] forKey:@"mus_quad_pelagic"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_adl_inde] ? @"1": @"0"] forKey:@"mus_adl_independent"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_adl_depe] ? @"1": @"0"] forKey:@"mus_adl_dependent"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_adl_assi] ? @"1": @"0"] forKey:@"mus_adl_assistance_required"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_neuro_np] ? @"1": @"0"] forKey:@"neuro_no_problem"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_neuro_day] ? @"1": @"0"] forKey:@"neuro_daytime_som"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_neuro_fat] ? @"1": @"0"] forKey:@"neuro_fatigue"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_neuro_head] ? @"1": @"0"] forKey:@"neuro_headache"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_neuro_numb] ? @"1": @"0"] forKey:@"neuro_numbness"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_mental_alert] ? @"1": @"0"] forKey:@"neuro_mental_alert"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_mental_dis] ? @"1": @"0"] forKey:@"neuro_mental_disoriented"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_mental_com] ? @"1": @"0"] forKey:@"neuro_mental_comatose"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_mental_mem] ? @"1": @"0"] forKey:@"neuro_mental_memory_loss"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_func_np] ? @"1": @"0"] forKey:@"neuro_fun_limit_no_problem"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_func_dysp] ? @"1": @"0"] forKey:@"neuro_fun_limit_dysphagia"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_func_exec] ? @"1": @"0"] forKey:@"neuro_fun_limit_excessive_oral"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_func_slurr] ? @"1": @"0"] forKey:@"neuro_fun_limit_slurred_speech"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_activi_noRes] ? @"1": @"0"] forKey:@"act_perm_no_restrictions"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_activi_crut] ? @"1": @"0"] forKey:@"act_perm_crutches"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_activi_comp] ? @"1": @"0"] forKey:@"act_perm_complete_bed_rest"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_activi_cane] ? @"1": @"0"] forKey:@"act_perm_cane"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_activi_bed] ? @"1": @"0"] forKey:@"act_perm_bed_rest_brp"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_activi_pros] ? @"1": @"0"] forKey:@"act_perm_prosthesis"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_activi_up] ? @"1": @"0"] forKey:@"act_perm_upas_tolerated"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_activi_wheel] ? @"1": @"0"] forKey:@"act_perm_wheelchair"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_activi_trans] ? @"1": @"0"] forKey:@"act_perm_transfer_bed"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_activi_walker] ? @"1": @"0"] forKey:@"act_perm_walker"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_activi_part] ? @"1": @"0"] forKey:@"act_perm_partial_weight"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_activi_indepe] ? @"1": @"0"] forKey:@"act_perm_independent_home"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_activi_other] ? @"1": @"0"] forKey:@"act_perm_other"];
    [formData setObject:NonNilString(txt_activity_other.text) forKey:@"act_perm_other_text"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_respi_np] ? @"1": @"0"] forKey:@"resp_no_problem"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_respi_dysOnExer] ? @"1": @"0"] forKey:@"resp_dyspnea_on_exertion"];
    [formData setObject:NonNilString(txt_resp_ft.text) forKey:@"resp_dyspnea_on_exertion_value"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_respi_dyspAtRest] ? @"1": @"0"] forKey:@"resp_dyspnea_at_rest"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_respi_tachy] ? @"1": @"0"] forKey:@"resp_tachypnea"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_respi_sob] ? @"1": @"0"] forKey:@"resp_sob_at_rest"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_cough_dry] ? @"1": @"0"] forKey:@"resp_cough_dry"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_cough_pro] ? @"1": @"0"] forKey:@"resp_cough_productive"];
    [formData setObject:NonNilString(txt_resp_amt.text) forKey:@"resp_cough_secretions_amt"];
    [formData setObject:NonNilString(txt_resp_order.text) forKey:@"resp_cough_secretions_color"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_spec_ann_pnx] ? @"1": @"0"] forKey:@"spl_pop_ann_pnx_vacc"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_spec_ann_flu] ? @"1": @"0"] forKey:@"spl_pop_ann_flu_vacc"];
    [formData setObject:NonNilString(txt_spec_pnx_date.text) forKey:@"spl_pop_ann_pnx_vacc_date"];
    [formData setObject:NonNilString(txt_spec_flu_date.text) forKey:@"spl_pop_ann_flu_vacc_date"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_cardio_np] ? @"1": @"0"] forKey:@"cv_no_problem"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_cardio_tachy] ? @"1": @"0"] forKey:@"cv_tachycardic"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_cardio_ortho] ? @"1": @"0"] forKey:@"cv_orthopnea"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_cardio_dia] ? @"1": @"0"] forKey:@"cv_diaphoretic"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_cardio_chest] ? @"1": @"0"] forKey:@"cv_chest_pain"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_cardio_sob] ? @"1": @"0"] forKey:@"cv_sob"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_edema_noEd] ? @"1": @"0"] forKey:@"cv_edema_not_present"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_edema_noPi] ? @"1": @"0"] forKey:@"cv_edema_no_pittong"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_edema_pi] ? @"1": @"0"] forKey:@"cv_edema_pitting"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_nutri_has] ? @"1": @"0"] forKey:@"nut_screen_lost_gained"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_nutri_bodLess] ? @"1": @"0"] forKey:@"nut_screen_body_mass_lt"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_nutri_bodMore] ? @"1": @"0"] forKey:@"nut_screen_body_mass_gt"];
    [formData setObject:NonNilString(txt_bmi.text) forKey:@"nut_screen_bmi_value"];
    //[formData setObject:@"" forKey:@"edit"];

    [self callSubmitAPI];
}


-(void)callSubmitAPI{
    NIVTIcketView *object_TV = [NIVTIcketView new];
    dispatch_queue_t myQueue = dispatch_queue_create("SUTII", 0);
    [[AppDelegate sharedInstance] showCustomLoader:self];
    
    dispatch_async(myQueue, ^{
        NSDictionary *dicti =[object_TV newPatientHIstoryAPI:formData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            NSLog(@"MESSAGE: %@", dicti);
            if(dicti)
            {
                if ([dicti[@"error"] isEqualToString:@"0"]) {
                    NIVPatientDis *objectVC     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVPatientDis"];
                    objectVC.prevFormData = self.prevFormData;
                    [self.navigationController pushViewController:objectVC animated:YES];
                }
                else{
                    [[AppDelegate sharedInstance] showAlertMessage:dicti[@"msg"]];
                }
            }
        });
    });
}

-(IBAction)nextButtonPressed{
    [universalTextField resignFirstResponder];
    [txt_activity_other resignFirstResponder];
    //[Utils takeScreenshot:d_scrollView];
    
    [self saveFormData];
    
//    NIVPatientDis *objectVC     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVPatientDis"];
//    objectVC.prevFormData = self.prevFormData;
//    [self.navigationController pushViewController:objectVC animated:YES];
}

-(IBAction)backButtonPressed{
    [universalTextField resignFirstResponder];
    [txt_activity_other resignFirstResponder];
    [self.navigationController popViewControllerAnimated:NO];
}

-(IBAction)selectDate:(UIButton*)sender{
    [self dateOne:sender];
}

-(void)dateOne:(UIButton*)sender{
    dateTag = (int)sender.tag;
    if (dateTag == 1 || dateTag == 2) {
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSCalendar *cal = [NSCalendar currentCalendar];
        [comps setDay:0];
        [comps setMonth:0];
        [comps setYear:0];
         picker.date = [cal dateByAddingComponents:comps toDate:[NSDate date] options:0];
        [self createCalendarPopoverFrom:sender];
    }
    else {
        [popoverCon presentPopoverFromRect:CGRectMake(sender.frame.size.width/4-10, sender.frame.size.height/1-10, 1, 10)
                                    inView:sender
                  permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
        [self createCalendarView];
        popoverViewCon.preferredContentSize         = CGSizeMake(320,280);
        [popoverCon setPopoverContentSize:CGSizeMake(320, 280) animated:NO];
    }
}

-(void)createCalendarView{
    calendarView                                = [[[NSBundle mainBundle] loadNibNamed:@"WSCalendarView" owner:self options:nil] firstObject];
    calendarView.tappedDayBackgroundColor       = [UIColor lightGrayColor];
    calendarView.calendarStyle                  = WSCalendarStyleDialog;
    calendarView.isShowEvent                    = false;
    calendarView.delegate                       = self;
    [calendarView setupAppearance];
    [self.view addSubview:calendarView];
    
    calendarViewEvent                           = [[[NSBundle mainBundle] loadNibNamed:@"WSCalendarView" owner:self options:nil] firstObject];
    calendarViewEvent.calendarStyle             = WSCalendarStyleView;
    calendarViewEvent.isShowEvent               = false;
    calendarViewEvent.tappedDayBackgroundColor  = [UIColor lightGrayColor];
    calendarViewEvent.frame                     = CGRectMake(0, 0, popoverViewCon.view.frame.size.width, popoverViewCon.view.frame.size.height);
    calendarViewEvent.delegate                  = self;
    [calendarViewEvent setupAppearance];
    [popoverViewCon.view addSubview:calendarViewEvent];
}

#pragma mark - Checkbox

-(void)setCheckboxes{
    NSArray *buttons = [[NSArray alloc] initWithObjects:btn_diagno_pri, btn_diagno_sec, btn_eyes_np, btn_eyes_blind, btn_eyes_decre, btn_ears_np,btn_ears_deaf, btn_ears_decre, btn_neuro_np, btn_neuro_day, btn_neuro_head, btn_neuro_fat, btn_neuro_numb, btn_mental_alert, btn_mental_com, btn_mental_dis, btn_mental_mem, btn_func_np, btn_func_exec, btn_func_dysp, btn_func_slurr, btn_respi_np, btn_respi_dysOnExer, btn_respi_dyspAtRest, btn_respi_tachy, btn_respi_sob, btn_cough_dry, btn_cough_pro, btn_cardio_np, btn_cardio_ortho, btn_cardio_chest, btn_cardio_tachy, btn_cardio_dia, btn_cardio_sob, btn_edema_noEd, btn_edema_noPi, btn_edema_pi, btn_musc_np, btn_musc_amp, btn_musc_para, btn_musc_quad, btn_musc_poor, btn_musc_men, btn_adl_inde, btn_adl_assi, btn_adl_depe, btn_activi_noRes, btn_activi_comp, btn_activi_bed, btn_activi_up, btn_activi_trans, btn_activi_part, btn_activi_other, btn_activi_crut, btn_activi_cane, btn_activi_pros, btn_activi_wheel, btn_activi_walker, btn_activi_indepe, btn_spec_ann_pnx, btn_spec_ann_flu, btn_nutri_has, btn_nutri_bodLess,btn_nutri_bodMore,  nil];
    [Utils uncheckBoxes:buttons];
}

-(IBAction)selectCheck:(UIButton*)sender{
    [universalTextField resignFirstResponder];
    [Utils performCheckboxSelection:sender];
    
    if (sender == btn_cough_pro) {
        if ([Utils isChecked:btn_cough_pro]) {
            txt_resp_amt.enabled = YES;
            txt_resp_order.enabled = YES;
            [txt_resp_amt becomeFirstResponder];
        }
        else {
            txt_resp_amt.text = @"";
            txt_resp_order.text = @"";
            txt_resp_amt.enabled = NO;
            txt_resp_order.enabled = NO;
        }
    }
    
    if (sender == btn_respi_dysOnExer) {
        if ([Utils isChecked:btn_respi_dysOnExer]) {
            txt_resp_ft.enabled = YES;
            [txt_resp_ft becomeFirstResponder];
        }
        else {
            txt_resp_ft.text = @"";
            txt_resp_ft.enabled = NO;
        }
    }
    
    if (sender == btn_activi_other) {
        if ([Utils isChecked:btn_activi_other]) {
            txt_activity_other.editable = YES;
            [txt_activity_other becomeFirstResponder];
        }
        else {
            txt_activity_other.text = @"";
            txt_activity_other.editable = NO;
        }
    }
}



#pragma mark - Dates

-(void)autoFillDates{
    NSArray *textFields = [[NSArray alloc] initWithObjects:txt_spec_pnx_date, txt_spec_flu_date, nil];
    [Utils setTodaysDateToTextFields:textFields];
}

#pragma mark WSCalendarViewDelegate

-(void)didTapLabel:(WSLabel *)lblView withDate:(NSDate *)selectedDate
{
    switch (dateTag) {
        case 1:txt_spec_pnx_date.text = [Utils setDateFormatFormString:selectedDate];
            break;
        case 2:txt_spec_flu_date.text = [Utils setDateFormatFormString:selectedDate];
            break;
            
        default:
            break;
    }
    [popoverCon dismissPopoverAnimated:NO];
}

-(void)deactiveWSCalendarWithDate:(NSDate *)selectedDate{
}

-(NSArray *)setupEventForDate{
    return eventArray;
}

#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    universalTextField  = textField;
    if (![@[txt_pt_first, txt_pt_middle, txt_pt_last, txt_diag_primary, txt_diag_secondary] containsObject:universalTextField]){
        d_point             = d_scrollView.contentOffset;
        
        CGPoint point;
        CGRect rect         = [textField bounds];
        rect                = [textField convertRect:rect toView:d_scrollView];
        point               = rect.origin;
        point.x             = 0;
        point.y             -= 120;
        [UIView animateWithDuration:0.5 animations:^{
            [d_scrollView setContentOffset:point animated:NO];
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.returnKeyType == UIReturnKeyDone) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    CGPoint point;
    CGRect rect = [textView bounds];
    rect        = [textView convertRect:rect toView:d_scrollView];
    point       = rect.origin;
    point.x     = 0;
    point.y     -= 120;
    [UIView animateWithDuration:0.5 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
}

@end
