//
//  NIVCareComp.h
//  RT APP
//
//  Created by Anil Prasad on 14/11/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSCalendarView.h"
#import "Utils.h"
#import "SignatureView.h"
#import "NIVHomeSafe.h"
#import "NIVTIcketView.h"
#import "NIVTIcketModel.h"

@interface NIVCareComp : UIViewController<UIPopoverControllerDelegate, WSCalendarViewDelegate>
{
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
    
    UITextField *universalTextField;
    
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
    
    __weak IBOutlet UIImageView *img_caregiver_initial;
    __weak IBOutlet UIImageView *img_clinician_initial;
    
    __weak IBOutlet UIButton *btn_chk_2_1;
    __weak IBOutlet UIButton *btn_chk_2_2;
    __weak IBOutlet UIButton *btn_chk_2_3;
    __weak IBOutlet UIButton *btn_chk_2_4;
    __weak IBOutlet UIButton *btn_chk_2_5;
    __weak IBOutlet UIButton *btn_chk_2_6;
    __weak IBOutlet UIButton *btn_chk_2_7;
    __weak IBOutlet UIButton *btn_chk_2_8;
    __weak IBOutlet UIButton *btn_chk_2_9;
    __weak IBOutlet UIButton *btn_chk_2_10;
    __weak IBOutlet UIButton *btn_chk_2_11;
    __weak IBOutlet UIButton *btn_chk_2_12;
    __weak IBOutlet UIButton *btn_chk_2_13;
    __weak IBOutlet UIButton *btn_chk_2_14;
    __weak IBOutlet UIButton *btn_chk_2_15;
    __weak IBOutlet UIButton *btn_chk_2_16;
    __weak IBOutlet UIButton *btn_chk_2_17;
    __weak IBOutlet UIButton *btn_chk_2_18;
    __weak IBOutlet UIButton *btn_chk_2_19;
    __weak IBOutlet UIButton *btn_chk_2_20;
    
    __weak IBOutlet UIButton *btn_chk_5_1;
    __weak IBOutlet UIButton *btn_chk_5_2;
    __weak IBOutlet UIButton *btn_chk_5_3;
    __weak IBOutlet UIButton *btn_chk_5_4;
    __weak IBOutlet UIButton *btn_chk_5_5;
    __weak IBOutlet UIButton *btn_chk_5_6;
    
    __weak IBOutlet UIButton *btn_chk_7_1;
    __weak IBOutlet UIButton *btn_chk_7_1_1;
    __weak IBOutlet UIButton *btn_chk_7_1_1_1;
    __weak IBOutlet UIButton *btn_chk_7_1_1_2;
    __weak IBOutlet UIButton *btn_chk_7_1_1_3;
    __weak IBOutlet UIButton *btn_chk_7_1_2;
    __weak IBOutlet UIButton *btn_chk_7_1_2_1;
    __weak IBOutlet UIButton *btn_chk_7_1_2_2;
    __weak IBOutlet UIButton *btn_chk_7_1_2_3;
    
    __weak IBOutlet UIButton *btn_chk_8_1;
    __weak IBOutlet UIButton *btn_chk_8_2;
    __weak IBOutlet UIButton *btn_chk_8_3;
    __weak IBOutlet UIButton *btn_chk_8_4;
    __weak IBOutlet UIButton *btn_chk_8_5;
    __weak IBOutlet UIButton *btn_chk_8_6;
    
    __weak IBOutlet UIButton *btn_chk_9_1;
    __weak IBOutlet UIButton *btn_chk_9_2;
    
    __weak IBOutlet UIButton *btn_chk_10_1;
    __weak IBOutlet UIButton *btn_chk_10_2;
    __weak IBOutlet UIButton *btn_chk_10_3;
    
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
    
}

@property (nonatomic, strong) NSMutableDictionary *formData;
@property (nonatomic, strong) NSMutableDictionary *prevFormData;


@end
