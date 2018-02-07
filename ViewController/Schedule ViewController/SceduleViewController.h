//
//  SceduleViewController.h
//  RAP APP
//
//  Created by Anil Prasad on 4/5/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAWeekView.h"
@class MAEventKitDataSource;
@interface SceduleViewController : UIViewController<MAWeekViewDataSource,MAWeekViewDelegate,UITableViewDataSource,UITableViewDelegate, UIPopoverControllerDelegate,UIPickerViewDelegate, UIPickerViewDataSource>
{
     MAEventKitDataSource *_eventKitDataSource;
    
    IBOutlet UIImageView *drop_img;
    IBOutlet UITextField *txt_rtName;
    IBOutlet UIButton *btn_rtName;
    NSString *rt_Id;
    
    IBOutlet MAWeekView *view_gridCalender;
    IBOutlet UITableView *table_view;
    IBOutlet UIView * view_events;
    __weak IBOutlet UIView *view_Indicator;
    IBOutlet UILabel *lbl_title;
    IBOutlet UIButton *btn_addSchedule;
    
    IBOutlet UIButton *btn_day;
    IBOutlet UIButton *btn_month;
    IBOutlet UIButton *btn_year;
    IBOutlet UIButton *btn_calendar;
    IBOutlet UIButton *btn_hour;
    IBOutlet UIButton *btn_minute;
    IBOutlet UIButton *btn_AM_PM;
    IBOutlet UIButton *btn_communication;
    IBOutlet UIButton *btn_update;
    IBOutlet UITextView *txt_notes;
    
    UIViewController *pickerController;
    UIPopoverController *popoverCalendar;
    UIDatePicker *datePicker;
    NSMutableArray *arryDate;
    
    UIViewController *picker_hh_mm;
    UIPopoverController *popoverHourMinute;
    UIPickerView *hourPicker;
    UIPickerView *minutePicker;
    
    UIViewController *picker_tableView;
    UITableView *drop_tableView;
    UIPopoverController *table_popOver;
    NSArray *datakkk;
    
    UIViewController *am_pm_picker;
    UIPopoverController *am_pm_popover;
    
    IBOutlet UIButton *date_btn;
    IBOutlet UIButton *time_btn;
    IBOutlet UIButton *type_btn;
    IBOutlet UIButton *user_btn;
    IBOutlet UIButton *notes_btn;
    
    IBOutlet UITableView *table_schedule;
    NSMutableDictionary *schedule_dict;
    NSMutableArray *schedule_array;
    NSMutableArray *arr_tableData1;
}


-(IBAction)addSchedule:(id)sender;

@end
