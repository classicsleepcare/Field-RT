//
//  NIVPatientDis.m
//  RT APP
//
//  Created by Anil Prasad on 14/11/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import "NIVPatientDis.h"

@interface NIVPatientDis ()

@end

@implementation NIVPatientDis
@synthesize formData;

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self autoFillDates];
    
    d_scrollView.contentSize                    = CGSizeMake(880, 2100);
    d_scrollView.contentOffset                  = CGPointMake(0,0);
    
    popoverViewCon                              = [[UIViewController alloc]init];
    popoverViewCon.preferredContentSize         = CGSizeMake(320,298);
    calendarViewController.frame                = CGRectMake(0, 0, CGRectGetWidth(popoverViewCon.view.bounds),CGRectGetHeight(popoverViewCon.view.bounds));
    [popoverViewCon.view addSubview:calendarViewController];
    popoverCon                                  = [[UIPopoverController alloc] initWithContentViewController:popoverViewCon];
    

    
    formData = [NSMutableDictionary new];
    txt_pt_name.text = self.prevFormData[@"pt_name"];
    txt_physician_name.text = RT_NAME;
}

-(void)saveFormData{
    [formData setObject:self.prevFormData[@"ticket_id"] forKey:@"ticket_id"];
    [formData setObject:RT_ID forKey:@"rt_id"];
    [formData setObject:self.prevFormData[@"Pt_ID"] forKey:@"pt_id"];
    [formData setObject:self.prevFormData[@"Dr_ID"] forKey:@"dr_id"];
    [formData setObject:NonNilString(txt_physician_name.text) forKey:@"physician_name"];
    [formData setObject:NonNilString(str_admission_date) forKey:@"admission_date"];
    [formData setObject:NonNilString(str_discharge_date) forKey:@"discharge_date"];
    [formData setObject:NonNilString(txt_reason.text) forKey:@"discharge_reason"];
    [formData setObject:NonNilString(txt_problems.text) forKey:@"problems_identified"];
    [formData setObject:NonNilString(txt_goals.text) forKey:@"goals_met"];
    [formData setObject:NonNilString(txt_overall.text) forKey:@"overall_status"];
    [formData setObject:NonNilString(txt_summary.text) forKey:@"summary"];
    [formData setObject:NonNilString(txt_comments.text) forKey:@"comments"];
    [formData setObject:img_practitoner_sign.image forKey:@"practitioner_sign"];
   // [formData setObject:@"" forKey:@"edit"];
    
    [self callSubmitAPI];
}

-(void)callSubmitAPI{
    NIVTIcketView *object_TV = [NIVTIcketView new];
    dispatch_queue_t myQueue = dispatch_queue_create("SUTII", 0);
    [[AppDelegate sharedInstance] showCustomLoader:self];
    
    dispatch_async(myQueue, ^{
        NSDictionary *dicti =[object_TV patientDisAPI:formData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            NSLog(@"MESSAGE: %@", dicti);
            if(dicti)
            {
                if ([dicti[@"error"] isEqualToString:@"0"]) {
//                    NIVTrilogyVentPerf *objectVCV     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVTrilogyVentPerf"];
                    NIVAstralVentPerf *objectVCA     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVAstralVentPerf"];
                    
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
    [universalTextView resignFirstResponder];
    //[Utils takeScreenshot:d_scrollView];
    
    if (txt_admission_date.text.length == 0 &&
        txt_discharge_date.text.length == 0 &&
        txt_date.text.length == 0 &&
        txt_reason.text.length == 0 &&
        txt_problems.text.length == 0 &&
        txt_goals.text.length == 0 &&
        txt_overall.text.length == 0 &&
        txt_summary.text.length == 0 &&
        txt_comments.text.length == 0 &&
        img_practitoner_sign.image == nil)
    {
//        NIVTrilogyVentPerf *objectVCV     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVTrilogyVentPerf"];
        NIVAstralVentPerf *objectVCA     = [self.storyboard instantiateViewControllerWithIdentifier:@"NIVAstralVentPerf"];
        
        objectVCA.prevFormData = self.prevFormData;
        [self.navigationController pushViewController:objectVCA animated:YES];
        
//        if ([formData[@""] isEqualToString:@"Vent"]) {
//            objectVCV.prevFormData = self.prevFormData;
//            [self.navigationController pushViewController:objectVCV animated:YES];
//        }
//        else { // Astral
//            objectVCA.prevFormData = self.prevFormData;
//            [self.navigationController pushViewController:objectVCA animated:YES];
//        }
    }
    else if (txt_admission_date.text.length > 0 &&
             txt_discharge_date.text.length > 0 &&
             txt_date.text.length > 0 &&
             txt_reason.text.length > 0 &&
             txt_problems.text.length > 0 &&
             txt_goals.text.length > 0 &&
             txt_overall.text.length > 0 &&
             txt_summary.text.length > 0 &&
             txt_comments.text.length > 0 &&
             img_practitoner_sign.image != nil)
    {
        [self saveFormData];
    }
    else{
        [[AppDelegate sharedInstance] showAlertMessage:@"Partial filling of fields is not allowed. Either fill complete form or leave all the fields blank."];
    }
}

-(IBAction)backButtonPressed{
    [universalTextView resignFirstResponder];
    [self.navigationController popViewControllerAnimated:NO];
}

-(IBAction)selectDate:(UIButton*)sender{
    [self dateOne:sender];
}

-(void)dateOne:(UIButton*)sender{
    dateTag = (int)sender.tag;
    if (dateTag == 3) {
        [popoverCon presentPopoverFromRect:CGRectMake(sender.frame.size.width/2, sender.frame.size.height/5, 1, 1)
                                    inView:sender
                  permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
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
    NSArray *textFields = [[NSArray alloc] initWithObjects:txt_date, nil];
    [Utils setTodaysDateToTextFields:textFields];
    str_date = [Utils setDateFormatForAPI:[NSDate date]];
}

#pragma mark WSCalendarViewDelegate

-(void)didTapLabel:(WSLabel *)lblView withDate:(NSDate *)selectedDate
{
    switch (dateTag) {
        case 1:txt_admission_date.text = [Utils setDateFormatFormString:selectedDate];
            str_admission_date = [Utils setDateFormatForAPI:selectedDate];
            break;
        case 2:txt_discharge_date.text = [Utils setDateFormatFormString:selectedDate];
            str_discharge_date = [Utils setDateFormatForAPI:selectedDate];
            break;
        case 3:txt_date.text = [Utils setDateFormatFormString:selectedDate];
            str_date = [Utils setDateFormatForAPI:selectedDate];
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
    [universalTextView resignFirstResponder];
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
    [img_practitoner_sign setImage:[signaturePanel getSignatureImage]];
    [signatureBackgroundView removeFromSuperview];
}

-(void)clearInitialsView{
    [signaturePanel clearSignature];
}

-(void)closeInitialsView{
    [signatureBackgroundView removeFromSuperview];
}

#pragma mark - UITextView Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    universalTextView = textView;
    
    CGPoint point;
    CGRect rect = [textView bounds];
    rect        = [textView convertRect:rect toView:d_scrollView];
    point       = rect.origin;
    point.x     = 0;
    point.y     -= 120;
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

@end
