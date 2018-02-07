//
//  SetUpTicketFormThree.m
//  RT APP
//
//  Created by Anil Prasad on 04/06/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "SetUpTicketFormThree.h"
#import "SetUpTicketFormFour.h"

@interface SetUpTicketFormThree ()

@end

@implementation SetUpTicketFormThree
@synthesize formOneData, isNewTicket, dict_form, initial1, initial2, initial3, signature, patient_name, isNotSubmitted, mrr_legal_auth_sign, mrr_witness_sign;

-(void)dismissKeyboard {
    [universalTextField resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    d_scrollView.contentSize    = CGSizeMake(880, 2200);
    d_scrollView.contentOffset  = CGPointMake(0,0);
    
    [btn_1 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_2 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_3 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_3_1 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_4 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_5 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_6 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_7 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_8 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_8_1 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_9 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_10 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_10_1 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_11 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_12 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_13 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_14 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_15 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_16 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_17 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_18 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_19 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_20 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_21 setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];

    [btn_chk_home setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_chk_office setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_chk_other setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_chk_full_setup setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_chk_resupply_only setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    
    arr_mask_size = [[NSArray alloc] initWithObjects:@"Petite/XSmall", @"Small", @"S/M", @"Medium", @"Large", @"XLarge", nil];


    // Calendar
    popoverViewConDate              = [UIViewController new];
    popoverViewConDate.view.frame   = CGRectMake(300, 200, 300, 530);
    
    datePicker                      = [[UIDatePicker alloc] initWithFrame:CGRectMake (-160, 10, 650, 600)];
    datePicker.datePickerMode       = UIDatePickerModeDate;
    popoverViewConDate.view         = datePicker;
    
    popoverConDate           = [[UIPopoverController alloc] initWithContentViewController:popoverViewConDate];
    popoverConDate.popoverContentSize = CGSizeMake(300, 180);
    popoverConDate.delegate  = self;
    
    
    popoverViewCon                              = [[UIViewController alloc]init];
    dropdownsTableviewCon                       = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    popoverViewCon.preferredContentSize         = CGSizeMake(200,500);
    dropdownsTableviewCon.clearsSelectionOnViewWillAppear = NO;
    dropdownsTableviewCon.tableView.tag         = 123; // NOT USED
    dropdownsTableviewCon.tableView.delegate    = self;
    dropdownsTableviewCon.tableView.dataSource  = self;
    dropdownsTableviewCon.tableView.frame       = CGRectMake(0, 0, CGRectGetWidth(popoverViewCon.view.bounds),
                                                             CGRectGetHeight(popoverViewCon.view.bounds));
    
    [popoverViewCon.view addSubview:dropdownsTableviewCon.tableView];
    popoverCon                                  = [[UIPopoverController alloc] initWithContentViewController:popoverViewCon];
    
    if (isNewTicket){
        //[[AppDelegate sharedInstance] removeCustomLoader];
        txt_patientName.text = [NSString stringWithFormat:@"%@ %@", [formOneData valueForKey:@"pt_first"], [formOneData valueForKey:@"pt_last"]];
        txt_patient_id.text = [formOneData valueForKey:@"pt_id"];
        txt_csc_clinician.text = RT_NAME;
        txt_mask_interface.text = [formOneData valueForKey:@"mask"];
        txt_size.text = [formOneData valueForKey:@"mask_name"];
        txt_machine_model.text = [formOneData valueForKey:@"model"];
        txt_serial_number.text = [formOneData valueForKey:@"serial"];
        
        [[AppDelegate sharedInstance] showCustomLoader:self];

        HistoryView *object_HV          = [HistoryView new];
        NSDictionary *dict1              = [object_HV getDetailListForPatientOfId:[formOneData valueForKey:@"pt_id"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            if(dict1)
            {
                HistoryModel* object_HM = [[HistoryModel alloc]initWithDictionaryForPatientDetail:dict1];
                // object_HM.dict_docInfo
                NSString *doc_name = [NSString stringWithFormat:@"%@ %@", [object_HM.dict_docInfo valueForKey:@"Dr_First"], [object_HM.dict_docInfo valueForKey:@"Dr_Last"]];
                txt_ordering_physician.text = doc_name;
                [formOneData setObject:doc_name forKey:@"doc_name"];
                NSString *doc_phone = [object_HM.dict_docInfo valueForKey:@"Dr_Phone"];
                [formOneData setObject:doc_phone forKey:@"doc_phone"];
            }
            
        });
        
        [self dateChanged];
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
    
    txt_patientName.text = [NSString stringWithFormat:@"%@ %@",dict_form[@"pt_first"],dict_form[@"pt_last"]];
    txt_patient_id.text = dict_form[@"place_of_service_text"];
    txt_csc_clinician.text = dict_form[@"other_instructed"];
    txt_ordering_physician.text = dict_form[@"rt_trainer_name"];
    txt_machine_model.text = dict_form[@"reason_for_visit"];
    
    if ([[dict_form valueForKey:@"goal1"] isEqualToString:@"1"]) {
        [btn_1 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal2"] isEqualToString:@"1"]) {
        [btn_2 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal3"] isEqualToString:@"1"]) {
        [btn_3 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal4"] isEqualToString:@"1"]) {
        [btn_3_1 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal5"] isEqualToString:@"1"]) {
        [btn_4 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal6"] isEqualToString:@"1"]) {
        [btn_5 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal7"] isEqualToString:@"1"]) {
        [btn_6 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal8"] isEqualToString:@"1"]) {
        [btn_7 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal9"] isEqualToString:@"1"]) {
        [btn_8 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal10"] isEqualToString:@"1"]) {
        [btn_8_1 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal11"] isEqualToString:@"1"]) {
        [btn_9 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal12"] isEqualToString:@"1"]) {
        [btn_10 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal13"] isEqualToString:@"1"]) {
        [btn_10_1 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal14"] isEqualToString:@"1"]) {
        [btn_11 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal15"] isEqualToString:@"1"]) {
        [btn_12 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal16"] isEqualToString:@"1"]) {
        [btn_13 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal17"] isEqualToString:@"1"]) {
        [btn_14 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal18"] isEqualToString:@"1"]) {
        [btn_15 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal19"] isEqualToString:@"1"]) {
        [btn_16 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal20"] isEqualToString:@"1"]) {
        [btn_17 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal21"] isEqualToString:@"1"]) {
        [btn_18 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([dict_form[@"goal22"] isEqualToString:@"1"]) {
        [btn_19 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    
    txt_summary.text            = dict_form[@"rt_summary"];
    txt_patientCaregiver.text   = dict_form[@"patient_caregiver"];
    txt_relationship.text       = dict_form[@"relationship"];
    txt_date.text               = [self getFormattedDate:dict_form[@"rt_trainer_date"]];
    txt_datePatient.text               = [self getFormattedDate:dict_form[@"rt_trainer_date"]];
    format_Date                 = [self getFormatedDateToSubmit:dict_form[@"rt_trainer_date"]];
    img_sign.image              = [self getImage:dict_form[@"rt_trainer_signature"]];
    img_signPatient.image       = [self getImage:dict_form[@"rt_patient_signature"]];
    
    if ([dict_form[@"isFinalSubmit"] isEqualToString:@"1"]){
        disableFormView.hidden = NO;
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


-(void)nextButtonPressed{
    
    if (isNewTicket) {
        [self validateFilledForm:YES];
    }
    else if (isNotSubmitted){
        [self validateFilledForm:NO];
    }
    else{
        
        SetUpTicketFormFour *formVC     = [self.storyboard instantiateViewControllerWithIdentifier:@"SUTFF"];
        formVC.dict_form                = dict_form;
        formVC.isNewTicket              = NO;
        
        if ([dict_form[@"isFinalSubmit"] isEqualToString:@"0"]){
            img_initial1        = initial1;
            img_initial2        = initial2;
            img_initial3        = initial3;
            img_signature       = signature;
            //img_mrr_legal_auth_sign = mrr_legal_auth_sign;
            //img_mrr_witness_sign    = mrr_witness_sign;
            
            
            formVC.trainer_signature        = img_sign.image;
            formVC.patient_signature        = img_signPatient.image;
            formVC.initial1                 = img_initial1;
            formVC.initial2                 = img_initial2;
            formVC.initial3                 = img_initial3;
            formVC.signature                = img_signature;
            
            formVC.mrr_legal_auth_sign      = mrr_legal_auth_sign;
            formVC.mrr_witness_sign         = mrr_witness_sign;
            formVC.pip_legal_auth_rep_sign  = _pip_legal_auth_rep_sign;
            
            formVC.isNotSubmitted           = YES;
        }
        [self.navigationController pushViewController:formVC animated:YES];
        
    }
    
}

-(void)validateFilledForm:(BOOL)NewTicket{
    
    if ([btn_1.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_2.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_3.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_3_1.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_4.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_5.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_6.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_7.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_8.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_8_1.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_9.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_10.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_10_1.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_11.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_12.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_13.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_14.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_15.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_16.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_17.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_18.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] &&
        [btn_19.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        
        [[AppDelegate sharedInstance] showAlertMessage:@"Atleast 'one' Goal has to be checked!"];
    }
    
    else if (img_sign.image == nil) {
        [[AppDelegate sharedInstance] showAlertMessage:@"One of the initials not present!"];
    }
    else if (img_signPatient.image == nil){
        [[AppDelegate sharedInstance] showAlertMessage:@"One of the initials not present!"];
    }
    
    /*
    else if ([txt_patient_id.text isEqualToString:@""]){
        [[AppDelegate sharedInstance] showAlertMessage:@"'Place of Service' field is mandatory!"];
    }
    else if ([txt_csc_clinician.text isEqualToString:@""]){
        [[AppDelegate sharedInstance] showAlertMessage:@"'Others Instructed' is mandatory!"];
    }
    else if ([txt_ordering_physician.text isEqualToString:@""]){
        [[AppDelegate sharedInstance] showAlertMessage:@"'RT/Trainer Name' field is mandatory!"];
    }
    else if ([txt_machine_model.text isEqualToString:@""]){
        [[AppDelegate sharedInstance] showAlertMessage:@"'Reason of Visit' field is mandatory!"];
    }
    */
    /*
    else if ([txt_summary.text isEqualToString:@""]){
        [[AppDelegate sharedInstance] showAlertMessage:@"All field(s) are mandatory!"];
    }
    if ([txt_patientCaregiver.text isEqualToString:@""]){
        [[AppDelegate sharedInstance] showAlertMessage:@"All field(s) are mandatory!"];
    }
    else if ([txt_relationship.text isEqualToString:@""]){
        [[AppDelegate sharedInstance] showAlertMessage:@"All field(s) are mandatory!"];
    }
    else if ([txt_date.text isEqualToString:@""]){
        [[AppDelegate sharedInstance] showAlertMessage:@"All field(s) are mandatory!"];
    }
     
     */
    else{
        [self saveFormData:NewTicket];
    }

}

-(void)saveFormData:(BOOL)NewTicket{
    [formOneData setObject:txt_patient_id.text forKey:@"place_of_service_text"];
    [formOneData setObject:txt_csc_clinician.text forKey:@"csc_clinician_name"];
    [formOneData setObject:txt_ordering_physician.text forKey:@"ordering_physician_name"];
    [formOneData setObject:txt_machine_model.text forKey:@"reason_for_visit"];
    
    //btn_chk_resupply_only
    if ([btn_chk_full_setup.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"full_resupply"];
    }
    if ([btn_chk_resupply_only.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"2" forKey:@"full_resupply"];
    }
    
    
    if ([btn_chk_home.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"Home" forKey:@"pap_location"];
    }
    else if ([btn_chk_office.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"Office" forKey:@"pap_location"];
    }
    else if ([btn_chk_other.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:txt_other.text forKey:@"pap_location"];
    }
    else {
        [formOneData setObject:@"" forKey:@"pap_location"];
    }
    
    [formOneData setObject:txt_additional_supplies.text forKey:@"add_item_need"];
    
    if ([btn_1.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal1"];
    }else if ([btn_1.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal1"];
    }else{
        [formOneData setObject:@"" forKey:@"goal1"];
    }
    
    if ([btn_2.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal2"];
    }else if ([btn_2.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal2"];
    }else{
        [formOneData setObject:@"" forKey:@"goal2"];
    }
    
    if ([btn_3.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal3"];
    }else if ([btn_3.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal3"];
    }else{
        [formOneData setObject:@"" forKey:@"goal3"];
    }
    
    if ([btn_3_1.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal4"];
    }else if ([btn_3_1.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal4"];
    }else{
        [formOneData setObject:@"" forKey:@"goal4"];
    }
    
    if ([btn_4.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal5"];
    }else  if ([btn_4.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal5"];
    }{
        [formOneData setObject:@"" forKey:@"goal5"];
    }
    
    if ([btn_5.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal6"];
    }else if ([btn_5.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal6"];
    }else{
        [formOneData setObject:@"" forKey:@"goal6"];
    }
    
    if ([btn_6.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal7"];
    }else if ([btn_6.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal7"];
    }else{
        [formOneData setObject:@"" forKey:@"goal7"];
    }
    
    if ([btn_7.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal8"];
    }else if ([btn_7.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal8"];
    }else{
        [formOneData setObject:@"" forKey:@"goal8"];
    }
    
    if ([btn_8.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal9"];
    }else if ([btn_8.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal9"];
    }else{
        [formOneData setObject:@"" forKey:@"goal9"];
    }
    
    if ([btn_8_1.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal10"];
    }else if ([btn_8_1.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal10"];
    }else{
        [formOneData setObject:@"" forKey:@"goal10"];
    }
    
    if ([btn_9.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal11"];
    }else if ([btn_9.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal11"];
    }else{
        [formOneData setObject:@"" forKey:@"goal11"];
    }
    
    if ([btn_10.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal12"];
    }else if ([btn_10.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal12"];
    }else{
        [formOneData setObject:@"" forKey:@"goal12"];
    }
    
    if ([btn_10_1.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal13"];
    }else if ([btn_10_1.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal13"];
    }else{
        [formOneData setObject:@"" forKey:@"goal13"];
    }
    
    if ([btn_11.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal14"];
    }else if ([btn_11.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal14"];
    }else{
        [formOneData setObject:@"" forKey:@"goal14"];
    }
    
    if ([btn_12.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal15"];
    }else if ([btn_12.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal15"];
    }else{
        [formOneData setObject:@"" forKey:@"goal15"];
    }
    
    if ([btn_13.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal16"];
    }else if ([btn_13.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal16"];
    }else{
        [formOneData setObject:@"" forKey:@"goal16"];
    }
    
    if ([btn_14.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal17"];
    }else if ([btn_14.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal17"];
    }else{
        [formOneData setObject:@"" forKey:@"goal17"];
    }
    
    if ([btn_15.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal18"];
    }else if ([btn_15.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal18"];
    }else{
        [formOneData setObject:@"" forKey:@"goal18"];
    }
    
    if ([btn_16.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal19"];
    }else if ([btn_16.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal19"];
    }else{
        [formOneData setObject:@"" forKey:@"goal19"];
    }
    
    if ([btn_17.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal20"];
    }else if ([btn_17.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal20"];
    }else{
        [formOneData setObject:@"" forKey:@"goal20"];
    }
    
    if ([btn_18.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal21"];
    }else if ([btn_18.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal21"];
    }else{
        [formOneData setObject:@"" forKey:@"goal21"];
    }
    
    if ([btn_19.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal22"];
    }else if ([btn_19.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal22"];
    }else{
        [formOneData setObject:@"" forKey:@"goal22"];
    }
    
    if ([btn_20.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal23"];
    }else if ([btn_20.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal23"];
    }else{
        [formOneData setObject:@"" forKey:@"goal23"];
    }
    
    if ([btn_21.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"goal24"];
    }else if ([btn_21.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"goal24"];
    }else{
        [formOneData setObject:@"" forKey:@"goal24"];
    }
    
    
    [formOneData setValue:txt_summary.text forKey:@"rt_summary"];
    //[formOneData setObject:txt_patientCaregiver.text forKey:@"patient_caregiver"];
    [formOneData setValue:txt_relationship.text forKey:@"relationship"];
    [formOneData setValue:format_Date forKey:@"rt_trainer_date"];
    
    img_initial1 = initial1;
    img_initial2 = initial2;
    img_initial3 = initial3;
    img_signature = signature;
    
    
    SetUpTicketFormFour *formVC     = [self.storyboard instantiateViewControllerWithIdentifier:@"SUTFF"];
    
    formVC.formOneData              = formOneData;
    formVC.trainer_signature        = img_sign.image;
    formVC.patient_signature        = img_signPatient.image;
    
    [Utils saveImage:img_sign.image forKey:@"trainer_signature"];
    [Utils saveImage:img_signPatient.image forKey:@"patient_signature"];
    
    formVC.initial1                 = img_initial1;
    formVC.initial2                 = img_initial2; // Not using
    formVC.initial3                 = img_initial3;
    formVC.signature                = img_signature;
    //formVC.legal_auth_rep_sign      = _legal_auth_rep_sign;
    
    formVC.mrr_legal_auth_sign = mrr_legal_auth_sign;
    formVC.mrr_witness_sign = mrr_witness_sign;
    formVC.pip_legal_auth_rep_sign = _pip_legal_auth_rep_sign; //(Optional in case of Respironics)
    
    formVC.isNewTicket              = NewTicket;
    
    if (!NewTicket) {
        
        formVC.dict_form            = dict_form;
        
        img_initial1                = initial1;
        img_initial2                = initial2;
        img_initial3                = initial3;
        img_signature               = signature;
        
        formVC.trainer_signature    = img_sign.image;
        formVC.patient_signature    = img_signPatient.image;
        formVC.initial1             = img_initial1;
        formVC.initial2             = img_initial2;
        formVC.initial3             = img_initial3;
        formVC.signature            = img_signature;
    }
//    [Utils saveAllKeysAndValues:formOneData];

    
    [self.navigationController pushViewController:formVC animated:YES];
}

-(void)autoFillMode{
    img_sign.image = [Utils getImageForKey:@"trainer_signature"];
    img_signPatient.image = [Utils getImageForKey:@"patient_signature"];
    
    txt_patient_id.text = NonNilString([Utils getTextForKey:@"place_of_service_text"]);
    txt_csc_clinician.text = NonNilString([Utils getTextForKey:@"csc_clinician_name"]);
    txt_ordering_physician.text = NonNilString([Utils getTextForKey:@"ordering_physician_name"]);
    txt_machine_model.text = NonNilString([Utils getTextForKey:@"reason_for_visit"]);
    
    txt_summary.text = NonNilString([Utils getTextForKey:@"rt_summary"]);
    txt_relationship.text = NonNilString([Utils getTextForKey:@"relationship"]);
   // txt_date.text = NonNilString([Utils getTextForKey:@"rt_trainer_date"]);
    //txt_datePatient.text = NonNilString([Utils getTextForKey:@"rt_trainer_date"]);
   // txt_date_of_setup.text = NonNilString([Utils getTextForKey:@"rt_trainer_date"]);
    
    
    if ([[Utils getTextForKey:@"full_resupply"] isEqualToString:@"1"]) {
        [btn_chk_full_setup setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"full_resupply"] isEqualToString:@"2"]) {
        [btn_chk_resupply_only setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    
    if ([[Utils getTextForKey:@"pap_location"] isEqualToString:@"Home"]) {
        [btn_chk_home setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    else if ([[Utils getTextForKey:@"pap_location"] isEqualToString:@"Office"]){
        [btn_chk_office setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    else if ([[Utils getTextForKey:@"pap_location"] isEqualToString:@""]){
        [btn_chk_home setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
        [btn_chk_office setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
        [btn_chk_other setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
    else{
        [btn_chk_other setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
        txt_other.text = NonNilString([Utils getTextForKey:@"pap_location"]);
    }
    
    
    if ([[Utils getTextForKey:@"goal1"] isEqualToString:@"1"]) {
        [btn_1 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal2"] isEqualToString:@"1"]) {
        [btn_2 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal3"] isEqualToString:@"1"]) {
        [btn_3 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal4"] isEqualToString:@"1"]) {
        [btn_3_1 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal5"] isEqualToString:@"1"]) {
        [btn_4 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal6"] isEqualToString:@"1"]) {
        [btn_5 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal7"] isEqualToString:@"1"]) {
        [btn_6 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal8"] isEqualToString:@"1"]) {
        [btn_7 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal9"] isEqualToString:@"1"]) {
        [btn_8 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal10"] isEqualToString:@"1"]) {
        [btn_8_1 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal11"] isEqualToString:@"1"]) {
        [btn_9 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal12"] isEqualToString:@"1"]) {
        [btn_10 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal13"] isEqualToString:@"1"]) {
        [btn_10_1 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal14"] isEqualToString:@"1"]) {
        [btn_11 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
        txt_additional_supplies.text = NonNilString([Utils getTextForKey:@"add_item_need"]);
        txt_additional_supplies.hidden = NO;
        lbl_additional_Items.hidden = NO;
    }
    if ([[Utils getTextForKey:@"goal15"] isEqualToString:@"1"]) {
        [btn_12 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal16"] isEqualToString:@"1"]) {
        [btn_13 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal17"] isEqualToString:@"1"]) {
        [btn_14 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal18"] isEqualToString:@"1"]) {
        [btn_15 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal19"] isEqualToString:@"1"]) {
        [btn_16 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal20"] isEqualToString:@"1"]) {
        [btn_17 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal21"] isEqualToString:@"1"]) {
        [btn_18 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal22"] isEqualToString:@"1"]) {
        [btn_19 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal21"] isEqualToString:@"1"]) {
        [btn_20 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    if ([[Utils getTextForKey:@"goal22"] isEqualToString:@"1"]) {
        [btn_21 setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }

}

-(void)showSignatureView:(UIButton*)sender{
    CGPoint point           = CGPointMake(0,800);
    [UIView animateWithDuration:0.1 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
    
    [self createSignatureView:sender];
}

-(IBAction)actionForButton:(UIButton*)sender{
    
    
    switch (sender.tag) {
        case 111:{
            [self showSizeList:sender];
        }
            break;
        case 50:{
            [self nextButtonPressed];
        }
            break;
        case 51:{
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 52:{
            
        }
            break;
        case 53:{
            [self showSignatureView:sender];
        }
            break;
        case 54:{
            [self showSignatureView:sender];
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
            
   //************** All Checkboxes **********//
        case 1:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 2:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 3:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 31:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 4:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 5:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 6:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 7:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 8:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 81:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 9:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 10:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 101:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 11:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
                txt_additional_supplies.hidden = NO;
                lbl_additional_Items.hidden = NO;
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
                txt_additional_supplies.hidden = YES;
                lbl_additional_Items.hidden = YES;
            }
        }
            break;
        case 12:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 13:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 14:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 15:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 16:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 17:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 18:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 19:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
                //txt_additional_supplies.hidden = NO;
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
                //txt_additional_supplies.hidden = YES;
            }
        }
            break;
        case 20:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
        case 211:{
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
                [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
            else{
                [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
            }
        }
            break;
            
        default:
            break;
    }
}


-(void)showSizeList:(UIButton*)sender{
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(200,225);
    [popoverCon setPopoverContentSize:CGSizeMake(200, 225) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
    
}

-(void)showPopover:(UIButton*)sender{
    dropdownsTableviewCon.tableView.contentOffset = CGPointMake(0, 0);
    [popoverCon presentPopoverFromRect:CGRectMake(sender.frame.size.width / 2, sender.frame.size.height / 1, 1, 1) inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(void)selectDate:(UIButton*)sender{
    
    CGPoint point           = CGPointMake(0,760);
    [UIView animateWithDuration:0.1 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
    
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
    //    NSString *dateStr           = [FormatDate stringFromDate:[datePicker date]];
    NSString *dateStr           = [FormatDate stringFromDate:[NSDate date]];
    
    NSDateFormatter *FormatDate1 = [[NSDateFormatter alloc] init];
    [FormatDate1 setLocale: [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [FormatDate1 setDateFormat:@"yyyy-MM-dd"]; // MM-dd-yyyy
    //    NSString *dateStr1 = [FormatDate1 stringFromDate:[datePicker date]];
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
    txt_datePatient.text    = selectedDate;
    txt_date_of_setup.text  = selectedDate;
}

#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arr_mask_size.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID             = @"dropDownList";
    UITableViewCell * cell_table        = [tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell_table) {
        cell_table                      = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                                                reuseIdentifier:strID];
    }
    
    cell_table.textLabel.font           = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
    cell_table.textLabel.text           = [arr_mask_size objectAtIndex:indexPath.row];

    
    return cell_table;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    txt_size.text = [arr_mask_size objectAtIndex:indexPath.row];
    [popoverCon dismissPopoverAnimated:YES];

}

#pragma mark -

-(IBAction)checkUncheckBtnHome:(UIButton*)sender{
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
        [btn_chk_office setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
        [btn_chk_other setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
        txt_other.enabled = NO;
        txt_other.text = @"";
    }
    else{
        [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
}

-(IBAction)checkUncheckBtnOffice:(UIButton*)sender{
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
        [btn_chk_home setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
        [btn_chk_other setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
        txt_other.enabled = NO;
        txt_other.text = @"";
    }
    else{
        [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
}

-(IBAction)checkUncheckBtnOther:(UIButton*)sender{
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
        [btn_chk_home setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
        [btn_chk_office setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
        txt_other.enabled = YES;
        [txt_other becomeFirstResponder];
    }
    else{
        [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
}

-(IBAction)checkUncheckBtnFullSetup:(UIButton*)sender{
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
        [btn_chk_resupply_only setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
    else{
        [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
}

-(IBAction)checkUncheckBtnResupplyOnly:(UIButton*)sender{
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
        [btn_chk_full_setup setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
    else{
        [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
}


#pragma mark - Signature View

//-(void)createSignatureView:(UIButton*)sender{
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
        case 53:{
            [img_sign setImage:[signaturePanel getSignatureImage]];
        }
            break;
            
        case 54:{
            [img_signPatient setImage:[signaturePanel getSignatureImage]];
        }
            break;
            
        default:
            break;
    }
    
    [signatureBackgroundView removeFromSuperview];

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
    point.y     -= 20;
    [UIView animateWithDuration:0.5 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == txt_patientName) {
        [txt_patient_id becomeFirstResponder];
    }
    else if (textField == txt_patient_id){
        [txt_csc_clinician becomeFirstResponder];
    }
    else if (textField == txt_csc_clinician){
        [txt_ordering_physician becomeFirstResponder];
    }
    else if (textField == txt_ordering_physician){
        [txt_machine_model becomeFirstResponder];
    }
    else if (textField == txt_patientCaregiver){
        [txt_relationship becomeFirstResponder];
    }
    else if (textField == txt_relationship){
        CGPoint point = CGPointMake(0,760);
        [UIView animateWithDuration:0.5 animations:^{
            [d_scrollView setContentOffset:point animated:NO];
        }];
        [textField resignFirstResponder];
    }
    else{
        [textField resignFirstResponder];
    }
    
    
    return YES;
}

@end
