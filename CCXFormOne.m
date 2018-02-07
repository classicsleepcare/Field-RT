//
//  CCXFormOne.m
//  RT APP
//
//  Created by Anil Prasad on 06/07/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import "CCXFormOne.h"

@interface CCXFormOne ()

@end

@implementation CCXFormOne
@synthesize formOneData;

-(void)dismissKeyboard {
    [universalTextField resignFirstResponder];
    [txt_comments resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self uncheckBox:btn_cpap               ];
    [self uncheckBox:btn_auto_pap           ];
    [self uncheckBox:btn_bi_level           ];
    [self uncheckBox:btn_auto_bi_level      ];
    [self uncheckBox:btn_bi_level_st        ];
    [self uncheckBox:btn_auto_sv            ];
    [self uncheckBox:btn_initial_unit       ];
    [self uncheckBox:btn_replacement_unit   ];
    [self checkBox:btn_heated             ];
    [self uncheckBox:btn_cool_passover      ];
    [self uncheckBox:btn_nasal_pillows      ];
    [self uncheckBox:btn_nasal              ];
    [self uncheckBox:btn_full               ];
    [self uncheckBox:btn_mask_size_s        ];
    [self uncheckBox:btn_mask_size_m        ];
    [self uncheckBox:btn_mask_size_l        ];
    [self uncheckBox:btn_mask_size_xl       ];
    [self uncheckBox:btn_mask_size_other    ];
    [self uncheckBox:btn_rate_off           ];
    [self uncheckBox:btn_rate_auto          ];
    [self uncheckBox:btn_rate_other         ];
    [self uncheckBox:btn_card               ];
    [self checkBox:btn_modem_wireless     ];
    [self uncheckBox:btn_usb                ];
    [self uncheckBox:btn_sms_yes            ];
    [self checkBox:btn_sms_no             ];
    [self uncheckBox:btn_sms_unknown        ];
    [self uncheckBox:btn_agreement_accept   ];
    
    txt_date_setup.enabled = NO;
    txt_patient_sign_date.enabled = NO;
    txt_company_rep_sign_date.enabled = NO;
    txt_patient_name.enabled = NO;
    txt_dob.enabled = NO;
    txt_address.enabled = NO;

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    d_scrollView.contentSize            = CGSizeMake(880, 2200);
    d_scrollView.contentOffset          = CGPointMake(0,0);
    
    txt_patient_sign_date.enabled       = NO;
    txt_company_rep_sign_date.enabled   = NO;
    txt_date_setup.enabled              = NO;
    [self autoFillDates];
    
    txt_setup_performed_at.text         = [formOneData valueForKey:@"pap_location"];
    txt_patient_name.text               = [NSString stringWithFormat:@"%@ %@",
                                           [formOneData valueForKey:@"pt_first"],
                                           [formOneData valueForKey:@"pt_last"]];
    txt_dob.text                        = [formOneData valueForKey:@"pt_dob"];
    txt_address.text                    = [NSString stringWithFormat:@"%@, %@, %@, %@",
                                           [formOneData valueForKey:@"pt_add"],
                                           [formOneData valueForKey:@"pt_city"],
                                           [formOneData valueForKey:@"pt_state"],
                                           [formOneData valueForKey:@"pt_zip"]];
    txt_primary_contact.text            = [formOneData valueForKey:@"pt_home"];
    txt_secondary_contact.text          = [formOneData valueForKey:@"pt_cell"];
    txt_patient_email.text              = [formOneData valueForKey:@"pt_email"];
    txt_patient_email_in_monitoring_site.text = [formOneData valueForKey:@"pt_email"];
    txt_mask_type_name.text             = [formOneData valueForKey:@"mask"];
    NSString *mask_size                 = [formOneData valueForKey:@"mask_name"];
    if ([mask_size isEqualToString:@"Petite/XSmall"]){
        txt_mask_size_other.text = @"Petite/XSmall";
        [self checkBox:btn_mask_size_other];
    }
    if ([mask_size isEqualToString:@"S/M"]){
        txt_mask_size_other.text = @"S/M";
        [self checkBox:btn_mask_size_other];
    }
    if ([mask_size isEqualToString:@"Small"])           [self checkBox:btn_mask_size_s];
    if ([mask_size isEqualToString:@"Medium"])          [self checkBox:btn_mask_size_m];
    if ([mask_size isEqualToString:@"Large"])           [self checkBox:btn_mask_size_l];
    if ([mask_size isEqualToString:@"XLarge"])          [self checkBox:btn_mask_size_xl];
    
    txt_make_model.text = [NSString stringWithFormat:@"%@, %@", [formOneData valueForKey:@"machine"], [formOneData valueForKey:@"model"]];
    txt_serial.text = [formOneData valueForKey:@"serial"];
        
    NSString *machine = [formOneData valueForKey:@"machine"];
    if ([machine containsString:@"AirCurve"]||
        [machine containsString:@"AirSense"]){
        NSString *serial = [formOneData valueForKey:@"serial"];
        NSString *wireless_id = [serial componentsSeparatedByString:@"-"][1];
        txt_wireless_id.text = wireless_id;
    }
    else{
        txt_wireless_id.text = [formOneData valueForKey:@"modem_serial"];
    }
    
    txt_provider_name.text = @"Classic SleepCare, LLC";
    
    txt_physician_name.text = [formOneData valueForKey:@"doc_name"];
    txt_physician_phone.text = [formOneData valueForKey:@"doc_phone"];

    if (![[formOneData valueForKey:@"cpap_cm"] isEqualToString:@"-"]) {
        txt_epap.text                   = [formOneData valueForKey:@"cpap_cm"];
        [self checkBox:btn_cpap];
    }
    if (![[formOneData valueForKey:@"cpap_auto_low_pressure"] isEqualToString:@"-"]) {
        txt_auto_pap_min.text           = [formOneData valueForKey:@"cpap_auto_low_pressure"];
        [self checkBox:btn_auto_pap];
    }
    if (![[formOneData valueForKey:@"cpap_auto_high_pressure"] isEqualToString:@"-"]) {
        txt_auto_pap_max.text           = [formOneData valueForKey:@"cpap_auto_high_pressure"];
        [self checkBox:btn_auto_pap];
    }
    if (![[formOneData valueForKey:@"bi_st_epap"] isEqualToString:@"-"]) {
        txt_bi_level_epap.text          = [formOneData valueForKey:@"bi_st_epap"];
        [self checkBox:btn_bi_level];
    }
    if (![[formOneData valueForKey:@"bi_st_ipap"] isEqualToString:@"-"]) {
        txt_bi_level_ipap.text          = [formOneData valueForKey:@"bi_st_ipap"];
        [self checkBox:btn_bi_level];
    }
    if (![[formOneData valueForKey:@"bi_auto_epap_min"] isEqualToString:@"-"]) {
        txt_auto_bi_level_epap.text     = [formOneData valueForKey:@"bi_auto_epap_min"];
        [self checkBox:btn_auto_bi_level];
    }
    if (![[formOneData valueForKey:@"bi_auto_epap_max"] isEqualToString:@"-"]) {
        txt_auto_bi_level_ipap.text     = [formOneData valueForKey:@"bi_auto_epap_max"];
        [self checkBox:btn_auto_bi_level];
    }
    if (![[formOneData valueForKey:@"bi_auto_st_ipap"] isEqualToString:@"-"]) {
        txt_bi_level_st_min.text        = [formOneData valueForKey:@"bi_auto_st_ipap"];
        [self checkBox:btn_bi_level_st];
    }
    if (![[formOneData valueForKey:@"bi_auto_st_epap"] isEqualToString:@"-"]) {
        txt_bi_level_st_max.text        = [formOneData valueForKey:@"bi_auto_st_epap"];
        [self checkBox:btn_bi_level_st];
    }
    if (![[formOneData valueForKey:@"bi_auto_st_backup_rate"] isEqualToString:@"-"]) {
        txt_bi_level_st_rr.text         = [formOneData valueForKey:@"bi_auto_st_backup_rate"];
        [self checkBox:btn_bi_level_st];
    }
    if (![[formOneData valueForKey:@"bi_auto_sv_pressure_support_min"] isEqualToString:@"-"]) {
        txt_auto_sv_min.text            = [formOneData valueForKey:@"bi_auto_sv_pressure_support_min"];
        [self checkBox:btn_auto_sv];
    }
    if (![[formOneData valueForKey:@"bi_auto_sv_pressure_support_max"] isEqualToString:@"-"]) {
        txt_auto_sv_max.text            = [formOneData valueForKey:@"bi_auto_sv_pressure_support_max"];
        [self checkBox:btn_auto_sv];
    }
    
    NSString *auto_sv_epap          = [NSString stringWithFormat:@"%@/%@",
                                       [formOneData valueForKey:@"bi_auto_sv_ipap_max"], [formOneData valueForKey:@"bi_auto_sv_epap_min"]];
    
    if ([[formOneData valueForKey:@"bi_auto_sv_ipap_max"] isEqualToString:@"-"] &&
        [[formOneData valueForKey:@"bi_auto_sv_epap_min"] isEqualToString:@"-"]){
        txt_auto_sv_epap.text       = @"";
    }
    else if ([[formOneData valueForKey:@"bi_auto_sv_ipap_max"] isEqualToString:@"-"]) {
        txt_auto_sv_epap.text       = [formOneData valueForKey:@"bi_auto_sv_epap_min"];;
    }
    else if ([[formOneData valueForKey:@"bi_auto_sv_epap_min"] isEqualToString:@"-"]) {
        txt_auto_sv_epap.text       = [formOneData valueForKey:@"bi_auto_sv_ipap_max"];;
    }
    else{
        txt_auto_sv_epap.text       = auto_sv_epap;
    }
    
    if ([[formOneData valueForKey:@"bi_auto_sv_backup_rate"] caseInsensitiveCompare:@"Auto"] == NSOrderedSame) {
        [self checkBox:btn_rate_auto];
    }
    else if ([[formOneData valueForKey:@"bi_auto_sv_backup_rate"] isEqualToString:@"-"]){
    }
    else{
        [self checkBox:btn_rate_other];
        txt_rate_other.text = [formOneData valueForKey:@"bi_auto_sv_backup_rate"];
    }
    
    if ([[formOneData valueForKey:@"bi_auto_st_backup_rate"] caseInsensitiveCompare:@"Auto"] == NSOrderedSame) {
        [self checkBox:btn_rate_auto];
    }
    else if ([[formOneData valueForKey:@"bi_auto_st_backup_rate"] isEqualToString:@"-"]){
    }
    else{
        [self checkBox:btn_rate_other];
        txt_rate_other.text = [formOneData valueForKey:@"bi_auto_st_backup_rate"];
    }
    
    
    // Disable conditional Textboxes
    txt_rate_other.enabled              = NO;
    txt_mask_size_other.enabled         = NO;
    if ([Utils isEditingMode]) {
        [self autoFillMode];
    }
}

