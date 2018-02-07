//
//  NIVNewPatientProfile.m
//  RT APP
//
//  Created by Anil Prasad on 14/11/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import "NIVNewPatientProfile.h"

@interface NIVNewPatientProfile ()

@end

@implementation NIVNewPatientProfile
@synthesize formData;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self autoFillDates];
    txt_pt_name.text = self.prevFormData[@"pt_name"];
    txt_therapist_name.text = RT_NAME;
    
    d_scrollView.contentSize                    = CGSizeMake(880, 600);
    d_scrollView.contentOffset                  = CGPointMake(0,0);
    
    arr_medication = [NSMutableArray new];
    dict_medication = [NSMutableDictionary new];
    
    popoverViewCon                              = [[UIViewController alloc]init];
    popoverViewCon.preferredContentSize         = CGSizeMake(320,298);
    calendarViewController.frame                = CGRectMake(0, 0, CGRectGetWidth(popoverViewCon.view.bounds),CGRectGetHeight(popoverViewCon.view.bounds));
    [popoverViewCon.view addSubview:calendarViewController];
    popoverCon                                  = [[UIPopoverController alloc] initWithContentViewController:popoverViewCon];
    
    formData = [NSMutableDictionary new];

}

-(void)saveFormData{
    [formData setObject:self.prevFormData[@"ticket_id"] forKey:@"ticket_id"];
    [formData setObject:RT_ID forKey:@"rt_id"];
    [formData setObject:self.prevFormData[@"pt_id"] forKey:@"pt_id"];
    [formData setObject:self.prevFormData[@"Dr_ID"] forKey:@"Dr_ID"];
    [formData setObject:NonNilString(txt_therapist_name.text) forKey:@"therapist_name"];
    [formData setObject:NonNilString(str_date) forKey:@"date"];
    [formData setObject:NonNilString(txt_oxy_settings.text) forKey:@"curr_oxy_settings"];
    [formData setObject:NonNilString(txt_vent_settings.text) forKey:@"curr_vent_settings"];
    [formData setObject:img_therapist.image forKey:@"therapist_sign"];
    [formData setObject:[Utils setDateFormatForAPI:[NSDate date]] forKey:@"sign_date"];
     
    [formData setObject:[Utils createJSON:arr_medication] forKey:@"json_medications"];
    /*
     Example:-
     [{"medication":"test medication","medication_date":"2017-12-08","frequency":"12","route":"test route","start_date":"2017-12-10","stop_date":"2017-12-15"},
     {"medication":"test medication2","medication_date":"2017-12-08","frequency":"44","route":"test route2","start_date":"2017-12-10","stop_date":"2017-12-15"}]
     */
//    [formData setObject:@"" forKey:@"edit"];
    
    [self callSubmitAPI];
}

-(BOOL)isSuccessfullyValidated{
    if (img_therapist.image == nil) {
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
        NSDictionary *dicti =[object_TV newPtProfileAPI:formData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            NSLog(@"MESSAGE: %@", dicti);
            if(dicti)
            {
                if ([dicti[@"error"] isEqualToString:@"0"]) {
                    [[AppDelegate sharedInstance] showAlertMessage:dicti[@"msg"]];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                else{
                    [[AppDelegate sharedInstance] showAlertMessage:dicti[@"msg"]];
                }
            }
        });
    });
}

-(IBAction)nextButtonPressed{
    //[Utils takeScreenshot:d_scrollView];
    if ([self isSuccessfullyValidated]) {
        [self saveFormData];
    }
    else{
        [[AppDelegate sharedInstance] showAlertMessage:@"Therapist signature is mandatory."];
    }
    
}

-(IBAction)backButtonPressed{
   [self.navigationController popViewControllerAnimated:NO];
}

