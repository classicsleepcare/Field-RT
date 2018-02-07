//
//  PatientInformationViewController.m
//  RAP APP
//
//  Created by Anil Prasad on 4/23/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "PatientInformationViewController.h"
#import "DoctorDetailCell.h"
#import "PDFViewController.h"
#import "HistoryViewController.h"
#import "PatientViewController.h"

@interface PatientInformationViewController ()

@end

@implementation PatientInformationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
     lbl_PatienNameWithID.text = [NSString stringWithFormat:@"%@ %@- %@",_dict_patientInfo[@"Pt_First"],_dict_patientInfo[@"Pt_Last"],_dict_patientInfo[@"Pt_ID"]];
    [self showNote];
    [self showPatientInformation];
    [self showDoctorInformation];
    [self showInsuranceInformation];
    
    view_info.hidden=NO;
    DoctorVw.hidden=YES;
    InsuVw.hidden=YES;
     imgview_tabbarPatientSearch.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tab_patient" ofType:@"png"]];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}
-(void)showPatientInformation
{
    lbl_Referred.text=_dict_patientInfo[@"Ref_Date"];
    lbl_FirstName.text=_dict_patientInfo[@"Pt_First"];
    lbl_LastName.text=_dict_patientInfo[@"Pt_Last"];
    lbl_City.text=_dict_patientInfo[@"Pt_City"];
    lbl_address1.text= _dict_patientInfo[@"Pt_Add1"];
    lbl_address2.text=_dict_patientInfo[@"Pt_Add2"];
    lbl_county.text= _dict_patientInfo[@"Pt_County"];
    lbl_DOB.text=_dict_patientInfo[@"Pt_Birth_Date"];
    lbl_sex.text=_dict_patientInfo[@"Pt_Sex"];
    lbl_state.text=_dict_patientInfo[@"Pt_State"];
 //   lbl_status.text=_dict_patientInfo[@"App_Den_Sup_Date"];Status
    lbl_status.text=[NSString stringWithFormat:@"%@: %@",_dict_patientInfo[@"Status"],_dict_patientInfo[@"App_Den_Sup_Date"]];
    lbl_zip.text= _dict_patientInfo[@"Pt_Zip"];

}
-(void)showDoctorInformation
{
    lbl_doctor.text = [_dict_docInfo[@"Dr_First"] stringByAppendingString:[NSString stringWithFormat:@" %@",_dict_docInfo[@"Dr_Last"]]];
    lbl_address.text=_dict_docInfo[@"Dr_Address"];
    lbl_NPI.text=_dict_docInfo[@"Dr_NPI"];
    lbl_Facility.text=_dict_docInfo[@"fac_full_name"];
    lbl_fax1.text=_dict_docInfo[@"Conf_Fax"];
    lbl_Fac_fax1.text=_dict_docInfo[@"fac_fax"];
    lbl_Fac_phone1.text = _dict_docInfo[@"fac_phone"];
    
    
    
    
    txtView_nuanceText.text= [NSString stringWithFormat:@"%@\n%@\n%@",_dict_docInfo[@"Dr_Nuance"],_dict_docInfo[@"compliance_nuance"],_dict_docInfo[@"fac_nuance"]];
    if([txtView_nuanceText.text isEqualToString:[NSString stringWithFormat:@"\n%@\%@",_dict_docInfo[@"compliance_nuance"],_dict_docInfo[@"fac_nuance"]]]&& ![txtView_nuanceText.text isEqualToString:@"\n\n"])
    {
        txtView_nuanceText.text=[NSString stringWithFormat:@"%@\%@",_dict_docInfo[@"compliance_nuance"],_dict_docInfo[@"fac_nuance"]];
      
    }
    else if ([txtView_nuanceText.text isEqualToString:[NSString stringWithFormat:@"\n\n%@",_dict_docInfo[@"fac_nuance"]]]&& ![txtView_nuanceText.text isEqualToString:@"\n\n"])
    {
        txtView_nuanceText.text=[NSString stringWithFormat:@"%@",_dict_docInfo[@"fac_nuance"]];
    }
    else if ([txtView_nuanceText.text isEqualToString:@"\n\n"])
    {
         txtView_nuanceText.text = @"There is no nuance for this patient";
    }
    
    NSString *doc_phone = _dict_docInfo[@"Dr_Phone"];
    if (doc_phone.length >8) {
        NSMutableString *mu = [NSMutableString stringWithString:doc_phone];
        [mu insertString:@"-" atIndex:3];
        [mu insertString:@"-" atIndex:7];
        lbl_phone1.text =mu;
        
    }
    
    
    
    lbl_nuanceDocName.text = [NSString stringWithFormat:@"Doctor - %@",lbl_doctor.text];
}


-(IBAction)makeCall:(id)sender{
    NSLog(@"lbl_phone1.text: %@", lbl_phone1.text);
    [self makeTheCall:lbl_phone1.text];
}
-(void)makeTheCall:(NSString*)phone{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phone]]];
}

