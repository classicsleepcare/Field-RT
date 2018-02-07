//
//  NIVSetupTicketTwo.h
//  RT APP
//
//  Created by Anil Prasad on 11/28/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "SignatureView.h"
#import "NIVRespCare.h"
#import "NIVCareComp.h"
#import "NIVTIcketView.h"
#import "NIVTIcketModel.h"
#import "PDFViewController.h"


@interface NIVSetupTicketTwo : UIViewController{
    __weak IBOutlet UIScrollView *d_scrollView;

    UIView *signatureBackgroundView;
    UIView *signatureVw;
    SignatureView *signaturePanel;
    CGPoint d_point;

    __weak IBOutlet UITextField *txt_otherNameNumber;
    __weak IBOutlet UITextField *txt_date;
    __weak IBOutlet UIImageView *img_initial;
    __weak IBOutlet UIImageView *img_pt_signature;
    
    NSString *str_date;

}

@property (nonatomic, strong) NSMutableDictionary *formData;
@property (nonatomic, strong) NSMutableDictionary *prevFormData;
@property (nonatomic, strong) NSMutableDictionary *pageOneFormData;
@property (strong, nonatomic) NSDictionary *dict_retrivedData, *dict_retrivedData_local;


@end
