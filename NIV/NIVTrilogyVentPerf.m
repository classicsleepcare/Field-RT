//
//  NIVTrilogyVentPerf.m
//  RT APP
//
//  Created by Anil Prasad on 11/30/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import "NIVTrilogyVentPerf.h"

@interface NIVTrilogyVentPerf ()

@end

@implementation NIVTrilogyVentPerf
@synthesize formData;

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
    [rad_mode_avaps_ae setSelected:YES];
}



-(void)saveFormData{
    [formData setObject:self.prevFormData[@"ticket_id"] forKey:@"ticket_id"];
    [formData setObject:RT_ID forKey:@"rt_id"];
    [formData setObject:self.prevFormData[@"pt_id"] forKey:@"pt_id"];
    [formData setObject:NonNilString(str_pt_dob) forKey:@"dob"];
    [formData setObject:NonNilString(txt_vent_type1.text) forKey:@"ventilator_type1"];
    [formData setObject:NonNilString(txt_vent_serial1.text) forKey:@"ventilator_serial1"];
    [formData setObject:NonNilString(txt_vent_hours1.text) forKey:@"ventilator_hours1"];
    [formData setObject:NonNilString(txt_vent_due1.text) forKey:@"ventilator_pmdue1"];
    [formData setObject:NonNilString(txt_vent_type2.text) forKey:@"ventilator_type2"];
    [formData setObject:NonNilString(txt_vent_serial2.text) forKey:@"ventilator_serial2"];
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
    
    [formData setObject:NonNilString(txt_vent_pip.text) forKey:@"ventilator_mparam_pip"];
    [formData setObject:NonNilString(txt_vent_rr.text) forKey:@"ventilator_mparam_rr"];
    [formData setObject:NonNilString(txt_vent_ie.text) forKey:@"ventilator_mparam_ie"];
    [formData setObject:NonNilString(txt_vent_map.text) forKey:@"ventilator_mparam_map"];
    [formData setObject:NonNilString(txt_vent_vte_vti.text) forKey:@"ventilator_mparam_vte"];
    [formData setObject:NonNilString(txt_vent_leak.text) forKey:@"ventilator_mparam_leak"];
    [formData setObject:NonNilString(txt_vent_ve.text) forKey:@"ventilator_mparam_ve"];
    [formData setObject:NonNilString(txt_vent_peakFlow.text) forKey:@"ventilator_mparam_peak_flow"];
    
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_mode_avaps_ae.selectedButton.tag] forKey:@"mode_type"];
    
    if (rad_mode_avaps_ae.selectedButton.tag == 0) {
        [formData setObject:NonNilString(txt_mode_avaps_ae_vtTarget.text) forKey:@"vt_target_vt"];
        [formData setObject:NonNilString(txt_mode_avaps_ae_breath.text) forKey:@"breath_rate"];
        [formData setObject:NonNilString(txt_mode_avaps_ae_maxPreSupp.text) forKey:@"max_pressure_support"];
        [formData setObject:NonNilString(txt_mode_avaps_ae_minPreSupp.text) forKey:@"min_pressure_support"];
        [formData setObject:NonNilString(txt_mode_avaps_ae_maxPre.text) forKey:@"max_pressure"];
        [formData setObject:NonNilString(txt_mode_avaps_ae_maxEPAP.text) forKey:@"max_epap"];
        [formData setObject:NonNilString(txt_mode_avaps_ae_minEPAP.text) forKey:@"min_epap"];
        [formData setObject:NonNilString(txt_mode_avaps_ae_O2.text) forKey:@"o2"];
        [formData setObject:NonNilString(txt_mode_avaps_ae_mpv.text) forKey:@"mpv"];
        [formData setObject:NonNilString(txt_mode_avaps_ae_avapsRate.text) forKey:@"avaps_rate"];
        [formData setObject:NonNilString(txt_mode_avaps_ae_flow_sen.text) forKey:@"avapsae_trigger_flow_s"];
        [formData setObject:NonNilString(txt_mode_avaps_ae_flow_cyc.text) forKey:@"avapsae_trigger_flow_cs"];
        [formData setObject:NonNilString(txt_mode_avaps_ae_riseTime.text) forKey:@"rise_time"];
        [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_rampLenght_avaps_ae.selectedButton.tag] forKey:@"ramp_length"];
        [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_trigger_avaps_ae.selectedButton.tag] forKey:@"avapsae_trigger"];
    }
    else {
        [formData setObject:NonNilString(txt_mode_avaps_vtTarget.text) forKey:@"vt_target_vt"];
        [formData setObject:NonNilString(txt_mode_avaps_breath.text) forKey:@"breath_rate"];
        [formData setObject:NonNilString(txt_mode_avaps_inspir.text) forKey:@"inspiratory_time"];
        [formData setObject:NonNilString(txt_mode_avaps_maxIPAP.text) forKey:@"max_ipap"];
        [formData setObject:NonNilString(txt_mode_avaps_minIPAP.text) forKey:@"min_ipap"];
        [formData setObject:NonNilString(txt_mode_avaps_epap.text) forKey:@"epap"];
        [formData setObject:NonNilString(txt_mode_avaps_O2.text) forKey:@"o2"];
        [formData setObject:NonNilString(txt_mode_avaps_avapsRate.text) forKey:@"avaps_rate"];
        [formData setObject:NonNilString(txt_mode_avaps_riseTIme.text) forKey:@"rise_time"];
        [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_rampLenght_avaps.selectedButton.tag] forKey:@"ramp_length"];
        [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_trigger_avaps.selectedButton.tag] forKey:@"avaps_trigger"];
    }
    
    [formData setObject:NonNilString(txt_alarm_pri_circ.text) forKey:@""];
    [formData setObject:NonNilString(txt_alarm_pri_apnea.text) forKey:@""];
    [formData setObject:NonNilString(txt_alarm_pri_low_insp.text) forKey:@""];
    [formData setObject:NonNilString(txt_alarm_pri_high_insp.text) forKey:@""];
    [formData setObject:NonNilString(txt_alarm_pri_low_vte.text) forKey:@""];
    [formData setObject:NonNilString(txt_alarm_pri_high_vte.text) forKey:@""];
    [formData setObject:NonNilString(txt_alarm_pri_low_ve.text) forKey:@""];
    [formData setObject:NonNilString(txt_alarm_pri_high_ve.text) forKey:@""];
    [formData setObject:NonNilString(txt_alarm_pri_low_rr.text) forKey:@""];
    [formData setObject:NonNilString(txt_alarm_pri_high_rr.text) forKey:@""];
    
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_resuscitation.selectedButton.tag] forKey:@"res_bag"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_batteries.selectedButton.tag] forKey:@"batteries"];
    [formData setObject:NonNilString(txt_alarm_level.text) forKey:@"level_of_charge"];
    [formData setObject:NonNilString(txt_alarm_number.text) forKey:@"num_cycles"];
    [formData setObject:NonNilString(txt_alarm_hum.text) forKey:@"humidifier"];
    [formData setObject:NonNilString(txt_alarm_serial.text) forKey:@"serial"];
    [formData setObject:NonNilString(txt_mpv_pc_ipap) forKey:@"mpv_pc_ipap"];
    [formData setObject:NonNilString(txt_mpv_pc_epap.text) forKey:@"mpv_pc_epap"];
    [formData setObject:NonNilString(txt_mpv_pc_breath.text) forKey:@"mpv_pc_breath_rate"];
    [formData setObject:NonNilString(txt_mpv_pc_return.text) forKey:@"mpv_pc_return_vt"];
    [formData setObject:NonNilString(txt_mpv_ac_target.text) forKey:@"mpv_ac_target_vt"];
    [formData setObject:NonNilString(txt_mpv_ac_peep.text) forKey:@"mpv_ac_peep"];
    [formData setObject:NonNilString(txt_mpv_ac_breath.text) forKey:@"mpv_ac_breath_rate"];
    [formData setObject:NonNilString(txt_mpv_ac_return.text) forKey:@"mpv_ac_return_vt"];
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
        NSDictionary *dicti =[object_TV trilogyVentPerfAPI:formData];
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

