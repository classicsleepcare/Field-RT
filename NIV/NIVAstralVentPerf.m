//
//  NIVAstralVentPerf.m
//  RT APP
//
//  Created by Anil Prasad on 11/30/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import "NIVAstralVentPerf.h"

@interface NIVAstralVentPerf ()

@end

@implementation NIVAstralVentPerf
@synthesize formData, dict_retrivedData, dict_retrivedData_local;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self autoFillDates];
    txt_pt_name.text = self.prevFormData[@"pt_name"];
    txt_alarm_hum.text = self.prevFormData[@"humidifier"];
    txt_alarm_serial.text = self.prevFormData[@"serial"];
    
    d_scrollView.contentSize                    = CGSizeMake(880, 2100);
    d_scrollView.contentOffset                  = CGPointMake(0,0);
    
    popoverViewCon                              = [[UIViewController alloc]init];
    popoverViewCon.preferredContentSize         = CGSizeMake(320,298);
    calendarViewController.frame                = CGRectMake(0, 0, CGRectGetWidth(popoverViewCon.view.bounds),CGRectGetHeight(popoverViewCon.view.bounds));
    [popoverViewCon.view addSubview:calendarViewController];
    popoverCon                                  = [[UIPopoverController alloc] initWithContentViewController:popoverViewCon];
    
    formData = [NSMutableDictionary new];
    [rad_mode_ivap setSelected:YES];

}



