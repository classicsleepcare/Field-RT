//
//  SetAppointment.m
//  RT APP
//
//  Created by Anil Prasad on 09/06/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "SetAppointment.h"
#import "AppointmentModel.h"
#import "AppointmentView.h"

@interface SetAppointment ()
{
    AppointmentView *object_CV;
    
}

@end

@implementation SetAppointment
@synthesize isViewMode;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lbl_patientName.text = self.patientName;
    
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
    
    if (isViewMode) {
        [self getDetailsOfAppointment];
        [btn_setAppt setTitle:@"Update Appointment" forState:UIControlStateNormal];
    }

}

-(void)getDetailsOfAppointment{
    object_CV = [AppointmentView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("NewRecord", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dict =[object_CV viewAppointment:self.pt_ID];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dict)
            {
                AppointmentModel *object_CM = [[AppointmentModel alloc] initWithDictionary:dict];
                NSDictionary *appt_dict     = object_CM.dict_rt_listing_details;
                txt_date.text               = appt_dict[@"sch_date"];
                txt_hh.text                 = appt_dict[@"sch_hr"];
                txt_mm.text                 = appt_dict[@"sch_min"];
                txt_am_pm.text              = appt_dict[@"time_type"];
                NSString *notes             = appt_dict[@"sch_notes"];
                if (![notes isEqualToString:@""]) {
                    old_notes.hidden = NO;
                    old_notes.text = [NSString stringWithFormat:@"OLD NOTES: \n\n%@", notes];
                }
                else{
                    //txt_notes.text              = appt_dict[@"sch_notes"];
                }
            }
        });
    });
}

-(IBAction)actionForButton:(UIButton*)sender{
    [txt_notes resignFirstResponder];
    
    switch (sender.tag) {
        case 50:{
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 51:{
            [self checkAllEntriesOfSchedule];
        }
            break;
        case 20:{
            [self createCalendarPopoverFrom:sender];
        }
            break;
        case 21:{
            [self createHourMinutePopoverFrom:sender];
        }
            break;
        case 22:{
            [self createHourMinutePopoverFrom:sender];
        }
            break;
        case 23:{
            CGRect frame = sender.frame;
            int y = frame.origin.y;
            int x = frame.origin.x;
            [self createAMPMPopOver:y+140 xAxis:x+60];
        }
            break;
            
        default:
            break;
    }
}

-(void)checkAllEntriesOfSchedule{
    
    if (txt_date.text.length == 0){
        [[AppDelegate sharedInstance] showAlertMessage:@"All field(s) are mandatory!"];
    }
    else if (txt_mm.text.length == 0) {
        [[AppDelegate sharedInstance] showAlertMessage:@"All field(s) are mandatory!"];
    }
    else if (txt_hh.text.length == 0){
        [[AppDelegate sharedInstance] showAlertMessage:@"All field(s) are mandatory!"];
    }
    else if (txt_am_pm.text.length == 0){
        [[AppDelegate sharedInstance] showAlertMessage:@"All field(s) are mandatory!"];
    }
    else if ([txt_notes.text isEqualToString:@"Enter Notes here..."] ||
             [txt_notes.text isEqualToString:@""]  ||
             [txt_notes.text isEqualToString:@" "] ||
             [txt_notes.text isEqualToString:@"   "]){
        [[AppDelegate sharedInstance] showAlertMessage:@"Notes field can't be left empty!"];
    }
    else{
        
        if (isViewMode) {
            [self editOldRecordForPatient:self.pt_ID andAptId:self.apt_id];
        }
        else{
            [self addNewRecordForPatient:self.pt_ID];
        }
        
    }
}

-(void)addNewRecordForPatient:(NSString*)pt_Id{
    object_CV = [AppointmentView new];
    NSString *notes = [NSString new];
    
    if ([old_notes.text isEqualToString:@""]) {
        notes = txt_notes.text;
    }
    else{
        notes = [NSString stringWithFormat:@"%@ \n %@", old_notes.text, txt_notes.text];
    }
    dispatch_queue_t myQueue = dispatch_queue_create("NewRecord", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dict =[object_CV updateNewRecordWithRTId:RT_ID
                                                         pt_id:pt_Id
                                                         notes:notes
                                                          date:selectedScheduleDate
                                                            hr:txt_hh.text
                                                           min:txt_mm.text
                                                     time_type:txt_am_pm.text];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dict)
            {
                //AppointmentModel *object_CM = [[AppointmentModel alloc] initWithDictionary:dict];
                
                [[[UIAlertView alloc] initWithTitle:@"Message" message:@"Appointment added!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];

//                if ([object_CM.msg isEqualToString:@"updated successfully"]) {
//                    
//                    [[AppDelegate sharedInstance] showAlertMessage:@"Appointment added!"];
//                }
//                else{
//                    [[AppDelegate sharedInstance] showAlertMessage:@"Something went wrong!"];
//                }
            }
        });
    });
}

