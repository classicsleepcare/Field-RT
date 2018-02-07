//
//  PatientViewController.h
//  RAP APP
//
//  Created by Anil Prasad on 4/5/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIDocumentInteractionControllerDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,UIPopoverControllerDelegate>
{
    NSString *str1;
    NSMutableArray *arryDate;
    UIDatePicker *datePicker;
    UIViewController *pickerController;
    IBOutlet UITextField *txt_FirstName;
    IBOutlet UITextField *txt_LastName;
    IBOutlet UITextField *txt_Status;
    IBOutlet UITextField *txt_Facility;
    IBOutlet UITextField *txt_Insurance;
    IBOutlet UITextField *txt_Doctor;
    IBOutlet UITextField *txt_Ref_F_Month;
    IBOutlet UITextField *txt_Ref_T_Month;
    IBOutlet UITextField *txt_Ref_F_Day;
    IBOutlet UITextField *txt_Ref_T_Day;
    IBOutlet UITextField *txt_Ref_F_Year;
    IBOutlet UITextField *txt_Ref_T_Year;
    IBOutlet UITextField *txt_Ref_DateRange;
    IBOutlet UITextField *txt_App_F_Month;
    IBOutlet UITextField *txt_App_T_Month;
    IBOutlet UITextField *txt_App_F_Day;
    IBOutlet UITextField *txt_App_T_Day;
    IBOutlet UITextField *txt_App_F_Year;
    IBOutlet UITextField *txt_App_T_Year;
    IBOutlet UITextField *txt_Den_F_Month;
    IBOutlet UITextField *txt_Den_T_Month;
    IBOutlet UITextField *txt_Den_F_Day;
    IBOutlet UITextField *txt_Den_T_Day;
    IBOutlet UITextField *txt_Den_F_Year;
    IBOutlet UITextField *txt_Den_T_Year;
    IBOutlet UITextField *txt_Set_F_Month;
    IBOutlet UITextField *txt_Set_T_Month;
    IBOutlet UITextField *txt_Set_F_Day;
    IBOutlet UITextField *txt_Set_T_Day;
    IBOutlet UITextField *txt_Set_F_Year;
    IBOutlet UITextField *txt_Set_T_Year;
    IBOutlet UITextField *txt_Set_DateRange;
    IBOutlet UITextField *txt_Den_DateRange;
    IBOutlet UITextField *txt_App_DateRange;
    IBOutlet UITextField *txt_RefDown_F_Month;
    IBOutlet UITextField *txt_RefDown_T_Month;
    IBOutlet UITextField *txt_RefDown_F_Day;
    IBOutlet UITextField *txt_RefDown_T_Day;
    IBOutlet UITextField *txt_RefDown_F_Year;
    IBOutlet UITextField *txt_RefDown_T_Year;
    IBOutlet UITextField *txt_RefDown_DateRange;

    IBOutlet UIButton *btn_Ref_F_Calender;
    IBOutlet UIButton *btn_Ref_T_Calender;
    IBOutlet UIButton *btn_App_F_Calender;
    IBOutlet UIButton *btn_App_T_Calender;
    IBOutlet UIButton *btn_Den_F_Calender;
    IBOutlet UIButton *btn_Den_T_Calender;
    IBOutlet UIButton *btn_Set_F_Calender;
    IBOutlet UIButton *btn_Set_T_Calender;
    IBOutlet UIButton *btn_RefDown_F_Calender;
    IBOutlet UIButton *btn_RefDown_T_Calender;
    IBOutlet UIButton *btn_Search;
    IBOutlet UIButton *btn_Clear;
    IBOutlet UIButton *btn_PatientInfo;
    IBOutlet UIButton *btn_InsuranceInfo;
    IBOutlet UIButton *btn_DoctorInfo;
    IBOutlet UIButton *btn_Nuance;
    IBOutlet UIButton *btn_Back;
    
    
    IBOutlet UIView *PatientFormVw;
    
    UIView *calenderVw;
   
    UIPopoverController *popoverController;
    
    IBOutlet UILabel *lbl_Heading;
    
      UILabel *toolTipLabel;
    
    CGRect framePDF;
    NSArray *arr_SearchListOfPatients;
     
    
    NSString* month;
    NSString* day;
    NSString* year;
    
    
    int StoreTag;
   
    
}
@property(nonatomic,strong)NSString *strPdfName;
@property(nonatomic,weak)UIViewController *previewController;
-(IBAction)action_fromDateCalender:(id)sender;
-(IBAction)action_TODateCalender:(id)sender;

-(IBAction)action_Search:(id)sender;
-(IBAction)action_Clear:(id)sender;
-(IBAction)action_Back:(id)sender;

-(IBAction)customDropDownMenu:(id)sender;
  @end