static SEL extracted() {
    return @selector(selectedCheckBox:);
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
    [btn_close addTarget:self action:extracted() forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:btn_close];
    
    UIButton *btn_clear             = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_clear.frame                 = CGRectMake(200, 350, 100, 32);
    btn_clear.backgroundColor       = [UIColor colorWithRed:22.0/255.0 green:125.0/255.0 blue:164.0/255.0 alpha:1.0];
    btn_clear.titleLabel.textColor  = [UIColor whiteColor];
    [btn_clear setTitle:@"Clear" forState:UIControlStateNormal];
    btn_clear.tag                   = 444;
    btn_clear.layer.cornerRadius    = 7;
    btn_clear.clipsToBounds         = YES;
    [btn_clear addTarget:self action:@selector(selectedCheckBox:) forControlEvents:UIControlEventTouchUpInside];
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
    lbl_info.text                   = @"Initial/Signature on the dotted line and click Save. Press clear to start over.";
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
        case 111:{
            [img_patient_sign_view setImage:[signaturePanel getSignatureImage]];
        }
            break;
            
        case 222:{
            [img_company_rep_sign_view setImage:[signaturePanel getSignatureImage]];
        }
            break;
            
        default:
            break;
    }
    
    [signatureBackgroundView removeFromSuperview];
    
}


