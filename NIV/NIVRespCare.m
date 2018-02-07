//
//  NIVRespCare.m
//  RT APP
//
//  Created by Anil Prasad on 14/11/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import "NIVRespCare.h"

@interface NIVRespCare ()

@end

@implementation NIVRespCare
@synthesize formData, dict_retrivedData, dict_retrivedData_local;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self autoFillDates];

    txt_name.text = self.prevFormData[@"pt_name"];
    popoverViewCon                              = [[UIViewController alloc]init];
    popoverViewCon.preferredContentSize         = CGSizeMake(320,298);
    calendarViewController.frame                = CGRectMake(0, 0, CGRectGetWidth(popoverViewCon.view.bounds),CGRectGetHeight(popoverViewCon.view.bounds));
    [popoverViewCon.view addSubview:calendarViewController];
    popoverCon                                  = [[UIPopoverController alloc] initWithContentViewController:popoverViewCon];
    
    formData = [NSMutableDictionary new];
}

-(void)autoFillForm{
    dict_retrivedData_local = dict_retrivedData[@"consent_clinical_services"];
    txt_name.text = dict_retrivedData_local[@"patient_name"];  
}

-(void)saveFormData{
    
    [formData setObject:self.prevFormData[@"ticket_id"] forKey:@"ticket_id"];
    [formData setObject:RT_ID forKey:@"rt_id"];
    [formData setObject:NonNilString(txt_name.text) forKey:@"patient_name"];
    [formData setObject:img_caregiver.image forKey:@"patient_sign"];
    [formData setObject:NonNilString(str_caregiver_date) forKey:@"patient_sign_date"];
    [formData setObject:img_guardian.image forKey:@"parent_sign"];
    [formData setObject:NonNilString(str_guardian_date) forKey:@"parent_sign_date"];
    if (img_witness.image != nil) {
        [formData setObject:img_witness.image forKey:@"witness_sign"];
    }
    [formData setObject:NonNilString(str_witness_date) forKey:@"witness_sign_date"];
    //[formData setObject:@"" forKey:@"edit"];
    
    [self callSubmitAPI];
}

-(BOOL)isSuccessfullyValidated{
    if (img_caregiver.image == nil ||
        img_guardian.image == nil) {
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
        NSDictionary *dicti =[object_TV respCareAPI:formData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            NSLog(@"MESSAGE: %@", dicti);
            if(dicti)
            {
                if ([dicti[@"error"] isEqualToString:@"0"]) {
//                    NIVCareComp *objectVCV     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVCareComp"];
                    NIVCareCompAstral *objectVCA     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVCareCompAstral"];
                    objectVCA.prevFormData = self.prevFormData;
                    [self.navigationController pushViewController:objectVCA animated:YES];
                    
//                    if ([formData[@""] isEqualToString:@"Vent"]) {
//                        objectVCV.prevFormData = self.prevFormData;
//                        [self.navigationController pushViewController:objectVCV animated:YES];
//                    }
//                    else { // Astral
//                        objectVCA.prevFormData = self.prevFormData;
//                        [self.navigationController pushViewController:objectVCA animated:YES];
//                    }
                }
                else{
                    [[AppDelegate sharedInstance] showAlertMessage:dicti[@"msg"]];
                }
            }
        });
    });
}

-(IBAction)nextButtonPressed{
    //[txt_otherNameNumber resignFirstResponder];
    //[Utils takeScreenshot:d_scrollView];
    
    if ([self isSuccessfullyValidated]) {
        [self saveFormData];
    }
    else{
        [[AppDelegate sharedInstance] showAlertMessage:@"Signatures before witness are mandatory."];
    }
//    NIVCareComp *objectVCV     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVCareComp"];
//    NIVCareCompAstral *objectVCA     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVCareCompAstral"];
//    objectVCA.prevFormData = self.prevFormData;
//    [self.navigationController pushViewController:objectVCA animated:YES];
//
//    if ([formData[@""] isEqualToString:@"Vent"]) {
//        objectVCV.prevFormData = self.prevFormData;
//        [self.navigationController pushViewController:objectVCV animated:YES];
//    }
//    else { // Astral
//        objectVCA.prevFormData = self.prevFormData;
//        [self.navigationController pushViewController:objectVCA animated:YES];
//    }
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
    [popoverCon presentPopoverFromRect:CGRectMake(sender.frame.size.width/4-10, sender.frame.size.height/1-10, 1, 10)
                                inView:sender
              permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
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


-(void)autoFillDates{
    NSArray *textFields = [[NSArray alloc] initWithObjects:txt_caregiver_date, txt_guardian_date, txt_witness_date, nil];
    [Utils setTodaysDateToTextFields:textFields];
    str_caregiver_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_guardian_date = [Utils setDateFormatForAPI:[NSDate date]];
    str_witness_date = [Utils setDateFormatForAPI:[NSDate date]];
}

#pragma mark WSCalendarViewDelegate

-(void)didTapLabel:(WSLabel *)lblView withDate:(NSDate *)selectedDate
{
    switch (dateTag) {
        case 0:txt_caregiver_date.text = [Utils setDateFormatFormString:selectedDate];
            str_caregiver_date = [Utils setDateFormatForAPI:selectedDate];
            break;
        case 1:txt_guardian_date.text = [Utils setDateFormatFormString:selectedDate];
            str_guardian_date = [Utils setDateFormatForAPI:selectedDate];
            break;
        case 2:txt_witness_date.text = [Utils setDateFormatFormString:selectedDate];
            str_witness_date = [Utils setDateFormatForAPI:selectedDate];
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


-(IBAction)selectSignature:(UIButton*)sender{
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
        case 0:[img_caregiver setImage:[signaturePanel getSignatureImage]];
            break;
        case 1:[img_guardian setImage:[signaturePanel getSignatureImage]];
            break;
        case 2:[img_witness setImage:[signaturePanel getSignatureImage]];
            break;
            
        default:
            break;
    }    [signatureBackgroundView removeFromSuperview];
}

-(void)clearInitialsView{
    [signaturePanel clearSignature];
}

-(void)closeInitialsView{
    [signatureBackgroundView removeFromSuperview];
}


@end
