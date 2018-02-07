//
//  SceduleViewController.m
//  RAP APP
//
//  Created by Anil Prasad on 4/5/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "SceduleViewController.h"
#import "MAWeekView.h"
#import "MAEvent.h"
#import "MAEventKitDataSource.h"
#import "ScheduleModel.h"
#import "AppDelegate.h"
#import "ScheduleView.h"
#import "DoctorDetailCell.h"
#import "HistoryModel.h"
#import "HistoryView.h"
#import "PatientInformationViewController.h"
#import "HistoryCell.h"
#import "CreateSchedule.h"
#import "ViewSchedule.h"
#import "SetUpTicketFormOne.h"
#import "TicketFormModel.h"
#import "TicketFormView.h"

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@interface SceduleViewController ()
{
    NSArray *arr_weekFirstAndLastDate;
    TicketFormView *object_TV;

    NSDateFormatter *formatter;
    ScheduleView *object_SV;
    NSArray *arr_eventInfo;
    NSArray *arr_eventDates;
    UIColor *eventColor;
    NSMutableArray *dates;
    NSMutableArray *arr_tableData;
}

@property (strong, nonatomic) NSArray *arr_rt_listing;

@end

@implementation SceduleViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
   
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    
    
    
    datakkk = [[NSArray alloc] initWithObjects:@"dataSource", @"ScheduleView", @"gridCalender", @"nibNameOrNil", @"dates", @"nibNameOrNil", @"viewDidLoad", @"return", nil];
    arr_weekFirstAndLastDate = [view_gridCalender.titleDate componentsSeparatedByString:@"to"];
    
    object_SV =[ScheduleView new];
    
    

    
    table_view.dataSource=self;
    table_view.delegate=self;
    
    if ([RT_ID isEqualToString:@""]){
        drop_img.hidden = NO;
        txt_rtName.hidden = NO;
        btn_rtName.hidden = NO;
        btn_addSchedule.hidden = YES;
        
        [self loadListOfRT];
    }
    else{
        drop_img.hidden = YES;
        txt_rtName.hidden = YES;
        btn_rtName.hidden = YES;
        btn_addSchedule.hidden = NO;
        
        [self showEventsInView:RT_ID];
    }
}

-(void)loadListOfRT{
    object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Dropdown", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        NSDictionary *dicti =[object_TV getArraysForDropdowns:@"68"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM = [[TicketFormModel alloc] initWithDictionary:dicti];
                self.arr_rt_listing        = object_TM.arr_rt_listing;
                [drop_tableView reloadData];
                
                NSDictionary *dict = self.arr_rt_listing[0];
                txt_rtName.text = dict[@"rt_name"];
                rt_Id = dict[@"rt_id"];
                [self showEventsInView:dict[@"rt_id"]];

            }
        });
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    UISwipeGestureRecognizer *swipeGestureUP = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeGestureUP.direction=UISwipeGestureRecognizerDirectionUp;
    [view_gridCalender addGestureRecognizer:swipeGestureUP];
    
    UISwipeGestureRecognizer *swipeGestureDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeGestureDown.direction=UISwipeGestureRecognizerDirectionDown;
    [view_gridCalender addGestureRecognizer:swipeGestureDown];
   	// Do any additional setup after loading the view.
    
    // Creating Add Patient Schedule View
    [btn_day addTarget:self action:@selector(actionForButton:) forControlEvents:UIControlEventTouchUpInside];
    [btn_month addTarget:self action:@selector(actionForButton:) forControlEvents:UIControlEventTouchUpInside];
    [btn_year addTarget:self action:@selector(actionForButton:) forControlEvents:UIControlEventTouchUpInside];
    [btn_calendar addTarget:self action:@selector(actionForButton:) forControlEvents:UIControlEventTouchUpInside];
    [btn_hour addTarget:self action:@selector(actionForButton:) forControlEvents:UIControlEventTouchUpInside];
    [btn_minute addTarget:self action:@selector(actionForButton:) forControlEvents:UIControlEventTouchUpInside];
    [btn_AM_PM addTarget:self action:@selector(actionForButton:) forControlEvents:UIControlEventTouchUpInside];
    [btn_communication addTarget:self action:@selector(actionForButton:) forControlEvents:UIControlEventTouchUpInside];
    [btn_update addTarget:self action:@selector(actionForButton:) forControlEvents:UIControlEventTouchUpInside];

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
    
    
    // Communications
    picker_tableView            = [UIViewController new];
    picker_tableView.preferredContentSize = CGSizeMake(300,500);
    drop_tableView              = [[UITableView alloc] init];
    drop_tableView.delegate     = self;
    drop_tableView.dataSource   = self;
    
