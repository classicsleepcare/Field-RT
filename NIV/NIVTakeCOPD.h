//
//  NIVTakeCOPD.h
//  RT APP
//
//  Created by Anil Prasad on 14/11/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "NIVNewPatientProfile.h"
#import "APRadioButton.h"
#import "NIVNewPatientProfile.h"
#import "NIVTIcketView.h"
#import "NIVTIcketModel.h"

@interface NIVTakeCOPD : UIViewController{
    __weak IBOutlet UIScrollView *d_scrollView;

    int score1, score2, score3, score4, score5, score6, score7, score8, score_total;
    
    __weak IBOutlet UITextField *txt_name;
    __weak IBOutlet UITextField *txt_date;
    
    __weak IBOutlet UILabel *txt_score_1;
    __weak IBOutlet UILabel *txt_score_2;
    __weak IBOutlet UILabel *txt_score_3;
    __weak IBOutlet UILabel *txt_score_4;
    __weak IBOutlet UILabel *txt_score_5;
    __weak IBOutlet UILabel *txt_score_6;
    __weak IBOutlet UILabel *txt_score_7;
    __weak IBOutlet UILabel *txt_score_8;
    __weak IBOutlet UILabel *txt_score_total;

    __weak IBOutlet APRadioButton *rad_1;
    __weak IBOutlet APRadioButton *rad_2;
    __weak IBOutlet APRadioButton *rad_3;
    __weak IBOutlet APRadioButton *rad_4;
    __weak IBOutlet APRadioButton *rad_5;
    __weak IBOutlet APRadioButton *rad_6;
    __weak IBOutlet APRadioButton *rad_7;
    __weak IBOutlet APRadioButton *rad_8;

    NSString *str_date;

}

@property (nonatomic, strong) NSMutableDictionary *formData;
@property (nonatomic, strong) NSMutableDictionary *prevFormData;
@property (strong, nonatomic) NSDictionary *dict_retrivedData, *dict_retrivedData_local;

@end
