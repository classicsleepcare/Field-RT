//
//  HistoryViewController.h
//  RAP APP
//
//  Created by Anil Prasad on 4/5/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoctorViewController.h"



@interface HistoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,TabBarTextSearchDelegate>
{
   
    __weak IBOutlet UITableView *table_historyView;
    __weak IBOutlet UILabel *lbl_title;
    IBOutlet UIButton *btn_LastName;
    IBOutlet UIButton *btn_FirstName;
    IBOutlet UIButton *btn_RefDate;
    IBOutlet UIButton *btn_doctor;
    IBOutlet UIButton *btn_status;
    IBOutlet UIButton *btn_insurance;
    IBOutlet UIButton *btn_appDate;
    IBOutlet UIButton *btn_deniedDate;
    IBOutlet UIButton *btn_setupDate;
   
}
@property(nonatomic,strong)UIButton *btn_selected;
- (IBAction)actionSegmentcontrol:(id)sender;
- (IBAction)action_headerButton:(id)sender;



@end