-(void)saveFormData{
    [formData setObject:self.prevFormData[@"ticket_id"] forKey:@"ticket_id"];
    [formData setObject:RT_ID forKey:@"rt_id"];
    [formData setObject:self.prevFormData[@"pt_id"] forKey:@"pt_id"];
    [formData setObject:NonNilString(str_pt_dob) forKey:@"dob"];
    [formData setObject:NonNilString(txt_vent_type1.text) forKey:@"ventilator_type1"];
    [formData setObject:NonNilString(txt_vent_serial1.text) forKey:@"ventilator_serial1"];
    [formData setObject:NonNilString(txt_vent_DN1.text) forKey:@"ventilator_dn1"];
    [formData setObject:NonNilString(txt_vent_hours1.text) forKey:@"ventilator_hours1"];
    [formData setObject:NonNilString(txt_vent_due1.text) forKey:@"ventilator_pmdue1"];
    [formData setObject:NonNilString(txt_vent_type2.text) forKey:@"ventilator_type2"];
    [formData setObject:NonNilString(txt_vent_serial2.text) forKey:@"ventilator_serial2"];
    [formData setObject:NonNilString(txt_vent_DN2.text) forKey:@"ventilator_dn2"];
    [formData setObject:NonNilString(txt_vent_hours2.text) forKey:@"ventilator_hours2"];
    [formData setObject:NonNilString(txt_vent_due2.text) forKey:@"ventilator_pmdue2"];
    [formData setObject:NonNilString(txt_vent_hours_of_use.text) forKey:@"ventilator_hours_prescribed"];
    
    if (rad_interface.selectedButton.tag == 0) {
        [formData setObject:@"1" forKey:@"ventilator_interface_trach"];
    }else if (rad_interface.selectedButton.tag == 1) {
        [formData setObject:@"1" forKey:@"ventilator_interface_mask"];
    }else if (rad_interface.selectedButton.tag == 2) {
        [formData setObject:@"1" forKey:@"ventilator_interface_mouthpiece"];
    }
    else{
        [formData setObject:@"0" forKey:@"ventilator_interface_trach"];
        [formData setObject:@"0" forKey:@"ventilator_interface_mask"];
        [formData setObject:@"0" forKey:@"ventilator_interface_mouthpiece"];
    }
    
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_mode_ivap.selectedButton.tag] forKey:@"mode_type"];

    if (rad_mode_ivap.selectedButton.tag == 0) {
        [formData setObject:NonNilString(txt_ivap_height.text) forKey:@"height"];
        [formData setObject:NonNilString(txt_ivap_average.text) forKey:@"avg_vt"];
        [formData setObject:NonNilString(txt_ivap_targetPtRate.text) forKey:@"target_patient_rate"];
        [formData setObject:NonNilString(txt_ivap_targetVa.text) forKey:@"target_va"];
        [formData setObject:NonNilString(txt_ivap_epap.text) forKey:@"epap"];
        [formData setObject:NonNilString(txt_ivap_max_press.text) forKey:@"max_pressure_support"];
        [formData setObject:NonNilString(txt_ivap_rise_time.text) forKey:@"rise_time"];
        [formData setObject:NonNilString(txt_ivap_ti_min.text) forKey:@"ti_min"];
        [formData setObject:NonNilString(txt_ivap_ti_max.text) forKey:@"ti_max"];
        [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_trigger_ivap.selectedButton.tag] forKey:@"ivaps_trigger"];
        [formData setObject:NonNilString(txt_ivap_cycle.text) forKey:@"cycle_percent"];
        [formData setObject:NonNilString(txt_ivap_O2.text) forKey:@"o2"];
    } else {
        [formData setObject:NonNilString(txt_ps_height.text) forKey:@"height"];
        [formData setObject:NonNilString(txt_ps_press.text) forKey:@"pressure"];
        [formData setObject:NonNilString(txt_ps_safety.text) forKey:@"safety_vt"];
        [formData setObject:NonNilString(txt_ps_peep.text) forKey:@"peep"];
        [formData setObject:NonNilString(txt_ps_resp.text) forKey:@"respiratory_rate"];
        [formData setObject:NonNilString(txt_ps_max_press.text) forKey:@"max_pressure_support"];
        [formData setObject:NonNilString(txt_ps_rise_time.text) forKey:@"rise_time"];
        [formData setObject:NonNilString(txt_ps_ti_min.text) forKey:@"ti_min"];
        [formData setObject:NonNilString(txt_ps_ti_max.text) forKey:@"ti_max"];
        [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_trigger_ps.selectedButton.tag] forKey:@"ps_trigger"];
        [formData setObject:NonNilString(txt_ps_cycle.text) forKey:@"cycle_percent"];
    }
        
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_disconnect_alarm.selectedButton.tag] forKey:@"disconnect_alarm"];
    [formData setObject:NonNilString(txt_alarm_vte_low.text) forKey:@"vte_low"];
    [formData setObject:NonNilString(txt_alarm_vte_high.text) forKey:@"vte_high"];
    [formData setObject:NonNilString(txt_alarm_mve_low.text) forKey:@"mve_low"];
    [formData setObject:NonNilString(txt_alarm_mve_high.text) forKey:@"mve_high"];
    [formData setObject:NonNilString(txt_alarm_press_low.text) forKey:@"pressure_low"];
    [formData setObject:NonNilString(txt_alarm_press_high.text) forKey:@"pressure_high"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_low_peep_alarm.selectedButton.tag] forKey:@"low_peep"];
    [formData setObject:NonNilString(txt_alarm_resp_low.text) forKey:@"respiratory_rate_low"];
    [formData setObject:NonNilString(txt_alarm_resp_high.text) forKey:@"respiratory_rate_high"];
    [formData setObject:NonNilString(txt_alarm_apnea.text) forKey:@"apnea_detection"];
    [formData setObject:NonNilString(txt_alarm_leak.text) forKey:@"leak"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_resuscitation.selectedButton.tag] forKey:@"res_bag"];
    [formData setObject:NonNilString(txt_alarm_hum.text) forKey:@"humidifier"];
    [formData setObject:NonNilString(txt_alarm_serial.text) forKey:@"serial"];
    [formData setObject:NonNilString(txt_obs_press.text) forKey:@"obs_vent_pressure"];
    [formData setObject:NonNilString(txt_obs_pip.text) forKey:@"obs_vent_pip"];
    [formData setObject:NonNilString(txt_obs_peep.text) forKey:@"obs_vent_peep"];
    [formData setObject:NonNilString(txt_obs_mve.text) forKey:@"obs_vent_mve"];
    [formData setObject:NonNilString(txt_obs_rr.text) forKey:@"obs_vent_rr"];
    [formData setObject:NonNilString(txt_obs_vte.text) forKey:@"obs_vent_vte"];
    [formData setObject:NonNilString(txt_obs_leak.text) forKey:@"obs_vent_leak"];
    [formData setObject:NonNilString(txt_obs_rise.text) forKey:@"obs_vent_rise"];
    [formData setObject:NonNilString(txt_obs_ti.text) forKey:@"obs_vent_ti"];
    [formData setObject:NonNilString(txt_obs_spont_trig.text) forKey:@"obs_vent_percent_spont_trig"];
    [formData setObject:NonNilString(txt_obs_spont_cyc.text) forKey:@"obs_vent_percent_spont_cyc"];
    [formData setObject:NonNilString(txt_obs_ave_vt.text) forKey:@"obs_vent_ave_vt"];
    [formData setObject:NonNilString(txt_obs_ave_vtkg.text) forKey:@"obs_vent_ave_vtkg"];
    [formData setObject:NonNilString(txt_obs_target.text) forKey:@"obs_vent_target_va"];
    [formData setObject:NonNilString(txt_mpv_itime.text) forKey:@"mpv_pacv_itime"];
    [formData setObject:NonNilString(txt_mpv_vol.text) forKey:@"mpv_pacv_volume"];
    [formData setObject:NonNilString(txt_mpv_resp.text) forKey:@"mpv_pacv_resp_rate"];
    [formData setObject:NonNilString(txt_mpv_usage.text) forKey:@"usage_per_day"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_nebulizer.selectedButton.tag] forKey:@"nebulizer_inline"];
    [formData setObject:img_clinician.image forKey:@"clinician_sign"];
    [formData setObject:str_clini_date forKey:@"date"];

