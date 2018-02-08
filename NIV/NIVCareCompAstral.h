//
//  NIVCareCompAstral.h
//  RT APP
//
//  Created by Anil Prasad on 1/12/18.
//  Copyright © 2018 ankit gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSCalendarView.h"
#import "Utils.h"
#import "SignatureView.h"
#import "NIVHomeSafe.h"
#import "NIVTIcketView.h"
#import "NIVTIcketModel.h"

@interface NIVCareCompAstral : UIViewController<UIPopoverControllerDelegate, WSCalendarViewDelegate>{
    
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
    
    __weak IBOutlet UITextField *txt_patient_name;
    __weak IBOutlet UITextField *txt_caregiver_name;
    
    __weak IBOutlet UITextField *txt_one_date;
    __weak IBOutlet UITextField *txt_two_date;
    __weak IBOutlet UITextField *txt_three_date;
    __weak IBOutlet UITextField *txt_four_date;
    __weak IBOutlet UITextField *txt_five_date;
    __weak IBOutlet UITextField *txt_six_date;
    __weak IBOutlet UITextField *txt_seven_date;
    __weak IBOutlet UITextField *txt_eight_date;
    __weak IBOutlet UITextField *txt_nine_date;
    __weak IBOutlet UITextField *txt_ten_date;
    __weak IBOutlet UITextField *txt_eleven_date;
    __weak IBOutlet UITextField *txt_twelve_date;
    __weak IBOutlet UITextField *txt_thirteen_date;
    __weak IBOutlet UITextField *txt_fourteen_date;
    __weak IBOutlet UITextField *txt_fifteen_date;
    __weak IBOutlet UITextField *txt_sixteen_date;
    __weak IBOutlet UITextField *txt_seventeen_date;
    __weak IBOutlet UITextField *txt_eighteen_date;
    __weak IBOutlet UITextField *txt_nineteen_date;
    __weak IBOutlet UITextField *txt_twenty_date;
    __weak IBOutlet UITextField *txt_twentyOne_date;
    
    
    __weak IBOutlet UIImageView *img_one_initial;
    __weak IBOutlet UIImageView *img_two_initial;
    __weak IBOutlet UIImageView *img_three_initial;
    __weak IBOutlet UIImageView *img_four_initial;
    __weak IBOutlet UIImageView *img_five_initial;
    __weak IBOutlet UIImageView *img_six_initial;
    __weak IBOutlet UIImageView *img_seven_initial;
    __weak IBOutlet UIImageView *img_eight_initial;
    __weak IBOutlet UIImageView *img_nine_initial;
    __weak IBOutlet UIImageView *img_ten_initial;
    __weak IBOutlet UIImageView *img_eleven_initial;
    __weak IBOutlet UIImageView *img_twelve_initial;
    __weak IBOutlet UIImageView *img_thirteen_initial;
    __weak IBOutlet UIImageView *img_fourteen_initial;
    __weak IBOutlet UIImageView *img_fifteen_initial;
    __weak IBOutlet UIImageView *img_sixteen_initial;
    __weak IBOutlet UIImageView *img_seventeen_initial;
    __weak IBOutlet UIImageView *img_eighteen_initial;
    __weak IBOutlet UIImageView *img_nineteen_initial;
    __weak IBOutlet UIImageView *img_twenty_initial;
    __weak IBOutlet UIImageView *img_twentyOne_initial;
  
    
    __weak IBOutlet UIImageView *img_caregiver_initial;
    __weak IBOutlet UIImageView *img_clinician_initial;
    
    NSString *str_one_date;
    NSString *str_two_date;
    NSString *str_three_date;
    NSString *str_four_date;
    NSString *str_five_date;
    NSString *str_six_date;
    NSString *str_seven_date;
    NSString *str_eight_date;
    NSString *str_nine_date;
    NSString *str_ten_date;
    NSString *str_eleven_date;
    NSString *str_twelve_date;
    NSString *str_thirteen_date;
    NSString *str_fourteen_date;
    NSString *str_fifteen_date;
    NSString *str_sixteen_date;
    NSString *str_seventeen_date;
    NSString *str_eighteen_date;
    NSString *str_nineteen_date;
    NSString *str_twenty_date;
    NSString *str_twentyOne_date;
    
}

@property (nonatomic, strong) NSMutableDictionary *formData;
@property (nonatomic, strong) NSMutableDictionary *prevFormData;
@property (strong, nonatomic) NSDictionary *dict_retrivedData, *dict_retrivedData_local;

@end
