//
//  SetUpTicketFormTwo.m
//  RT APP
//
//  Created by Anil Prasad on 16/12/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "SetUpTicketFormTwo.h"
#import "TicketFormModel.h"
#import "TicketFormView.h"
#import "SetupTicketFormFiveViewController.h"

@interface SetUpTicketFormTwo (){
    TicketFormView *object_TV;
}

@end

@implementation SetUpTicketFormTwo
@synthesize arr_rt_states, isNewTicket, dict_form, formOneData, isNotSubmitted;


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

-(void)autoFillSetupTicket{
    
    
    img_signature1.image            = [self getImage:dict_form[@"initials1"]];
    //img_signature2.image            = [self getImage:dict_form[@"initials2"]];
    img_signature3.image            = [self getImage:dict_form[@"initials3"]];
    img_signature4.image            = [self getImage:dict_form[@"signature"]];
    txt_date.text                   = [self getFormattedDate:dict_form[@"rt_trainer_date"]];
    format_Date                     = [self getFormattedDate:dict_form[@"rt_trainer_date"]];
    txt_fName.text                  = dict_form[@"care_first"];
    txt_lName.text                  = dict_form[@"care_last"];
    txt_address.text                = dict_form[@"care_address"];
    txt_city.text                   = dict_form[@"care_city"];
    txt_state.text                  = dict_form[@"care_state"];
    txt_zip.text                    = dict_form[@"care_zip"];
    txt_hPhone.text                 = dict_form[@"care_phone"];
    txt_email.text                  = dict_form[@"care_email"];
    
    NSString *auth_person              = dict_form[@"auth_person"];
    
    if ([auth_person isEqualToString:@"0"]) {
        [(RadioButton*) self.yesNoRadio[1] setSelected:YES];
    }
    if ([auth_person isEqualToString:@"1"]) {
        auth_view.hidden = NO;
        [(RadioButton*) self.yesNoRadio[0] setSelected:YES];
        auth_other_name.text        = dict_form[@"auth_person_name"];
        auth_patient_name.text      = [NSString stringWithFormat:@"%@ %@",dict_form[@"pt_first"],dict_form[@"pt_last"]];
    }
    
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
    signImg                         = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    
    return signImg;
}

