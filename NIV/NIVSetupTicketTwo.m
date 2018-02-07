//
//  NIVSetupTicketTwo.m
//  RT APP
//
//  Created by Anil Prasad on 11/28/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import "NIVSetupTicketTwo.h"

@interface NIVSetupTicketTwo ()

@end

@implementation NIVSetupTicketTwo
@synthesize formData, dict_retrivedData, dict_retrivedData_local;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self autoFillDates];
    
    d_scrollView.contentSize            = CGSizeMake(880, 820);
    d_scrollView.contentOffset          = CGPointMake(0,0);
    formData = [NSMutableDictionary new];
    //[self autoFillForm];
}

-(void)autoFillForm{
    
    img_initial.image = [Utils getImage:[dict_retrivedData_local[@"patient_initial"] lastPathComponent]]; // Get CORRECT PATH
    NSDate *date = [Utils stringToDateWithFormat:@"yyyy-MM-dd HH:mm:ss" andStringDate:dict_retrivedData_local[@"date"]];
    txt_date.text = [Utils setDateFormatFormString:date];
    
}

-(void)saveFormData{
    [formData addEntriesFromDictionary:self.pageOneFormData];
    [formData setObject:self.prevFormData[@"pt_id"] forKey:@"pt_id"];
    [formData setObject:RT_ID forKey:@"rt_id"];
    [formData setObject:img_initial.image forKey:@"patient_initial"];
    [formData setObject:img_pt_signature.image forKey:@"patient_sign"];
    [formData setObject:NonNilString(str_date) forKey:@"date"];
    [formData setObject:txt_otherNameNumber.text forKey:@"print_name_number"];
    
    [Utils saveAllKeysAndValues:formData];
    [self callSubmitAPI];
}

-(BOOL)isSuccessfullyValidated{
    if (img_initial.image == nil ||
        img_pt_signature.image == nil) {
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
        NSDictionary *dicti =[object_TV submitSetupTicket:formData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            NSLog(@"MESSAGE: %@", dicti);
            if(dicti)
            {
                if ([dicti[@"error"] isEqualToString:@"0"]) {
                    NIVRespCare *objectVC     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVRespCare"];
                    NSDictionary *returedData = [dicti valueForKey:@"data"];
                    [self.prevFormData setObject:returedData[@"ticket_id"] forKey:@"ticket_id"];
                    objectVC.prevFormData = self.prevFormData;
                    objectVC.dict_retrivedData = dict_retrivedData;
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
    [txt_otherNameNumber resignFirstResponder];
    //[Utils takeScreenshot:d_scrollView];

    if ([self isSuccessfullyValidated]) {
        [self saveFormData];
    }
    else{
        [[AppDelegate sharedInstance] showAlertMessage:@"The initial and signature at the bottom are mandatory."];
    }
    
//    NIVRespCare *objectVC     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVRespCare"];
//    objectVC.prevFormData = self.prevFormData;
//    [self.navigationController pushViewController:objectVC animated:YES];
}

-(IBAction)backButtonPressed{
    [txt_otherNameNumber resignFirstResponder];
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - Initials

-(IBAction)selectSignature:(UIButton*)sender{
    [txt_otherNameNumber resignFirstResponder];
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
        case 1:[img_initial setImage:[signaturePanel getSignatureImage]];
            break;
        case 2:[img_pt_signature setImage:[signaturePanel getSignatureImage]];
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

#pragma mark - Dates

-(void)autoFillDates{
    NSArray *textFields = [[NSArray alloc] initWithObjects:txt_date, nil];
    [Utils setTodaysDateToTextFields:textFields];
    str_date = [Utils setDateFormatForAPI:[NSDate date]];
}

#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{    
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
    if (textField.returnKeyType == UIReturnKeyDone) {
        [textField resignFirstResponder];
    }
    return YES;
}

-(IBAction)showMedicarePDF{
    
//    PDFViewController *object_PDFVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PDFVC"];
//    object_PDFVC.isPrivacyPolicy = YES;
//    [self.navigationController pushViewController:object_PDFVC animated:YES];
//    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PDFViewController *objectVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"PDFVC"];
    objectVC.isPrivacyPolicy = NO;
    objectVC.isDMEPOS = YES;
   // [self.navigationController pushViewController:objectVC animated:YES];
}

@end