//    UIView *view_toolBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(picker_tableView.view.bounds), 50)];
//    view_toolBar.backgroundColor=[UIColor colorWithRed:179.0/255.0 green:2.0/255.0 blue:6.0/255.0 alpha:1];
//    [picker_tableView.view addSubview:view_toolBar];
    
    drop_tableView.frame = CGRectMake(0, 0, CGRectGetWidth(picker_tableView.view.bounds),
                                                    CGRectGetHeight(picker_tableView.view.bounds));
    [picker_tableView.view addSubview:drop_tableView];
    
//    UIButton *clearButton =[UIButton buttonWithType:UIButtonTypeCustom];
//    clearButton.frame = CGRectMake(20, 10, 60, 30);
//    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
//    [clearButton addTarget:self action:@selector(clearTextfields) forControlEvents:UIControlEventTouchUpInside];
//    clearButton.titleLabel.textColor = [UIColor whiteColor];
//    clearButton.titleLabel.font = [UIFont systemFontOfSize:20.0];
//    [view_toolBar addSubview:clearButton];
    
    table_popOver = [[UIPopoverController alloc] initWithContentViewController:picker_tableView];
    table_popOver.popoverContentSize = CGSizeMake(230, 450);
    
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
}

-(void)clearTextfields{
    [table_popOver dismissPopoverAnimated:YES];
}

#pragma mark - Button Actions
-(IBAction)actionForButton:(UIButton *)sender{
    switch (sender.tag) {
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
            //[txt_notes resignFirstResponder];
            
            CGRect frame = sender.frame;
            int y = frame.origin.y;
            int x = frame.origin.x;
            [self createRTListPopOver:y+30 xAxis:x+110];
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

#pragma mark - Update Method

-(void)checkAllEntriesOfSchedule{
    if (btn_day.titleLabel.text.length == 0) {
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select a Schedule Date"];
    }
    else if ([btn_hour.titleLabel.text isEqualToString:@"HH"]){
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select time (hour)"];
    }
    else if ([btn_minute.titleLabel.text isEqualToString:@"MM"]){
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select time (minute)"];
    }
    else if ([btn_communication.titleLabel.text isEqualToString:@"Type"]){
        [[AppDelegate sharedInstance] showAlertMessage:@"Please select Schedule Type"];
    }
    else{
        [self saveAndUpdateSchedule];
    }
        
}

-(void)saveAndUpdateSchedule{
    schedule_dict       = [[NSMutableDictionary alloc] init];
    NSString *date_l    = [NSString stringWithFormat:@"%@/%@/%@",
                           btn_day.titleLabel.text, btn_month.titleLabel.text,btn_year.titleLabel.text];
    NSString *time_l    = [NSString stringWithFormat:@"%@:%@ %@",
                           btn_hour.titleLabel.text, btn_minute.titleLabel.text, btn_AM_PM.titleLabel.text];
    NSString *type_l    = btn_communication.titleLabel.text;
    NSString *notes_l   = txt_notes.text;
    
    [schedule_dict setObject:date_l forKey:@"date_l"];
    [schedule_dict setObject:time_l forKey:@"time_l"];
    [schedule_dict setObject:type_l forKey:@"type_l"];
    [schedule_dict setObject:notes_l forKey:@"notes_l"];
    
    [schedule_array addObject:schedule_dict];
    [table_schedule reloadData];
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

#pragma mark - Communication PopOver

-(void)createRTListPopOver:(int)yAxis xAxis:(int)xAxis{
    
    [table_popOver presentPopoverFromRect:CGRectMake(xAxis,yAxis, 2, 2) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    table_popOver.delegate=self;
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
    
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
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
    [FormatDate setDateFormat:@"dd/MM/YYYY"];
    NSString *dateStr = [FormatDate stringFromDate:[datePicker date]];
    [self getSelectedDate:dateStr];
}

- (void)getSelectedDate:(NSString *)daStr {
    
    [arryDate removeAllObjects];
    arryDate= (NSMutableArray *)[daStr componentsSeparatedByString:@"/"];
    
    [btn_day setTitle:[arryDate objectAtIndex:0] forState:UIControlStateNormal];
    [btn_month setTitle:[arryDate objectAtIndex:1] forState:UIControlStateNormal];
    [btn_year setTitle:[arryDate objectAtIndex:2] forState:UIControlStateNormal];

}

#pragma mark -
#pragma mark -

-(void)handleSwipeGesture:(UISwipeGestureRecognizer*)swipGesture
{
    if(swipGesture.direction== UISwipeGestureRecognizerDirectionUp)
    {
        [self animateMainViewWithGestureDirection:0];
    }
    else if (swipGesture.direction== UISwipeGestureRecognizerDirectionDown)
    {
        [self animateMainViewWithGestureDirection:1];
    }
    
}
-(void)animateMainViewWithGestureDirection:(int)direction
{
    if (direction==0) {
        lbl_title.hidden =YES;
        
        if ([RT_ID isEqualToString:@""]) {
            drop_img.hidden = YES;
            txt_rtName.hidden = YES;
            btn_rtName.hidden = YES;
        }
        else{
            btn_addSchedule.hidden = YES;
        }
        view_Indicator.hidden=YES;
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            view_gridCalender.frame = CGRectMake(17, -200, CGRectGetWidth(view_gridCalender.bounds), CGRectGetHeight(view_gridCalender.bounds));
            view_events.frame = CGRectMake(5, 410, CGRectGetWidth(view_events.bounds), CGRectGetHeight(view_events.bounds));
            table_view.frame =CGRectMake(5, 460, CGRectGetWidth(table_view.bounds), 200);
        } completion:nil];
        
    }
    else if (direction==1)
    {
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            view_gridCalender.frame = CGRectMake(17, 50, CGRectGetWidth(view_gridCalender.bounds), CGRectGetHeight(view_gridCalender.bounds));
            view_events.frame = CGRectMake(5, 610, CGRectGetWidth(view_events.bounds), CGRectGetHeight(view_events.bounds));
            table_view.frame =CGRectMake(5, 660, CGRectGetWidth(table_view.bounds), 0);
            
        } completion:^(BOOL finished) {
            
            lbl_title.hidden= NO;
            
            if ([RT_ID isEqualToString:@""]){
                drop_img.hidden = NO;
                txt_rtName.hidden = NO;
                btn_rtName.hidden = NO;
            }
            else{
                btn_addSchedule.hidden = NO;
                view_Indicator.hidden=NO;
            }
            
            
           
        }];
 
    }
}

