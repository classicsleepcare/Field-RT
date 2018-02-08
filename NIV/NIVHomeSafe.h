//
//  NIVHomeSafe.h
//  RT APP
//
//  Created by Anil Prasad on 14/11/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSCalendarView.h"
#import "Utils.h"
#import "SignatureView.h"
#import "APRadioButton.h"
#import "NIVNewPatientHistory.h"
#import "NIVTIcketView.h"
#import "NIVTIcketModel.h"

@interface NIVHomeSafe : UIViewController{
    __weak IBOutlet UIScrollView *d_scrollView;
    
    UIView *signatureBackgroundView;
    UIView *signatureVw;
    SignatureView *signaturePanel;
    
    UITextField *universalTextField;
    CGPoint d_point;
    
    __weak IBOutlet APRadioButton *rad_1_1;
    __weak IBOutlet UIButton *btn_1_2;
    __weak IBOutlet APRadioButton *rad_1_3;
    
    __weak IBOutlet APRadioButton *rad_2_1;
    __weak IBOutlet APRadioButton *rad_2_2;

    __weak IBOutlet APRadioButton *rad_3_1;
    __weak IBOutlet APRadioButton *rad_3_2;
    __weak IBOutlet APRadioButton *rad_3_3;
    __weak IBOutlet APRadioButton *rad_3_4;
    __weak IBOutlet APRadioButton *rad_3_5;
    __weak IBOutlet APRadioButton *rad_3_6;

    __weak IBOutlet APRadioButton *rad_4_1;
    __weak IBOutlet APRadioButton *rad_4_2;
    __weak IBOutlet APRadioButton *rad_4_3;
    __weak IBOutlet APRadioButton *rad_4_4;
    __weak IBOutlet APRadioButton *rad_4_5;
    __weak IBOutlet APRadioButton *rad_4_6;
    __weak IBOutlet APRadioButton *rad_4_7;
    __weak IBOutlet APRadioButton *rad_4_8;
    __weak IBOutlet APRadioButton *rad_4_9;
    __weak IBOutlet APRadioButton *rad_4_10;
    __weak IBOutlet APRadioButton *rad_4_11;

    __weak IBOutlet APRadioButton *rad_5_1;
    __weak IBOutlet APRadioButton *rad_5_2;
    __weak IBOutlet APRadioButton *rad_5_3;
    __weak IBOutlet APRadioButton *rad_5_4;

    __weak IBOutlet APRadioButton *rad_6_1;
    __weak IBOutlet APRadioButton *rad_6_2;
    __weak IBOutlet APRadioButton *rad_6_3;
    __weak IBOutlet APRadioButton *rad_6_4;
    __weak IBOutlet APRadioButton *rad_6_5;
    __weak IBOutlet APRadioButton *rad_6_6;
    __weak IBOutlet APRadioButton *rad_6_7;

    __weak IBOutlet APRadioButton *rad_7_1;
    __weak IBOutlet APRadioButton *rad_7_2;
    __weak IBOutlet APRadioButton *rad_7_3;
    __weak IBOutlet APRadioButton *rad_7_4;
    __weak IBOutlet APRadioButton *rad_7_5;
    __weak IBOutlet APRadioButton *rad_7_6;

    __weak IBOutlet APRadioButton *rad_8_1;

    __weak IBOutlet APRadioButton *rad_9_1;

    __weak IBOutlet UITextField *txt_dwelling_other;
    __weak IBOutlet UITextField *txt_dwelling_list;
    __weak IBOutlet UITextField *txt_phone;
    __weak IBOutlet UITextField *txt_list;
    __weak IBOutlet UITextField *txt_Recommendation;
    __weak IBOutlet UITextField *txt_plan;
    __weak IBOutlet UITextField *txt_patient_name;
    __weak IBOutlet UITextField *txt_date;
    __weak IBOutlet UITextField *txt_date_of_birth;

    __weak IBOutlet UIImageView *img_clinician_sign;
    
    NSString *str_date_of_birth;
    NSString *str_date;
}

@property (nonatomic, strong) NSMutableDictionary *formData;
@property (nonatomic, strong) NSMutableDictionary *prevFormData;
@property (strong, nonatomic) NSDictionary *dict_retrivedData, *dict_retrivedData_local;

@end