//    [formData setObject:@"" forKey:@"edit"];
    [self callSubmitAPI];
}

-(BOOL)isSuccessfullyValidated{
    if (img_clinician.image == nil) {
        return false;
    }
    else{
        return true;
    }
}

-(void)callSubmitAPI{
    NIVTIcketView *object_TV = [NIVTIcketView new];
    dispatch_queue_t myQueue = dispatch_queue_create("SUTII", 0);
    [[AppDelegate sharedInstance] showCustomLoader:self];
    
    dispatch_async(myQueue, ^{
        NSDictionary *dicti =[object_TV astralVentPerfAPI:formData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            NSLog(@"MESSAGE: %@", dicti);
            if(dicti)
            {
                if ([dicti[@"error"] isEqualToString:@"0"]) {
                    NIVPatientProg *objectVC     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVPatientProg"];
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
    //[universalTextField resignFirstResponder];
    //[Utils takeScreenshot:d_scrollView];
    
    if ([self isSuccessfullyValidated]) {
        [self saveFormData];
    }
    else{
        [[AppDelegate sharedInstance] showAlertMessage:@"Clinician signature is mandatory."];
    }
    
//    NIVPatientProg *objectVC     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVPatientProg"];
//    [self.navigationController pushViewController:objectVC animated:YES];
}

-(IBAction)backButtonPressed{
    //[universalTextField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - Initials

-(IBAction)selectSignature:(UIButton*)sender{
    [universalTextField resignFirstResponder];
    [self createSignatureView:sender];
}

-(void)createSignatureView:(UIButton*)sender{
    
    signatureBackgroundView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0 ,1024,768)];
    [signatureBackgroundView setBackgroundColor:[UIColor colorWithRed:120.0/255.0 green:120.0/255.0 blue:121.0/255.0 alpha:0.4]];
    [self.view addSubview:signatureBackgroundView];
    [self.view bringSubviewToFront:signatureBackgroundView];
    
    signatureVw                     = [[UIView alloc] initWithFrame:CGRectMake(50, 150, 700, 400)];
    signatureVw.backgroundColor     = [UIColor whiteColor];
    [signatureBackgroundView addSubview:signatureVw];
    
    UIImageView *header             = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 703, 40)];
    header.image                    = [UIImage imageNamed:@"header_bg"];
    header.userInteractionEnabled   = YES;
    [signatureVw addSubview:header];
    
    UILabel *lbl_sign               = [[UILabel alloc] initWithFrame:CGRectMake(0, 1, 700, 30)];
    lbl_sign.text                   = @"Signature";
    lbl_sign.textColor              = [UIColor whiteColor];
    lbl_sign.textAlignment          = NSTextAlignmentCenter;
    lbl_sign.font                   = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    [header addSubview:lbl_sign];
    
    UIButton *btn_close             = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_close.frame                 = CGRectMake(665, 1, 32, 32);
    btn_close.tag                   = 333;
    [btn_close setImage:[UIImage imageNamed:@"close-icon"] forState:UIControlStateNormal];
    [btn_close addTarget:self action:@selector(closeInitialsView) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:btn_close];
    
    UIButton *btn_clear             = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_clear.frame                 = CGRectMake(200, 350, 100, 32);
    btn_clear.backgroundColor       = [UIColor colorWithRed:22.0/255.0 green:125.0/255.0 blue:164.0/255.0 alpha:1.0];
    btn_clear.titleLabel.textColor  = [UIColor whiteColor];
    [btn_clear setTitle:@"Clear" forState:UIControlStateNormal];
    btn_clear.tag                   = 444;
    btn_clear.layer.cornerRadius    = 7;
    btn_clear.clipsToBounds         = YES;
    [btn_clear addTarget:self action:@selector(clearInitialsView) forControlEvents:UIControlEventTouchUpInside];
    [signatureVw addSubview:btn_clear];
    
    UIButton *btn_save1              = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_save1.frame                  = CGRectMake(400, 350, 100, 32);
    btn_save1.backgroundColor        = [UIColor colorWithRed:22.0/255.0 green:125.0/255.0 blue:164.0/255.0 alpha:1.0];
    btn_save1.titleLabel.textColor   = [UIColor whiteColor];
    [btn_save1 setTitle:@"Save" forState:UIControlStateNormal];
    btn_save1.tag                    = sender.tag;
    btn_save1.layer.cornerRadius     = 7;
    btn_save1.clipsToBounds          = YES;
    [btn_save1 addTarget:self action:@selector(saveSignature:) forControlEvents:UIControlEventTouchUpInside];
    [signatureVw addSubview:btn_save1];
    
    UILabel *lbl_info               = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 700, 30)];
    //lbl_info.text                   = @"Initial/Signature on the dotted line and click Save. Press clear to start over.";
    lbl_info.textColor              = [UIColor blackColor];
    lbl_info.textAlignment          = NSTextAlignmentCenter;
    lbl_info.font                   = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f];
    [signatureVw addSubview:lbl_info];
    
    signaturePanel                   = [[SignatureView alloc] initWithFrame:CGRectMake(100, 80, 500, 250)];
    signaturePanel.layer.borderWidth = 1.0;
    signaturePanel.layer.borderColor = [[UIColor blackColor] CGColor];
    [signatureVw addSubview:signaturePanel];
}