static int dateNO = 0;
static int counter = 7 * 5;

- (NSArray *)weekView:(MAWeekView *)weekView eventsForDate:(NSDate *)startDate {
	
    NSArray *arr;
    if(arr_tableData.count>7) arr=@[self.event,self.event];
    else   arr=@[self.event];
    
    for (MAEvent *event in arr) {
        
        NSDictionary *dict_eventInfo;
        
        NSDate *eventDate;
        
        int r;
        
        if (dateNO>=arr_tableData.count)
        {
            r =0;

        }
        else
        {
            r = [dates[dateNO] integerValue];
            
            NSString *str_eventDate;
            
            if(arr_eventDates.count>0)str_eventDate =arr_eventDates[dateNO];
            eventDate = [self convertIntoCurrentDateFrom:str_eventDate];
            
            if(arr_tableData.count>0)
            {
                dict_eventInfo = arr_tableData[dateNO];
                
            }
            if (!eventDate) {
                eventDate =startDate;
            }
            
            
            //NSLog(@"nextDate: %@ ...", eventDate);
            
        }
        dateNO++;
        
        NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:eventDate];
        [components setHour:r-8];
        [components setMinute:0];
        [components setSecond:0];
        
        event.start = [CURRENT_CALENDAR dateFromComponents:components];
        
        if(r>=8)
            // if(r<=8)
        {
            event.displayDate= eventDate;
            event.backgroundColor = [UIColor colorWithRed:22.0/255.0 green:125.0/255.0 blue:164.0/255.0 alpha:1];

            event.title =[NSString stringWithFormat:@"%@ %@\n(Setup)",dict_eventInfo[@"Pt_First"],dict_eventInfo[@"Pt_Last"]];
            event.str_id= dict_eventInfo[@"Pt_ID"];

            [components setHour:r-7];
            counter--;
        }

        [components setMinute:0];

        event.end = [CURRENT_CALENDAR dateFromComponents:components];
        
        if (dict_eventInfo &&![dict_eventInfo[@"sch_type"] isEqualToString:@"Set Up"])
        {
            event.backgroundColor = [UIColor colorWithRed:22.0/255.0 green:125.0/255.0 blue:164.0/255.0 alpha:1];
            event.title=[NSString stringWithFormat:@"%@ %@\n(Supply)",dict_eventInfo[@"Pt_First"],dict_eventInfo[@"Pt_Last"]];
            
            NSLog(@"eventDate: %@ : %@", eventDate, event.title);
        }
    }
    return arr;
}