-(void)showInsuranceInformation
{
    lbl_HST.text=_dict_insInfo[@"HST_Status"];
    lbl_Primary_Ins.text=_dict_insInfo[@"Pri_Policy"];
    lbl_Primary.text=_dict_insInfo[@"Primary"];
    lbl_Secondary.text=_dict_insInfo[@"Secondary"];
    lbl_Sec_Ins.text=_dict_insInfo[@"Sec_Policy"];
    lbl_Ter_Ins.text=_dict_insInfo[@"Ter_Policy"];
    lbl_Tertiary.text=_dict_insInfo[@"Tertiary"];
}
-(void)showNote
{
    textView_notes.textAlignment=NSTextAlignmentJustified;
    
    NSString *str = [_dict_patientInfo[@"Pend_Other"]  stringByReplacingOccurrencesOfString:@"&#039;" withString:@""];
    
    NSRange r;
   
    while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        str = [str stringByReplacingCharactersInRange:r withString:@""];
    
    str = [str stringByReplacingOccurrencesOfString:@"&lt;p&gt;" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"&lt;/p&gt;" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"nbsp" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@";" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"&" withString:@""];
   
    NSArray *arr ;
    
        arr = [str componentsSeparatedByString:@"."];
    
    str = [arr componentsJoinedByString:@".\n"];

    NSLog(@"%@",str);
    
    textView_notes.text =str;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /*
    if (_arr_pdfs.count >1) {
        return 3;
    }
    else{
        return 2;
    }
     */
    return _arr_pdfs.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *strID = @"files";
    DoctorDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
  
//    cell.lbl_PdfDetail.text = _arr_FileName[indexPath.row];
    /*
    if (indexPath.row == 0) cell.lbl_PdfDetail.text = @"Download.pdf";
    if (indexPath.row == 1) cell.lbl_PdfDetail.text = @"Compliance_Download.pdf";
    if (_arr_pdfs.count >1) {
        if (indexPath.row == 2) cell.lbl_PdfDetail.text = [NSString stringWithFormat:@"SUT_%@", [_arr_pdfs[1] lastPathComponent]];
    }
     */
    cell.lbl_PdfDetail.text = [_arr_pdfs[indexPath.row] lastPathComponent];

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PDFViewController *object_PDFVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PDFVC"];
   
//    object_PDFVC.str_pdf = _arr_pdfs[indexPath.row];;
//    object_PDFVC.str_pdfName = _arr_FileName[indexPath.row];
    
    if (indexPath.row == 0) {
        object_PDFVC.str_pdf = @"demo1";
        object_PDFVC.str_pdfName = @"Checklist.pdf";
    }
    if (indexPath.row == 1) {
        object_PDFVC.str_pdf = @"demo2";
        object_PDFVC.str_pdfName = @"Compliance.pdf";
    }
    if (_arr_pdfs.count >1) {
        if (indexPath.row == 2) {
            object_PDFVC.str_pdf = _arr_pdfs[1];
            object_PDFVC.str_pdfName = [NSString stringWithFormat:@"SUT_%@", [_arr_pdfs[1] lastPathComponent]];
        }
    }
    
    object_PDFVC.str_pdfName = [_arr_pdfs[indexPath.row] lastPathComponent];
    object_PDFVC.str_pdf = [_arr_pdfs objectAtIndex:indexPath.row];
    
    
    [self.navigationController pushViewController:object_PDFVC animated:YES];
}
-(void)action_Back:(id)sender
{
//    if ([[self.navigationController.viewControllers firstObject] isKindOfClass:[HistoryViewController class]])
//    {
//        [self.navigationController popToViewController:[[self.navigationController viewControllers]objectAtIndex:0] animated:YES];
//    }
//    else if([[self.navigationController.viewControllers firstObject] isKindOfClass:[PatientViewController class]])
//    {
//        [self.navigationController popToViewController:[[self.navigationController viewControllers]objectAtIndex:1] animated:YES];
//    }
//    else{
//        [self.navigationController popToViewController:[[self.navigationController viewControllers]objectAtIndex:2] animated:YES];
//    }
[self.navigationController popViewControllerAnimated:YES];
}
-(void)action_Nuance:(id)sender
{
    view_customAlert.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.90];
    
    view_customAlert.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.25 delay:.06 options:UIViewAnimationOptionCurveEaseOut animations:^{
        view_customAlert.transform = CGAffineTransformIdentity;
        [self.view addSubview:view_customAlert];
    } completion:^(BOOL finished)
     {
         // do something once the animation finishes, put it here
     }];

}
-(void)profileInfo:(UIButton*)sender
{
    switch (sender.tag) {
        case 0:
            imgview_tabbarPatientSearch.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tab_patient" ofType:@"png"]];
            view_info.hidden=NO;
            DoctorVw.hidden=YES;
            InsuVw.hidden=YES;
            break;
        case 1:
            imgview_tabbarPatientSearch.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"doct_tab" ofType:@"png"]];
            view_info.hidden=YES;
            DoctorVw.hidden=NO;
            InsuVw.hidden=YES;
            break;
        case 2:
            imgview_tabbarPatientSearch.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"insurance_tab" ofType:@"png"]];
           view_info.hidden=YES;
            DoctorVw.hidden=YES;
            InsuVw.hidden=NO;
            break;
        default:
            break;
    }
 
}
-(IBAction)closeCustoview:(id)sender
{
    [UIView transitionWithView:self.view
                      duration:0.50
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^
     {
         [view_customAlert removeFromSuperview];
     }
                    completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