-(void)createAddMedicationView:(int)sender edit:(BOOL)isEdit{
    [universalTextField resignFirstResponder];

    backgroundView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0 ,1024,768)];
    //[backgroundView setBackgroundColor:[UIColor colorWithRed:120.0/255.0 green:120.0/255.0 blue:121.0/255.0 alpha:0.4]];
    [self.view addSubview:backgroundView];
    [self.view bringSubviewToFront:backgroundView];
    // border radius
    [addItemView.layer setCornerRadius:10.0f];
    // border
    [addItemView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [addItemView.layer setBorderWidth:0.1f];
    // drop shadow
    [addItemView.layer setShadowColor:[UIColor blackColor].CGColor];
    [addItemView.layer setShadowOpacity:0.4];
    [addItemView.layer setShadowRadius:60.0];
    [addItemView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    [backgroundView addSubview:addItemView];
    [addItemView setHidden:NO];
    if (isEdit) {
        editMode = YES;
    }
}

-(IBAction)addRowItem:(UIButton*)sender{
    BOOL validated = [Utils validateEmptyTextFields:@[txt_med_name, txt_med_date, txt_med_freq, txt_med_route, txt_med_date_start, txt_med_date_end]];
    if (validated) {
        NSDictionary        *temp = @{@"medication":txt_med_name.text,
                                      @"medication_date":txt_med_date.text,
                                      @"frequency":txt_med_freq.text,
                                      @"route":txt_med_route.text,
                                      @"start_date":txt_med_date_start.text,
                                      @"stop_date":txt_med_date_end.text
                                      };
        if (editMode) {
            [arr_medication replaceObjectAtIndex:sender.tag withObject:temp];
        }
        else{
            [arr_medication addObject:temp];
        }
        [table_medication reloadData];
        editMode = NO;
        [Utils emptyTextFields:@[txt_med_name, txt_med_date, txt_med_freq, txt_med_route, txt_med_date_start, txt_med_date_end]];
        [backgroundView setHidden:YES];
    }
    else{
        [[AppDelegate sharedInstance] showAlertMessage:@"All field(s) are mandatory!"];
    }
}

-(IBAction)removeAddItemsView{
    [Utils emptyTextFields:@[txt_med_name, txt_med_date, txt_med_freq, txt_med_route, txt_med_date_start, txt_med_date_end]];
    [backgroundView setHidden:YES];
}

#pragma mark - UITableVIew

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footerView             = [[UIView alloc] initWithFrame:CGRectMake(670, 0, 97, 33)];
    //footerView.layer.borderColor    = [UIColor grayColor].CGColor;
    //footerView.layer.borderWidth    = 1.0f;
    footerView.tag                  = section;
    footerView.backgroundColor      = [UIColor clearColor];
    
    UIButton *btn_add               = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_add.frame                   = CGRectMake(677, 0, 90, 33);
    btn_add.backgroundColor         = [UIColor colorWithRed:22.0/255.0 green:125.0/255.0 blue:164.0/255.0 alpha:1.0];
    [btn_add setTitle:@"Add Rows" forState:UIControlStateNormal];
    [btn_add setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_add addTarget:self action:@selector(createAddMedicationView:edit:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btn_add];
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 33;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_medication.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str    = @"medicationProfile";
    HistoryCell *cell       = [table_medication dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
    
    [cell customizeLabelInCell];
    
    NSDictionary *dict_t            = [arr_medication objectAtIndex:indexPath.row];
    cell.lbmp_medication.text       = dict_t[@"medication"];
    cell.lbmp_date.text             = dict_t[@"medication_date"];
    cell.lbmp_frequency.text        = dict_t[@"frequency"];
    cell.lbmp_route.text            = dict_t[@"route"];
    cell.lbmp_date_start.text       = dict_t[@"start_date"];
    cell.lbmp_date_end.text         = dict_t[@"stop_date"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict_t        = [arr_medication objectAtIndex:indexPath.row];
    txt_med_name.text           = dict_t[@"medication"];
    txt_med_date.text           = dict_t[@"medication_date"];
    txt_med_freq.text           = dict_t[@"frequency"];
    txt_med_route.text          = dict_t[@"route"];
    txt_med_date_start.text     = dict_t[@"start_date"];
    txt_med_date_end.text       = dict_t[@"stop_date"];
    
    btn_addUpdate.tag           = indexPath.row;
    [self createAddMedicationView:(int)indexPath.row edit:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item  = [arr_medication objectAtIndex:indexPath.row];
    [arr_medication removeObject:item];
    [table_medication reloadData];
}

#pragma mark - Dates

-(IBAction)selectDate:(UIButton*)sender{
    [universalTextField resignFirstResponder];
    [self dateOne:sender];
}

-(void)dateOne:(UIButton*)sender{
    dateTag = (int)sender.tag;
    [popoverCon presentPopoverFromRect:CGRectMake(sender.frame.size.width/2, sender.frame.size.height/1, 1, 1)
                                inView:sender
              permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
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
    NSArray *textFields = [[NSArray alloc] initWithObjects:txt_date, txt_therapist_date, nil];
    [Utils setTodaysDateToTextFields:textFields];
    str_date = [Utils setDateFormatForAPI:[NSDate date]];
}

#pragma mark WSCalendarViewDelegate

-(void)didTapLabel:(WSLabel *)lblView withDate:(NSDate *)selectedDate
{
    switch (dateTag) {
        case 1:txt_med_date.text = [Utils setDateFormatFormString:selectedDate];
            str_med_date = [Utils setDateFormatForAPI:selectedDate];
            break;
        case 2:txt_med_date_start.text = [Utils setDateFormatFormString:selectedDate];
            str_med_date_start = [Utils setDateFormatForAPI:selectedDate];
            break;
        case 3:txt_med_date_end.text = [Utils setDateFormatFormString:selectedDate];
            str_med_date_end = [Utils setDateFormatForAPI:selectedDate];
            break;
        case 4:txt_date.text = [Utils setDateFormatFormString:selectedDate];
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

#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    universalTextField  = textField;
    
    if (![@[txt_pt_name, txt_therapist_name, txt_med_name, txt_med_freq, txt_med_route] containsObject:universalTextField]){
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
    [img_therapist setImage:[signaturePanel getSignatureImage]];
    [signatureBackgroundView removeFromSuperview];
}

-(void)clearInitialsView{
    [signaturePanel clearSignature];
}

-(void)closeInitialsView{
    [signatureBackgroundView removeFromSuperview];
}

@end
