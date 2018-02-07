//
//  UpdateDoctorViewController.h
//  RAP APP
//
//  Created by Anil Prasad on 6/24/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateDoctorViewController : UIViewController
{
    __weak IBOutlet UIView *view_DoctorInfoGrayedOut;
    __weak IBOutlet UIView *view_FacilityGrayedOut;
  
    
    IBOutlet UILabel *lbl_date;
    __weak IBOutlet UITextField *txt_selectDoctorname;
    IBOutlet UITextField *txt_NPI;
    IBOutlet UITextField *txt_licence;
    IBOutlet UITextField *txt_facility_fax;
   
    IBOutlet UITextField *txt_firstName;
    __weak IBOutlet UITextField *txt_middleName;
    IBOutlet UITextField *txt_lastName;
    IBOutlet UITextField *txt_Phone;
    IBOutlet UITextField *txt_ConfFax;
    IBOutlet UITextField *txt_DocContact;
    IBOutlet UITextField *txt_address_Doctor;
    IBOutlet UITextField *txt_city_Doc;
    IBOutlet UITextField *txt_city_Facility;
    IBOutlet UITextField *txt_Zip_Doc;
    IBOutlet UITextField *txt_Zip_Facility;

    
   
    IBOutlet UITextField *txt_UPIN;
     IBOutlet UITextField *txt_faciltyName;
    IBOutlet UITextField *txt_faciltyNickName;
    IBOutlet UITextField *txt_faciltyPhone;
    IBOutlet UITextField *txt_faciltyContact;
    IBOutlet UITextField *txt_address_Facility;
    __weak IBOutlet UITextField *txt_SelectFacility;
     
    
    
    IBOutlet UITextView *txt_addNotes_Doc;
    IBOutlet UITextView *txt_addNotes_Fac;
    IBOutlet UITextView *txt_Nuance_Doc;
    IBOutlet UITextView *txt_Nuance_Fac;
    IBOutlet UITextView *txt_OtherInstructions_U;
    IBOutlet UITextView *txt_OtherInstructions_D;
    
    IBOutlet UITextField *txt_Other_Referral_U;
    IBOutlet UITextField *txt_Other_Machine_U;
    IBOutlet UITextField *txt_Other_Mask_U;
    IBOutlet UITextField *txt_Other_Referral_D;
    IBOutlet UITextField *txt_Other_Machine_D;
    IBOutlet UITextField *txt_Other_Mask_D;
    
    
    IBOutlet UIButton *btn_HST_U;
    IBOutlet UIButton *btn_traditional_U;
    IBOutlet UIButton *btn_HST_D;
    IBOutlet UIButton *btn_traditional_D;
    
    IBOutlet UIButton *btn_NoPreference_U;
    IBOutlet UIButton *btn_ResMed_U;
    IBOutlet UIButton *btn_NoPreference_D;
    IBOutlet UIButton *btn_ResMed_D;
    
    IBOutlet UIButton *btn_Repirionics_Mask_U;
    IBOutlet UIButton *btn_Repirionics_Machine_U;
    IBOutlet UIButton *btn_Repirionics_Mask_D;
    IBOutlet UIButton *btn_Repirionics_Machine_D;
    
    
    IBOutlet UIButton *btn_Fischer_Referral_U;
    IBOutlet UIButton *btn_Fischer_Mask_U;
     IBOutlet UIButton *btn_Fischer_Machine_D;
    IBOutlet UIButton *btn_Fischer_Mask_D;
    
    IBOutlet UIButton *btn_other_Machine_U;
    IBOutlet UIButton *btn_other_Mask_U;
    IBOutlet UIButton *btn_other_Referral_U;
    IBOutlet UIButton *btn_other_Machine_D;
    IBOutlet UIButton *btn_other_Mask_D;
    IBOutlet UIButton *btn_other_Referral_D;
    
    IBOutlet UIButton *btn_ft_pt_Comfort_U;
    IBOutlet UIButton *btn_followScipt_U;
    IBOutlet UIButton *btn_ft_pt_Comfort_D;
    IBOutlet UIButton *btn_followScipt_D;
    
    
    IBOutlet UIButton *btn_Modem_Y_U;
    IBOutlet UIButton *btn_Modem_N_U;
    IBOutlet UIButton *btn_MD_Y_U;
    IBOutlet UIButton *btn_MD_N_U;
    IBOutlet UIButton *btn_14Days_U;
    __weak IBOutlet UIButton *btn_25Days_U;
    IBOutlet UIButton *btn_30Days_U;
    __weak IBOutlet UIButton *btn_45Days_U;
    IBOutlet UIButton *btn_60Days_U;
    IBOutlet UIButton *btn_90Days_U;
    IBOutlet UIButton *btn_OnceYear_U;
    IBOutlet UIButton *btn_Modem_Y_D;
    IBOutlet UIButton *btn_Modem_N_D;
    IBOutlet UIButton *btn_MD_Y_D;
    IBOutlet UIButton *btn_MD_N_D;
    IBOutlet UIButton *btn_14Days_D;
    __weak IBOutlet UIButton *btn_25Days_D;
    IBOutlet UIButton *btn_30Days_D;
    __weak IBOutlet UIButton *btn_45Days_D;
    IBOutlet UIButton *btn_60Days_D;
    IBOutlet UIButton *btn_90Days_D;
    IBOutlet UIButton *btn_OnceYear_D;
    
    
    __weak IBOutlet UILabel *lbl_selectStatefac;
    __weak IBOutlet UILabel *lbl_selectStateDoc;
    NSString * str_facilityState;
    
  
    IBOutlet UIScrollView *scroll_Form;
    IBOutlet UIView *view_form;
    
    //July2
    NSMutableArray *arry_DoctorList;
    NSMutableArray *arry_NameChnaged;
   

}
- (IBAction)action_SwitchCondition:(id)sender;
- (IBAction)showDatePicker:(id)sender;
- (IBAction)checkBox_referralTypesFirst:(id)sender;
-(IBAction)showPop:(UIButton *)sender;
- (IBAction)CheckBoxes_MachinePrefrencesFirst:(id)sender;
- (IBAction)checkBoxes_MaskPrefrencesFirst:(id)sender;
- (IBAction)checkBoxes_ModemFirst:(id)sender;
- (IBAction)checkBoxes_MDAcessFirst:(id)sender;
- (IBAction)checkBoxes_downloads:(id)sender;
- (IBAction)update:(id)sender;
- (IBAction)checkBoxes_ReferralTypeSecond:(id)sender;
- (IBAction)checkBoxes_MachinePreferencesSecond:(id)sender;
- (IBAction)checkBoxes_MaskPreferenceSecond:(id)sender;
- (IBAction)checkBoxes_ModemSecond:(id)sender;
- (IBAction)checkBoxes_MDAcessSecond:(id)sender;
- (IBAction)checkBoxes_DownloadsSecond:(id)sender;

@end