-(void)dismissKeyboard {
    [universalTextField resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([Utils isEditingMode]) {
        [self autoFillMode];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    for (RadioButton *radioButton in self.yesNoRadio) {
        radioButton.ButtonIcon          = [UIImage imageNamed:@"radio_btn"];
        radioButton.ButtonIconSelected  = [UIImage imageNamed:@"radio_btn_o"];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        d_scrollView.contentSize    = CGSizeMake(880, 1920);
        d_scrollView.contentOffset  = CGPointMake(0,0);
        
        
        
        // Calendar
        popoverViewConDate              = [UIViewController new];
        popoverViewConDate.view.frame   = CGRectMake(300, 200, 300, 530);
        
        datePicker                      = [[UIDatePicker alloc] initWithFrame:CGRectMake (-160, 10, 650, 600)];
        datePicker.datePickerMode       = UIDatePickerModeDate;
        popoverViewConDate.view         = datePicker;
        
        popoverConDate           = [[UIPopoverController alloc] initWithContentViewController:popoverViewConDate];
        popoverConDate.popoverContentSize = CGSizeMake(300, 180);
        popoverConDate.delegate  = self;
        
        // States
        popoverViewCon                              = [[UIViewController alloc]init];
        dropdownsTableviewCon                       = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
        popoverViewCon.preferredContentSize         = CGSizeMake(200,300);
        dropdownsTableviewCon.tableView.delegate    = self;
        dropdownsTableviewCon.tableView.dataSource  = self;
        
        dropdownsTableviewCon.tableView.frame       = CGRectMake(0, 0, CGRectGetWidth(popoverViewCon.view.bounds),
                                                                 CGRectGetHeight(popoverViewCon.view.bounds));
        
        [popoverViewCon.view addSubview:dropdownsTableviewCon.tableView];
        popoverCon                          = [[UIPopoverController alloc] initWithContentViewController:popoverViewCon];
        popoverViewCon.preferredContentSize = CGSizeMake(100,300);
        [popoverCon setPopoverContentSize:CGSizeMake(100, 200) animated:NO];
        popoverCon.delegate                 = self;
        /*
        // Get user geolocation
        NSString *lat = [[NSUserDefaults standardUserDefaults] objectForKey:@"lat"];
        NSString *lon = [[NSUserDefaults standardUserDefaults] objectForKey:@"lon"];
        
        NSString *geocodingBaseUrl = @"http://maps.googleapis.com/maps/api/geocode/json?";
        NSString *url = [NSString stringWithFormat:@"%@latlng=%@,%@&sensor=false",geocodingBaseUrl,lat, lon];
        
        
        [WebserviceClass getParseDataFromUrl:url :^(id result, NSError *error) {
            
            NSDictionary *dict  = result;
            if ([[dict valueForKey:@"status"] isEqualToString:@"OVER_QUERY_LIMIT"] ||
                [[dict valueForKey:@"status"] isEqualToString:@"ZERO_RESULTS"]) {
                userGeoLocation = @"Unknown";
            }
            else{
                userGeoLocation = [[[dict objectForKey:@"results"] objectAtIndex:0] objectForKey:@"formatted_address"];
            }
            NSLog(@"RESULT :%@",userGeoLocation);
        }];
        */
        //[[AppDelegate sharedInstance] showCustomLoader:self];
    });

    if (isNewTicket){
        //[[AppDelegate sharedInstance] removeCustomLoader];
        [self dateChanged];
    }
    else{
        [[AppDelegate sharedInstance] showCustomLoader:self];
        [self performSelector:@selector(autoFillSetupTicket) withObject:nil afterDelay:1.0];
        btn_delete.enabled      = NO;
        btn_submit.enabled      = NO;
        btn_save.enabled        = NO;
        //lbl_readOnly.hidden     = NO;

    }
}

-(IBAction)actionForButton:(UIButton*)sender{
    
    [universalTextField resignFirstResponder];
    
    
    switch (sender.tag) {
        case 121:{
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 122:{
            // delete btn
        }
            break;
        case 123:{
              // Not used anymore
        }
            break;
        case 124:{
            // save btn
        }
            break;
        case 11:{
            [self selectSignOne:sender];
        }
            break;
        case 12:{
            [self selectSignTwo:sender];
        }
            break;
        case 13:{
            [self selectSignThree:sender];
        }
            break;
        case 14:{
            [self selectSignFour:sender];
            
//            CGPoint point = CGPointMake(0,550);
//            [UIView animateWithDuration:0.5 animations:^{
//                [d_scrollView setContentOffset:point animated:NO];
//            }];
        }
            break;
        case 15:{
            //[self selectDate:sender];
        }
            break;
        case 16:{
            [self selectState:sender];
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
        case 23:{
            [self nextButtonPressed];
        }
            break;
            
        default:
            break;
    }
}

-(void)showAlert{
    [[[UIAlertView alloc] initWithTitle:@"WARNING NOTICE" message:@"Before continuing to the next page, please verify all required fields have been filled in. If all required fields are verified select next." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Next", nil] show];
}

-(void)nextButtonPressed{
    
    if (isNewTicket) {
        [self validateFilledForm:YES];

    }
    else if (isNotSubmitted) {
        [self validateFilledForm:NO];
    }
    else{
        
//        SetUpTicketFormThree *formThreeVC   = [self.storyboard instantiateViewControllerWithIdentifier:@"SUTFTH"];
//        formThreeVC.isNewTicket             = NO;
//        formThreeVC.dict_form               = dict_form;
//        
//        if ([dict_form[@"isFinalSubmit"] isEqualToString:@"0"]){
//            formThreeVC.initial1                = img_signature1.image;
//            formThreeVC.initial2                = img_signature2.image;
//            formThreeVC.initial3                = img_signature3.image;
//            formThreeVC.signature               = img_signature4.image;
//        }
        
        SetupTicketFormFiveViewController *formFiveVC   = [self.storyboard instantiateViewControllerWithIdentifier:@"FIVE"];
        formFiveVC.isNewTicket             = NO;
        formFiveVC.dict_form               = dict_form;
        
        if ([dict_form[@"isFinalSubmit"] isEqualToString:@"0"]){
            formFiveVC.initial1                = img_signature1.image;
            formFiveVC.initial3                = img_signature3.image;
            formFiveVC.signature               = img_signature4.image;
        }
        
        [self.navigationController pushViewController:formFiveVC animated:YES];

    }

}

-(void)validateFilledForm:(BOOL)NewTicket{
    
    if (img_signature1.image == nil) {
        [[AppDelegate sharedInstance] showAlertMessage:@"One of the initials not present!"];
    }
//    else if (img_signature2.image == nil){
//        [[AppDelegate sharedInstance] showAlertMessage:@"One of the initials not present!"];
//    }
    else if (img_signature3.image == nil){
        [[AppDelegate sharedInstance] showAlertMessage:@"One of the initials not present!"];
    }
    else if (img_signature4.image == nil){
        [[AppDelegate sharedInstance] showAlertMessage:@"Signature not present!"];
    }
    
    /*
    if ([txt_date.text isEqualToString:@""]){
        [[AppDelegate sharedInstance] showAlertMessage:@"All field(s) are mandatory!"];
    }
    else if ([txt_fName.text isEqualToString:@""]){
        [[AppDelegate sharedInstance] showAlertMessage:@"All field(s) are mandatory!"];
    }
    else if ([txt_lName.text isEqualToString:@""]){
        [[AppDelegate sharedInstance] showAlertMessage:@"All field(s) are mandatory!"];
    }
    else if ([txt_address.text isEqualToString:@""]){
        [[AppDelegate sharedInstance] showAlertMessage:@"All field(s) are mandatory!"];
    }
    else if ([txt_city.text isEqualToString:@""]){
        [[AppDelegate sharedInstance] showAlertMessage:@"All field(s) are mandatory!"];
    }
    else if ([txt_state.text isEqualToString:@""]){
        [[AppDelegate sharedInstance] showAlertMessage:@"All field(s) are mandatory!"];
    }
    else if ([txt_zip.text isEqualToString:@""]){
        [[AppDelegate sharedInstance] showAlertMessage:@"All field(s) are mandatory!"];
    }
    else if ([txt_hPhone.text isEqualToString:@""]){
        [[AppDelegate sharedInstance] showAlertMessage:@"All field(s) are mandatory!"];
    }
    else if ([txt_email.text isEqualToString:@""]){
        [[AppDelegate sharedInstance] showAlertMessage:@"All field(s) are mandatory!"];
    }
    else if (![self validateEmailWithString:txt_email.text]){
        [[AppDelegate sharedInstance] showAlertMessage:@"'Email' format is incorrect!"];
    }
    */
    
    else{
        [self saveFormData:NewTicket];
    }

}

-(void)saveFormData:(BOOL)NewTicket{
    
    [formOneData setObject:format_Date forKey:@"date"];
    [formOneData setObject:txt_fName.text forKey:@"care_first"];
    [formOneData setObject:txt_lName.text forKey:@"care_last"];
    [formOneData setObject:txt_address.text forKey:@"care_address"];
    [formOneData setObject:txt_city.text forKey:@"care_city"];
    [formOneData setObject:txt_state.text forKey:@"care_state"];
    [formOneData setObject:txt_zip.text forKey:@"care_zip"];
    [formOneData setObject:txt_hPhone.text forKey:@"care_phone"];
    [formOneData setObject:txt_email.text forKey:@"care_email"];
    
    NSString *yesNo_radio = [(RadioButton*)self.yesNoRadio[0] selectedButton].titleLabel.text;
    
    if ([yesNo_radio isEqualToString:@"No"]) {
        [formOneData setObject:@"0" forKey:@"auth_person"];
    }
    if ([yesNo_radio isEqualToString:@"Yes"]) {
        [formOneData setObject:@"1" forKey:@"auth_person"];
    }
    
    [formOneData setObject:auth_other_name.text forKey:@"auth_person_name"];
    
    
    SetupTicketFormFiveViewController *formFiveVC   = [self.storyboard instantiateViewControllerWithIdentifier:@"FIVE"];
    formFiveVC.formOneData             = formOneData;
    formFiveVC.initial1                = img_signature1.image;
    formFiveVC.initial3                = img_signature3.image;
    formFiveVC.signature               = img_signature4.image;
    
    [Utils saveImage:img_signature1.image forKey:@"form2img1"];
    [Utils saveImage:img_signature3.image forKey:@"form2img2"];
    [Utils saveImage:img_signature4.image forKey:@"form2img3"];

    formFiveVC.isNewTicket             = NewTicket;
    
    if (!NewTicket) {
        formFiveVC.dict_form               = dict_form;
        formFiveVC.initial1                = img_signature1.image;
        formFiveVC.initial3                = img_signature3.image;
        formFiveVC.signature               = img_signature4.image;
        formFiveVC.isNotSubmitted          = YES;
    }
//    [Utils saveAllKeysAndValues:formOneData];
    [self.navigationController pushViewController:formFiveVC animated:YES];
}

-(void)autoFillMode{
    img_signature1.image = [Utils getImageForKey:@"form2img1"];
    img_signature3.image = [Utils getImageForKey:@"form2img2"];
    img_signature4.image = [Utils getImageForKey:@"form2img3"];

    //txt_date.text = NonNilString([Utils getTextForKey:@"date"]);
    txt_fName.text = NonNilString([Utils getTextForKey:@"care_first"]);
    txt_lName.text = NonNilString([Utils getTextForKey:@"care_last"]);
    txt_address.text = NonNilString([Utils getTextForKey:@"care_address"]);
    txt_city.text = NonNilString([Utils getTextForKey:@"care_city"]);
    txt_state.text = NonNilString([Utils getTextForKey:@"care_state"]);
    txt_zip.text = NonNilString([Utils getTextForKey:@"care_zip"]);
    txt_hPhone.text = NonNilString([Utils getTextForKey:@"care_phone"]);
    txt_email.text = NonNilString([Utils getTextForKey:@"care_email"]);
    
    NSString *auth_person  = NonNilString([Utils getTextForKey:@"auth_person"]);
    
    if ([auth_person isEqualToString:@"0"]) {
        [(RadioButton*) self.yesNoRadio[1] setSelected:YES];
    }
    if ([auth_person isEqualToString:@"1"]) {
        auth_view.hidden = NO;
        [(RadioButton*) self.yesNoRadio[0] setSelected:YES];
        auth_other_name.text = NonNilString([Utils getTextForKey:@"auth_person_name"]);
        auth_patient_name.text      = [NSString stringWithFormat:@"%@ %@",NonNilString([Utils getTextForKey:@"pt_first"]),NonNilString([Utils getTextForKey:@"pt_last"])];
    }
}

/*
-(void)submitForm{
 
    object_TV                   = [TicketFormView new];
    dispatch_queue_t myQueue    = dispatch_queue_create("Sumbit", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dicti     = [object_TV submitTicketPtId:[formOneData valueForKey:@"pt_id"]
                                                       status:[formOneData valueForKey:@"status"]
                                                     pt_first:[formOneData valueForKey:@"pt_first"]
                                                      pt_last:[formOneData valueForKey:@"pt_last"]
                                                       gender:[formOneData valueForKey:@"gender"]
                                                      spanish:[formOneData valueForKey:@"spanish"]
                                                       pt_add:[formOneData valueForKey:@"pt_add"]
                                                      pt_city:[formOneData valueForKey:@"pt_city"]
                                                     pt_state:[formOneData valueForKey:@"pt_state"]
                                                       pt_zip:[formOneData valueForKey:@"pt_zip"]
                                                      pt_home:[formOneData valueForKey:@"pt_home"]
                                                      pt_cell:[formOneData valueForKey:@"pt_cell"]
                                                      pt_work:[formOneData valueForKey:@"pt_work"]
                                                     pt_email:[formOneData valueForKey:@"pt_email"]
                                                      machine:[formOneData valueForKey:@"machine"]
                                                         cpap:[formOneData valueForKey:@"cpap"]
                                                        level:[formOneData valueForKey:@"level"]
                                                 manufacturer:[formOneData valueForKey:@"manufacturer"]
                                                        model:[formOneData valueForKey:@"model"]
                                                       serial:[formOneData valueForKey:@"serial"]
                                                           cm:[formOneData valueForKey:@"cm"]
                                                    ramp_time:[formOneData valueForKey:@"ramp_time"]
                                                         rate:[formOneData valueForKey:@"rate"]
                                                        modem:[formOneData valueForKey:@"modem"]
                                                   modem_type:[formOneData valueForKey:@"modem_type"]
                                                 modem_serial:[formOneData valueForKey:@"modem_serial"]
                                                    hum_modem:[formOneData valueForKey:@"hum_modem"]
                                             hum_manufacturer:[formOneData valueForKey:@"hum_manufacturer"]
                                                   hum_serial:[formOneData valueForKey:@"hum_serial"]
                                                         mask:[formOneData valueForKey:@"mask"]
                                                    mask_type:[formOneData valueForKey:@"mask_type"]
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
                                                    json_item:[formOneData valueForKey:@"json_item"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM = [[TicketFormModel alloc] initWithDictionary:dicti];
                
                NSLog(@"MESSAGE: %@", object_TM.msg);
                
                [self submitInitialsForTicket:object_TM.ticket_id];
                
            }
        });
    });
}



-(void)submitInitialsForTicket:(NSString*)ID{
    object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("initials", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    
    dispatch_async(myQueue, ^{
        NSDictionary *dicti =[object_TV submitTicketWithID:ID
                                                  initial1:img_signature1.image
                                                  initial2:img_signature2.image
                                                  initial3:img_signature3.image
                                                 signature:img_signature4.image];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            NSLog(@"MESSAGE: %@", dicti);
            if(dicti)
            {
                [[[UIAlertView alloc] initWithTitle:@"Message!" message:@"Ticket submitted successfully!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                
                //                TicketFormModel *object_TM = [[TicketFormModel alloc] initWithDictionary:dicti];
                //                NSLog(@"MESSAGE: %@", object_TM.msg);
            }
        });
    });
}
 
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    [self.navigationController popToRootViewControllerAnimated:YES];
    if (buttonIndex == 1) {
        
    }
}
#pragma mark - 
-(IBAction)selectedYes{
    auth_view.hidden = NO;
    auth_patient_name.text = [NSString stringWithFormat:@"%@ %@", [formOneData valueForKey:@"pt_first"], [formOneData valueForKey:@"pt_last"]];
}

-(IBAction)selectedNo{
    auth_view.hidden = YES;
    auth_patient_name.text = @"";
    auth_other_name.text = @"";
}

#pragma mark - Email Validator

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark - Signature View

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
        case 11:{
            [img_signature1 setImage:[signaturePanel getSignatureImage]];
        }
            break;
        case 12:{
            //[img_signature2 setImage:[signaturePanel getSignatureImage]];
        }
            break;
        case 13:{
            [img_signature3 setImage:[signaturePanel getSignatureImage]];
        }
            break;
        case 14:{
            [img_signature4 setImage:[signaturePanel getSignatureImage]];
        }
            break;
            
        default:
            break;
    }
    [signatureBackgroundView removeFromSuperview];

}

#pragma mark -
#pragma mark -

-(void)selectSignOne:(UIButton*)sender{
    [self createSignatureView:sender];
}

-(void)selectSignTwo:(UIButton*)sender{
    [self createSignatureView:sender];
}

-(void)selectSignThree:(UIButton*)sender{
    [self createSignatureView:sender];
}

-(void)selectSignFour:(UIButton*)sender{
    [self createSignatureView:sender];
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
    
    [popoverConDate presentPopoverFromRect:CGRectMake(x+90,y+30, 2, 2) inView:d_scrollView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
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
}

-(void)selectState:(UIButton*)sender{
    CGPoint point           = CGPointMake(0,600);
    [UIView animateWithDuration:0.1 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
    
    dropdownsTableviewCon.tableView.contentOffset = CGPointMake(0, 0);
    [popoverCon presentPopoverFromRect:CGRectMake(sender.frame.size.width / 2, sender.frame.size.height-35, 1, 1) inView:sender permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == dropdownsTableviewCon.tableView) {
        return arr_rt_states.count;
    }
    else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell_table;
    static NSString * strID = @"dropDownList";
    cell_table = [tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell_table) {
        cell_table = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    
    cell_table.textLabel.textAlignment  = NSTextAlignmentCenter;
    cell_table.textLabel.font           = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
    cell_table.textLabel.text           = [arr_rt_states objectAtIndex:indexPath.row];
    
    return cell_table;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    txt_state.text      = [arr_rt_states objectAtIndex:indexPath.row];
    
    CGPoint point       = CGPointMake(0,600);
    [UIView animateWithDuration:0.5 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
    
    [popoverCon dismissPopoverAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33;
}

#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    universalTextField  = textField;
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
    
    if (textField      == txt_fName) {
        [txt_lName becomeFirstResponder];
    }
    else if (textField == txt_lName){
        [txt_address becomeFirstResponder];
    }
    else if (textField == txt_address){
        [txt_city becomeFirstResponder];
    }
    else if (textField == txt_city){
        [txt_zip becomeFirstResponder];
    }
    else if (textField == txt_zip){
        [txt_hPhone becomeFirstResponder];
    }
    else if (textField == txt_hPhone){
        [txt_email becomeFirstResponder];
    }
    else{
        CGPoint point  = CGPointMake(0,550);
        [UIView animateWithDuration:0.5 animations:^{
            [d_scrollView setContentOffset:point animated:NO];
        }];
        
        [textField resignFirstResponder];
    }
    
    return YES;
}












@end
