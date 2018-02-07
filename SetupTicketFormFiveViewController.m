//
//  SetupTicketFormFiveViewController.m
//  RT APP
//
//  Created by Anil Prasad on 29/06/16.
//  Copyright © 2016 Anil Prasad. All rights reserved.
//

#import "SetupTicketFormFiveViewController.h"
#import "TicketFormModel.h"
#import "TicketFormView.h"
#import "SignatureView.h"
#import "SetUpTicketFormThree.h"
#import "SetupTicketHIPAA.h"

@interface SetupTicketFormFiveViewController (){
    TicketFormView *object_TV;
    SignatureView *signaturePanel;
    UIView *signatureVw;
    UIView *signatureBackgroundView;
    UIImage *signImg;
    CGPoint d_point;
    NSString *format_Date;
    NSMutableArray *arryDate;

}

@end


@implementation SetupTicketFormFiveViewController
@synthesize formOneData, isNewTicket, dict_form, initial1, initial2, initial3, signature, patient_name, isNotSubmitted;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [btn_auth setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    d_scrollView.contentSize    = CGSizeMake(880, 1700);
    d_scrollView.contentOffset  = CGPointMake(0,0);
    
    txt_pt_name.text = [NSString stringWithFormat:@"%@ %@", [formOneData valueForKey:@"pt_first"], [formOneData valueForKey:@"pt_last"]];
    txt_pt_id.text   = [formOneData valueForKey:@"pt_id"];
    txt_pt_dob.text  = [formOneData valueForKey:@"pt_dob"];
    
    [self dateChanged];
    if ([Utils isEditingMode]) {
        [self autoFillMode];
    }
}

-(void)dismissKeyboard {
    [universalTextField resignFirstResponder];
}

#pragma mark - Date Formatter

