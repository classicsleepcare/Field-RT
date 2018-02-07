//
//  AddNewDoctorViewController.h
//  RAP APP
//
//  Created by Anil Prasad on 5/28/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewDoctorViewController : UIViewController<UIPopoverControllerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

{
      int StoreTag;

    __weak IBOutlet UIView *view_DoctorInfoGrayedOut;
    __weak IBOutlet UIView *view_FacilityGrayedOut;
    __weak IBOutlet UIView *view_ExistingFacilityGrayedOut;
  
    NSString *str_referral;
    NSString *str_14, *str_25, *str_30, *str_45,*str_60, *str_90,*str_120;
    NSString *str_Modem_D , *str_MDAccess_D;
    NSString *str_14_D, *str_25_D, *str_30_D, *str_45_D,*str_60_D, *str_90_D,*str_120_D;
    
    NSMutableArray *arr_machine;
    NSMutableArray *arr_mask;
    NSMutableArray *arr_referrals_D;
    NSMutableArray *arr_machine_D;
    NSMutableArray *arr_mask_D;
    
    IBOutlet UILabel *lbl_date;
    IBOutlet UILabel *lbl_showDocState;
    IBOutlet UILabel *lbl_StateFacility;
    IBOutlet UIButton *btn_StateDoc;
    IBOutlet UIButton *btn_StateFacility;
    
    IBOutlet UITextField *txt_NPI;
    IBOutlet UITextField *txt_licence;
    IBOutlet UITextField *txt_MiddleName;
    IBOutlet UITextField *txt_firstName;
    IBOutlet UITextField *txt_lastName;
    IBOutlet UITextField *txt_Phone;
    IBOutlet UITextField *txt_ConfFax;
    IBOutlet UITextField *txt_DocContact;
    IBOutlet UITextField *txt_address_Doctor;
    IBOutlet UITextField *txt_city_Doc;
    IBOutlet UITextField *txt_city_Facility;
    IBOutlet UITextField *txt_Zip_Doc;
    IBOutlet UITextField *txt_Zip_Facility;
    IBOutlet UITextField *txt_SelectFacility;
    IBOutlet UITextField *txt_UPIN;
    IBOutlet UITextField *txt_faciltyName;
    IBOutlet UITextField *txt_faciltyNickName;
    IBOutlet UITextField *txt_faciltyPhone;
    IBOutlet UITextField *txt_faciltyContact;
    IBOutlet UITextField *txt_address_Facility;
    IBOutlet UITextField *txt_facilityFax;
    IBOutlet UITextField *txt_Other_Referral_U;
    IBOutlet UITextField *txt_Other_Machine_U;
    IBOutlet UITextField *txt_Other_Mask_U;
    IBOutlet UITextField *txt_Other_Referral_D;
    IBOutlet UITextField *txt_Other_Machine_D;
    IBOutlet UITextField *txt_Other_Mask_D;
    
    IBOutlet UITextView *txt_addNotes_Doc;
    IBOutlet UITextView *txt_addNotes_Fac;
    IBOutlet UITextView *txt_Nuance_Doc;
    IBOutlet UITextView *txt_Nuance_Fac;
    IBOutlet UITextView *txt_OtherInstructions_U;
    IBOutlet UITextView *txt_OtherInstructions_D;
    
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
    IBOutlet UIButton *btn_Fischer_Machine_U;
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
    IBOutlet UIButton *btn_30Days_U;
    __weak IBOutlet UIButton *btn_25Days_U;
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
    IBOutlet UIButton *btn_facilityUpdate;
    
     IBOutlet UIScrollView *scroll_Form;
     IBOutlet UIView *view_form;
   
    NSString* month;
    NSString* day;
    NSString* year;

}
@property(nonatomic,strong)UIButton *btn_selected;

- (IBAction)action_SwitchCondition:(id)sender;

-(IBAction)showPop:(UIButton *)sender;
-(IBAction)action_HST_U:(id)sender;
-(IBAction)action_Traditional_U:(id)sender;
-(IBAction)action_other__Referral_U:(id)sender;
-(IBAction)action_NoPref__Machine_U:(id)sender;
-(IBAction)action_Repirionics_Machine_U:(id)sender;
-(IBAction)action_ResMed_Machine_U:(id)sender;
-(IBAction)action_Fischer_Machine_U:(id)sender;
-(IBAction)action_other__Machine_U:(id)sender;
-(IBAction)action_FtComfort_Mask_U:(id)sender;
-(IBAction)action_FollowScirpt_U:(id)sender;
-(IBAction)action_Repirionics_Mask_U:(id)sender;
-(IBAction)action_Fischer_Mask_U:(id)sender;
-(IBAction)action_other__Mask_U:(id)sender;
-(IBAction)action_Modem_Y_U:(id)sender;
-(IBAction)action_Modem_N_U:(id)sender;
-(IBAction)action_MD_Y_U:(id)sender;
-(IBAction)action_MD_N_U:(id)sender;
-(IBAction)action_14Days_U:(id)sender;
- (IBAction)action_25Days_U:(id)sender;
-(IBAction)action_30Days_U:(id)sender;
- (IBAction)action_45Days_U:(id)sender;
-(IBAction)action_60Days_U:(id)sender;
-(IBAction)action_90Days_U:(id)sender;
-(IBAction)action_OnceYear_U:(id)sender;
-(IBAction)action_HST_D:(id)sender;
-(IBAction)action_Traditional_D:(id)sender;
-(IBAction)action_other__Referral_D:(id)sender;
-(IBAction)action_NoPref__Machine_D:(id)sender;
-(IBAction)action_Repirionics_Machine_D:(id)sender;
-(IBAction)action_ResMed_Machine_D:(id)sender;
-(IBAction)action_Fischer_Machine_D:(id)sender;
-(IBAction)action_other__Machine_D:(id)sender;
-(IBAction)action_FtComfort_Mask_D:(id)sender;
-(IBAction)action_FollowScirpt_D:(id)sender;
-(IBAction)action_Repirionics_Mask_D:(id)sender;
-(IBAction)action_Fischer_Mask_D:(id)sender;
-(IBAction)action_other__Mask_D:(id)sender;
-(IBAction)action_Modem_Y_D:(id)sender;
-(IBAction)action_Modem_N_D:(id)sender;
-(IBAction)action_MD_Y_D:(id)sender;
-(IBAction)action_MD_N_D:(id)sender;
-(IBAction)action_14Days_D:(id)sender;
- (IBAction)action_25Days_D:(id)sender;
-(IBAction)action_30Days_D:(id)sender;
- (IBAction)action_45Days_D:(id)sender;
-(IBAction)action_60Days_D:(id)sender;
-(IBAction)action_90Days_D:(id)sender;
-(IBAction)action_OnceYear_D:(id)sender;
-(IBAction)action_save:(id)sender;
- (IBAction)showDatePicker:(id)sender;

@end
