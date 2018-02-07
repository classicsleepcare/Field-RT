//
//  SearchReferralViewController.h
//  RAP APP
//
//  Created by Anil Prasad on 5/20/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SearchPatientViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SearchReferralViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPopoverControllerDelegate>

{
    IBOutlet UILabel *lbl_swipeLeft;
    IBOutlet UILabel *lbl_swipeRight;
    __weak IBOutlet UIImageView *imageViewForwardArrow;
    __weak IBOutlet UIImageView *imageView_backArrow;
    __weak IBOutlet UIPageControl *btn_pageControl;
    
    __weak IBOutlet UITableView *tabel_searchePatientOne;
    __weak IBOutlet UITableView *tabel_searchePatientSecond;
    
    __weak IBOutlet UIView *view_RightHeaderButtons;
    __weak IBOutlet UIView *view_LeftHeaderButtons;
        
    IBOutlet UILabel *lbl_showCount;
    IBOutlet UILabel *lbl_showSelectedValue;
    NSArray *arr_Dropdownlist;
    UIPopoverController *popover;
   
 UITableView *tbl_Data;
   
 
    
    __weak IBOutlet UIButton *btn_leftLastName;
    __weak IBOutlet UIButton *btn_leftFirstName;
    __weak IBOutlet UIButton *btn_referraldate;
    __weak IBOutlet UIButton *btn_appdate;
    __weak IBOutlet UIButton *btn_setupDate;
    __weak IBOutlet UIButton *btn_doctor;
    __weak IBOutlet UIButton *btn_insurance;
    __weak IBOutlet UIButton *btn_status;
    
    __weak IBOutlet UIButton *btn_RT;
    __weak IBOutlet UIButton *btn_mask;
    __weak IBOutlet UIButton *btn_machine;
    __weak IBOutlet UIButton *btn_secondary;
    __weak IBOutlet UIButton *btn_City;
    __weak IBOutlet UIButton *btn_rightStatus;
    __weak IBOutlet UIButton *btn_rightfirstName;
    __weak IBOutlet UIButton *btn_rightLastName;
    
    
    
}

@property(strong,nonatomic)NSArray *arr_searchedPatientList;
- (IBAction)actionBack:(id)sender;
-(IBAction)customDropDownMenu:(id)sender;
- (IBAction)action_HeaderButtons:(id)sender;
- (IBAction)actionRightHeaderButtons:(id)sender;

@end