-(IBAction)selectedPatientSignature:(UIButton*)sender{
    CGPoint point           = CGPointMake(0,800);
    [UIView animateWithDuration:0.1 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
    [universalTextField resignFirstResponder];
    [self createSignatureView:sender];
}

-(IBAction)selectedCompanyRepSignature:(UIButton*)sender{
    CGPoint point           = CGPointMake(0,800);
    [UIView animateWithDuration:0.1 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
    [universalTextField resignFirstResponder];
    [self createSignatureView:sender];
}

-(IBAction)goBack{
    [self.navigationController popViewControllerAnimated:YES];
    
    /*
     UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"StoryboardTwo" bundle:nil];
     UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"CCXFormOne"];
     [self.navigationController pushViewController:vc animated:YES];
     
     */
}

-(void)saveData{
    [formOneData setObject:format_Date                                  forKey:@"cig_setup_date"]; // format_Date txt_date_setup.text
    [formOneData setObject:txt_setup_performed_at.text                  forKey:@"cig_setup_perform"];
    [formOneData setObject:txt_patient_emergency_contact.text           forKey:@"cig_emergency_contact"];

/*
    [formOneData setObject:txt_patient_name.text                        forKey:@""];
    [formOneData setObject:txt_dob.text                                 forKey:@""];
    [formOneData setObject:txt_address.text                             forKey:@""];
*/
    [formOneData setObject:txt_physician_name.text                      forKey:@"cig_physician_name"];
    [formOneData setObject:txt_physician_phone.text                     forKey:@"cig_physician_phone"];
    [formOneData setObject:txt_primary_contact.text                     forKey:@"cig_primary_contact"];
    [formOneData setObject:txt_secondary_contact.text                   forKey:@"cig_secondary_contact"];
    [formOneData setObject:txt_patient_email.text                       forKey:@"cig_patient_email"];
    
    [formOneData setObject:txt_epap.text                                forKey:@"cig_epap"];
    [formOneData setObject:txt_auto_pap_min.text                        forKey:@"cig_auto_pap_min"];
    [formOneData setObject:txt_auto_pap_max.text                        forKey:@"cig_auto_pap_max"];
    [formOneData setObject:txt_bi_level_epap.text                       forKey:@"cig_bi_level_epap"];
    [formOneData setObject:txt_bi_level_ipap.text                       forKey:@"cig_bi_level_ipap"];
    [formOneData setObject:txt_auto_bi_level_epap.text                  forKey:@"cig_auto_bi_level_epap"];
    [formOneData setObject:txt_auto_bi_level_ipap.text                  forKey:@"cig_auto_bi_level_ipap"];
    [formOneData setObject:txt_bi_level_st_min.text                     forKey:@"cig_bi_level_st_min"];
    [formOneData setObject:txt_bi_level_st_max.text                     forKey:@"cig_bi_level_st_max"];
    [formOneData setObject:txt_bi_level_st_rr.text                      forKey:@"cig_bi_level_st_rr"];
    [formOneData setObject:txt_auto_sv_min.text                         forKey:@"cig_auto_sv_min"];
    [formOneData setObject:txt_auto_sv_max.text                         forKey:@"cig_auto_sv_max"];
    [formOneData setObject:txt_auto_sv_epap.text                        forKey:@"cig_auto_sv_epap"];
    
    [formOneData setObject:txt_make_model.text                          forKey:@"cig_make_model"];
    [formOneData setObject:txt_serial.text                              forKey:@"cig_serial"];
    [formOneData setObject:txt_mask_type_name.text                      forKey:@"cig_mask_type_name"];
    [formOneData setObject:txt_wireless_id.text                         forKey:@"cig_wireless_id"];


    if ([self checkedOption:btn_mask_size_s]){[formOneData setObject:@"Small"           forKey:@"cig_mask_size"];}
    else if ([self checkedOption:btn_mask_size_m]){[formOneData setObject:@"Medium"     forKey:@"cig_mask_size"];}
    else if ([self checkedOption:btn_mask_size_l]){[formOneData setObject:@"Large"      forKey:@"cig_mask_size"];}
    else if ([self checkedOption:btn_mask_size_xl]){[formOneData setObject:@"X-Large"   forKey:@"cig_mask_size"];}
    else if ([self checkedOption:btn_mask_size_other]){[formOneData setObject:txt_mask_size_other.text forKey:@"cig_mask_size"];}
    else {[formOneData setObject:@"" forKey:@"cig_mask_size"];}

    [formOneData setObject:txt_patient_email_in_monitoring_site.text    forKey:@"cig_pt_email_monitor"];
    [formOneData setObject:txt_provider_name.text                       forKey:@"cig_provider_name"];
    [formOneData setObject:format_Date                   forKey:@"cig_pt_sign_date"]; // txt_patient_sign_date.text
    [formOneData setObject:format_Date               forKey:@"cig_provider_date"]; // format date txt_company_rep_sign_date.text
    
    [formOneData setObject:txt_comments.text                            forKey:@"cig_additional_comment"];
    
    if ([self checkedOption:btn_initial_unit]) [formOneData setObject:@"1" forKey:@"cig_unit"];
    if ([self checkedOption:btn_replacement_unit]) [formOneData setObject:@"2" forKey:@"cig_unit"];
    
    if ([self checkedOption:btn_rate_off]){[formOneData setObject:@"1" forKey:@"cig_rate_off"];}
    else{[formOneData setObject:@"0" forKey:@"cig_rate_off"];}
    if ([self checkedOption:btn_rate_auto]){[formOneData setObject:@"1" forKey:@"cig_rate_auto"];}
    else{[formOneData setObject:@"0" forKey:@"cig_rate_auto"];}
    if ([self checkedOption:btn_rate_other]){[formOneData setObject:txt_rate_other.text forKey:@"cig_rate_other"];}
    else{[formOneData setObject:@"" forKey:@"cig_rate_other"];}
    
    if ([self checkedOption:btn_heated]) [formOneData setObject:@"1" forKey:@"cig_humidifier"];
    if ([self checkedOption:btn_cool_passover]) [formOneData setObject:@"2" forKey:@"cig_humidifier"];
    
    if ([self checkedOption:btn_nasal_pillows]) [formOneData setObject:@"1" forKey:@"cig_mask"];
    if ([self checkedOption:btn_nasal]) [formOneData setObject:@"2" forKey:@"cig_mask"];
    if ([self checkedOption:btn_full]) [formOneData setObject:@"3" forKey:@"cig_mask"];
    
    if ([self checkedOption:btn_sms_yes]) [formOneData setObject:@"1" forKey:@"cig_sms_tagged"];
    if ([self checkedOption:btn_sms_no]) [formOneData setObject:@"2" forKey:@"cig_sms_tagged"];
    if ([self checkedOption:btn_sms_unknown]) [formOneData setObject:@"3" forKey:@"cig_sms_tagged"];
    
    if ([self checkedOption:btn_card]) {[formOneData setObject:@"1" forKey:@"cig_comp_meas_card"];}
    else{[formOneData setObject:@"0" forKey:@"cig_comp_meas_card"];}
    if ([self checkedOption:btn_modem_wireless]) {[formOneData setObject:@"1" forKey:@"cig_comp_meas_modemwireless"];}
    else{[formOneData setObject:@"0" forKey:@"cig_comp_meas_modemwireless"];}
    if ([self checkedOption:btn_usb]) {[formOneData setObject:@"1" forKey:@"cig_comp_meas_usb"];}
    else{[formOneData setObject:@"0" forKey:@"cig_comp_meas_usb"];}

    if ([self checkedOption:btn_agreement_accept]) {[formOneData setObject:@"1" forKey:@"cig_agreement"];}
    else{[formOneData setObject:@"0" forKey:@"cig_agreement"];}
    
    
    if ([self checkedOption:btn_cpap]) {[formOneData setObject:@"1" forKey:@"cig_cpap"];}
    else{[formOneData setObject:@"0" forKey:@"cig_cpap"];}
    
    if ([self checkedOption:btn_auto_pap]) {[formOneData setObject:@"1" forKey:@"cig_auto_pap"];}
    else{[formOneData setObject:@"0" forKey:@"cig_auto_pap"];}
    
    if ([self checkedOption:btn_bi_level]) {[formOneData setObject:@"1" forKey:@"cig_bi_level"];}
    else{[formOneData setObject:@"0" forKey:@"cig_bi_level"];}
    
    if ([self checkedOption:btn_auto_bi_level]) {[formOneData setObject:@"1" forKey:@"cig_auto_bi_level"];}
    else{[formOneData setObject:@"0" forKey:@"cig_auto_bi_level"];}
    
    if ([self checkedOption:btn_bi_level_st]) {[formOneData setObject:@"1" forKey:@"cig_bi_level_st"];}
    else{[formOneData setObject:@"0" forKey:@"cig_bi_level_st"];}
    
    if ([self checkedOption:btn_auto_sv]) {[formOneData setObject:@"1" forKey:@"cig_auto_sv"];}
    else{[formOneData setObject:@"0" forKey:@"cig_auto_sv"];}
    
    //cig_representative_sign

    /*
    CCXFormTwo *formVC              = [self.storyboard instantiateViewControllerWithIdentifier:@"CCXFormTwo"];
    formVC.formOneData              = formOneData;
    formVC.cig_pt_sign              = img_patient_sign_view.image;
    formVC.cig_representative_sign  = img_company_rep_sign_view.image;
    
    [self.navigationController pushViewController:formVC animated:YES];
     */
}

-(void)autoFillMode{
    
    
    txt_date_setup.text = [Utils getTextForKey:@"cig_setup_date"]; // format_Date txt_date_setup.text
    txt_setup_performed_at.text = [Utils getTextForKey:@"cig_setup_perform"];
    txt_physician_name.text = [Utils getTextForKey:@"cig_physician_name"];
    txt_physician_phone.text = [Utils getTextForKey:@"cig_physician_phone"];
    txt_primary_contact.text = [Utils getTextForKey:@"cig_primary_contact"];
    txt_secondary_contact.text = [Utils getTextForKey:@"cig_secondary_contact"];
    txt_patient_email.text = [Utils getTextForKey:@"cig_patient_email"];
    txt_patient_email_in_monitoring_site.text = [Utils getTextForKey:@"cig_pt_email_monitor"];

    /*
    txt_epap.text = [formOneData valueForKey:@"cig_epap"];
    txt_auto_pap_min.text = [formOneData valueForKey:@"cig_auto_pap_min"];
    txt_auto_pap_max.text = [formOneData valueForKey:@"cig_auto_pap_max"];
    txt_bi_level_epap.text = [formOneData valueForKey:@"cig_bi_level_epap"];
    txt_bi_level_ipap.text = [formOneData valueForKey:@"cig_bi_level_ipap"];
    txt_auto_bi_level_epap.text = [formOneData valueForKey:@"cig_auto_bi_level_epap"];
    txt_auto_bi_level_ipap.text = [formOneData valueForKey:@"cig_auto_bi_level_ipap"];
    txt_bi_level_st_min.text = [formOneData valueForKey:@"cig_bi_level_st_min"];
    txt_bi_level_st_max.text = [formOneData valueForKey:@"cig_bi_level_st_max"];
    txt_bi_level_st_rr.text = [formOneData valueForKey:@"cig_bi_level_st_rr"];
    txt_auto_sv_min.text = [formOneData valueForKey:@"cig_auto_sv_min"];
    txt_auto_sv_max.text = [formOneData valueForKey:@"cig_auto_sv_max"];
    txt_auto_sv_epap.text = [formOneData valueForKey:@"cig_auto_sv_epap"];
    
    txt_make_model.text = [formOneData valueForKey:@"cig_make_model"];
    txt_serial.text = [formOneData valueForKey:@"cig_serial"];
    txt_mask_type_name.text = [formOneData valueForKey:@"cig_mask_type_name"];
    txt_wireless_id.text = [formOneData valueForKey:@"cig_wireless_id"];
    txt_provider_name.text = [formOneData valueForKey:@"cig_provider_name"];

     txt_patient_sign_date.text = [formOneData valueForKey:@"cig_pt_sign_date"]; // txt_patient_sign_date.text
     txt_company_rep_sign_date.text = [formOneData valueForKey:@"cig_provider_date"]; // format date txt_company_rep_sign_date.text
     
    */
    
    
    img_patient_sign_view.image = [Utils getImageForKey:@"img_patient_sign_view1"];
    img_company_rep_sign_view.image = [Utils getImageForKey:@"img_company_rep_sign_view1"];
    
    txt_patient_emergency_contact.text = [Utils getTextForKey:@"cig_emergency_contact"];
    txt_comments.text = [Utils getTextForKey:@"cig_additional_comment"];
    
    if ([[Utils getTextForKey:@"cig_unit"] isEqualToString:@"1"]) {
        [self checkBox:btn_initial_unit];
    }
    if ([[Utils getTextForKey:@"cig_unit"] isEqualToString:@"2"]) {
        [self checkBox:btn_replacement_unit];
    }
    
    
    if ([[Utils getTextForKey:@"cig_mask"] isEqualToString:@"1"]) {
        [self checkBox:btn_nasal_pillows];
    }
    if ([[Utils getTextForKey:@"cig_mask"] isEqualToString:@"2"]) {
        [self checkBox:btn_nasal];
    }
    if ([[Utils getTextForKey:@"cig_mask"] isEqualToString:@"3"]) {
        [self checkBox:btn_full];
    }
    
    
    if ([[Utils getTextForKey:@"cig_sms_tagged"] isEqualToString:@"1"]) {
        [self checkBox:btn_sms_yes];
    }
    if ([[Utils getTextForKey:@"cig_sms_tagged"] isEqualToString:@"2"]) {
        [self checkBox:btn_sms_no];
    }
    if ([[Utils getTextForKey:@"cig_sms_tagged"] isEqualToString:@"3"]) {
        [self checkBox:btn_sms_unknown];
    }
    
    
    if ([[Utils getTextForKey:@"cig_agreement"] isEqualToString:@"1"]) {
        [self checkBox:btn_agreement_accept];
    }
}


-(BOOL)isEmpty:(UITextField*)txtField{
    if ([txtField.text isEqualToString:@""]) return true;
    return false;
}

#pragma mark - Email Validator

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark -

-(IBAction)selectedSkip{
    [txt_comments resignFirstResponder];
    [universalTextField resignFirstResponder];
    CCXFormTwo *formVC     = [self.storyboard instantiateViewControllerWithIdentifier:@"CCXFormTwo"];
    formVC.formOneData     = formOneData;
    formVC.trainer_signature = _trainer_signature;//yes
    formVC.patient_signature = _patient_signature;//yes
    
    formVC.initial1 = _initial1;
    formVC.initial3 = _initial3;
    formVC.signature = _signature;
    
    formVC.mrr_legal_auth_sign = _mrr_legal_auth_sign;
    formVC.mrr_witness_sign = _mrr_witness_sign;
    formVC.pip_legal_auth_rep_sign = _pip_legal_auth_rep_sign;
    formVC.final_signature = _final_signature; //yes
    
    formVC.dict_form = _dict_form; // Not using
    formVC.patient_name = _patient_name;
    
    formVC.isNewTicket = _isNewTicket;//yes
    formVC.isNotSubmitted = _isNotSubmitted; // Not using //yes
    [formOneData setObject:@"0" forKey:@"cig_include"];
    
    [self.navigationController pushViewController:formVC animated:YES];
}

-(IBAction)selectedNext{
    
    [self validation];
}

-(void)validation{
    [txt_comments resignFirstResponder];
    [universalTextField resignFirstResponder];
    if ([txt_date_setup.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"Date of Set-Up cannot be left blank!"];
    else if ([txt_setup_performed_at.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"Set-Up performed at cannot be left blank!"];
    else if ([txt_patient_name.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"Patient Name cannot be left blank!"];
    else if ([txt_dob.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"DOB cannot be left blank!"];
    else if ([txt_physician_name.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"Physician Name cannot be left blank!"];
    else if ([txt_physician_phone.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"Physician Phone cannot be left blank!"];
    else if ([txt_address.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"Address cannot be left blank!"];
    else if ([txt_primary_contact.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"Primary Contact cannot be left blank!"];
    else if ([txt_secondary_contact.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"Secondary Contact cannot be left blank!"];
    //else if (![self validateEmailWithString:txt_patient_email.text]) [[AppDelegate sharedInstance] showAlertMessage:@"Patient 'Email' format is incorrect!"];
    else if ([txt_patient_email.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"Patient Email Address cannot be left blank!"];
    
    else if ([txt_patient_email_in_monitoring_site.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"Patient Email Address Entered in Monitoring Site cannot be left blank!"];
    else if ([txt_wireless_id.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"Wireless ID# cannot be left blank!"];
    else if ([txt_provider_name.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"Provider Name cannot be left blank!"];
    
    /*
    else if ([self checkedOption:btn_cpap]) {
        if ([txt_epap.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"PAP Device Settings cannot be left empty!"];
    }
    else if ([self checkedOption:btn_auto_pap]) {
        if ([txt_auto_pap_min.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"PAP Device Settings cannot be left empty!"];
        if ([txt_auto_pap_max.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"PAP Device Settings cannot be left empty!"];
    }
    else if ([self checkedOption:btn_bi_level]) {
        if ([txt_bi_level_epap.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"PAP Device Settings cannot be left empty!"];
        if ([txt_bi_level_ipap.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"PAP Device Settings cannot be left empty!"];
    }
    else if ([self checkedOption:btn_auto_bi_level]) {
        if ([txt_auto_bi_level_epap.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"PAP Device Settings cannot be left empty!"];
        if ([txt_auto_bi_level_ipap.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"PAP Device Settings cannot be left empty!"];
    }
    else if ([self checkedOption:btn_bi_level_st]) {
        if ([txt_bi_level_st_min.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"PAP Device Settings cannot be left empty!"];
        if ([txt_bi_level_st_max.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"PAP Device Settings cannot be left empty!"];
        if ([txt_bi_level_st_rr.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"PAP Device Settings cannot be left empty!"];
    }
    else if ([self checkedOption:btn_auto_sv]) {
        if ([txt_auto_sv_min.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"PAP Device Settings cannot be left empty!"];
        if ([txt_auto_sv_max.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"PAP Device Settings cannot be left empty!"];
        if ([txt_auto_sv_epap.text isEqualToString:@""]) [[AppDelegate sharedInstance] showAlertMessage:@"PAP Device Settings cannot be left empty!"];
    }
    */
    
    else if (![self checkedOption:btn_initial_unit] && ![self checkedOption:btn_replacement_unit]) [[AppDelegate sharedInstance] showAlertMessage:@"Please select 'Initial OR Replacement' Unit."];
    else if (![self checkedOption:btn_heated] && ![self checkedOption:btn_cool_passover]) [[AppDelegate sharedInstance] showAlertMessage:@"Humidifier type cannot be left unchecked!"];
    else if (![self checkedOption:btn_modem_wireless]) [[AppDelegate sharedInstance] showAlertMessage:@"Modem/Wireless cannot be left unchecked!"];
    else if (img_patient_sign_view.image == nil) [[AppDelegate sharedInstance] showAlertMessage:@"Patient's signature cannot be left blank!"];
    else if (img_company_rep_sign_view.image == nil) [[AppDelegate sharedInstance] showAlertMessage:@"Company Representative's signature cannot be left blank!"];
    
    else{
        
        [self saveData];
        
        CCXFormTwo *formVC     = [self.storyboard instantiateViewControllerWithIdentifier:@"CCXFormTwo"];
        formVC.formOneData     = formOneData;
        formVC.trainer_signature = _trainer_signature;//yes
        formVC.patient_signature = _patient_signature;//yes
        
        formVC.initial1 = _initial1;
        formVC.initial3 = _initial3;
        formVC.signature = _signature;
        
        formVC.mrr_legal_auth_sign = _mrr_legal_auth_sign;
        formVC.mrr_witness_sign = _mrr_witness_sign;
        formVC.pip_legal_auth_rep_sign = _pip_legal_auth_rep_sign;
        formVC.final_signature = _final_signature; //yes
        
        formVC.dict_form = _dict_form; // Not using
        formVC.patient_name = _patient_name;
        
        formVC.isNewTicket = _isNewTicket;//yes
        formVC.isNotSubmitted = _isNotSubmitted; // Not using //yes
        
        formVC.cig_pt_sign              = img_patient_sign_view.image;
        formVC.cig_representative_sign  = img_company_rep_sign_view.image;
        
        [Utils saveImage:img_patient_sign_view.image forKey:@"img_patient_sign_view1"];
        [Utils saveImage:img_company_rep_sign_view.image forKey:@"img_company_rep_sign_view1"];
        
        [formOneData setObject:@"1" forKey:@"cig_include"];
        
        [self.navigationController pushViewController:formVC animated:YES];
    }
    
}



#pragma mark -

-(IBAction)selectedCheckBox:(UIButton*)sender{
    [universalTextField resignFirstResponder];
    
    switch (sender.tag) {
        case 333:[signatureBackgroundView removeFromSuperview];
            break;
        case 444:[signaturePanel clearSignature];
            break;
        case 1:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_auto_pap];
            [self uncheckBox:btn_bi_level];
            [self uncheckBox:btn_auto_bi_level];
            [self uncheckBox:btn_bi_level_st];
            [self uncheckBox:btn_auto_sv];
        }
            break;
        case 2:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_cpap];
            [self uncheckBox:btn_bi_level];
            [self uncheckBox:btn_auto_bi_level];
            [self uncheckBox:btn_bi_level_st];
            [self uncheckBox:btn_auto_sv];
        }
            break;
        case 3:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_cpap];
            [self uncheckBox:btn_auto_pap];
            [self uncheckBox:btn_auto_bi_level];
            [self uncheckBox:btn_bi_level_st];
            [self uncheckBox:btn_auto_sv];
        }
            break;
        case 4:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_cpap];
            [self uncheckBox:btn_auto_pap];
            [self uncheckBox:btn_bi_level];
            [self uncheckBox:btn_bi_level_st];
            [self uncheckBox:btn_auto_sv];
        }
            break;
        case 5:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_cpap];
            [self uncheckBox:btn_auto_pap];
            [self uncheckBox:btn_bi_level];
            [self uncheckBox:btn_auto_bi_level];
            [self uncheckBox:btn_auto_sv];
        }
            break;
        case 6:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_cpap];
            [self uncheckBox:btn_auto_pap];
            [self uncheckBox:btn_bi_level];
            [self uncheckBox:btn_auto_bi_level];
            [self uncheckBox:btn_bi_level_st];
        }
            break;
        case 7:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_replacement_unit];
        }
            break;
        case 8:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_initial_unit];
        }
            break;
        case 9:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_cool_passover];
        }
            break;
        case 10:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_heated];
        }
            break;
        case 11:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_nasal];
            [self uncheckBox:btn_full];
        }
            break;
        case 12:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_nasal_pillows];
            [self uncheckBox:btn_full];
        }
            break;
        case 13:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_nasal_pillows];
            [self uncheckBox:btn_nasal];
        }
            break;
        case 14:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_mask_size_m];
            [self uncheckBox:btn_mask_size_l];
            [self uncheckBox:btn_mask_size_xl];
            [self uncheckBox:btn_mask_size_other];
            txt_mask_size_other.enabled = NO;
            txt_mask_size_other.text = @"";
        }
            break;
        case 15:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_mask_size_s];
            [self uncheckBox:btn_mask_size_l];
            [self uncheckBox:btn_mask_size_xl];
            [self uncheckBox:btn_mask_size_other];
            txt_mask_size_other.enabled = NO;
            txt_mask_size_other.text = @"";
        }
            break;
        case 16:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_mask_size_s];
            [self uncheckBox:btn_mask_size_m];
            [self uncheckBox:btn_mask_size_xl];
            [self uncheckBox:btn_mask_size_other];
            txt_mask_size_other.enabled = NO;
            txt_mask_size_other.text = @"";
        }
            break;
        case 17:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_mask_size_s];
            [self uncheckBox:btn_mask_size_m];
            [self uncheckBox:btn_mask_size_l];
            [self uncheckBox:btn_mask_size_other];
            txt_mask_size_other.enabled = NO;
            txt_mask_size_other.text = @"";
        }
            break;
        case 18:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_mask_size_s];
            [self uncheckBox:btn_mask_size_m];
            [self uncheckBox:btn_mask_size_l];
            [self uncheckBox:btn_mask_size_xl];
            txt_mask_size_other.enabled = YES;
            [txt_mask_size_other becomeFirstResponder];
        }
            break;
        case 19:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_rate_auto];
            [self uncheckBox:btn_rate_other];
            txt_rate_other.enabled = NO;
            txt_rate_other.text = @"";
        }
            break;
        case 20:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_rate_off];
            [self uncheckBox:btn_rate_other];
            txt_rate_other.enabled = NO;
            txt_rate_other.text = @"";
        }
            break;
        case 21:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_rate_auto];
            [self uncheckBox:btn_rate_off];
            txt_rate_other.enabled = YES;
            [txt_rate_other becomeFirstResponder];
        }
            break;
        case 22:[self performCheckboxSelection:sender];
            break;
        case 23:[self performCheckboxSelection:sender];
            break;
        case 24:[self performCheckboxSelection:sender];
            break;
        case 25:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_sms_no];
            [self uncheckBox:btn_sms_unknown];
        }
            break;
        case 26:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_sms_yes];
            [self uncheckBox:btn_sms_unknown];
        }
            break;
        case 27:{
            [self performCheckboxSelection:sender];
            [self uncheckBox:btn_sms_yes];
            [self uncheckBox:btn_sms_no];
        }
            break;
        case 28:[self performCheckboxSelection:sender];
            break;
            
        default:
            break;
    }
}