-(void)editOldRecordForPatient:(NSString*)pt_Id andAptId:(NSString*)apt_id{
    object_CV = [AppointmentView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("NewRecord", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dict =[object_CV updateOldRecordWithRTId:RT_ID
                                                        apt_id:@""
                                                         pt_id:pt_Id
                                                         notes:txt_notes.text
                                                          date:txt_date.text
                                                            hr:txt_hh.text
                                                           min:txt_mm.text
                                                     time_type:txt_am_pm.text];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dict)
            {
                
                [[[UIAlertView alloc] initWithTitle:@"Message" message:@"Appointment updated!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
               
            }
        });
    });
}

#pragma mark - AM-PM PopOver

-(void)createAMPMPopOver:(int)yAxis xAxis:(int)xAxis{
    [am_pm_popover presentPopoverFromRect:CGRectMake(xAxis,yAxis, 2, 2) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    am_pm_popover.delegate=self;
}

-(void)selectAMPM:(UIButton*)sender{
    if (sender.tag == 79) txt_am_pm.text = @"AM";
    if (sender.tag == 80) txt_am_pm.text = @"PM";;
    [am_pm_popover dismissPopoverAnimated:YES];
}

#pragma mark - HourMinute View

-(void)createHourMinutePopoverFrom:(UIButton*)sender{
    switch (sender.tag) {
        case 21:{// Hour
            
            hourPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 50, 180)];
            hourPicker.delegate = self;
            hourPicker.dataSource = self;
            hourPicker.showsSelectionIndicator = YES;
            [hourPicker selectRow:5 inComponent:0 animated:NO];
            picker_hh_mm.view = hourPicker;
            
            CGRect frame = sender.frame;
            int y = frame.origin.y;
            int x = frame.origin.x;
            
            [self createPopOverForHourMinute:y+140 xAxis:x+60];
            
        }
            break;
        case 22:{// Minute
            
            minutePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 50, 180)];
            minutePicker.delegate = self;
            minutePicker.dataSource = self;
            minutePicker.showsSelectionIndicator = YES;
            [minutePicker selectRow:5 inComponent:0 animated:NO];
            picker_hh_mm.view = minutePicker;
            
            CGRect frame = sender.frame;
            int y = frame.origin.y;
            int x = frame.origin.x;
            
            [self createPopOverForHourMinute:y+140 xAxis:x+60];
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
        //[btn_hour setTitle:hour forState:UIControlStateNormal];
        txt_hh.text = hour;
    }
    else{
        NSString *minute = [NSString stringWithFormat:@"%ld", (long)row];
        if (minute.length == 1) {
            minute = [NSString stringWithFormat:@"0%ld", (long)row];
        }
        //[btn_minute setTitle:minute forState:UIControlStateNormal];
        txt_mm.text = minute;
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
    
    [self createPopOverForCalendar:y+140 xAxis:x+150];
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
    
    
    txt_date.text = [NSString stringWithFormat:@"%@/%@/%@", [arryDate objectAtIndex:1], [arryDate objectAtIndex:0], [arryDate objectAtIndex:2]];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
