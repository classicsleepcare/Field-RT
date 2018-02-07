//
//  CreateSchedule.m
//  RT APP
//
//  Created by Anil Prasad on 17/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "CreateSchedule.h"
#import "HistoryCell.h"
#import "CreateScheduleModel.h"
#import "CreateScheduleView.h"

@interface CreateSchedule (){
    CreateScheduleView *object_CV;

}

@end

@implementation CreateSchedule
@synthesize isNewSchedule, patientName, selectedPatientID,dict_scheduleData;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Calendar
    pickerController            = [UIViewController new];
    pickerController.view.frame = CGRectMake(300, 200, 300, 530);
    
    datePicker                  = [[UIDatePicker alloc] initWithFrame:CGRectMake (0, 0, 300, 300)];
    datePicker.datePickerMode   = UIDatePickerModeDate;
    pickerController.view       = datePicker;
    
    popoverCalendar             = [[UIPopoverController alloc] initWithContentViewController:pickerController];
    popoverCalendar.popoverContentSize = CGSizeMake(300, 180);
    popoverCalendar.delegate    = self;
    
    // Hour-Minute
    picker_hh_mm                = [UIViewController new];
    picker_hh_mm.view.frame     = CGRectMake(300, 200, 300, 530);
    popoverHourMinute = [[UIPopoverController alloc] initWithContentViewController:picker_hh_mm];
    popoverHourMinute.popoverContentSize = CGSizeMake(90, 180);
    popoverHourMinute.delegate = self;
    
    
    // Type(called Communications) & Patient List
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
    popoverCon = [[UIPopoverController alloc] initWithContentViewController:popoverViewCon];
    
    
    // AM-PM
    am_pm_picker = [UIViewController new];
    am_pm_picker.preferredContentSize = CGSizeMake(100, 80);
    UIButton *am = [UIButton buttonWithType:UIButtonTypeCustom];
    [am setFrame:CGRectMake(10, 2, 80, 40)];
    [am setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [am setTitle:@"AM" forState:UIControlStateNormal];
    [am setTag:79];
    [am addTarget:self action:@selector(selectAMPM:) forControlEvents:UIControlEventTouchUpInside];
    [am_pm_picker.view addSubview:am];
    
    UIView *a_view = [[UIView alloc] initWithFrame:CGRectMake(5, 40, 100, 1)];
    [a_view setBackgroundColor:[UIColor lightGrayColor]];
    [am_pm_picker.view addSubview:a_view];
    
    UIButton *pm = [UIButton buttonWithType:UIButtonTypeCustom];
    [pm setFrame:CGRectMake(10, 40, 80, 40)];
    [pm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pm setTitle:@"PM" forState:UIControlStateNormal];
    [pm setTag:80];
    [pm addTarget:self action:@selector(selectAMPM:) forControlEvents:UIControlEventTouchUpInside];
    [am_pm_picker.view addSubview:pm];
    
    am_pm_popover = [[UIPopoverController alloc] initWithContentViewController:am_pm_picker];
    am_pm_popover.popoverContentSize = CGSizeMake(110, 80);
    
    schedule_array = [[NSMutableArray alloc] init];
    
    //************
    
    if (isNewSchedule) {
        btn_patientName.hidden = YES;
        lbl_patientName.hidden = YES;
        view_table_title.hidden = YES;
        btn_update.enabled = NO;
        lbl_patientName.text = patientName;
        lbl_NewPatientName.text = patientName;
        
        [self viewScheduleFromCalendar:selectedPatientID];
    }
    else{
        lbl_NewPatientName.hidden = YES;
        [self loadDataOfAllPatients];
    }
}

