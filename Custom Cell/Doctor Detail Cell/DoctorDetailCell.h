//
//  DoctorDetailCell.h
//  RAP APP
//
//  Created by Anil Prasad on 4/5/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorDetailCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UIButton *btn_doctorListAddress;
@property (weak, nonatomic) IBOutlet UIButton *btn_docDetailAddress;
@property(nonatomic,weak)IBOutlet UILabel *lbl_docName;
@property(nonatomic,weak)IBOutlet UILabel *lbl_cityName;
@property(nonatomic,weak)IBOutlet UILabel *lbl_address;
@property(nonatomic,weak)IBOutlet UILabel *lbl_contact;
@property(nonatomic,weak)IBOutlet UILabel *lbl_docPhone;
@property(nonatomic,weak)IBOutlet UILabel *lbl_fax;
@property(nonatomic,weak)IBOutlet UILabel *lbl_npi;
@property(nonatomic,weak)IBOutlet UILabel *lbl_facAdd;
@property(nonatomic,weak)IBOutlet UILabel *lbl_facPhone;
@property(nonatomic,weak)IBOutlet UILabel *lbl_facFax;
@property(nonatomic,weak)IBOutlet UILabel *lbl_lastRef;
@property(nonatomic,weak)IBOutlet UILabel *lbl_DoctorOfficeContact;
@property (weak, nonatomic) IBOutlet UILabel *lbl_facOfficeContact;
@property(nonatomic,weak)IBOutlet UITextView *txtView_nuance;
@property(nonatomic,weak)IBOutlet UIWebView *webView_nuance;

@property(nonatomic,weak)IBOutlet UILabel *lbl_Patient;
@property(nonatomic,weak)IBOutlet UILabel *lbl_Doctor;
@property(nonatomic,weak)IBOutlet UILabel *lbl_Insurance;
@property(nonatomic,weak)IBOutlet UILabel *lbl_Status;
@property(nonatomic,weak)IBOutlet UILabel *lbl_PdfDetail;
@property(nonatomic,weak)IBOutlet UIImageView *img_pdf;
@property(nonatomic,weak)IBOutlet UIImageView *img_schCircle;
@property(nonatomic,weak)IBOutlet UIImageView *img_schDevider;
@property(nonatomic,weak)IBOutlet UILabel *lbl_schTime;
@property(nonatomic,weak)IBOutlet UILabel *lbl_schName;
-(IBAction)addressDirectionMethod:(id)sender;
@end
