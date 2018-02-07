//
//  NIVCareComp.m
//  RT APP
//
//  Created by Anil Prasad on 14/11/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import "NIVCareComp.h"

@interface NIVCareComp ()

@end

@implementation NIVCareComp
@synthesize formData;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCheckboxes];
    [self autoFillDates];
    txt_patient_name.text = self.prevFormData[@"pt_name"];
    
    d_scrollView.contentSize                    = CGSizeMake(880, 3420);
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
    [formData setObject:self.prevFormData[@"pt_id"] forKey:@"pt_id"];
    [formData setObject:NonNilString(txt_caregiver_name.text) forKey:@"caregiver_name"];
    [formData setObject:NonNilString(str_thirteen_date) forKey:@"date"];
    [formData setObject:NonNilString(str_one_date) forKey:@"goal1_date"];
    [formData setObject:img_one_initial.image forKey:@"goal1_initials"];
    [formData setObject:NonNilString(str_two_date) forKey:@"goal2_date"];
    [formData setObject:img_two_initial.image forKey:@"goal2_initials"];
    
    if ([Utils isChecked:btn_chk_2_1]) {
        [formData setObject:@"1" forKey:@"goal2_front_start_stop"];
    } else {
        [formData setObject:@"0" forKey:@"goal2_front_start_stop"];
    }
    
    if ([Utils isChecked:btn_chk_2_2]) {
        [formData setObject:@"1" forKey:@"goal2_front_up_down"];
    } else {
        [formData setObject:@"0" forKey:@"goal2_front_up_down"];
    }
    
    if ([Utils isChecked:btn_chk_2_3]) {
        [formData setObject:@"1" forKey:@"goal2_front_ac_power_led"];
    } else {
        [formData setObject:@"0" forKey:@"goal2_front_ac_power_led"];
    }
    
    if ([Utils isChecked:btn_chk_2_4]) {
        [formData setObject:@"1" forKey:@"goal2_front_red_alarm_led"];
    } else {
        [formData setObject:@"0" forKey:@"goal2_front_red_alarm_led"];
    }
    
    if ([Utils isChecked:btn_chk_2_5]) {
        [formData setObject:@"1" forKey:@"goal2_front_audio_pause"];
    } else {
        [formData setObject:@"0" forKey:@"goal2_front_audio_pause"];
    }
    
    if ([Utils isChecked:btn_chk_2_6]) {
        [formData setObject:@"1" forKey:@"goal2_front_left_right"];
    } else {
        [formData setObject:@"0" forKey:@"goal2_front_left_right"];
    }
    
    if ([Utils isChecked:btn_chk_2_7]) {
        [formData setObject:@"1" forKey:@"goal2_front_backlight_led"];
    } else {
        [formData setObject:@"0" forKey:@"goal2_front_backlight_led"];
    }
    
    if ([Utils isChecked:btn_chk_2_8]) {
        [formData setObject:@"1" forKey:@"goal2_front_yellow_alarm_led"];
    } else {
        [formData setObject:@"0" forKey:@"goal2_front_yellow_alarm_led"];
    }
    
    if ([Utils isChecked:btn_chk_2_9]) {
        [formData setObject:@"1" forKey:@"goal2_rear_ac_power_inlet"];
    } else {
        [formData setObject:@"0" forKey:@"goal2_rear_ac_power_inlet"];
    }
    
    if ([Utils isChecked:btn_chk_2_10]) {
        [formData setObject:@"1" forKey:@"goal2_rear_exhalation_port"];
    } else {
        [formData setObject:@"0" forKey:@"goal2_rear_exhalation_port"];
    }
    
    if ([Utils isChecked:btn_chk_2_11]) {
        [formData setObject:@"1" forKey:@"goal2_rear_serial_connector"];
    } else {
        [formData setObject:@"0" forKey:@"goal2_rear_serial_connector"];
    }
    
    if ([Utils isChecked:btn_chk_2_12]) {
        [formData setObject:@"1" forKey:@"goal2_rear_ethernet_connector"];
    } else {
        [formData setObject:@"0" forKey:@"goal2_rear_ethernet_connector"];
    }
    
    if ([Utils isChecked:btn_chk_2_13]) {
        [formData setObject:@"1" forKey:@"goal2_rear_o2_connector"];
    } else {
        [formData setObject:@"0" forKey:@"goal2_rear_o2_connector"];
    }
    
    if ([Utils isChecked:btn_chk_2_14]) {
        [formData setObject:@"1" forKey:@"goal2_rear_detachable_battery_slot"];
    } else {
        [formData setObject:@"0" forKey:@"goal2_rear_detachable_battery_slot"];
    }
    
    if ([Utils isChecked:btn_chk_2_15]) {
        [formData setObject:@"1" forKey:@"goal2_rear_breathing_circuit_conn"];
    } else {
        [formData setObject:@"0" forKey:@"goal2_rear_breathing_circuit_conn"];
    }
    
    if ([Utils isChecked:btn_chk_2_16]) {
        [formData setObject:@"1" forKey:@"goal2_rear_sd_datacard_slot"];
    } else {
        [formData setObject:@"0" forKey:@"goal2_rear_sd_datacard_slot"];
    }
    
    if ([Utils isChecked:btn_chk_2_16]) {
        [formData setObject:@"1" forKey:@"goal2_rear_remote_alarm"];
    } else {
        [formData setObject:@"0" forKey:@"goal2_rear_remote_alarm"];
    }
    
    if ([Utils isChecked:btn_chk_2_17]) {
        [formData setObject:@"1" forKey:@"goal2_rear_external_battery_connector"];
    } else {
        [formData setObject:@"0" forKey:@"goal2_rear_external_battery_connector"];
    }
    
    if ([Utils isChecked:btn_chk_2_18]) {
        [formData setObject:@"1" forKey:@"goal2_rear_air_inlet_filter"];
    } else {
        [formData setObject:@"0" forKey:@"goal2_rear_air_inlet_filter"];
    }
    
    if ([Utils isChecked:btn_chk_2_19]) {
        [formData setObject:@"1" forKey:@"goal2_rear_cord_retainer"];
    } else {
        [formData setObject:@"0" forKey:@"goal2_rear_cord_retainer"];
    }


    [formData setObject:NonNilString(str_three_date) forKey:@"goal3_date"];
    [formData setObject:img_three_initial.image forKey:@"goal3_initials"];
    [formData setObject:NonNilString(str_four_date) forKey:@"goal4_date"];
    [formData setObject:img_four_initial.image forKey:@"goal4_initials"];
    [formData setObject:NonNilString(str_five_date) forKey:@"goal5_date"];
    [formData setObject:img_five_initial.image forKey:@"goal5_initials"];
    
    
    if ([Utils isChecked:btn_chk_5_1]) {
        [formData setObject:@"1" forKey:@"goal5_patient_circuit"];
    } else {
        [formData setObject:@"0" forKey:@"goal5_patient_circuit"];
    }
    
    if ([Utils isChecked:btn_chk_5_2]) {
        [formData setObject:@"1" forKey:@"goal5_filter"];
    } else {
        [formData setObject:@"0" forKey:@"goal5_filter"];
    }
    
    if ([Utils isChecked:btn_chk_5_3]) {
        [formData setObject:@"1" forKey:@"goal5_exhalation_device"];
    } else {
        [formData setObject:@"0" forKey:@"goal5_exhalation_device"];
    }
    
    if ([Utils isChecked:btn_chk_5_4]) {
        [formData setObject:@"1" forKey:@"goal5_tubing"];
    } else {
        [formData setObject:@"0" forKey:@"goal5_tubing"];
    }
    
    if ([Utils isChecked:btn_chk_5_5]) {
        [formData setObject:@"1" forKey:@"goal5_patient_connector"];
    } else {
        [formData setObject:@"0" forKey:@"goal5_patient_connector"];
    }
    
    if ([Utils isChecked:btn_chk_5_6]) {
        [formData setObject:@"1" forKey:@"goal5_humidifier"];
    } else {
        [formData setObject:@"0" forKey:@"goal5_humidifier"];
    }
    

    [formData setObject:NonNilString(str_six_date) forKey:@"goal6_date"];
    [formData setObject:img_six_initial.image forKey:@"goal6_initials"];
    [formData setObject:NonNilString(str_seven_date) forKey:@"goal7_date"];
    [formData setObject:img_seven_initial.image forKey:@"goal7_initials"];
    
    
    if ([Utils isChecked:btn_chk_7_1]) {
        [formData setObject:@"1" forKey:@"goal7_selected_viewing_options"];
    } else {
        [formData setObject:@"0" forKey:@"goal7_selected_viewing_options"];
    }
    
    if ([Utils isChecked:btn_chk_7_1_1]) {
        [formData setObject:@"1" forKey:@"goal7_detailed_view_off"];
    } else {
        [formData setObject:@"0" forKey:@"goal7_detailed_view_off"];
    }
    
    if ([Utils isChecked:btn_chk_7_1_1_1]) {
        [formData setObject:@"1" forKey:@"goal7_dvo_top_monitor_panel"];
    } else {
        [formData setObject:@"0" forKey:@"goal7_dvo_top_monitor_panel"];
    }
    
    if ([Utils isChecked:btn_chk_7_1_1_2]) {
        [formData setObject:@"1" forKey:@"goal7_dvo_middle_datetime_panel"];
    } else {
        [formData setObject:@"0" forKey:@"goal7_dvo_middle_datetime_panel"];
    }
    
    if ([Utils isChecked:btn_chk_7_1_1_3]) {
        [formData setObject:@"1" forKey:@"goal7_dvo_bottom_status_panel"];
    } else {
        [formData setObject:@"0" forKey:@"goal7_dvo_bottom_status_panel"];
    }
    
    if ([Utils isChecked:btn_chk_7_1_2]) {
        [formData setObject:@"1" forKey:@"goal7_detailed_view"];
    } else {
        [formData setObject:@"0" forKey:@"goal7_detailed_view"];
    }
    
    if ([Utils isChecked:btn_chk_7_1_2_1]) {
        [formData setObject:@"1" forKey:@"goal7_dv_top_monitor_panel"];
    } else {
        [formData setObject:@"0" forKey:@"goal7_dv_top_monitor_panel"];
    }
    
    if ([Utils isChecked:btn_chk_7_1_2_2]) {
        [formData setObject:@"1" forKey:@"goal7_dv_middle_settings_panel"];
    } else {
        [formData setObject:@"0" forKey:@"goal7_dv_middle_settings_panel"];
    }
    
    if ([Utils isChecked:btn_chk_7_1_2_3]) {
        [formData setObject:@"1" forKey:@"goal7_dv_bottom_status_panel"];
    } else {
        [formData setObject:@"0" forKey:@"goal7_dv_bottom_status_panel"];
    }
    

    [formData setObject:NonNilString(str_eight_date) forKey:@"goal8_date"];
    [formData setObject:img_eight_initial.image forKey:@"goal8_initials"];
    
    
    if ([Utils isChecked:btn_chk_8_1]) {
        [formData setObject:@"1" forKey:@"goal8_switch_to_sec_settings"];
    } else {
        [formData setObject:@"0" forKey:@"goal8_switch_to_sec_settings"];
    }
    
    if ([Utils isChecked:btn_chk_8_2]) {
        [formData setObject:@"1" forKey:@"goal8_safely_remove_sdcard"];
    } else {
        [formData setObject:@"0" forKey:@"goal8_safely_remove_sdcard"];
    }
    
    if ([Utils isChecked:btn_chk_8_3]) {
        [formData setObject:@"1" forKey:@"goal8_my_settings"];
    } else {
        [formData setObject:@"0" forKey:@"goal8_my_settings"];
    }
    
    if ([Utils isChecked:btn_chk_8_4]) {
        [formData setObject:@"1" forKey:@"goal8_options"];
    } else {
        [formData setObject:@"0" forKey:@"goal8_options"];
    }
    
    if ([Utils isChecked:btn_chk_8_5]) {
        [formData setObject:@"1" forKey:@"goal8_alarm_log"];
    } else {
        [formData setObject:@"0" forKey:@"goal8_alarm_log"];
    }
    
    if ([Utils isChecked:btn_chk_8_6]) {
        [formData setObject:@"1" forKey:@"goal8_info"];
    } else {
        [formData setObject:@"0" forKey:@"goal8_info"];
    }
    

    [formData setObject:NonNilString(str_nine_date) forKey:@"goal9_date"];
    [formData setObject:img_nine_initial.image forKey:@"goal9_initials"];
    
    if ([Utils isChecked:btn_chk_9_1]) {
        [formData setObject:@"1" forKey:@"goal9_audio_pause"];
    } else {
        [formData setObject:@"0" forKey:@"goal9_audio_pause"];
    }
    
    if ([Utils isChecked:btn_chk_9_2]) {
        [formData setObject:@"1" forKey:@"goal9_alarm_occurs"];
    } else {
        [formData setObject:@"0" forKey:@"goal9_alarm_occurs"];
    }
    
    
    [formData setObject:NonNilString(str_ten_date) forKey:@"goal10_date"];
    [formData setObject:img_ten_initial.image forKey:@"goal10_initials"];
    
    if ([Utils isChecked:btn_chk_10_1]) {
        [formData setObject:@"1" forKey:@"goal10_external_battery"];
    } else {
        [formData setObject:@"0" forKey:@"goal10_external_battery"];
    }
    
    if ([Utils isChecked:btn_chk_10_2]) {
        [formData setObject:@"1" forKey:@"goal10_detachable_battery"];
    } else {
        [formData setObject:@"0" forKey:@"goal10_detachable_battery"];
    }
    
    if ([Utils isChecked:btn_chk_10_3]) {
        [formData setObject:@"1" forKey:@"goal10_internal_battery"];
    } else {
        [formData setObject:@"0" forKey:@"goal10_internal_battery"];
    }
    
    
    [formData setObject:NonNilString(str_eleven_date) forKey:@"goal11_date"];
    [formData setObject:img_eleven_initial.image forKey:@"goal11_initials"];
    [formData setObject:NonNilString(str_twelve_date) forKey:@"goal12_date"];
    [formData setObject:img_twelve_initial.image forKey:@"goal12_initials"];
    [formData setObject:img_caregiver_initial.image forKey:@"caregiver_sign"];
    [formData setObject:img_clinician_initial.image forKey:@"clinician_sign"];
    //[formData setObject:@"" forKey:@"edit"];

    [self callSubmitAPI];
}

