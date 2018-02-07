//
//  SetAppointment.h
//  RT APP
//
//  Created by Anil Prasad on 09/06/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SetAppointment : UIViewController<UIPopoverControllerDelegate,UIPickerViewDelegate, UIPickerViewDataSource,UITextViewDelegate, UIAlertViewDelegate>{
    
    IBOutlet UITextView *old_notes;
    
    IBOutlet UITextView *txt_notes;
    IBOutlet UITextField *txt_date;
    IBOutlet UITextField *txt_mm;
    IBOutlet UITextField *txt_hh;
    IBOutlet UITextField *txt_am_pm;
    
    IBOutlet UILabel *lbl_patientName;
    
    IBOutlet UIButton *btn_setAppt;
    
    
    IBOutlet UIButton *btn_date;
    IBOutlet UIButton *btn_mm;
    IBOutlet UIButton *btn_hh;
    IBOutlet UIButton *btn_AM_PM;

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
    
    UIPopoverController *popoverCon;
    UIViewController *popoverViewCon;
    UITableViewController *dropdownsTableviewCon;
    NSString *selectedScheduleDate;

}

@property (strong, nonatomic) NSString *pt_ID;
@property (strong, nonatomic) NSString *patientName;
@property BOOL isViewMode;
@property (strong, nonatomic) NSString *apt_id;

@end
