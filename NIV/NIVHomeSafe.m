//
//  NIVHomeSafe.m
//  RT APP
//
//  Created by Anil Prasad on 14/11/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import "NIVHomeSafe.h"

@interface NIVHomeSafe ()

@end

@implementation NIVHomeSafe
@synthesize formData, dict_retrivedData, dict_retrivedData_local;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCheckboxes];
    [self autoFillDates];
    txt_patient_name.text = self.prevFormData[@"pt_name"];
    
    d_scrollView.contentSize                    = CGSizeMake(880, 2030);
    d_scrollView.contentOffset                  = CGPointMake(0,0);
    
    formData = [NSMutableDictionary new];

}

-(void)dismissKeyboard {
    [universalTextField resignFirstResponder];
}

-(void)saveFormData{
    [formData setObject:self.prevFormData[@"ticket_id"] forKey:@"ticket_id"];
    [formData setObject:RT_ID forKey:@"rt_id"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_1_1.selectedButton.tag] forKey:@"dwelling_type"];
    if (rad_1_1.selectedButton.tag == 2) [formData setObject:NonNilString(txt_dwelling_other.text) forKey:@"dwelling_other"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_1_2] ? @"1": @"0"] forKey:@"emergency_preparedness"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_1_3.selectedButton.tag] forKey:@"fall_risk_assessment"];
    [formData setObject:NonNilString(txt_dwelling_list.text) forKey:@"dwelling_floor_list_number"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_2_1.selectedButton.tag] forKey:@"phone_available"];
    [formData setObject:NonNilString(txt_phone.text) forKey:@"phone_number"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_2_2.selectedButton.tag] forKey:@"911_available"];
    [formData setObject:NonNilString(txt_list.text) forKey:@"local_hospital_list_name"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_3_1.selectedButton.tag] forKey:@"o2_safety_CHHC_oxygen"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_3_2.selectedButton.tag] forKey:@"o2_safety_no_smoking"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_3_3.selectedButton.tag] forKey:@"o2_safety_o23ft"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_3_4.selectedButton.tag] forKey:@"o2_safety_o210ft"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_3_5.selectedButton.tag] forKey:@"o2_safety_spare_tank"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_3_6.selectedButton.tag] forKey:@"o2_safety_storage"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_5_1.selectedButton.tag] forKey:@"electrical_requirements_supplied_to_home"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_5_2.selectedButton.tag] forKey:@"electrical_requirements_outlets_grounded"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_5_3.selectedButton.tag] forKey:@"electrical_requirements_extension_cords"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_5_4.selectedButton.tag] forKey:@"electrical_requirements_amperage"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_4_1.selectedButton.tag] forKey:@"env_req_adequate_access_hme"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_4_2.selectedButton.tag] forKey:@"env_req_door_size"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_4_3.selectedButton.tag] forKey:@"env_req_infestation_bugs"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_4_4.selectedButton.tag] forKey:@"env_req_obstacles_hme"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_4_5.selectedButton.tag] forKey:@"env_req_obstacles_mobility"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_4_6.selectedButton.tag] forKey:@"env_req_refrigerator"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_4_7.selectedButton.tag] forKey:@"env_req_water_supply"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_4_8.selectedButton.tag] forKey:@"env_req_heat_cooling"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_4_9.selectedButton.tag] forKey:@"env_req_environment_homecare"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_4_10.selectedButton.tag] forKey:@"env_req_pets_type"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_4_11.selectedButton.tag] forKey:@"env_req_medical_supplies"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_6_1.selectedButton.tag] forKey:@"fire_res_saf_emergency_exit"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_6_2.selectedButton.tag] forKey:@"fire_res_saf_smoke_det_present"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_6_3.selectedButton.tag] forKey:@"fire_res_saf_smoke_det_functional"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_6_4.selectedButton.tag] forKey:@"fire_res_saf_smoke_det_checkedin"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_6_5.selectedButton.tag] forKey:@"fire_res_saf_family_encouraged_smoke"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_6_6.selectedButton.tag] forKey:@"fire_res_saf_extinguishers_present"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_6_7.selectedButton.tag] forKey:@"fire_res_saf_extinguishers_functional"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_7_1.selectedButton.tag] forKey:@"fire_res_saf_extinguishers_checkedin"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_7_2.selectedButton.tag] forKey:@"fire_res_saf_family_encouraged_ext"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_7_3.selectedButton.tag] forKey:@"fire_res_saf_co_monitor_present"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_7_4.selectedButton.tag] forKey:@"fire_res_saf_co_monitor_functional"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_7_5.selectedButton.tag] forKey:@"fire_res_saf_co_monitor_checkedin"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_7_6.selectedButton.tag] forKey:@"fire_res_saf_family_encouraged_com"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_8_1.selectedButton.tag] forKey:@"patient_caregiver_informed"];
    [formData setObject:NonNilString(txt_Recommendation.text) forKey:@"recommendation"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_9_1.selectedButton.tag] forKey:@"patient_caregiver_confirms"];
    [formData setObject:NonNilString(txt_plan.text) forKey:@"plan_followup_actions"];
    [formData setObject:img_clinician_sign.image forKey:@"cvc_clinical_sign"];
    [formData setObject:NonNilString(txt_patient_name.text) forKey:@"pt_name"];
    [formData setObject:str_date forKey:@"date"];
    [formData setObject:str_date_of_birth forKey:@"dob"];
    //[formData setObject:@"" forKey:@"edit"];
    
    [self callSubmitAPI];
}