-(BOOL)isSuccessfullyValidated{
    if (img_one_initial.image == nil ||
        img_two_initial.image == nil ||
        img_three_initial.image == nil ||
        img_four_initial.image == nil ||
        img_five_initial.image == nil ||
        img_six_initial.image == nil ||
        img_seven_initial.image == nil ||
        img_eight_initial.image == nil ||
        img_nine_initial.image == nil ||
        img_ten_initial.image == nil ||
        img_eleven_initial.image == nil ||
        img_twelve_initial.image == nil ||
        img_caregiver_initial.image == nil ||
        img_clinician_initial.image == nil) {
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
        NSDictionary *dicti =[object_TV trilogyCareCompAPI:formData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            NSLog(@"MESSAGE: %@", dicti);
            if(dicti)
            {
                if ([dicti[@"error"] isEqualToString:@"0"]) {
                    NIVHomeSafe *objectVC     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVHomeSafe"];
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
    if ([self isSuccessfullyValidated]) {
        [self saveFormData];
    }
    else{
        [[AppDelegate sharedInstance] showAlertMessage:@"All initials and signature at the bottom are mandatory."];
    }
    
//    NIVHomeSafe *objectVC     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVHomeSafe"];
//    objectVC.prevFormData = self.prevFormData;
//    [self.navigationController pushViewController:objectVC animated:YES];
}

-(IBAction)backButtonPressed{
    //[txt_otherNameNumber resignFirstResponder];
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - Dates

-(IBAction)selectDate:(UIButton*)sender{
    [self dateOne:sender];
}

-(void)dateOne:(UIButton*)sender{
    dateTag = (int)sender.tag;
    
    if (dateTag == 11 || dateTag == 12) {
        [popoverCon presentPopoverFromRect:CGRectMake(sender.frame.size.width/4-10, sender.frame.size.height/1-10, 1, 10)
                                    inView:sender
                  permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
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
    NSArray *textFields = [[NSArray alloc] initWithObjects:txt_one_date, txt_two_date, txt_three_date, txt_four_date, txt_five_date, txt_six_date, txt_seven_date, txt_eight_date, txt_nine_date, txt_ten_date, txt_eleven_date, txt_twelve_date, txt_thirteen_date, nil];
    [Utils setTodaysDateToTextFields:textFields];
    str_one_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_two_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_three_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_four_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_five_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_six_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_seven_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_eight_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_nine_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_ten_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_eleven_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_twelve_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_thirteen_date = [Utils setDateFormatForAPI:[NSDate date]];

}

#pragma mark WSCalendarViewDelegate

-(void)didTapLabel:(WSLabel *)lblView withDate:(NSDate *)selectedDate
{
    switch (dateTag) {
        case 1:txt_one_date.text = [Utils setDateFormatFormString:selectedDate];
            str_one_date = [Utils setDateFormatForAPI:selectedDate];
            break;
        case 2:txt_two_date.text = [Utils setDateFormatFormString:selectedDate];
            str_two_date = [Utils setDateFormatForAPI:selectedDate];
            break;
        case 3:txt_three_date.text = [Utils setDateFormatFormString:selectedDate];
            str_three_date = [Utils setDateFormatForAPI:selectedDate];
            break;
        case 4:txt_four_date.text = [Utils setDateFormatFormString:selectedDate];
            str_four_date = [Utils setDateFormatForAPI:selectedDate];
            break;
        case 5:txt_five_date.text = [Utils setDateFormatFormString:selectedDate];
            str_five_date = [Utils setDateFormatForAPI:selectedDate];
            break;
        case 6:txt_six_date.text = [Utils setDateFormatFormString:selectedDate];
            str_six_date = [Utils setDateFormatForAPI:selectedDate];
            break;
        case 7:txt_seven_date.text = [Utils setDateFormatFormString:selectedDate];
            str_seven_date = [Utils setDateFormatForAPI:selectedDate];
            break;
        case 8:txt_eight_date.text = [Utils setDateFormatFormString:selectedDate];
            str_eight_date = [Utils setDateFormatForAPI:selectedDate];
            break;
        case 9:txt_nine_date.text = [Utils setDateFormatFormString:selectedDate];
            str_nine_date = [Utils setDateFormatForAPI:selectedDate];
            break;
        case 10:txt_ten_date.text = [Utils setDateFormatFormString:selectedDate];
            str_ten_date = [Utils setDateFormatForAPI:selectedDate];
            break;
        case 11:txt_eleven_date.text = [Utils setDateFormatFormString:selectedDate];
            str_eleven_date = [Utils setDateFormatForAPI:selectedDate];
            break;
        case 12:txt_twelve_date.text = [Utils setDateFormatFormString:selectedDate];
            str_twelve_date = [Utils setDateFormatForAPI:selectedDate];
            break;
        case 13:txt_thirteen_date.text = [Utils setDateFormatFormString:selectedDate];
            str_thirteen_date = [Utils setDateFormatForAPI:selectedDate];
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

-(IBAction)selectInitial:(UIButton*)sender{
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
        case 201:[img_one_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 202:[img_two_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 203:[img_three_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 204:[img_four_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 205:[img_five_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 206:[img_six_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 207:[img_seven_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 208:[img_eight_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 209:[img_nine_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 210:[img_ten_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 211:[img_eleven_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 212:[img_twelve_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 213:[img_caregiver_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 214:[img_clinician_initial setImage:[signaturePanel getSignatureImage]];
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

#pragma mark - Checkboxes

-(IBAction)selectCheckbox:(UIButton*)sender{
    [Utils performCheckboxSelection:sender];
}

-(void)setCheckboxes{
    NSArray *buttons = [[NSArray alloc] initWithObjects:btn_chk_2_1, btn_chk_2_2, btn_chk_2_3, btn_chk_2_4, btn_chk_2_5, btn_chk_2_6, btn_chk_2_7, btn_chk_2_8, btn_chk_2_9, btn_chk_2_10, btn_chk_2_11, btn_chk_2_12, btn_chk_2_13, btn_chk_2_14, btn_chk_2_15, btn_chk_2_16, btn_chk_2_17, btn_chk_2_18, btn_chk_2_19, btn_chk_2_20, btn_chk_5_1, btn_chk_5_2, btn_chk_5_3, btn_chk_5_4, btn_chk_5_5, btn_chk_5_6, btn_chk_7_1, btn_chk_7_1_1, btn_chk_7_1_1_1, btn_chk_7_1_1_2, btn_chk_7_1_1_3, btn_chk_7_1_2, btn_chk_7_1_2_1, btn_chk_7_1_2_2, btn_chk_7_1_2_3, btn_chk_8_1, btn_chk_8_2, btn_chk_8_3, btn_chk_8_4, btn_chk_8_5, btn_chk_8_6, btn_chk_9_1, btn_chk_9_2, btn_chk_10_1, btn_chk_10_2, btn_chk_10_3, nil];
    [Utils uncheckBoxes:buttons];
}

















@end
