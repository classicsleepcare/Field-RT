//
//  ListOfDoctorsVC.h
//  RAP APP
//
//  Created by Anil Prasad on 4/5/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchPatientViewController.h"


@interface ListOfDoctorsVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    
    
   
    UIView *calenderVw;
    
   
    IBOutlet UILabel*lbl_docDetail_name;
    IBOutlet UILabel*lbl_docDetail_city;
    UILabel *toolTipLabel;
   
    int StoreTag;
    IBOutlet UIView *detail_view;
    IBOutlet UITableView *table_docDetail;
    IBOutlet UITableView *table_docList;
    
}


@property(nonatomic,strong)UIButton *btn_selectedHeader;

-(IBAction)addNewDoctor:(id)sender;
-(IBAction)CloseViewMethod:(id)sender;
-(IBAction)directionAndNuanceMethod:(id)sender;
-(IBAction)action_headerButton:(id)sender ;
@end
