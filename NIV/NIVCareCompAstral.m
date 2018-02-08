//
//  NIVCareCompAstral.m
//  RT APP
//
//  Created by Anil Prasad on 1/12/18.
//  Copyright © 2018 ankit gupta. All rights reserved.
//

#import "NIVCareCompAstral.h"

@interface NIVCareCompAstral ()

@end

@implementation NIVCareCompAstral
@synthesize formData, dict_retrivedData, dict_retrivedData_local;

- (void)viewDidLoad {
    [super viewDidLoad];
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
    //    [formData setObject:NonNilString() forKey:@"date"];
    [formData setObject:NonNilString(str_one_date) forKey:@"goal_air_inlet_date"];
    [formData setObject:img_one_initial.image forKey:@"goal_air_inlet_initials"];
    [formData setObject:NonNilString(str_two_date) forKey:@"goal_low_flow_date"];
    [formData setObject:img_two_initial.image forKey:@"goal_low_flow_initials"];
    [formData setObject:NonNilString(str_three_date) forKey:@"goal_sensor_connector_date"];
    [formData setObject:img_three_initial.image forKey:@"goal_sensor_connector_initials"];
    [formData setObject:NonNilString(str_three_date) forKey:@"goal_dcpower_inlet_date"];
    [formData setObject:img_four_initial.image forKey:@"goal_dcpower_inlet_initials"];
    [formData setObject:NonNilString(str_four_date) forKey:@"goal_device_onoff_date"];
    [formData setObject:img_five_initial.image forKey:@"goal_device_onoff_initials"];
    [formData setObject:NonNilString(str_five_date) forKey:@"goal_touch_screen_date"];
    [formData setObject:img_six_initial.image forKey:@"goal_touch_screen_initials"];
    [formData setObject:NonNilString(str_six_date) forKey:@"goal_power_indicators_date"];
    [formData setObject:img_seven_initial.image forKey:@"goal_power_indicators_initials"];
    [formData setObject:NonNilString(str_seven_date) forKey:@"goal_therapy_onoff_date"];
    [formData setObject:img_eight_initial.image forKey:@"goal_therapy_onoff_initials"];
    [formData setObject:NonNilString(str_eight_date) forKey:@"goal_alarm_mute_reset_date"];
    [formData setObject:img_nine_initial.image forKey:@"goal_alarm_mute_reset_initials"];
    [formData setObject:NonNilString(str_nine_date) forKey:@"goal_alarm_bar_date"];
    [formData setObject:img_ten_initial.image forKey:@"goal_alarm_bar_initials"];
    [formData setObject:NonNilString(str_ten_date) forKey:@"goal_start_stop_button_date"];
    [formData setObject:img_eleven_initial.image forKey:@"goal_start_stop_button_initials"];
    [formData setObject:NonNilString(str_eleven_date) forKey:@"goal_connect_astral_date"];
    [formData setObject:img_twelve_initial.image forKey:@"goal_connect_astral_initials"];
    [formData setObject:NonNilString(str_twelve_date) forKey:@"goal_demonstrate_ventilator_on_date"];
    [formData setObject:img_thirteen_initial.image forKey:@"goal_demonstrate_ventilator_on_initials"];
    [formData setObject:NonNilString(str_thirteen_date) forKey:@"goal_connect_external_battery_date"];
    [formData setObject:img_fourteen_initial.image forKey:@"goal_connect_external_battery_initials"];
    [formData setObject:NonNilString(str_fifteen_date) forKey:@"goal_assemble_circuit_date"];
    [formData setObject:img_fifteen_initial.image forKey:@"goal_assemble_circuit_initials"];
    [formData setObject:NonNilString(str_sixteen_date) forKey:@"goal_enter_settings_date"];
    [formData setObject:img_sixteen_initial.image forKey:@"goal_enter_settings_initials"];
    [formData setObject:NonNilString(str_seventeen_date) forKey:@"goal_enter_alarms_date"];
    [formData setObject:img_seventeen_initial.image forKey:@"goal_enter_alarms_initials"];
    [formData setObject:NonNilString(str_eighteen_date) forKey:@"goal_home_button_date"];
    [formData setObject:img_eighteen_initial.image forKey:@"goal_home_button_initials"];
    [formData setObject:NonNilString(str_nineteen_date) forKey:@"goal_change_programs_date"];
    [formData setObject:img_nineteen_initial.image forKey:@"goal_change_programs_initials"];
    [formData setObject:NonNilString(str_twenty_date) forKey:@"goal_cleaning_maintenance_date"];
    [formData setObject:img_twenty_initial.image forKey:@"goal_cleaning_maintenance_initials"];
    [formData setObject:NonNilString(str_twentyOne_date) forKey:@"goal_check_charge_level_date"];
    [formData setObject:img_twentyOne_initial.image forKey:@"goal_check_charge_level_initials"];
    [formData setObject:img_caregiver_initial.image forKey:@"caregiver_sign"];
    [formData setObject:img_clinician_initial.image forKey:@"clinician_sign"];
    //    [formData setObject:@"" forKey:@"edit"];
    
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
        img_thirteen_initial.image == nil ||
        img_fourteen_initial.image == nil ||
        img_fifteen_initial.image == nil ||
        img_sixteen_initial.image == nil ||
        img_seventeen_initial.image == nil ||
        img_eighteen_initial.image == nil ||
        img_nineteen_initial.image == nil ||
        img_twenty_initial.image == nil ||
        img_twentyOne_initial.image == nil ||
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
        NSDictionary *dicti =[object_TV astralCareCompAPI:formData];
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
    
    if (dateTag == 20 || dateTag == 21) {
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
    NSArray *textFields = [[NSArray alloc] initWithObjects:txt_one_date, txt_two_date, txt_three_date, txt_four_date, txt_five_date, txt_six_date, txt_seven_date, txt_eight_date, txt_nine_date, txt_ten_date, txt_eleven_date, txt_twelve_date, txt_thirteen_date, txt_fourteen_date, txt_fifteen_date, txt_sixteen_date, txt_seventeen_date, txt_eighteen_date, txt_nineteen_date, txt_twenty_date, txt_twentyOne_date, nil];
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
    str_fourteen_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_fifteen_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_sixteen_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_seventeen_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_eighteen_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_nineteen_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_twenty_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_twentyOne_date = [Utils setDateFormatForAPI:[NSDate date]];
}

#pragma mark WSCalendarViewDelegate

-(void)didTapLabel:(WSLabel *)lblView withDate:(NSDate *)selectedDate
{
    switch (dateTag) {
        case 1:[self setDateOf:txt_one_date andStrDate:str_one_date withDate:selectedDate];
            break;
        case 2:[self setDateOf:txt_two_date andStrDate:str_two_date withDate:selectedDate];
            break;
        case 3:[self setDateOf:txt_three_date andStrDate:str_three_date withDate:selectedDate];
            break;
        case 4:[self setDateOf:txt_four_date andStrDate:str_four_date withDate:selectedDate];
            break;
        case 5:[self setDateOf:txt_five_date andStrDate:str_five_date withDate:selectedDate];
            break;
        case 6:[self setDateOf:txt_six_date andStrDate:str_six_date withDate:selectedDate];
            break;
        case 7:[self setDateOf:txt_seven_date andStrDate:str_seven_date withDate:selectedDate];
            break;
        case 8:[self setDateOf:txt_eight_date andStrDate:str_eight_date withDate:selectedDate];
            break;
        case 9:[self setDateOf:txt_nine_date andStrDate:str_nine_date withDate:selectedDate];
            break;
        case 10:[self setDateOf:txt_ten_date andStrDate:str_ten_date withDate:selectedDate];
            break;
        case 11:[self setDateOf:txt_eleven_date andStrDate:str_eleven_date withDate:selectedDate];
            break;
        case 12:[self setDateOf:txt_twelve_date andStrDate:str_twelve_date withDate:selectedDate];
            break;
        case 13:[self setDateOf:txt_thirteen_date andStrDate:str_thirteen_date withDate:selectedDate];
            break;
        case 14:[self setDateOf:txt_fourteen_date andStrDate:str_fourteen_date withDate:selectedDate];
            break;
        case 15:[self setDateOf:txt_fifteen_date andStrDate:str_fifteen_date withDate:selectedDate];
            break;
        case 16:[self setDateOf:txt_sixteen_date andStrDate:str_sixteen_date withDate:selectedDate];
            break;
        case 17:[self setDateOf:txt_seventeen_date andStrDate:str_seventeen_date withDate:selectedDate];
            break;
        case 18:[self setDateOf:txt_eighteen_date andStrDate:str_eighteen_date withDate:selectedDate];
            break;
        case 19:[self setDateOf:txt_nineteen_date andStrDate:str_nineteen_date withDate:selectedDate];
            break;
        case 20:[self setDateOf:txt_twenty_date andStrDate:str_twenty_date withDate:selectedDate];
            break;
        case 21:[self setDateOf:txt_twentyOne_date andStrDate:str_twentyOne_date withDate:selectedDate];
            break;
        default:
            break;
    }
    [popoverCon dismissPopoverAnimated:NO];
}

-(void)setDateOf:(UITextField*)textField andStrDate:(NSString*)strDate withDate:(NSDate*)selectedDate{
    textField.text = [Utils setDateFormatFormString:selectedDate];
    strDate = [Utils setDateFormatForAPI:selectedDate];
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
        case 213:[img_thirteen_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 214:[img_fourteen_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 215:[img_fifteen_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 216:[img_sixteen_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 217:[img_seventeen_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 218:[img_eighteen_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 219:[img_nineteen_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 220:[img_twenty_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 221:[img_twentyOne_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 222:[img_caregiver_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 223:[img_clinician_initial setImage:[signaturePanel getSignatureImage]];
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


@end