-(BOOL)isSuccessfullyValidated{
    if (img_clinician_sign.image == nil) {
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
        NSDictionary *dicti =[object_TV homeSafeAPI:formData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            NSLog(@"MESSAGE: %@", dicti);
            if(dicti)
            {
                if ([dicti[@"error"] isEqualToString:@"0"]) {
                    NIVNewPatientHistory *objectVC     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVNewPatientHistory"];
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
    //[Utils takeScreenshot:d_scrollView];
    
    if ([self isSuccessfullyValidated]) {
        [self saveFormData];
    }
    else{
        [[AppDelegate sharedInstance] showAlertMessage:@"Clinician signature is mandatory."];
    }
    
//    NIVNewPatientHistory *objectVC     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVNewPatientHistory"];
//    objectVC.prevFormData = self.prevFormData;
//    [self.navigationController pushViewController:objectVC animated:YES];
    
}

-(IBAction)backButtonPressed{
    [universalTextField resignFirstResponder];
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
    [img_clinician_sign setImage:[signaturePanel getSignatureImage]];
    [signatureBackgroundView removeFromSuperview];
}

-(void)clearInitialsView{
    [signaturePanel clearSignature];
}

-(void)closeInitialsView{
    [signatureBackgroundView removeFromSuperview];
}

#pragma mark - Checkboxes

-(IBAction)selectCheck:(UIButton*)sender{
    [universalTextField resignFirstResponder];
    [Utils performCheckboxSelection:sender];
}

-(IBAction)selectCheckbox:(APRadioButton*)sender{
    if (sender == rad_5_2) {
        NSLog(@"%ld", (long)rad_5_2.selectedButton.tag);
    }
    [universalTextField resignFirstResponder];
   // NSLog(@"%@", sender.selectedButton.titleLabel.text);
}

-(void)setCheckboxes{
    NSArray *buttons = [[NSArray alloc] initWithObjects:btn_1_2, nil];
    [Utils uncheckBoxes:buttons];
}



#pragma mark - Dates

-(void)autoFillDates{
    [Utils setTodaysDateToTextFields:@[txt_date]];
    str_date = [Utils setDateFormatForAPI:[NSDate date]];
    NSDate *pt_dob = [Utils stringToDateWithFormat:@"MM-dd-yyy" andStringDate:self.prevFormData[@"pt_dob"]];
    str_date_of_birth = [Utils setDateFormatForAPI:pt_dob];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale: [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [formatter setDateFormat:@"MM/dd/yy"];
    txt_date_of_birth.text = [formatter stringFromDate:pt_dob];
}

#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    universalTextField  = textField;
    if (![@[txt_dwelling_other, txt_dwelling_list, txt_phone, txt_list] containsObject:universalTextField]){
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