- (MAEvent *)event {
    
	static int counter;
	
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	
	[dict setObject:[NSString stringWithFormat:@"number %i", counter++] forKey:@"test"];
	MAEvent *event = [[MAEvent alloc] init];
   	event.backgroundColor=[UIColor colorWithRed:32.0/255 green:123.0/255.0 blue:184.0/255.0 alpha:1];
    //
	event.textColor = [UIColor whiteColor];
	event.allDay = NO;
	event.userInfo = dict;
	return event;
}

- (MAEventKitDataSource *)eventKitDataSource {
    if (!_eventKitDataSource) {
        _eventKitDataSource = [[MAEventKitDataSource alloc] init];
    }
    return _eventKitDataSource;
}

/* Implementation for the MAWeekViewDelegate protocol */

- (void)weekView:(MAWeekView *)weekView eventTapped:(MAEvent *)event
{
    if ([RT_ID isEqualToString:@""]) {
        
    }
    else{
        [[AppDelegate sharedInstance] showCustomLoader:self];
        
        dispatch_queue_t myqueue = dispatch_queue_create("Kumar", 0);
        dispatch_async(myqueue, ^{
            
            HistoryView *object_HV = [HistoryView new];
            NSDictionary *dict = [object_HV getDetailListForPatientOfId:event.str_id];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AppDelegate sharedInstance] removeCustomLoader];
                if(dict)
                {
                    HistoryModel* object_HM = [[HistoryModel alloc]initWithDictionaryForPatientDetail:dict];
                    
                    SetUpTicketFormOne *formOne = [self.storyboard instantiateViewControllerWithIdentifier:@"SUTFO"];
                    formOne.isFromSchedule = YES;
                    formOne.isNewTicket = YES;
                    formOne.dict_patient = object_HM.dict_profileInfo;
                    [Utils setEditingMode:NO];

                    
                    [self.navigationController pushViewController:formOne animated:YES];
                    
                    
                }
                
            });
        });

    }
    
}

-(void)weekView:(MAWeekView *)weekView weekDidChange:(NSDate *)week
{
   
    arr_weekFirstAndLastDate = [view_gridCalender.titleDate componentsSeparatedByString:@"to"];
    
    if ([RT_ID isEqualToString:@""]) {
        [self showEventsInView:rt_Id];
    }
    else{
        [self showEventsInView:RT_ID];
    }
}

-(void)showEventsInView:(NSString*)RT_id
{
    dispatch_queue_t myQueue = dispatch_queue_create("Schedule", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dict =[object_SV getHistoryListFromDayForID:RT_id
                                                         FromDate:[arr_weekFirstAndLastDate firstObject]
                                                         LastDate:[arr_weekFirstAndLastDate lastObject]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            if(dict)
            {
                
                ScheduleModel *object_SM = [[ScheduleModel alloc]initWithDictionary:dict];
                [self changeWeekWithResponse:object_SM];
            }
        });
    });

}
-(void)changeWeekWithResponse:(ScheduleModel*)object
{
    dates =nil;
   arr_tableData=nil;
        
    
    dates =[NSMutableArray array];
    arr_tableData = [NSMutableArray array];
    arr_tableData1 = [NSMutableArray array]; // Added 10 Jun 2017
    if ([object.str_msg isEqualToString:@"Rep(s) patients found"])
    {
        
        arr_eventInfo = object.arr_Listing;
        
        NSLog(@"%@", object.arr_Listing);
      
        int count =0;
        for (NSDictionary *dict in arr_eventInfo)
        {
            NSString *str_date = [dict valueForKey:@"sch_time"];
            int time =[[[str_date componentsSeparatedByString:@":"] firstObject] intValue];
            [arr_tableData1 addObject:dict]; // Added 10 Jun 2017
            
            if (time>=0&&time<=20)
            //if (time>7&&time<20)
            {
                [dates addObject:[[str_date componentsSeparatedByString:@":"] firstObject]];
                [arr_tableData addObject:dict];
                count++;
            }
            
        }
        
        if(count==0)
        {
            //[[AppDelegate sharedInstance] showAlertMessage:@"There is no event between 8 AM to 7 PM in this week"];
        }

        if(arr_tableData) arr_eventDates =[arr_tableData valueForKey:@"sch_date"];
        
    }
    else
    {
        //[[AppDelegate sharedInstance] showAlertMessage:@"No Events found for this week"];
        [dates addObject:@""];
    }
 
     dateNO = 0;
    [view_gridCalender reloadData];
    [table_view reloadData];
    table_view.contentOffset=CGPointMake(0, 0);
}


