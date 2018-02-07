//
//  CreateSchedule.h
//  RT APP
//
//  Created by Anil Prasad on 17/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateSchedule : UIViewController<UITableViewDataSource,UITableViewDelegate, UIPopoverControllerDelegate,UIPickerViewDelegate, UIPickerViewDataSource,UITextViewDelegate>{
    
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
    
    
    
    UIViewController *am_pm_picker;
    UIPopoverController *am_pm_popover;
    
    IBOutlet UIButton *date_btn;
    IBOutlet UIButton *time_btn;
    IBOutlet UIButton *type_btn;
    IBOutlet UIButton *user_btn;
    IBOutlet UIButton *notes_btn;
    
    
    IBOutlet UILabel *lbl_patientName;
    IBOutlet UILabel *lbl_NewPatientName;

    IBOutlet UIButton *btn_patientName;
    
    IBOutlet UITableView *table_schedule;
    NSMutableDictionary *schedule_dict;
    NSMutableArray *schedule_array;
    
    UIPopoverController *popoverCon;
    UIViewController *popoverViewCon;
    UITableViewController *dropdownsTableviewCon;
    
    NSArray *arr_list;
    NSArray *arr_patientListing;
    int selectListNumber;

    NSString *selectedScheduleDate;
    IBOutlet UIView *view_table_title;
}

@property (nonatomic) BOOL isNewSchedule;

@property (strong, nonatomic) NSString *patientName;
@property (strong, nonatomic) NSString *selectedPatientID;

@property (strong, nonatomic) NSDictionary *dict_scheduleData;

@end
