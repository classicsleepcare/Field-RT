//
//  NIVPatientProg.m
//  RT APP
//
//  Created by Anil Prasad on 14/11/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import "NIVPatientProg.h"

@interface NIVPatientProg ()

@end

@implementation NIVPatientProg
@synthesize formData;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCheckboxes];
    [self autoFillDates];
    txt_pt_name.text = self.prevFormData[@"pt_name"];
    txt_therapist_name.text = RT_NAME;
    
    d_scrollView.contentSize                    = CGSizeMake(880, 2100);
    d_scrollView.contentOffset                  = CGPointMake(0,0);
    
    popoverViewCon                              = [[UIViewController alloc]init];
    popoverViewCon.preferredContentSize         = CGSizeMake(320,298);
    calendarViewController.frame                = CGRectMake(0, 0, CGRectGetWidth(popoverViewCon.view.bounds),CGRectGetHeight(popoverViewCon.view.bounds));
    [popoverViewCon.view addSubview:calendarViewController];
    popoverCon                                  = [[UIPopoverController alloc] initWithContentViewController:popoverViewCon];
    
    formData = [NSMutableDictionary new];

}

-(void)saveFormData{
    [formData setObject:self.prevFormData[@"ticket_id"] forKey:@"ticket_id"];
    [formData setObject:RT_ID forKey:@"rt_id"];
    [formData setObject:self.prevFormData[@"Pt_ID"] forKey:@"pt_id"];
    [formData setObject:self.prevFormData[@"Dr_ID"] forKey:@"dr_id"];
    [formData setObject:NonNilString(str_date) forKey:@"date"];
    [formData setObject:NonNilString(txt_reason.text) forKey:@"reason_for_visit"];
    [formData setObject:NonNilString(txt_obj_bp.text) forKey:@"obj_data_bp"];
    [formData setObject:NonNilString(txt_obj_pulse.text) forKey:@"obj_data_pulse"];
    [formData setObject:NonNilString(txt_obj_resp.text) forKey:@"obj_data_respirations"];
    [formData setObject:NonNilString(txt_obj_fev1.text) forKey:@"obj_data_fev_lit"];
    [formData setObject:NonNilString(txt_obj_fev2.text) forKey:@"obj_data_fev_per"];
    [formData setObject:NonNilString(txt_obj_fevfvc1.text) forKey:@"obj_data_fevfvc_lit"];
    [formData setObject:NonNilString(txt_obj_fevfvc2.text) forKey:@"obj_data_fevfvc_per"];
    [formData setObject:NonNilString(txt_obj_pef1.text) forKey:@"obj_data_pef_lit"];
    [formData setObject:NonNilString(txt_obj_pef2.text) forKey:@"obj_data_pef_per"];
    [formData setObject:NonNilString(txt_obj_weight.text) forKey:@"obj_data_weight"];
    [formData setObject:NonNilString(txt_obj_lpm1.text) forKey:@"obj_data_oxy_sat_per"];
    [formData setObject:NonNilString(txt_obj_lpm2.text) forKey:@"obj_data_oxy_sat_lpm"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_clear_bilateral] ? @"1": @"0"] forKey:@"aus_clear_bilateral"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)apr_rates.selectedButton.tag] forKey:@"aus_rales"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)apr_crepitant.selectedButton.tag] forKey:@"aus_crepitant"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)apr_wheezing_aus.selectedButton.tag] forKey:@"aus_wheezing"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)apr_diminished.selectedButton.tag] forKey:@"aus_diminished"];
    [formData setObject:NonNilString(txt_auscu_location.text) forKey:@"aus_diminished_location"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)apr_edema.selectedButton.tag] forKey:@"skin_app_edema"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)apr_crepitant_skin.selectedButton.tag] forKey:@"skin_app_cyanosis"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)apr_wheezing_skin.selectedButton.tag] forKey:@"skin_app_clubbing"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)apr_diminished_skin.selectedButton.tag] forKey:@"skin_app_diaphoresis"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_ventilator] ? @"1": @"0"] forKey:@"equip_present_ventilator"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_cpap] ? @"1": @"0"] forKey:@"equip_present_CPAP"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_oxy_concen] ? @"1": @"0"] forKey:@"equip_present_oxy_conc"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_suction] ? @"1": @"0"] forKey:@"equip_present_suction_machine"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_nebulizer] ? @"1": @"0"] forKey:@"equip_present_nebulizer"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_bipap] ? @"1": @"0"] forKey:@"equip_present_bipap"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_oxy_cylinders] ? @"1": @"0"] forKey:@"equip_present_oxy_cyl"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_cough] ? @"1": @"0"] forKey:@"equip_present_cough_assist"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_other] ? @"1": @"0"] forKey:@"equip_present_other"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_cleanliness] ? @"1": @"0"] forKey:@"equip_check_cleanliness"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_alarm_set] ? @"1": @"0"] forKey:@"equip_check_alarm_set"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_event] ? @"1": @"0"] forKey:@"equip_check_event_log"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_no_visible] ? @"1": @"0"] forKey:@"equip_check_no_damage"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_alarm_history] ? @"1": @"0"] forKey:@"equip_check_alarm_history"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_date_time] ? @"1": @"0"] forKey:@"equip_check_datetime"];
    [formData setObject:NonNilString(txt_notes.text) forKey:@"notes_from_visit"];
    [formData setObject:NonNilString(txt_others.text) forKey:@"others_present"];
    if (img_patient.image != nil) [formData setObject:img_patient.image forKey:@"patient_sign"];
    if (img_caregiver.image != nil) [formData setObject:img_caregiver.image forKey:@"caregiver_sign"];
    if (img_therapist.image != nil) [formData setObject:img_therapist.image forKey:@"therapist_sign"];
    [formData setObject:NonNilString(str_nextVisit_date) forKey:@"next_visit"];
