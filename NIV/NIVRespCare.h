//
//  NIVRespCare.h
//  RT APP
//
//  Created by Anil Prasad on 14/11/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSCalendarView.h"
#import "Utils.h"
#import "SignatureView.h"
#import "NIVCareComp.h"
#import "NIVCareCompAstral.h"
#import "NIVTIcketView.h"
#import "NIVTIcketModel.h"

@interface NIVRespCare : UIViewController<UIPopoverControllerDelegate, WSCalendarViewDelegate>
{
    
    __weak IBOutlet UITextField *txt_name;
    __weak IBOutlet UIImageView *img_caregiver;
    __weak IBOutlet UIImageView *img_guardian;
    __weak IBOutlet UIImageView *img_witness;
    
    __weak IBOutlet UITextField *txt_caregiver_date;
    __weak IBOutlet UITextField *txt_guardian_date;
    __weak IBOutlet UITextField *txt_witness_date;
    
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
    
    NSString *str_caregiver_date;
    NSString *str_guardian_date;
    NSString *str_witness_date;
}
@property (nonatomic, strong) NSMutableDictionary *formData;
@property (nonatomic, strong) NSMutableDictionary *prevFormData;
@property (strong, nonatomic) NSDictionary *dict_retrivedData, *dict_retrivedData_local;


@end 
