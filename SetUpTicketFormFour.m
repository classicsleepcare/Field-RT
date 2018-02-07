//
//  SetUpTicketFormFour.m
//  RT APP
//
//  Created by Anil Prasad on 04/06/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "SetUpTicketFormFour.h"
#import "TicketFormModel.h"
#import "TicketFormView.h"


@interface SetUpTicketFormFour (){
    TicketFormView *object_TV;
}


@end

@implementation SetUpTicketFormFour
@synthesize formOneData, isNewTicket, dict_form, initial1, initial2, initial3, signature, patient_name, isNotSubmitted;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [btn_terms setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];

    
    d_scrollView.contentSize    = CGSizeMake(880, 1515);
    d_scrollView.contentOffset  = CGPointMake(0,0);
    
    rt_trainer_signature = self.trainer_signature;
    rt_patient_signature = self.patient_signature;
    
    
    // Calendar
    popoverViewConDate              = [UIViewController new];
    popoverViewConDate.view.frame   = CGRectMake(300, 200, 300, 530);
    
    datePicker                      = [[UIDatePicker alloc] initWithFrame:CGRectMake (-160, 10, 650, 600)];
    datePicker.datePickerMode       = UIDatePickerModeDate;
    popoverViewConDate.view         = datePicker;
    
    popoverConDate           = [[UIPopoverController alloc] initWithContentViewController:popoverViewConDate];
    popoverConDate.popoverContentSize = CGSizeMake(300, 180);
    popoverConDate.delegate  = self;
    
    if (isNewTicket){
        
        //[[AppDelegate sharedInstance] removeCustomLoader];
        txt_patientName.text = [NSString stringWithFormat:@"%@ %@", [formOneData valueForKey:@"pt_first"], [formOneData valueForKey:@"pt_last"]];
        
        [self dateChanged];
        
        img_initial1    = initial1;
        img_initial2    = initial2;
        img_initial3    = initial3;
        img_signature   = signature;
    }
    else{
        [[AppDelegate sharedInstance] showCustomLoader:self];
        [self performSelector:@selector(autoFillSetupTicket) withObject:nil afterDelay:1.0];
    }
    if ([Utils isEditingMode]) {
        [self autoFillMode];
    }
}


-(void)autoFillSetupTicket{
    txt_patientName.text    = [NSString stringWithFormat:@"%@ %@", dict_form[@"pt_first"], dict_form[@"pt_last"]];
    txt_date.text           = [self getFormattedDate:dict_form[@"patient_date"]];
    format_Date             = [self getFormatedDateToSubmit:dict_form[@"patient_date"]];
    img_sign.image          = [self getImage:dict_form[@"final_signature"]];
    
    if ([dict_form[@"isFinalSubmit"] isEqualToString:@"1"]){
        disableFormView.hidden = NO;
        btn_save.hidden = YES;
        btn_submit.hidden = YES;
    }
    else{
        
    }
    
    [[AppDelegate sharedInstance] removeCustomLoader];
}