#pragma mark -
#pragma mark -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == drop_tableView) {
        return 1;
    }
    else if (tableView == table_schedule){
        return 1;
    }
    else
        if(arr_tableData1) // Added 10 Jun 2017
            return arr_tableData1.count; // Added 10 Jun 2017
        return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == drop_tableView) {
        return self.arr_rt_listing.count;
    }
    else if (tableView == table_schedule){
        return schedule_array.count;
    }
    else
        return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == drop_tableView) {
        static NSString *cellIdentifier = @"Celll";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        NSDictionary *dict = self.arr_rt_listing[indexPath.row];
        cell.textLabel.text = dict[@"rt_name"];
        
        return cell;
    }
    else if (tableView == table_schedule){
        static NSString *str = @"ScheduleCell";
        HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        [cell customizeLabelInCell];
        
        cell.lbl_date.text = [[schedule_array objectAtIndex:indexPath.row] valueForKey:@"date_l"];
        cell.lbl_time.text = [[schedule_array objectAtIndex:indexPath.row] valueForKey:@"time_l"];
        cell.lbl_type.text = [[schedule_array objectAtIndex:indexPath.row] valueForKey:@"type_l"];
        cell.lbl_user.text = [[schedule_array objectAtIndex:indexPath.row] valueForKey:@"type_l"]; //Change it
        cell.lbl_notes.text = [[schedule_array objectAtIndex:indexPath.row] valueForKey:@"notes_l"];
        
        return cell;
    }
    else {
        static NSString *str = @"eventcell";
        DoctorDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        NSDictionary *dict = arr_tableData1[indexPath.section]; // Added 10 Jun 2017
        
        int time =[[[dict[@"sch_time"] componentsSeparatedByString:@":"] firstObject] intValue];
        
        NSArray *mArray=[[dict valueForKey:@"sch_time"] componentsSeparatedByString:@":"];
        
        if (time<12)
        {
            if ([mArray count]>0)
            {
                
                cell.lbl_schTime.text = [NSString stringWithFormat:@"%@:%@",[mArray objectAtIndex:0],[mArray objectAtIndex:1]];
            }
            
            //cell.lbl_schTime.text = [NSString stringWithFormat:@"%@:00 am",[[dict[@"sch_time"] componentsSeparatedByString:@":"] firstObject]];
        }
        else
        {
            int pmTime ;
            if(time==12) pmTime = 12;
            else pmTime = time-12;
            
            
            
            //        cell.lbl_schTime.text = [NSString stringWithFormat:@"%@ pm",[dict[@"sch_time"]]];
            if ([mArray count]>0)
            {
                
                cell.lbl_schTime.text = [NSString stringWithFormat:@"%@:%@",[mArray objectAtIndex:0],[mArray objectAtIndex:1]];
            }
            
            
        }
        NSString *str_setup = dict[@"sch_type"];
        if ([str_setup isEqualToString:@"Set Up"])
        {
            cell.img_schCircle.image = [UIImage imageNamed:@"SetupCircle.png"];
            cell.img_schDevider.image = [UIImage imageNamed:@"Setupdivider.png"];
            cell.lbl_schName.textColor = [UIColor colorWithRed:32.0/255 green:123.0/255.0 blue:184.0/255.0 alpha:1];
            
            cell.lbl_schName.text = [NSString stringWithFormat:@"%@ %@ Setup",dict[@"Pt_First"],dict[@"Pt_Last"]];
        }
        else
        {
            cell.img_schCircle.image = [UIImage imageNamed:@"SupplyCircle.png"];
            cell.img_schDevider.image = [UIImage imageNamed:@"Supplydivider.png"];
            cell.lbl_schName.textColor=[UIColor colorWithRed:66.0/255.0 green:141.0/255.0 blue:68.0/255.0 alpha:1];
            cell.lbl_schName.text = [NSString stringWithFormat:@"%@ %@ Supply",dict[@"Pt_First"],dict[@"Pt_Last"]];
        }
        return cell;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == drop_tableView) {
        return @"";
    }
    else if (tableView == table_schedule){
        return @"";
    }
    else{
        NSString *str_date = [[arr_tableData1 valueForKey:@"sch_date"] objectAtIndex:section]; // Added 10 June 2017
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        NSDate *date = [dateFormatter dateFromString:str_date];
        [dateFormatter setDateFormat:@"EEEE"];
        NSString *str_dayName = [dateFormatter stringFromDate:date];
        
        str_date = [self convertDate:str_date];
        
        
        return [NSString stringWithFormat:@"%@ %@",str_dayName,str_date];
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (tableView == table_schedule) {
//        return 58;
//    }
//    else
//        return 50.0;
    return 33;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == drop_tableView) {
        
        NSDictionary *dict  = self.arr_rt_listing[indexPath.row];
        txt_rtName.text     = dict[@"rt_name"];
        rt_Id               = dict[@"rt_id"];
        [self showEventsInView:dict[@"rt_id"]];
        [table_popOver dismissPopoverAnimated:YES];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else{
        [[AppDelegate sharedInstance] showCustomLoader:self];
        NSDictionary *dict1 = [NSDictionary new];
        dict1 = arr_tableData1[indexPath.section];
        
        dispatch_queue_t myqueue = dispatch_queue_create("Kumar", 0);
        dispatch_async(myqueue, ^{
            
            HistoryView *object_HV = [HistoryView new];
            NSDictionary *dict = [object_HV getDetailListForPatientOfId:dict1[@"Pt_ID"]];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AppDelegate sharedInstance] removeCustomLoader];
                if(dict)
                {
                    HistoryModel* object_HM = [[HistoryModel alloc]initWithDictionaryForPatientDetail:dict];
                    
                    SetUpTicketFormOne *formOne = [self.storyboard instantiateViewControllerWithIdentifier:@"SUTFO"];
                    formOne.isFromSchedule = YES;
                    formOne.isNewTicket = YES;
                    formOne.dict_patient = object_HM.dict_profileInfo;
                    
                    [self.navigationController pushViewController:formOne animated:YES];
                    
                    
                }
                
            });
        });
    }
}