-(void)viewScheduleFromCalendar:(NSString*)ID{
    
    object_CV = [CreateScheduleView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Patient", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dict =[object_CV getListingsOfPatient:ID];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dict)
            {
                NSArray *arr_temp = dict[@"listing"];
                dict_scheduleData = arr_temp[0];
                
                NSString *sch_date = [dict_scheduleData valueForKey:@"sch_date"];
                NSArray *arr_sch_date = [sch_date componentsSeparatedByString:@"/"];
                
                [btn_month setTitle:[arr_sch_date objectAtIndex:0] forState:UIControlStateNormal];
                [btn_day setTitle:[arr_sch_date objectAtIndex:1] forState:UIControlStateNormal];
                [btn_year setTitle:[arr_sch_date objectAtIndex:2] forState:UIControlStateNormal];
                
                
                [btn_communication setTitle:[dict_scheduleData valueForKey:@"sch_type"] forState:UIControlStateNormal];
                [txt_notes setText:[dict_scheduleData valueForKey:@"sch_notes"]];
                
                
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"HH:mm:ss";
                NSDate *date = [dateFormatter dateFromString:[dict_scheduleData valueForKey:@"sch_time"]];
                
                dateFormatter.dateFormat = @"hh:mm a";
                NSString *pmamDateString = [dateFormatter stringFromDate:date];
                
                NSString *sch_date_time = pmamDateString;
                NSArray *arr_sch_date_time = [sch_date_time componentsSeparatedByString:@" "];
                
                NSString *raw_time = [arr_sch_date_time objectAtIndex:0];
                NSString *raw_am_pm = [arr_sch_date_time objectAtIndex:1];
                
                NSArray *act_time = [raw_time componentsSeparatedByString:@":"];
                
                [btn_hour setTitle:[act_time objectAtIndex:0] forState:UIControlStateNormal];
                [btn_minute setTitle:[act_time objectAtIndex:1] forState:UIControlStateNormal];
                [btn_AM_PM setTitle:raw_am_pm forState:UIControlStateNormal];
            }
        });
    });
}


-(void)clearTextfields{
    [popoverCon dismissPopoverAnimated:YES];
    
    
    
    [btn_day setTitle:@"" forState:UIControlStateNormal];
    [btn_month setTitle:@"" forState:UIControlStateNormal];
    [btn_year setTitle:@"" forState:UIControlStateNormal];
    [btn_hour setTitle:@"HH" forState:UIControlStateNormal];
    [btn_minute setTitle:@"MM" forState:UIControlStateNormal];
    [btn_AM_PM setTitle:@"AM" forState:UIControlStateNormal];
    [btn_communication setTitle:@"--- Select Type ---" forState:UIControlStateNormal];
    //[lbl_patientName setText:@"   -- Select Patient --"];
    [txt_notes setText:@"Enter Notes here..."];


}

#pragma mark - UITextView Delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    return textView.text.length + (text.length - range.length) <= 140; // limit char limit to 140
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([txt_notes.text isEqualToString:@"Enter Notes here..."]) {
        [txt_notes setText:@""];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([txt_notes.text isEqualToString:@""]  ||
        [txt_notes.text isEqualToString:@" "] ||
        [txt_notes.text isEqualToString:@"   "]) {
        [txt_notes setText:@"Enter Notes here..."];
    }
}