-(NSString*)getFormatedDateToSubmit:(NSString*)date{
    
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *dateFromString          = [[NSDate alloc] init];
    dateFromString                  = [dateFormatter dateFromString:date];
    
    NSDateFormatter *FormatDate1 = [[NSDateFormatter alloc] init];
    [FormatDate1 setLocale: [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [FormatDate1 setDateFormat:@"yyyy-MM-dd"]; // MM-dd-yyyy
    NSString *dateStr1 = [FormatDate1 stringFromDate:[datePicker date]];
    
    return dateStr1;
}

-(NSString*)getFormattedDate:(NSString*)date{
    
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateFromString          = [[NSDate alloc] init];
    dateFromString                  = [dateFormatter dateFromString:date];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"MM/dd/yy"];
    NSString *formattedDate         = [dateFormatter2 stringFromDate:dateFromString];
    
    return formattedDate;
}

-(UIImage*)getImage:(NSString*)signFileName{
    
    signImg                         = nil;
    NSString *urlString             = [NSString stringWithFormat:url_image, signFileName];
    NSLog(@"urlString is %@",urlString);
    signImg                         = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    
    return signImg;
}

-(void)saveFormWithoutValidation:(NSString*)isFinalSubmit{
    if (isNewTicket) {
        //[self submitForm:isFinalSubmit];
    }
    else{
        //[self submitEditedFormWithTicketID:dict_form[@"ticket_id"] isFinal:isFinalSubmit];
    }
}

-(void)validateForm{
    if (img_sign.image == nil) {
        [[[UIAlertView alloc] initWithTitle:@"Message:" message:@"Signature is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
    else if ([btn_terms.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]){
        [[[UIAlertView alloc] initWithTitle:@"Message:" message:@"Please accept terms in order to continue." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
    else{
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"StoryboardTwo" bundle:nil];
        
        if ([btn_terms.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]){
            [formOneData setObject:@"1" forKey:@"finalAgree"];
        }
        CCXFormOne *formVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"CCXFormOne"]; 
        formVC.formOneData = formOneData;
        formVC.trainer_signature = _trainer_signature;
        formVC.patient_signature = _patient_signature;
        
        formVC.initial1 = img_initial1;
        formVC.initial2 = img_initial2;
        formVC.initial3 = img_initial3;
        formVC.signature = img_signature;
        
        formVC.mrr_legal_auth_sign = _mrr_legal_auth_sign;
        formVC.mrr_witness_sign = _mrr_witness_sign;
        formVC.pip_legal_auth_rep_sign = _pip_legal_auth_rep_sign;
        formVC.final_signature = img_sign.image;
        [Utils saveImage:img_sign.image forKey:@"final_signature"];
        
        
        formVC.dict_form = dict_form; // Not using
        formVC.patient_name = patient_name;
        
        formVC.isNewTicket = isNewTicket;
        formVC.isNotSubmitted = isNotSubmitted; // Not using
        
        [self.navigationController pushViewController:formVC animated:YES];
    }
}

-(void)autoFillMode{
    img_sign.image = [Utils getImageForKey:@"final_signature"];
    if ([[Utils getTextForKey:@"finalAgree"] isEqualToString:@"1"]) {
        [btn_terms setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
}

/*
-(void)submitForm:(NSString*)isFinalSubmit{ // SUBMIT button action Now NEXT button
    
    
    
    object_TV                   = [TicketFormView new];
    dispatch_queue_t myQueue    = dispatch_queue_create("Sumbit", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dicti     = [object_TV submitTicketPtId:[formOneData valueForKey:@"pt_id"]
                                                       status:[formOneData valueForKey:@"status"]
                                                     pt_first:[formOneData valueForKey:@"pt_first"]
                                                      pt_last:[formOneData valueForKey:@"pt_last"]
                                                       gender:[formOneData valueForKey:@"pt_gender"]
                                                      spanish:[formOneData valueForKey:@"pt_spanish"]
                                                       pt_add:[formOneData valueForKey:@"pt_add"]
                                                      pt_city:[formOneData valueForKey:@"pt_city"]
                                                     pt_state:[formOneData valueForKey:@"pt_state"]
                                                       pt_zip:[formOneData valueForKey:@"pt_zip"]
                                                      pt_home:[formOneData valueForKey:@"pt_home"]
                                                      pt_cell:[formOneData valueForKey:@"pt_cell"]
                                                      pt_work:[formOneData valueForKey:@"pt_work"]
                                                     pt_email:[formOneData valueForKey:@"pt_email"]
                                                      machine:[formOneData valueForKey:@"machine"]
                                                         cpap1:[formOneData valueForKey:@"cpap1"]
                                                        level1:[formOneData valueForKey:@"level1"]
                                                         cpap:[formOneData valueForKey:@"cpap"]
                                                        level:[formOneData valueForKey:@"level"]
                                                 manufacturer:[formOneData valueForKey:@"manufacturer"]
                                                        model:[formOneData valueForKey:@"model"]
                                                       serial:[formOneData valueForKey:@"serial"]
                                                           cm:@"-"
                                                    ramp_time:[formOneData valueForKey:@"ramp_time"]
                                                         rate:@"-"
                                                        modem:[formOneData valueForKey:@"modem"]
                                                   modem_type:@"-"
                                                 modem_serial:[formOneData valueForKey:@"modem_serial"]
                                                    hum_modem:[formOneData valueForKey:@"hum_modem"]
                                             hum_manufacturer:[formOneData valueForKey:@"hum_manufacturer"]
                                                   hum_serial:[formOneData valueForKey:@"hum_serial"]
                                                         mask:[formOneData valueForKey:@"mask"]
                                                    mask_type:@"-"
                                                    mask_name:[formOneData valueForKey:@"mask_name"]
                                                      mask_id:[formOneData valueForKey:@"mask_id"]
                                                         date:[formOneData valueForKey:@"date"]
                                                   care_first:[formOneData valueForKey:@"care_first"]
                                                    care_last:[formOneData valueForKey:@"care_last"]
                                                 care_address:[formOneData valueForKey:@"care_address"]
                                                    care_city:[formOneData valueForKey:@"care_city"]
                                                   care_state:[formOneData valueForKey:@"care_state"]
                                                     care_zip:[formOneData valueForKey:@"care_zip"]
                                                   care_phone:[formOneData valueForKey:@"care_phone"]
                                                   care_email:[formOneData valueForKey:@"care_email"]
                                                 cpap_item_id:[formOneData valueForKey:@"cpap_item_id"]
                                                modem_item_id:[formOneData valueForKey:@"modem_item_id"]
                                                  hum_item_id:[formOneData valueForKey:@"hum_item_id"]
                                        place_of_service_text:[formOneData valueForKey:@"place_of_service_text"]
                                             other_instructed:[formOneData valueForKey:@"other_instructed"]
                                              rt_trainer_name:[formOneData valueForKey:@"rt_trainer_name"]
                                             reason_for_visit:[formOneData valueForKey:@"reason_for_visit"]
                                                        goal1:[formOneData valueForKey:@"goal1"]
                                                        goal2:[formOneData valueForKey:@"goal2"]
                                                        goal1:[formOneData valueForKey:@"goal3"]
                                                        goal1:[formOneData valueForKey:@"goal4"]
                                                        goal1:[formOneData valueForKey:@"goal5"]
                                                        goal1:[formOneData valueForKey:@"goal6"]
                                                        goal1:[formOneData valueForKey:@"goal7"]
                                                        goal1:[formOneData valueForKey:@"goal8"]
                                                        goal1:[formOneData valueForKey:@"goal9"]
                                                        goal1:[formOneData valueForKey:@"goal10"]
                                                        goal1:[formOneData valueForKey:@"goal11"]
                                                        goal1:[formOneData valueForKey:@"goal12"]
                                                        goal1:[formOneData valueForKey:@"goal13"]
                                                        goal1:[formOneData valueForKey:@"goal14"]
                                                        goal1:[formOneData valueForKey:@"goal15"]
                                                        goal1:[formOneData valueForKey:@"goal16"]
                                                        goal1:[formOneData valueForKey:@"goal17"]
                                                        goal1:[formOneData valueForKey:@"goal18"]
                                                        goal1:[formOneData valueForKey:@"goal19"]
                                                        goal1:[formOneData valueForKey:@"goal20"]
                                                        goal1:[formOneData valueForKey:@"goal21"]
                                                        goal1:[formOneData valueForKey:@"goal22"]
                                                   rt_summary:[formOneData valueForKey:@"rt_summary"]
                                            patient_caregiver:@"-"
                                                 relationship:[formOneData valueForKey:@"relationship"]
                                              rt_trainer_date:[formOneData valueForKey:@"rt_trainer_date"]
                                                 patient_date:format_Date
                                                    json_item:[formOneData valueForKey:@"json_item"]
                                          json_discarded_item:[formOneData valueForKey:@"json_discarded_item"]
                                              json_adtnl_item:[formOneData valueForKey:@"json_adtnl_item"]
                                                        notes:[formOneData valueForKey:@"notes"]
                                                 machine_type:[formOneData valueForKey:@"machine_type"]
                                                       pt_dob:[formOneData valueForKey:@"pt_dob"]
                                                      cpap_cm:[formOneData valueForKey:@"cpap_cm"]
                                               cpap_ramp_time:[formOneData valueForKey:@"cpap_ramp_time"]
                                          cpap_auto_ramp_time:[formOneData valueForKey:@"cpap_auto_ramp_time"]
                                       cpap_auto_low_pressure:[formOneData valueForKey:@"cpap_auto_low_pressure"]
                                      cpap_auto_high_pressure:[formOneData valueForKey:@"cpap_auto_high_pressure"]
                                              bi_st_ramp_time:[formOneData valueForKey:@"bi_st_ramp_time"]
                                                   bi_st_ipap:[formOneData valueForKey:@"bi_st_ipap"]
                                                   bi_st_epap:[formOneData valueForKey:@"bi_st_epap"]
                                            bi_auto_ramp_time:[formOneData valueForKey:@"bi_auto_ramp_time"]
                                             bi_auto_epap_min:[formOneData valueForKey:@"bi_auto_epap_min"]
                                             bi_auto_epap_max:[formOneData valueForKey:@"bi_auto_epap_max"]
                                 bi_auto_pressure_support_min:[formOneData valueForKey:@"bi_auto_pressure_support_min"]
                                 bi_auto_pressure_support_max:[formOneData valueForKey:@"bi_auto_pressure_support_max"]
                                         bi_auto_sv_ramp_time:[formOneData valueForKey:@"bi_auto_sv_ramp_time"]
                                          bi_auto_sv_epap_min:[formOneData valueForKey:@"bi_auto_sv_epap_min"]
                                          bi_auto_sv_ipap_max:[formOneData valueForKey:@"bi_auto_sv_ipap_max"]
                              bi_auto_sv_pressure_support_min:[formOneData valueForKey:@"bi_auto_sv_pressure_support_min"]
                              bi_auto_sv_pressure_support_max:[formOneData valueForKey:@"bi_auto_sv_pressure_support_max"]
                                       bi_auto_sv_backup_rate:[formOneData valueForKey:@"bi_auto_sv_backup_rate"]
                              bi_auto_sv_max_pressure_support:[formOneData valueForKey:@"bi_auto_sv_max_pressure_support"]
                                         bi_auto_st_ramp_time:[formOneData valueForKey:@"bi_auto_st_ramp_time"]
                                              bi_auto_st_ipap:[formOneData valueForKey:@"bi_auto_st_ipap"]
                                              bi_auto_st_epap:[formOneData valueForKey:@"bi_auto_st_epap"]
                                       bi_auto_st_backup_rate:[formOneData valueForKey:@"bi_auto_st_backup_rate"]
                                                  auth_person:[formOneData valueForKey:@"auth_person"]
                                             auth_person_name:[formOneData valueForKey:@"auth_person_name"]
                                             email_to_patient:[formOneData valueForKey:@"email_to_patient"]
                                               picked_machine:[formOneData valueForKey:@"picked_machine"]
                                          picked_machine_name:[formOneData valueForKey:@"picked_machine_name"]
                                          picked_manufacturer:[formOneData valueForKey:@"picked_manufacturer"]
                                        picked_machine_serial:[formOneData valueForKey:@"picked_machine_serial"]
                                            picked_hum_serial:[formOneData valueForKey:@"picked_hum_serial"]
                                          picked_modem_serial:[formOneData valueForKey:@"picked_modem_serial"]
                                                isFinalSubmit:isFinalSubmit
                                        mrr_medical_agreement:[formOneData valueForKey:@"mrr_medical_agreement"]
                                          mrr_legal_auth_name:[formOneData valueForKey:@"mrr_legal_auth_name"]
                                     mrr_legal_auth_sign_date:[formOneData valueForKey:@"mrr_legal_auth_sign_date"]
                                        mrr_witness_sign_date:[formOneData valueForKey:@"mrr_witness_sign_date"]
                                                    pip_email:[formOneData valueForKey:@"pip_email"]
                                                    pip_phone:[formOneData valueForKey:@"pip_phone"]
                                             pip_notification:[formOneData valueForKey:@"pip_notification"]
                                 pip_legal_auth_rep_sign_date:[formOneData valueForKey:@"pip_legal_auth_rep_sign_date"]
                                      pip_legal_auth_rep_name:[formOneData valueForKey:@"pip_legal_auth_rep_name"]
                                           csc_clinician_name:[formOneData valueForKey:@"csc_clinician_name"]
                                      ordering_physician_name:[formOneData valueForKey:@"ordering_physician_name"]
                                                 pap_location:[formOneData valueForKey:@"pap_location"]
                                                       goal23:[formOneData valueForKey:@"goal23"]
                                                       goal24:[formOneData valueForKey:@"goal24"]
                                                add_item_need:[formOneData valueForKey:@"add_item_need"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM = [[TicketFormModel alloc] initWithDictionary:dicti];
                
                NSLog(@"MESSAGE: %@", object_TM.msg);
                
                [self submitInitialsForTicket:object_TM.ticket_id isFinalSubmit:isFinalSubmit];
                
            }
        });
    });
}

-(void)submitEditedFormWithTicketID:(NSString*)ticket_id isFinal:(NSString*)isFinalSubmit{
    
    object_TV                   = [TicketFormView new];
    dispatch_queue_t myQueue    = dispatch_queue_create("SumbitEdited", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dicti     = [object_TV     editTicketId:ticket_id
                                                         PtId:[formOneData valueForKey:@"pt_id"]
                                                       status:[formOneData valueForKey:@"status"]
                                                     pt_first:[formOneData valueForKey:@"pt_first"]
                                                      pt_last:[formOneData valueForKey:@"pt_last"]
                                                       gender:[formOneData valueForKey:@"pt_gender"]
                                                      spanish:[formOneData valueForKey:@"pt_spanish"]
                                                       pt_add:[formOneData valueForKey:@"pt_add"]
                                                      pt_city:[formOneData valueForKey:@"pt_city"]
                                                     pt_state:[formOneData valueForKey:@"pt_state"]
                                                       pt_zip:[formOneData valueForKey:@"pt_zip"]
                                                      pt_home:[formOneData valueForKey:@"pt_home"]
                                                      pt_cell:[formOneData valueForKey:@"pt_cell"]
                                                      pt_work:[formOneData valueForKey:@"pt_work"]
                                                     pt_email:[formOneData valueForKey:@"pt_email"]
                                                      machine:[formOneData valueForKey:@"machine"]
                                                        cpap1:[formOneData valueForKey:@"cpap1"]
                                                       level1:[formOneData valueForKey:@"level1"]
                                                         cpap:[formOneData valueForKey:@"cpap"]
                                                        level:[formOneData valueForKey:@"level"]
                                                 manufacturer:[formOneData valueForKey:@"manufacturer"]
                                                        model:[formOneData valueForKey:@"model"]
                                                       serial:[formOneData valueForKey:@"serial"]
                                                           cm:@"-"
                                                    ramp_time:[formOneData valueForKey:@"ramp_time"]
                                                         rate:@"-"
                                                        modem:[formOneData valueForKey:@"modem"]
                                                   modem_type:@"-"
                                                 modem_serial:[formOneData valueForKey:@"modem_serial"]
                                                    hum_modem:[formOneData valueForKey:@"hum_modem"]
                                             hum_manufacturer:[formOneData valueForKey:@"hum_manufacturer"]
                                                   hum_serial:[formOneData valueForKey:@"hum_serial"]
                                                         mask:[formOneData valueForKey:@"mask"]
                                                    mask_type:@"-"
                                                    mask_name:[formOneData valueForKey:@"mask_name"]
                                                      mask_id:[formOneData valueForKey:@"mask_id"]
                                                         date:[formOneData valueForKey:@"date"]
                                                   care_first:[formOneData valueForKey:@"care_first"]
                                                    care_last:[formOneData valueForKey:@"care_last"]
                                                 care_address:[formOneData valueForKey:@"care_address"]
                                                    care_city:[formOneData valueForKey:@"care_city"]
                                                   care_state:[formOneData valueForKey:@"care_state"]
                                                     care_zip:[formOneData valueForKey:@"care_zip"]
                                                   care_phone:[formOneData valueForKey:@"care_phone"]
                                                   care_email:[formOneData valueForKey:@"care_email"]
                                                 cpap_item_id:[formOneData valueForKey:@"cpap_item_id"]
                                                modem_item_id:[formOneData valueForKey:@"modem_item_id"]
                                                  hum_item_id:[formOneData valueForKey:@"hum_item_id"]
                                        place_of_service_text:[formOneData valueForKey:@"place_of_service_text"]
                                             other_instructed:[formOneData valueForKey:@"other_instructed"]
                                              rt_trainer_name:[formOneData valueForKey:@"rt_trainer_name"]
                                             reason_for_visit:[formOneData valueForKey:@"reason_for_visit"]
                                                        goal1:[formOneData valueForKey:@"goal1"]
                                                        goal2:[formOneData valueForKey:@"goal2"]
                                                        goal1:[formOneData valueForKey:@"goal3"]
                                                        goal1:[formOneData valueForKey:@"goal4"]
                                                        goal1:[formOneData valueForKey:@"goal5"]
                                                        goal1:[formOneData valueForKey:@"goal6"]
                                                        goal1:[formOneData valueForKey:@"goal7"]
                                                        goal1:[formOneData valueForKey:@"goal8"]
                                                        goal1:[formOneData valueForKey:@"goal9"]
                                                        goal1:[formOneData valueForKey:@"goal10"]
                                                        goal1:[formOneData valueForKey:@"goal11"]
                                                        goal1:[formOneData valueForKey:@"goal12"]
                                                        goal1:[formOneData valueForKey:@"goal13"]
                                                        goal1:[formOneData valueForKey:@"goal14"]
                                                        goal1:[formOneData valueForKey:@"goal15"]
                                                        goal1:[formOneData valueForKey:@"goal16"]
                                                        goal1:[formOneData valueForKey:@"goal17"]
                                                        goal1:[formOneData valueForKey:@"goal18"]
                                                        goal1:[formOneData valueForKey:@"goal19"]
                                                        goal1:[formOneData valueForKey:@"goal20"]
                                                        goal1:[formOneData valueForKey:@"goal21"]
                                                        goal1:[formOneData valueForKey:@"goal22"]
                                                   rt_summary:[formOneData valueForKey:@"rt_summary"]
                                            patient_caregiver:[formOneData valueForKey:@"patient_caregiver"]
                                                 relationship:[formOneData valueForKey:@"relationship"]
                                              rt_trainer_date:[formOneData valueForKey:@"rt_trainer_date"]
                                                 patient_date:format_Date
                                                    json_item:[formOneData valueForKey:@"json_item"]
                                          json_discarded_item:[formOneData valueForKey:@"json_discarded_item"]
                                              json_adtnl_item:[formOneData valueForKey:@"json_adtnl_item"]
                                                        notes:[formOneData valueForKey:@"notes"]
                                                 machine_type:[formOneData valueForKey:@"machine_type"]
                                                       pt_dob:[formOneData valueForKey:@"pt_dob"]
                                                      cpap_cm:[formOneData valueForKey:@"cpap_cm"]
                                               cpap_ramp_time:[formOneData valueForKey:@"cpap_ramp_time"]
                                          cpap_auto_ramp_time:[formOneData valueForKey:@"cpap_auto_ramp_time"]
                                       cpap_auto_low_pressure:[formOneData valueForKey:@"cpap_auto_low_pressure"]
                                      cpap_auto_high_pressure:[formOneData valueForKey:@"cpap_auto_high_pressure"]
                                              bi_st_ramp_time:[formOneData valueForKey:@"bi_st_ramp_time"]
                                                   bi_st_ipap:[formOneData valueForKey:@"bi_st_ipap"]
                                                   bi_st_epap:[formOneData valueForKey:@"bi_st_epap"]
                                            bi_auto_ramp_time:[formOneData valueForKey:@"bi_auto_ramp_time"]
                                             bi_auto_epap_min:[formOneData valueForKey:@"bi_auto_epap_min"]
                                             bi_auto_epap_max:[formOneData valueForKey:@"bi_auto_epap_max"]
                                 bi_auto_pressure_support_min:[formOneData valueForKey:@"bi_auto_pressure_support_min"]
                                 bi_auto_pressure_support_max:[formOneData valueForKey:@"bi_auto_pressure_support_max"]
                                         bi_auto_sv_ramp_time:[formOneData valueForKey:@"bi_auto_sv_ramp_time"]
                                          bi_auto_sv_epap_min:[formOneData valueForKey:@"bi_auto_sv_epap_min"]
                                          bi_auto_sv_ipap_max:[formOneData valueForKey:@"bi_auto_sv_ipap_max"]
                              bi_auto_sv_pressure_support_min:[formOneData valueForKey:@"bi_auto_sv_pressure_support_min"]
                              bi_auto_sv_pressure_support_max:[formOneData valueForKey:@"bi_auto_sv_pressure_support_max"]
                                       bi_auto_sv_backup_rate:[formOneData valueForKey:@"bi_auto_sv_backup_rate"]
                              bi_auto_sv_max_pressure_support:[formOneData valueForKey:@"bi_auto_sv_max_pressure_support"]
                                         bi_auto_st_ramp_time:[formOneData valueForKey:@"bi_auto_st_ramp_time"]
                                              bi_auto_st_ipap:[formOneData valueForKey:@"bi_auto_st_ipap"]
                                              bi_auto_st_epap:[formOneData valueForKey:@"bi_auto_st_epap"]
                                       bi_auto_st_backup_rate:[formOneData valueForKey:@"bi_auto_st_backup_rate"]
                                                  auth_person:[formOneData valueForKey:@"auth_person"]
                                             auth_person_name:[formOneData valueForKey:@"auth_person_name"]
                                             email_to_patient:[formOneData valueForKey:@"email_to_patient"]
                                               picked_machine:[formOneData valueForKey:@"picked_machine"]
                                          picked_machine_name:[formOneData valueForKey:@"picked_machine_name"]
                                          picked_manufacturer:[formOneData valueForKey:@"picked_manufacturer"]
                                        picked_machine_serial:[formOneData valueForKey:@"picked_machine_serial"]
                                            picked_hum_serial:[formOneData valueForKey:@"picked_hum_serial"]
                                          picked_modem_serial:[formOneData valueForKey:@"picked_modem_serial"]
                                                isFinalSubmit:isFinalSubmit];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM = [[TicketFormModel alloc] initWithDictionary:dicti];
                
                NSLog(@"MESSAGE: %@", object_TM.msg);
                
                [self submitInitialsForTicket:ticket_id isFinalSubmit:isFinalSubmit];
                
            }
        });
    });
}

-(void)submitInitialsForTicket:(NSString*)ID isFinalSubmit:(NSString*)isFinalSubmit{
    object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("initials", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    
    dispatch_async(myQueue, ^{
        NSDictionary *dicti =[object_TV submitTicketWithID:ID
                                                  initial1:initial1
                                                  initial2:initial2
                                                  initial3:initial3
                                                 signature:img_signature
                                      rt_trainer_signature:rt_trainer_signature
                                      rt_patient_signature:rt_patient_signature
                                             isFinalSubmit:isFinalSubmit
                                           final_signature:img_sign.image
                                       mrr_legal_auth_sign:_mrr_legal_auth_sign
                                          mrr_witness_sign:_mrr_witness_sign
                                   pip_legal_auth_rep_sign:_pip_legal_auth_rep_sign];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            NSLog(@"MESSAGE: %@", dicti);
            if(dicti)
            {
                ticketSubmittedAlert = [[UIAlertView alloc] initWithTitle:@"Message!" message:@"Ticket submitted successfully!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [ticketSubmittedAlert show];
                
                //                TicketFormModel *object_TM = [[TicketFormModel alloc] initWithDictionary:dicti];
                //                NSLog(@"MESSAGE: %@", object_TM.msg);
            }
        });
    });
}
*/

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView == submitAlert) {
        
        if (buttonIndex == 0) {
            if (isNewTicket) {
                //[self submitForm:@"1"];
            }
            else{
                //[self submitEditedFormWithTicketID:dict_form[@"ticket_id"] isFinal:@"1"];
            }
        }
    }
    else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}


-(IBAction)actionForButton:(UIButton*)sender{
    
    [universalTextField resignFirstResponder];
    
    switch (sender.tag) {
        case 50:{
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 51:{
            /*
            submitAlert = [[UIAlertView alloc] initWithTitle:@"Are you sure?" message:@"" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
            
            [submitAlert show];
            */
            
            [self validateForm];
            
        }
            break;
        case 52:{
            [self saveFormWithoutValidation:@"0"];
        }
            break;
        case 53:{
            [self createSignatureView];
        }
            break;
        case 54:{
            //[self selectDate:sender];
        }
            break;
        case 55:{
            [self showPrivacyPolicyPDF];
        }
            break;
            
        case 21:{
            [signatureBackgroundView removeFromSuperview];
        }
            break;
        case 22:{
            [signaturePanel clearSignature];
        }
            break;
        
            
        default:
            break;
    }
}

-(void)showPrivacyPolicyPDF{
    PDFViewController *object_PDFVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PDFVC"];
    object_PDFVC.isPrivacyPolicy = YES;
    [self.navigationController pushViewController:object_PDFVC animated:YES];
}

-(void)selectDate:(UIButton*)sender{
    
    CGRect frame                    = sender.frame;
    int y                           = frame.origin.y;
    int x                           = frame.origin.x;
    
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    [datePicker setDate:[NSDate date]];
    datePicker.backgroundColor      = [UIColor clearColor];
    
    [dateFormatter setDateFormat:@"dd/MM/yy"];
    [datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    
    [popoverConDate presentPopoverFromRect:CGRectMake(x+50,y, 2, 2) inView:d_scrollView permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

- (void)dateChanged
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
    
    [self getSelectedDate:dateStr];
}

- (void)getSelectedDate:(NSString *)daStr {
    
    [arryDate removeAllObjects];
    arryDate                = (NSMutableArray *)[daStr componentsSeparatedByString:@"/"];
    
    NSString *day           = [arryDate objectAtIndex:0];
    NSString *month         = [arryDate objectAtIndex:1];
    NSString *year          = [arryDate objectAtIndex:2];
    
    NSString *selectedDate  = [NSString stringWithFormat:@"%@/%@/%@", month, day, year];
    txt_date.text           = selectedDate;
}

#pragma mark - Signature View

-(void)createSignatureView{
    
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
    btn_close.tag                   = 21;
    [btn_close setImage:[UIImage imageNamed:@"close-icon"] forState:UIControlStateNormal];
    [btn_close addTarget:self action:@selector(actionForButton:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:btn_close];
    
    UIButton *btn_clear             = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_clear.frame                 = CGRectMake(200, 350, 100, 32);
    btn_clear.backgroundColor       = [UIColor colorWithRed:22.0/255.0 green:125.0/255.0 blue:164.0/255.0 alpha:1.0];
    btn_clear.titleLabel.textColor  = [UIColor whiteColor];
    [btn_clear setTitle:@"Clear" forState:UIControlStateNormal];
    btn_clear.tag                   = 22;
    btn_clear.layer.cornerRadius    = 7;
    btn_clear.clipsToBounds         = YES;
    [btn_clear addTarget:self action:@selector(actionForButton:) forControlEvents:UIControlEventTouchUpInside];
    [signatureVw addSubview:btn_clear];
    
    UIButton *btn_save1              = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_save1.frame                  = CGRectMake(400, 350, 100, 32);
    btn_save1.backgroundColor        = [UIColor colorWithRed:22.0/255.0 green:125.0/255.0 blue:164.0/255.0 alpha:1.0];
    btn_save1.titleLabel.textColor   = [UIColor whiteColor];
    [btn_save1 setTitle:@"Save" forState:UIControlStateNormal];
    //btn_save1.tag                    = sender.tag;
    btn_save1.layer.cornerRadius     = 7;
    btn_save1.clipsToBounds          = YES;
    [btn_save1 addTarget:self action:@selector(saveSignature) forControlEvents:UIControlEventTouchUpInside];
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

-(void)saveSignature{
    [img_sign setImage:[signaturePanel getSignatureImage]];
    [signatureBackgroundView removeFromSuperview];
    
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
    point.y    -= 20;
    [UIView animateWithDuration:0.5 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    return YES;
}

#pragma mark -

-(IBAction)checkUncheckBtnTerms:(UIButton*)sender{
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    else{
        [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
}


@end