#pragma mark -
#pragma mark - Radio Action

-(IBAction)selectCheckbox:(APRadioButton*)sender{
    [universalTextField resignFirstResponder];
    
    if (sender == rad_mode_avaps_ae){
        view_mode_avaps_ae.hidden = NO;
        view_mode_avaps.hidden = YES;
        [self reset_avaps_mode];
    }
    
    if (sender == rad_mode_avaps) {
        view_mode_avaps_ae.hidden = YES;
        view_mode_avaps.hidden = NO;
        [self reset_avaps_ae_mode];
    }
    
    if (sender == rad_trigger_avaps_ae) {
        view_mode_avaps_ae_flow.hidden = NO;
    }
    if (sender == rad_trigger_avaps_ae1) {
        view_mode_avaps_ae_flow.hidden = YES;
        [Utils emptyTextFields:@[txt_mode_avaps_ae_flow_sen,
                                 txt_mode_avaps_ae_flow_cyc]];
    }
    if (sender == rad_trigger_avaps_ae2) {
        view_mode_avaps_ae_flow.hidden = YES;
        [Utils emptyTextFields:@[txt_mode_avaps_ae_flow_sen,
                                 txt_mode_avaps_ae_flow_cyc]];
    }
}

-(void)reset_avaps_ae_mode{
    [Utils emptyTextFields:@[txt_mode_avaps_ae_vtTarget,
                             txt_mode_avaps_ae_breath,
                             txt_mode_avaps_ae_maxPreSupp,
                             txt_mode_avaps_ae_minPreSupp,
                             txt_mode_avaps_ae_maxPre,
                             txt_mode_avaps_ae_maxEPAP,
                             txt_mode_avaps_ae_minEPAP,
                             txt_mode_avaps_ae_O2,
                             txt_mode_avaps_ae_mpv,
                             txt_mode_avaps_ae_avapsRate,
                             txt_mode_avaps_ae_riseTime,
                             txt_mode_avaps_ae_flow_sen,
                             txt_mode_avaps_ae_flow_cyc]];
}

-(void)reset_avaps_mode{
    [Utils emptyTextFields:@[txt_mode_avaps_vtTarget, 
                             txt_mode_avaps_breath, 
                             txt_mode_avaps_inspir, 
                             txt_mode_avaps_maxIPAP, 
                             txt_mode_avaps_minIPAP, 
                             txt_mode_avaps_epap, 
                             txt_mode_avaps_O2, 
                             txt_mode_avaps_avapsRate, 
                             txt_mode_avaps_riseTIme]];
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
