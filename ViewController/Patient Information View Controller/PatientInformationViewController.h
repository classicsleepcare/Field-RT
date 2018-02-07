//
//  PatientInformationViewController.h
//  RAP APP
//
//  Created by Anil Prasad on 4/23/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientInformationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UILabel *lbl_Referred;
    IBOutlet UILabel *lbl_FirstName;
    IBOutlet UILabel *lbl_LastName;
    IBOutlet UILabel *lbl_Status;
    IBOutlet UILabel *lbl_City;
    IBOutlet UILabel *lbl_PatienNameWithID;
    IBOutlet  UILabel *lbl_status;
    IBOutlet  UILabel *lbl_DOB;
    IBOutlet  UILabel *lbl_sex;
    IBOutlet  UILabel *lbl_address1;
    IBOutlet  UILabel *lbl_address2;
    IBOutlet  UILabel *lbl_state;
    IBOutlet  UILabel *lbl_zip;
    IBOutlet  UILabel *lbl_county;
    
    
    IBOutlet UILabel *lbl_doctor;
    IBOutlet UILabel *lbl_lab_Rep;
    IBOutlet UILabel *lbl_address;
    IBOutlet UILabel *lbl_NPI;
    IBOutlet UILabel *lbl_Facility;
    
    IBOutlet UILabel *lbl_nuanceDocName;
    IBOutlet UITextView *txtView_nuanceText;
    IBOutlet UILabel *lbl_phone1;
    IBOutlet UIButton *btn_call;
    
    IBOutlet UILabel *lbl_fax1;
    
  
    IBOutlet UILabel *lbl_Fac_phone1;
    
    IBOutlet UILabel *lbl_Fac_fax1;

    IBOutlet UILabel *lbl_Primary;
    IBOutlet UILabel *lbl_Primary_Ins;
    IBOutlet UILabel *lbl_Secondary;
    IBOutlet UILabel *lbl_Sec_Ins;
    IBOutlet UILabel *lbl_Tertiary;
    IBOutlet UILabel *lbl_Ter_Ins;
    IBOutlet UILabel *lbl_month;
    IBOutlet UILabel *lbl_day;
    IBOutlet UILabel *lbl_year;
    IBOutlet UILabel *lbl_HST;
    
    
    IBOutlet UIView *view_customAlert;
    IBOutlet UIView *PdfVw;
    IBOutlet UIView *view_info;
    IBOutlet UIView *DoctorVw;
    IBOutlet UIView *InsuVw;

    IBOutlet UITextView *textView_notes;
    
    IBOutlet UITableView *tbl_pdfList;
    
    IBOutlet UIImageView *imgview_tabbarPatientSearch;
}
@property(nonatomic,strong)NSDictionary *dict_patientInfo;
@property(nonatomic,strong)NSDictionary *dict_docInfo;
@property(nonatomic,strong)NSDictionary *dict_insInfo;

@property(nonatomic,strong)NSArray *arr_pdfs ,*arr_FileName;


-(IBAction)profileInfo:(id)sender;
-(IBAction)action_Nuance:(id)sender;
-(IBAction)action_Back:(id)sender;
-(IBAction)closeCustoview:(id)sender;

-(IBAction)makeCall:(id)sender;

@end