-(void)saveSignature:(UIButton*)sender{
    [img_clinician setImage:[signaturePanel getSignatureImage]];
    [signatureBackgroundView removeFromSuperview];
}

-(void)clearInitialsView{
    [signaturePanel clearSignature];
}

-(void)closeInitialsView{
    [signatureBackgroundView removeFromSuperview];
}

#pragma mark - Dates

-(void)autoFillDates{
    NSArray *textFields = [[NSArray alloc] initWithObjects:txt_clini_date, txt_today_date, nil];
    [Utils setTodaysDateToTextFields:textFields];
    NSDate *pt_dob = [Utils stringToDateWithFormat:@"MM-dd-yyy" andStringDate:self.prevFormData[@"pt_dob"]];
    str_pt_dob = [Utils setDateFormatForAPI:pt_dob];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale: [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [formatter setDateFormat:@"MM/dd/yy"];
    txt_pt_dob.text = [formatter stringFromDate:pt_dob];
    
    str_today_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_clini_date = [Utils setDateFormatForAPI:[NSDate date]];
}

#pragma mark -
#pragma mark - Radio Action

-(IBAction)selectCheckbox:(APRadioButton*)sender{
    [universalTextField resignFirstResponder];
    
    if (sender == rad_mode_ivap){
        view_mode_ivap.hidden = NO;
        view_mode_ps.hidden = YES;
        [self reset_ps_mode];
    }
    
    if (sender == rad_mode_ps) {
        view_mode_ivap.hidden = YES;
        view_mode_ps.hidden = NO;
        [self reset_ivap_mode];
    }
}

-(void)reset_ivap_mode{
    [Utils emptyTextFields:@[txt_ivap_height,
                             txt_ivap_average,
                             txt_ivap_targetPtRate,
                             txt_ivap_targetVa,
                             txt_ivap_epap,
                             txt_ivap_min_press,
                             txt_ivap_max_press,
                             txt_ivap_rise_time,
                             txt_ivap_ti_min,
                             txt_ivap_ti_max,
                             txt_ivap_cycle,
                             txt_ivap_O2]];
}

-(void)reset_ps_mode{
    [Utils emptyTextFields:@[txt_ps_height,
                             txt_ps_press,
                             txt_ps_safety,
                             txt_ps_peep,
                             txt_ps_resp,
                             txt_ps_max_press,
                             txt_ps_rise_time,
                             txt_ps_ti_min,
                             txt_ps_ti_max,
                             txt_ps_cycle]];
}


#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    universalTextField = textField;
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.returnKeyType == UIReturnKeyDone) {
        [textField resignFirstResponder];
    }
    return YES;
}

@end