- (void)dateChanged
{
    NSDateFormatter *FormatDate = [[NSDateFormatter alloc] init];
    [FormatDate setLocale: [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [FormatDate setDateFormat:@"dd/MM/yy"];
    NSString *dateStr           = [FormatDate stringFromDate:[NSDate date]];
    
    NSDateFormatter *FormatDate1 = [[NSDateFormatter alloc] init];
    [FormatDate1 setLocale: [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [FormatDate1 setDateFormat:@"yyyy-MM-dd"]; // MM-dd-yyyy
    NSString *dateStr1 = [FormatDate1 stringFromDate:[NSDate date]];
    
    format_Date = dateStr1;
    
    [self getSelectedDate:dateStr];
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

- (void)getSelectedDate:(NSString *)daStr {
    
    [arryDate removeAllObjects];
    arryDate                = (NSMutableArray *)[daStr componentsSeparatedByString:@"/"];
    
    NSString *day           = [arryDate objectAtIndex:0];
    NSString *month         = [arryDate objectAtIndex:1];
    NSString *year          = [arryDate objectAtIndex:2];
    
    NSString *selectedDate  = [NSString stringWithFormat:@"%@/%@/%@", month, day, year];
    txt_date1.text          = selectedDate;
    txt_date2.text          = selectedDate;

}

#pragma mark - Signature Image

-(UIImage*)getImage:(NSString*)signFileName{
    
    signImg                         = nil;
    NSString *urlString             = [NSString stringWithFormat:url_image, signFileName];
    NSLog(@"urlString is %@",urlString);
    signImg                         = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    
    return signImg;
}

#pragma mark - Signature Views

-(void)selectSignOne:(UIButton*)sender{
    [self createSignatureView:sender];
}

-(void)selectSignTwo:(UIButton*)sender{
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
        case 12:{
            [img_legal_auth_sign setImage:[signaturePanel getSignatureImage]];
        }
            break;
        case 13:{
            [img_witness_sign setImage:[signaturePanel getSignatureImage]];
        }
          
        default:
            break;
    }
    [signatureBackgroundView removeFromSuperview];
    
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

- (void)textFieldDidEndEditing:(UITextField *)textField{
    CGPoint point = CGPointMake(0,300);
    [UIView animateWithDuration:0.5 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
}

#pragma mark - Button Actions

-(IBAction)actionForButton:(UIButton*)sender{
    
    [universalTextField resignFirstResponder];
    
    switch (sender.tag) {
        case 11:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        case 12:
        {
            [self selectSignOne:sender];
            CGPoint point = CGPointMake(0,300);
            [UIView animateWithDuration:0.5 animations:^{
                [d_scrollView setContentOffset:point animated:NO];
            }];
        }
            break;
            
        case 13:
        {
            [self selectSignTwo:sender];
            CGPoint point = CGPointMake(0,300);
            [UIView animateWithDuration:0.5 animations:^{
                [d_scrollView setContentOffset:point animated:NO];
            }];
        }
            break;
            
        case 14:
        {
            [self nextButtonPressed];
        }
            break;
            
        default:
            break;
    }
    
}

-(IBAction)checkUncheckBtnAuth:(UIButton*)sender{
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    else{
        [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
}

-(void)nextButtonPressed{
    if (isNewTicket) {
        [self validateFilledForm:YES];
        
    }
    else if (isNotSubmitted) {
        [self validateFilledForm:NO];
    }
    else{
        
        SetUpTicketFormThree *formThreeVC   = [self.storyboard instantiateViewControllerWithIdentifier:@"SUTFTH"];
        formThreeVC.isNewTicket             = NO;
        formThreeVC.dict_form               = dict_form;
        
        if ([dict_form[@"isFinalSubmit"] isEqualToString:@"0"]){
            
            img_initial1 = initial1; //using
            img_initial2 = initial2;
            img_initial3 = initial3;//using
            img_signature = signature;//using
            
            //formThreeVC.legal_auth_sign          = img_legal_auth_sign.image;
            //formThreeVC.witness_sign             = img_witness_sign.image;
            formThreeVC.initial1                 = img_initial1;
            formThreeVC.initial2                 = img_initial2;
            formThreeVC.initial3                 = img_initial3;
            formThreeVC.signature                = img_signature;
            formThreeVC.isNotSubmitted           = YES;
        }

        [self.navigationController pushViewController:formThreeVC animated:YES];
        
    }
}

-(void)validateFilledForm:(BOOL)NewTicket{
    
    if (img_legal_auth_sign.image == nil) {
        [[AppDelegate sharedInstance] showAlertMessage:@"One of the initials not present!"];
    }
    else if (img_witness_sign.image == nil){
        [[AppDelegate sharedInstance] showAlertMessage:@"One of the initials not present!"];
    }
    
    else{
        [self saveFormData:NewTicket];
    }
}

-(void)saveFormData:(BOOL)NewTicket{
    
    [formOneData setObject:txt_legal_auth_name.text forKey:@"legal_auth_name"];
    
    SetUpTicketFormThree *formThreeVC   = [self.storyboard instantiateViewControllerWithIdentifier:@"SUTFTH"];
    formThreeVC.isNewTicket             = YES;
    formThreeVC.formOneData             = formOneData;
    
    
    
    img_initial1 = initial1;
    img_initial2 = initial2; // not using
    img_initial3 = initial3;
    img_signature = signature;
    
    SetupTicketHIPAA *formHipaa   = [self.storyboard instantiateViewControllerWithIdentifier:@"HIPAA"];
    formHipaa.isNewTicket             = YES;
    formHipaa.formOneData             = formOneData;
    
    formThreeVC.initial1 = initial1;
    formThreeVC.initial3 = initial3;
    formThreeVC.signature = signature;
    
    formHipaa.initial1 = initial1;
    formHipaa.initial3 = initial3;
    formHipaa.signature = signature;
    
    formThreeVC.mrr_legal_auth_sign          = img_legal_auth_sign.image;
    formThreeVC.mrr_witness_sign             = img_witness_sign.image;
    
    formHipaa.mrr_legal_auth_sign            = img_legal_auth_sign.image;
    formHipaa.mrr_witness_sign               = img_witness_sign.image;
    
    [Utils saveImage:img_legal_auth_sign.image forKey:@"img_legal_auth_sign"];
    [Utils saveImage:img_witness_sign.image forKey:@"img_witness_sign"];
    
    
    if ([btn_auth.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"mrr_medical_agreement"];
    }else{
        [formOneData setObject:@"1" forKey:@"mrr_medical_agreement"];
    }
    [formOneData setObject:txt_legal_auth_name.text forKey:@"mrr_legal_auth_name"];
    [formOneData setObject:format_Date forKey:@"mrr_legal_auth_sign_date"];
    [formOneData setObject:format_Date forKey:@"mrr_witness_sign_date"];


//    [Utils saveAllKeysAndValues:formOneData];

    if ([formOneData[@"manufacturer"] isEqualToString:@"ResMed"]) {
        
        [self.navigationController pushViewController:formHipaa animated:YES];
    }
    else{
        [self.navigationController pushViewController:formThreeVC animated:YES];
    }
}

-(void)autoFillMode{
    img_legal_auth_sign.image = [Utils getImageForKey:@"img_legal_auth_sign"];
    img_witness_sign.image = [Utils getImageForKey:@"img_witness_sign"];
    
    txt_legal_auth_name.text = NonNilString([Utils getTextForKey:@"legal_auth_name"]);
    
    if ([[Utils getTextForKey:@"mrr_medical_agreement"] isEqualToString:@"1"]){
        [btn_auth setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    
    txt_legal_auth_name.text = NonNilString([Utils getTextForKey:@"mrr_legal_auth_name"]);
    //txt_date1.text = NonNilString([Utils getTextForKey:@"mrr_legal_auth_sign_date"]);
    //txt_date2.text = NonNilString([Utils getTextForKey:@"mrr_witness_sign_date"]);
}

@end
