//
//  MyStateViewController.h
//  RAP APP
//
//  Created by Anil Prasad on 4/5/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLabel.h"


@interface MyStateViewController : UIViewController

{
    __weak IBOutlet UITableView *table_monthTally;
    __weak IBOutlet UIView *view_year;
    __weak IBOutlet UIView *view_month;
    
    __weak IBOutlet UILabel *lbl_title;
    
    __weak IBOutlet UILabel *lbl_year;
    __weak IBOutlet UILabel *lbl_month;
    
    __weak IBOutlet UILabel *lbl_selectedYear;
    __weak IBOutlet UILabel *lbl_selectedMonth;
    __weak IBOutlet UILabel *lbl_selectedMonthYear;
    
    
    __weak IBOutlet CustomLabel *lbl_yearReferral;
    __weak IBOutlet CustomLabel *lbl_yearApp;
    __weak IBOutlet CustomLabel *lbl_yearDen;
    __weak IBOutlet CustomLabel *lbl_yearSetup;
    __weak IBOutlet CustomLabel *lbl_yearNSU;
    __weak IBOutlet CustomLabel *lbl_yearNSUU;
    
    __weak IBOutlet CustomLabel *lbl_MonthReferral;
    __weak IBOutlet CustomLabel *lbl_MonthApp;
    __weak IBOutlet CustomLabel *lbl_MonthDen;
    __weak IBOutlet CustomLabel *lbl_MonthSetup;
    __weak IBOutlet CustomLabel *lbl_MonthNSU;
    __weak IBOutlet CustomLabel *lbl_MonthNSUU;
    
    
    __weak IBOutlet CustomLabel *lbl_JanRef;
    __weak IBOutlet CustomLabel *lbl_JanApp;
    __weak IBOutlet CustomLabel *lbl_Janden;
    __weak IBOutlet CustomLabel *lbl_JanSetup;
    
    __weak IBOutlet CustomLabel *lbl_FebRef;
    __weak IBOutlet CustomLabel *lbl_FebApp;
    __weak IBOutlet CustomLabel *lbl_Febden;
    __weak IBOutlet CustomLabel *lbl_FebSetup;
    
    __weak IBOutlet CustomLabel *lbl_MarRef;
    __weak IBOutlet CustomLabel *lbl_MarApp;
    __weak IBOutlet CustomLabel *lbl_Marden;
    __weak IBOutlet CustomLabel *lbl_MarSetup;
    
    __weak IBOutlet CustomLabel *lbl_AprRef;
    __weak IBOutlet CustomLabel *lbl_AprApp;
    __weak IBOutlet CustomLabel *lbl_Aprden;
    __weak IBOutlet CustomLabel *lbl_AprSetup;
    
    __weak IBOutlet CustomLabel *lbl_MayRef;
    __weak IBOutlet CustomLabel *lbl_MayApp;
    __weak IBOutlet CustomLabel *lbl_Mayden;
    __weak IBOutlet CustomLabel *lbl_MaySetup;
    
    __weak IBOutlet CustomLabel *lbl_JunRef;
    __weak IBOutlet CustomLabel *lbl_JunApp;
    __weak IBOutlet CustomLabel *lbl_Junden;
    __weak IBOutlet CustomLabel *lbl_JunSetup;
    
    __weak IBOutlet CustomLabel *lbl_JulRef;
    __weak IBOutlet CustomLabel *lbl_JulApp;
    __weak IBOutlet CustomLabel *lbl_Julden;
    __weak IBOutlet CustomLabel *lbl_JulSetup;
    
    __weak IBOutlet CustomLabel *lbl_AugRef;
    __weak IBOutlet CustomLabel *lbl_AugApp;
    __weak IBOutlet CustomLabel *lbl_Augden;
    __weak IBOutlet CustomLabel *lbl_AugSetup;
    
    __weak IBOutlet CustomLabel *lbl_SepRef;
    __weak IBOutlet CustomLabel *lbl_SepApp;
    __weak IBOutlet CustomLabel *lbl_Sepden;
    __weak IBOutlet CustomLabel *lbl_SepSetup;
    
    __weak IBOutlet CustomLabel *lbl_OctRef;
    __weak IBOutlet CustomLabel *lbl_OctApp;
    __weak IBOutlet CustomLabel *lbl_Octden;
    __weak IBOutlet CustomLabel *lbl_OctSetup;
    
    __weak IBOutlet CustomLabel *lbl_NovRef;
    __weak IBOutlet CustomLabel *lbl_NovApp;
    __weak IBOutlet CustomLabel *lbl_Novden;
    __weak IBOutlet CustomLabel *lbl_NovSetup;
    
    __weak IBOutlet CustomLabel *lbl_DecRef;
    __weak IBOutlet CustomLabel *lbl_DecApp;
    __weak IBOutlet CustomLabel *lbl_Decden;
    __weak IBOutlet CustomLabel *lbl_DecSetup;
    
    
    
}
- (IBAction)actioSegment:(id)sender;

- (IBAction)action_selection:(id)sender;
- (IBAction)actionGo:(id)sender;
 

@end