//    [formData setObject:@"" forKey:@"edit"];

    [self callSubmitAPI];
}

-(void)callSubmitAPI{
    NIVTIcketView *object_TV = [NIVTIcketView new];
    dispatch_queue_t myQueue = dispatch_queue_create("SUTII", 0);
    [[AppDelegate sharedInstance] showCustomLoader:self];
    
    dispatch_async(myQueue, ^{
        NSDictionary *dicti =[object_TV patientProgAPI:formData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            NSLog(@"MESSAGE: %@", dicti);
            if(dicti)
            {
                if ([dicti[@"error"] isEqualToString:@"0"]) {
                    NIVTakeCOPD *objectVC     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVTakeCOPD"];
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
    [universalTextView resignFirstResponder];
    [universalTextField resignFirstResponder];
    //[Utils takeScreenshot:d_scrollView];
    
    [self saveFormData];
    
//    NIVTakeCOPD *objectVC     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVTakeCOPD"];
//    [self.navigationController pushViewController:objectVC animated:YES];
}

-(IBAction)backButtonPressed{
    [universalTextView resignFirstResponder];
    [universalTextField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)setCheckboxes{
    NSArray *buttons = [[NSArray alloc] initWithObjects:btn_clear_bilateral,
                        btn_ventilator,
                        btn_cpap,
                        btn_oxy_concen,
                        btn_suction,
                        btn_other,
                        btn_nebulizer,
                        btn_bipap,
                        btn_oxy_cylinders,
                        btn_cough,
                        btn_cleanliness,
                        btn_alarm_set,
                        btn_event,
                        btn_no_visible,
                        btn_alarm_history,
                        btn_date_time,nil];
    [Utils uncheckBoxes:buttons];
}

-(IBAction)selectCheck:(UIButton*)sender{
    [universalTextField resignFirstResponder];
    [Utils performCheckboxSelection:sender];
    
//    if (sender == btn_cough_pro) {
//        if ([Utils isChecked:btn_cough_pro]) {
//            txt_resp_amt.enabled = YES;
//            txt_resp_order.enabled = YES;
//            [txt_resp_amt becomeFirstResponder];
//        }
//        else {
//            txt_resp_amt.text = @"";
//            txt_resp_order.text = @"";
//            txt_resp_amt.enabled = NO;
//            txt_resp_order.enabled = NO;
//        }
//    }
    
    
}


#pragma mark -
#pragma mark - Dates
-(IBAction)selectDate:(UIButton*)sender{
    [self dateOne:sender];
}

-(void)dateOne:(UIButton*)sender{
    dateTag = (int)sender.tag;
    
    if (dateTag == 2) {
        [popoverCon presentPopoverFromRect:CGRectMake(sender.frame.size.width/2, sender.frame.size.height/1, 1, -30)
                                    inView:sender
                  permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    }
    else{
        [popoverCon presentPopoverFromRect:CGRectMake(sender.frame.size.width/2, sender.frame.size.height/1, 1, 1)
                                    inView:sender
                  permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    
    [self createCalendarView];
    popoverViewCon.preferredContentSize         = CGSizeMake(320,280);
    [popoverCon setPopoverContentSize:CGSizeMake(320, 280) animated:NO];
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
#pragma mark - Dates

-(void)autoFillDates{
    NSArray *textFields = [[NSArray alloc] initWithObjects:txt_date, nil];
    [Utils setTodaysDateToTextFields:textFields];
    str_date = [Utils setDateFormatForAPI:[NSDate date]];
}

#pragma mark WSCalendarViewDelegate

-(void)didTapLabel:(WSLabel *)lblView withDate:(NSDate *)selectedDate
{
    switch (dateTag) {
        case 1:txt_date.text = [Utils setDateFormatFormString:selectedDate];
            str_date = [Utils setDateFormatForAPI:[NSDate date]];
            break;
        case 2:txt_nextVisit_date.text = [Utils setDateFormatFormString:selectedDate];
            str_nextVisit_date = [Utils setDateFormatForAPI:selectedDate];
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

#pragma mark - Initials

-(IBAction)selectSignature:(UIButton*)sender{
    [universalTextView resignFirstResponder];
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
    switch (sender.tag) {
        case 201:[img_patient setImage:[signaturePanel getSignatureImage]];
            break;
        case 202:[img_caregiver setImage:[signaturePanel getSignatureImage]];
            break;
        case 203:[img_therapist setImage:[signaturePanel getSignatureImage]];
            break;
            
        default:
            break;
    }
    [signatureBackgroundView removeFromSuperview];
}

-(void)clearInitialsView{
    [signaturePanel clearSignature];
}

-(void)closeInitialsView{
    [signatureBackgroundView removeFromSuperview];
}


#pragma mark - UITextView Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    universalTextView = textView;
    
    CGPoint point;
    CGRect rect = [textView bounds];
    rect        = [textView convertRect:rect toView:d_scrollView];
    point       = rect.origin;
    point.x     = 0;
    point.y     -= 60;
    [UIView animateWithDuration:0.5 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
}

#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    universalTextField  = textField;
    if (![@[txt_pt_name, txt_therapist_name] containsObject:universalTextField]){
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

@end
