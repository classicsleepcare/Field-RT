//
//  NIVNewPatientProfile.h
//  RT APP
//
//  Created by Anil Prasad on 14/11/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryCell.h"
#import "WSCalendarView.h"
#import "Utils.h"
#import "SignatureView.h"
#import "NIVTIcketView.h"
#import "NIVTIcketModel.h"

@interface NIVNewPatientProfile : UIViewController<UIPopoverControllerDelegate, WSCalendarViewDelegate>{
    
    __weak IBOutlet UIScrollView *d_scrollView;
    CGPoint d_point;

    WSCalendarView *calendarView;
    WSCalendarView *calendarViewEvent;
    NSMutableArray *eventArray;
    
    UIPopoverController *popoverCon;
    UIViewController *popoverViewCon;
    UIView *calendarViewController;
    
    UIView *signatureBackgroundView;
    UIView *signatureVw;
    SignatureView *signaturePanel;
    
    int dateTag;
    UITextField *universalTextField;

    UIView *backgroundView;
    __weak IBOutlet UIView *addItemView;
    __weak IBOutlet UITableView *table_medication;
    
    NSMutableArray *arr_medication;
    NSMutableDictionary *dict_medication;
    
    BOOL editMode;
    __weak IBOutlet UIButton *btn_addUpdate;
    
    __weak IBOutlet UITextField *txt_pt_name;
    __weak IBOutlet UITextField *txt_therapist_name;
    __weak IBOutlet UITextField *txt_date;
    
    __weak IBOutlet UITextField *txt_med_name;
    __weak IBOutlet UITextField *txt_med_date;
    __weak IBOutlet UITextField *txt_med_freq;
    __weak IBOutlet UITextField *txt_med_route;
    __weak IBOutlet UITextField *txt_med_date_start;
    __weak IBOutlet UITextField *txt_med_date_end;
    
    __weak IBOutlet UITextField *txt_oxy_settings;
    __weak IBOutlet UITextField *txt_vent_settings;
    __weak IBOutlet UITextField *txt_therapist_date;


    NSString *str_date;
    NSString *str_med_date;
    NSString *str_med_date_start;
    NSString *str_med_date_end;
    NSString *str_therapist_date;
    
    __weak IBOutlet UIImageView *img_therapist;
}

@property (nonatomic, strong) NSMutableDictionary *formData;
@property (nonatomic, strong) NSMutableDictionary *prevFormData;

@end