#pragma mark - Button Actions
-(IBAction)actionForButton:(UIButton *)sender{
    
    selectListNumber = sender.tag;

    switch (sender.tag) {
            
        case 11:{
            [self.navigationController popViewControllerAnimated:NO];
        }    
            break;
        case 991:{  //btn_day
            [txt_notes resignFirstResponder];
            [self createCalendarPopoverFrom:sender];
        }
            break;
        case 992:{ //btn_month
            [txt_notes resignFirstResponder];
            [self createCalendarPopoverFrom:sender];
        }
            break;
        case 993:{ //btn_year
            [txt_notes resignFirstResponder];
            [self createCalendarPopoverFrom:sender];
        }
            break;
        case 994:{ //btn_calendar
            [txt_notes resignFirstResponder];
            [self createCalendarPopoverFrom:sender];
        }
            break;
        case 995:{ //btn_hour
            [txt_notes resignFirstResponder];
            [self createHourMinutePopoverFrom:sender];
        }
            break;
        case 996:{ //btn_minute
            [txt_notes resignFirstResponder];
            [self createHourMinutePopoverFrom:sender];
        }
            break;
        case 997:{ //btn_AM_PM
            [txt_notes resignFirstResponder];
            
            CGRect frame = sender.frame;
            int y = frame.origin.y;
            int x = frame.origin.x;
            [self createAMPMPopOver:y+30 xAxis:x+47];
        }
            break;
        case 998:{ //btn_communication
            [txt_notes resignFirstResponder];
            [self selectType:sender];
        }
            break;
        case 990:{
            [txt_notes resignFirstResponder];
            [self selectPatient:sender];

        }
            break;
        case 999:{ //btn_update
            [txt_notes resignFirstResponder];
            [self checkAllEntriesOfSchedule];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Table Popovers

-(void)showPopover:(UIButton*)sender{
    dropdownsTableviewCon.tableView.contentOffset = CGPointMake(0, 0);
    [popoverCon presentPopoverFromRect:CGRectMake(sender.frame.size.width / 2, sender.frame.size.height / 1, 1, 1) inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(void)selectPatient:(UIButton*)sender{
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(230,500);
    [popoverCon setPopoverContentSize:CGSizeMake(210, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectType:(UIButton*)sender{
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(260,100);
    [popoverCon setPopoverContentSize:CGSizeMake(260, 80) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

#pragma mark - Update Method

-(void)checkAllEntriesOfSchedule{
    
    if ([lbl_patientName.text isEqualToString:@"   -- Select Patient --"]){
        [[AppDelegate sharedInstance] showAlertMessage:@"Patient not selected!"];
    }
    else if (btn_day.titleLabel.text.length == 0) {
        [[AppDelegate sharedInstance] showAlertMessage:@"Date not selected!"];
    }
    else if ([btn_hour.titleLabel.text isEqualToString:@"HH"]){
        [[AppDelegate sharedInstance] showAlertMessage:@"Time (hour) not selected!"];
    }
    else if ([btn_minute.titleLabel.text isEqualToString:@"MM"]){
        [[AppDelegate sharedInstance] showAlertMessage:@"Time (minute) not selected!"];
    }
    else if ([btn_communication.titleLabel.text isEqualToString:@"--- Select Type ---"]){
        [[AppDelegate sharedInstance] showAlertMessage:@"Schedule Type not selected!"];
    }
    else if ([txt_notes.text isEqualToString:@"Enter Notes here..."] ||
             [txt_notes.text isEqualToString:@""]  ||
             [txt_notes.text isEqualToString:@" "] ||
             [txt_notes.text isEqualToString:@"   "]){
        [[AppDelegate sharedInstance] showAlertMessage:@"Notes field can't be left empty!"];
    }
    else{
        if (selectedPatientID) {
            
            [self addNewRecordForPatient:selectedPatientID];
        }
        else{
            
        }
    }
    
}

#pragma mark - AM-PM PopOver

-(void)createAMPMPopOver:(int)yAxis xAxis:(int)xAxis{
    [am_pm_popover presentPopoverFromRect:CGRectMake(xAxis,yAxis, 2, 2) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    am_pm_popover.delegate=self;
}

-(void)selectAMPM:(UIButton*)sender{
    if (sender.tag == 79) [btn_AM_PM setTitle:@"AM" forState:UIControlStateNormal];
    if (sender.tag == 80) [btn_AM_PM setTitle:@"PM" forState:UIControlStateNormal];
    [am_pm_popover dismissPopoverAnimated:YES];
}


#pragma mark - HourMinute View

-(void)createHourMinutePopoverFrom:(UIButton*)sender{
    switch (sender.tag) {
        case 995:{// Hour
            
            hourPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 50, 180)];
            hourPicker.delegate = self;
            hourPicker.dataSource = self;
            hourPicker.showsSelectionIndicator = YES;
            [hourPicker selectRow:5 inComponent:0 animated:NO];
            picker_hh_mm.view = hourPicker;
            
            CGRect frame = sender.frame;
            int y = frame.origin.y;
            int x = frame.origin.x;
            
            [self createPopOverForHourMinute:y+30 xAxis:x+47];
            
        }
            break;
        case 996:{// Minute
            
            minutePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 50, 180)];
            minutePicker.delegate = self;
            minutePicker.dataSource = self;
            minutePicker.showsSelectionIndicator = YES;
            [minutePicker selectRow:5 inComponent:0 animated:NO];
            picker_hh_mm.view = minutePicker;
            
            CGRect frame = sender.frame;
            int y = frame.origin.y;
            int x = frame.origin.x;
            
            [self createPopOverForHourMinute:y+30 xAxis:x+47];
        }
            break;
            
        default:
            break;
    }
}

-(void)createPopOverForHourMinute:(int)yAxis xAxis:(int)xAxis{
    
    [popoverHourMinute presentPopoverFromRect:CGRectMake(xAxis,yAxis, 2, 2) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

#pragma mark - UIPickerView Delegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == hourPicker) {
        return 12;
    }
    else
        return 60;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == hourPicker) {
        NSString *hour = [NSString stringWithFormat:@"%ld", (long)row+1];
        if (hour.length == 1) {
            hour = [NSString stringWithFormat:@"0%ld", (long)row+1];
        }
        return hour;
    }
    else
    {
        NSString *minute = [NSString stringWithFormat:@"%ld", (long)row];
        if (minute.length == 1) {
            minute = [NSString stringWithFormat:@"0%ld", (long)row];
        }
        
        return minute;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == hourPicker) {
        NSString *hour = [NSString stringWithFormat:@"%ld", (long)row+1];
        if (hour.length == 1) {
            hour = [NSString stringWithFormat:@"0%ld", (long)row+1];
        }
        [btn_hour setTitle:hour forState:UIControlStateNormal];
    }
    else{
        NSString *minute = [NSString stringWithFormat:@"%ld", (long)row];
        if (minute.length == 1) {
            minute = [NSString stringWithFormat:@"0%ld", (long)row];
        }
        [btn_minute setTitle:minute forState:UIControlStateNormal];
        
    }
}


#pragma mark - Calendar View

-(void)createCalendarPopoverFrom:(UIButton*)sender{
    CGRect frame = sender.frame;
    int y = frame.origin.y;
    int x = frame.origin.x;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [datePicker setDate:[NSDate date]];
    datePicker.backgroundColor = [UIColor clearColor];
    
    [dateFormatter setDateFormat:@"dd-MM-YYYY"];
    [datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    
    [self createPopOverForCalendar:y+30 xAxis:x+20];
}

- (void)createPopOverForCalendar:(int)yAxis xAxis:(int)xAxis
{
    [popoverCalendar presentPopoverFromRect:CGRectMake(xAxis,yAxis, 2, 2) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (void)dateChanged
{
    NSDateFormatter *FormatDate = [[NSDateFormatter alloc] init];
    [FormatDate setLocale: [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [FormatDate setDateFormat:@"dd-MM-YYYY"];
    NSString *dateStr = [FormatDate stringFromDate:[datePicker date]];
    selectedScheduleDate = dateStr;
    [self getSelectedDate:dateStr];
}

- (void)getSelectedDate:(NSString *)daStr {
    
    [arryDate removeAllObjects];
    arryDate= (NSMutableArray *)[daStr componentsSeparatedByString:@"-"];
    
    [btn_day setTitle:[arryDate objectAtIndex:0] forState:UIControlStateNormal];
    [btn_month setTitle:[arryDate objectAtIndex:1] forState:UIControlStateNormal];
    [btn_year setTitle:[arryDate objectAtIndex:2] forState:UIControlStateNormal];
    
}

#pragma mark - UITableView Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == dropdownsTableviewCon.tableView) {
        if (selectListNumber == 990) return arr_list.count;
        else
            return 2;
    }
    else if (tableView == table_schedule){
        if (arr_patientListing.count == 0) return 0;
        else
            return arr_patientListing.count;
    }
    else
        return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == dropdownsTableviewCon.tableView) {
        static NSString *cellIdentifier = @"Celll";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
        if (selectListNumber == 990) {
            NSDictionary *dict = [arr_list objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", dict[@"Pt_First"], dict[@"Pt_Last"]];
        }
        if (selectListNumber == 998) { // Type
            if (indexPath.row == 0) cell.textLabel.text = @"Communication";
            if (indexPath.row == 1) cell.textLabel.text = @"Scheduled";
        }
        
        return cell;
    }
    else{
        static NSString *str = @"ScheduleCell";
        HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        [cell customizeLabelInCell];
        
        NSDictionary *dict = [arr_patientListing objectAtIndex:indexPath.row];
        
        cell.lbl_date.text = dict[@"sch_date"];
        cell.lbl_time.text = dict[@"sch_time"];
        cell.lbl_type.text = dict[@"sch_type"];
        cell.lbl_user.text = dict[@"username"];
        cell.lbl_notes.text = dict[@"sch_notes"];
        
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==  table_schedule) return 40;
        return 33;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == dropdownsTableviewCon.tableView) {
        
        if (selectListNumber == 990) {
            NSDictionary *dict = [arr_list objectAtIndex:indexPath.row];
            lbl_patientName.text = [NSString stringWithFormat:@"%@ %@", dict[@"Pt_First"], dict[@"Pt_Last"]];
            selectedPatientID = dict[@"Pt_ID"];
            [self showSchedulesOfSelectedPatient:dict[@"Pt_ID"]];
        }
        else{
            if (indexPath.row == 0){
                [btn_communication setTitle:@"Communication" forState:UIControlStateNormal];
            }
            else
                [btn_communication setTitle:@"Scheduled" forState:UIControlStateNormal];
        }
        
        
        [popoverCon dismissPopoverAnimated:YES];

    }
}

#pragma mark - Web Services

-(void)loadDataOfAllPatients{
    object_CV = [CreateScheduleView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Setup", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dict =[object_CV getListOfPatientWithRTID:RT_ID];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dict)
            {
                CreateScheduleModel *object_CM = [[CreateScheduleModel alloc] initWithDictionary:dict];
                [self detailedListPatients:object_CM];
            }
        });
    });
}

-(void)detailedListPatients:(CreateScheduleModel*)object{
    arr_list = object.arr_listing;
    // reload table
}

-(void)showSchedulesOfSelectedPatient:(NSString*)ID{
    object_CV = [CreateScheduleView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Patient", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dict =[object_CV getListingsOfPatient:ID];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dict)
            {
                CreateScheduleModel *object_CM = [[CreateScheduleModel alloc] initWithDictionary:dict];
                if ([object_CM.msg isEqualToString:@"record not found"]) {
                    arr_patientListing = nil;
                    [table_schedule reloadData];
                    [[AppDelegate sharedInstance] showAlertMessage:@"No records found of this Patient."];
                }
                else{
                    [self detailedSchedulesOfSelectedPatient:object_CM];
                }
            }
        });
    });
}

-(void)detailedSchedulesOfSelectedPatient:(CreateScheduleModel*)object{
    arr_patientListing = object.arr_patientListing;
    NSArray *temp = [[arr_patientListing reverseObjectEnumerator] allObjects];
    arr_patientListing = temp;
    [table_schedule reloadData];
}

-(void)addNewRecordForPatient:(NSString*)ID{
    object_CV = [CreateScheduleView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("NewRecord", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dict =[object_CV updateNewRecordWithId:ID
                                                        date:selectedScheduleDate
                                                        hour:btn_hour.titleLabel.text
                                                         min:btn_minute.titleLabel.text
                                                    timeType:btn_AM_PM.titleLabel.text
                                                        type:btn_communication.titleLabel.text
                                                       notes:txt_notes.text];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dict)
            {
                CreateScheduleModel *object_CM = [[CreateScheduleModel alloc] initWithDictionary:dict];
                if ([object_CM.msg isEqualToString:@"updated successfully"]) {
                    
                    [self clearTextfields];
                    arr_patientListing = nil;
                    [self showSchedulesOfSelectedPatient:ID];
                    
                    [[AppDelegate sharedInstance] showAlertMessage:@"Schedule added!"];
                }
                else{
                    [[AppDelegate sharedInstance] showAlertMessage:@"Something went wrong!"];
                }
            }
        });
    });
}



@end
