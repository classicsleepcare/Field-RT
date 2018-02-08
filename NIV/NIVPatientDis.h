//
//  NIVPatientDis.h
//  RT APP
//
//  Created by Anil Prasad on 14/11/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSCalendarView.h"
#import "Utils.h"
#import "SignatureView.h"
#import "NIVTrilogyVentPerf.h"
#import "NIVAstralVentPerf.h"
#import "NIVTIcketView.h"
#import "NIVTIcketModel.h"

@interface NIVPatientDis : UIViewController<UIPopoverControllerDelegate, WSCalendarViewDelegate>{
    __weak IBOutlet UIScrollView *d_scrollView;
    
    WSCalendarView *calendarView;
    WSCalendarView *calendarViewEvent;
    NSMutableArray *eventArray;
    
    UIPopoverController *popoverCon;
    UIViewController *popoverViewCon;
    UIView *calendarViewController;
    
    int dateTag;
    
    UIView *signatureBackgroundView;
    UIView *signatureVw;
    SignatureView *signaturePanel;
    
    CGPoint d_point;
    
    __weak IBOutlet UITextField *txt_pt_name;
    __weak IBOutlet UITextField *txt_physician_name;
    __weak IBOutlet UITextField *txt_admission_date;
    __weak IBOutlet UITextField *txt_discharge_date;
    __weak IBOutlet UITextField *txt_date;

    __weak IBOutlet UITextView *txt_reason;
    __weak IBOutlet UITextView *txt_problems;
    __weak IBOutlet UITextView *txt_goals;
    __weak IBOutlet UITextView *txt_overall;
    __weak IBOutlet UITextView *txt_summary;
    __weak IBOutlet UITextView *txt_comments;

    UITextView *universalTextView;

    __weak IBOutlet UIImageView *img_practitoner_sign;

    NSString *str_admission_date;
    NSString *str_discharge_date;
    NSString *str_date;
    

}

@property (nonatomic, strong) NSMutableDictionary *formData;
@property (nonatomic, strong) NSMutableDictionary *prevFormData;
@property (strong, nonatomic) NSDictionary *dict_retrivedData, *dict_retrivedData_local;

@end