#pragma mark -

-(void)performCheckboxSelection:(UIButton*)sender{
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [self checkBox:sender];
    }
    else{
        [self uncheckBox:sender];
    }
}

-(void)uncheckBox:(UIButton*)sender{
    [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
}

-(void)checkBox:(UIButton*)sender{
    [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
}

-(BOOL)checkedOption:(UIButton*)sender{
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) return true;
    return false;
}

#pragma mark -



#pragma mark -

- (void)autoFillDates
{
    NSDateFormatter *FormatDate = [[NSDateFormatter alloc] init];
    [FormatDate setLocale: [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [FormatDate setDateFormat:@"dd/MM/yy"];
    NSString *dateStr           = [FormatDate stringFromDate:[NSDate date]];
    
    NSDateFormatter *FormatDate1 = [[NSDateFormatter alloc] init];
    [FormatDate1 setLocale: [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [FormatDate1 setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr1 = [FormatDate1 stringFromDate:[NSDate date]];
    
    format_Date = dateStr1;
    /*
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"hh:mm a"];
    txt_setup_performed_at.text = [timeFormat stringFromDate:[NSDate date]];
    */
    [self getSelectedDate:dateStr];
}

- (void)getSelectedDate:(NSString *)daStr {
    
    [arryDate removeAllObjects];
    arryDate                = (NSMutableArray *)[daStr componentsSeparatedByString:@"/"];
    
    NSString *day           = [arryDate objectAtIndex:0];
    NSString *month         = [arryDate objectAtIndex:1];
    NSString *year          = [arryDate objectAtIndex:2];
    
    NSString *selectedDate  = [NSString stringWithFormat:@"%@/%@/%@", month, day, year];
    txt_patient_sign_date.text          = selectedDate;
    txt_company_rep_sign_date.text      = selectedDate;
    txt_date_setup.text                 = selectedDate;
}

#pragma mark - UITextView Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    d_point = d_scrollView.contentOffset;
    
    CGPoint point;
    CGRect rect = [textView bounds];
    rect        = [textView convertRect:rect toView:d_scrollView];
    point       = rect.origin;
    point.x     = 0;
    point.y     -= 20;
    [UIView animateWithDuration:0.5 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
}

#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    universalTextField = textField;
    
    d_point = d_scrollView.contentOffset;
    
    CGPoint point;
    CGRect rect = [textField bounds];
    rect        = [textField convertRect:rect toView:d_scrollView];
    point       = rect.origin;
    point.x     = 0;
    point.y     -= 15;
    [UIView animateWithDuration:0.5 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
}

@end
