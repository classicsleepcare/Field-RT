//
//  SetupTicketHIPAA.m
//  RT APP
//
//  Created by Anil Prasad on 09/08/16.
//  Copyright © 2016 ankit gupta. All rights reserved.
//

#import "SetupTicketHIPAA.h"
#import "SignatureView.h"
#import "TicketFormModel.h"
#import "TicketFormView.h"
#import "SetUpTicketFormThree.h"

@interface SetupTicketHIPAA ()<UIGestureRecognizerDelegate>{
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

@implementation SetupTicketHIPAA
@synthesize isNewTicket, dict_form, initial1, initial2, initial3, signature, isNotSubmitted, formOneData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [btn_email setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_text setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_voice setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];

    txt_email.text = [formOneData valueForKey:@"pt_email"];
    txt_phone.text = [formOneData valueForKey:@"pt_cell"];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    d_scrollView.contentSize    = CGSizeMake(880, 1700);
    d_scrollView.contentOffset  = CGPointMake(0,0);
    
    [self dateChanged];
    if ([Utils isEditingMode]) {
        [self autoFillMode];
    }
}

-(void)dismissKeyboard {
    [universalTextField resignFirstResponder];
}

- (IBAction)emailSelected {
    if ([btn_email.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [btn_email setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    else{
        [btn_email setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)textSelected {
    if ([btn_text.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [btn_text setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    else{
        [btn_text setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)voiceSelected {
    if ([btn_voice.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [btn_voice setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    else{
        [btn_voice setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
}

#pragma mark - Signature

- (IBAction)signPressed {
    CGPoint point = CGPointMake(0,300);
    [UIView animateWithDuration:0.5 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
    
    [self createSignatureView:nil];
    
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
    [btn_close addTarget:self action:@selector(closeSignatureView) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:btn_close];
    
    UIButton *btn_clear             = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_clear.frame                 = CGRectMake(200, 350, 100, 32);
    btn_clear.backgroundColor       = [UIColor colorWithRed:22.0/255.0 green:125.0/255.0 blue:164.0/255.0 alpha:1.0];
    btn_clear.titleLabel.textColor  = [UIColor whiteColor];
    [btn_clear setTitle:@"Clear" forState:UIControlStateNormal];
    btn_clear.layer.cornerRadius    = 7;
    btn_clear.clipsToBounds         = YES;
    [btn_clear addTarget:self action:@selector(clearSignatureView) forControlEvents:UIControlEventTouchUpInside];
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
    [img_signature setImage:[signaturePanel getSignatureImage]];
    
    [signatureBackgroundView removeFromSuperview];
    
}

-(void)closeSignatureView{
    [signatureBackgroundView removeFromSuperview];
}

-(void)clearSignatureView{
    [signaturePanel clearSignature];
}

#pragma mark -

- (IBAction)backPressed {
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)nextPressed {
    if (isNewTicket) {
        //[self validateFilledForm:YES];
        [self saveFormData];
        
    }
//    else if (isNotSubmitted) {
//        //[self validateFilledForm:NO];
//    }
    else{
        
        SetUpTicketFormThree *formThreeVC   = [self.storyboard instantiateViewControllerWithIdentifier:@"SUTFTH"];
        formThreeVC.isNewTicket             = NO;
        formThreeVC.dict_form               = dict_form;
        
        //if ([dict_form[@"isFinalSubmit"] isEqualToString:@"0"]){
            
            img_initial1 = initial1;
            img_initial2 = initial2;
            img_initial3 = initial3;
            img_signature1 = signature;
            
//            formThreeVC.mrr_legal_auth_sign          = img_mrr_legal_auth_sign.image;
//            formThreeVC.mrr_witness_sign             = img_mrr_witness_sign.image;
            formThreeVC.initial1                 = img_initial1;
            formThreeVC.initial2                 = img_initial2;
            formThreeVC.initial3                 = img_initial3;
            formThreeVC.signature                = img_signature1;
            formThreeVC.isNotSubmitted           = YES;
        //}
        
        [self.navigationController pushViewController:formThreeVC animated:YES];
        
    }
}

-(void)saveFormData{
    SetUpTicketFormThree *formThreeVC   = [self.storyboard instantiateViewControllerWithIdentifier:@"SUTFTH"];
    formThreeVC.isNewTicket             = YES;
    formThreeVC.dict_form               = dict_form;
    formThreeVC.formOneData             = self.formOneData;
    
    img_initial1 = initial1;
    img_initial2 = initial2;
    img_initial3 = initial3;
    img_signature1 = signature;
    
    formThreeVC.initial1                 = img_initial1;
    formThreeVC.initial2                 = img_initial2;
    formThreeVC.initial3                 = img_initial3;
    formThreeVC.signature                = img_signature1;
    formThreeVC.isNotSubmitted           = YES;
    
    // 9 JULY-start
    [formOneData setObject:txt_email.text forKey:@"pip_email"];
    [formOneData setObject:txt_phone.text forKey:@"pip_phone"];

    
    if ([self checkedOption:btn_email]) {[formOneData setObject:@"1" forKey:@"pip_notification_email"];}
    else{[formOneData setObject:@"0" forKey:@"pip_notification_email"];}
    if ([self checkedOption:btn_text]) {[formOneData setObject:@"1" forKey:@"pip_notification_text"];}
    else{[formOneData setObject:@"0" forKey:@"pip_notification_text"];}
    if ([self checkedOption:btn_voice]) {[formOneData setObject:@"1" forKey:@"pip_notification_voice"];}
    else{[formOneData setObject:@"0" forKey:@"pip_notification_voice"];}
    
    
    [formOneData setObject:format_Date forKey:@"pip_legal_auth_rep_sign_date"];
    [formOneData setObject:txt_name.text forKey:@"pip_legal_auth_rep_name"];
    
    formThreeVC.pip_legal_auth_rep_sign = img_signature.image;
    [Utils saveImage:img_signature.image forKey:@"pip_legal_auth_rep_sign"];
    
    formThreeVC.mrr_legal_auth_sign          = _mrr_legal_auth_sign;
    formThreeVC.mrr_witness_sign             = _mrr_witness_sign;
    
    
    // 9 JULY-end
//    [Utils saveAllKeysAndValues:formOneData];

    
    [self.navigationController pushViewController:formThreeVC animated:YES];
}

-(void)autoFillMode{
    img_signature.image = [Utils getImageForKey:@"pip_legal_auth_rep_sign"];
    
    txt_email.text = NonNilString([Utils getTextForKey:@"pip_email"]);
    txt_phone.text = NonNilString([Utils getTextForKey:@"pip_phone"]);
    
    if ([[Utils getTextForKey:@"pip_notification_email"] isEqualToString:@"1"]) {
        [btn_email setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    
    if ([[Utils getTextForKey:@"pip_notification_text"] isEqualToString:@"1"]) {
        [btn_text setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    
    if ([[Utils getTextForKey:@"pip_notification_voice"] isEqualToString:@"1"]) {
        [btn_voice setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    
    //txt_date.text = NonNilString([Utils getTextForKey:@"pip_legal_auth_rep_sign_date"]);
    txt_name.text = NonNilString([Utils getTextForKey:@"pip_legal_auth_rep_name"]);
    
}

#pragma mark - 

-(BOOL)checkedOption:(UIButton*)sender{
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) return true;
    return false;
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
    txt_date.text          = selectedDate;
    txt_date.text          = selectedDate;
    
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

@end