#pragma mark -
#pragma mark -

-(NSDate *)convertIntoCurrentDateFrom:(NSString *)str
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    //Create the date assuming the given string is in GMT
//    dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    // Commented that out to fix timezone issue applied by CURRENT_CALENDAR macro
    NSDate *dt = [dateFormatter dateFromString:str];
   
   
   
    return dt;
}
-(NSString*)convertDate:(NSString*)date
{
    
    NSString *final_str;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    NSDate *endDate = [dateFormat dateFromString:date];
    
    [dateFormat setDateFormat:@"MMMM-dd-yyyy"];
    NSArray *date_components = [[dateFormat stringFromDate:endDate] componentsSeparatedByString:@"-"];
    NSString * str = [date_components objectAtIndex:1];
    
    NSString* first_ltr = [str substringFromIndex:1];
    if ([first_ltr isEqualToString:@"1"]&&![str isEqualToString:@"11"]) {
        final_str = [NSString stringWithFormat:@"%@st",str];
    }
    else if ([first_ltr isEqualToString:@"2"]&&![str isEqualToString:@"12"])
    {
        final_str = [NSString stringWithFormat:@"%@nd",str];
    }
    else if ([first_ltr isEqualToString:@"3"]&&![str isEqualToString:@"13"])
    {
        final_str = [NSString stringWithFormat:@"%@rd",str];
    }
    else final_str = [NSString stringWithFormat:@"%@th ",str];
    
    return [NSString stringWithFormat:@"%@ %@",[date_components objectAtIndex:0],final_str];
    
}

- (void)didReceiveMemoryWarning
{
    
  [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)addSchedule:(id)sender{
    CreateSchedule *createSch = [self.storyboard instantiateViewControllerWithIdentifier:@"CSVC"];
    
    [self.navigationController pushViewController:createSch animated:YES];
}



@end
