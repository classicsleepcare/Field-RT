//
//  NIVSetupTicket.h
//  RT APP
//
//  Created by Anil Prasad on 14/11/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "APRadioButton.h"
#import "NIVSetupTicketTwo.h"
#import "HistoryCell.h"
#import "NIVTIcketView.h"
#import "NIVTIcketModel.h"
#import "HistoryModel.h"
#import "TicketFormView.h"
#import "TicketFormModel.h"


@interface NIVSetupTicket : UIViewController<UITextFieldDelegate,UIPopoverControllerDelegate,UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate>{
    __weak IBOutlet UIScrollView *d_scrollView;

    __weak IBOutlet UIButton *btn_vendor;
    __weak IBOutlet UIButton *btn_machine_name;
    __weak IBOutlet UIButton *btn_machine_serial;
    
    __weak IBOutlet UIButton *btn_heater_vendor;
    __weak IBOutlet UIButton *btn_heater_name;
    __weak IBOutlet UIButton *btn_heater_serial;
    
    __weak IBOutlet UIButton *btn_modem_name;
    __weak IBOutlet UIButton *btn_modem_serial;
    
    __weak IBOutlet UIButton *btn_mask_name;
    __weak IBOutlet UIButton *btn_mask_size;
    
    __weak IBOutlet UIButton *btn_has_returns;
    
    __weak IBOutlet UITextField *txt_pt_name;
    __weak IBOutlet UITextField *txt_pt_address;
    __weak IBOutlet UITextField *txt_pt_city;
    __weak IBOutlet UITextField *txt_pt_email;
    __weak IBOutlet UITextField *txt_pt_primary;
    __weak IBOutlet UITextField *txt_pt_backup;
    __weak IBOutlet UITextField *txt_pt_emergency;
    __weak IBOutlet UITextField *txt_pt_dob;
    __weak IBOutlet UITextField *txt_pt_facility;
    __weak IBOutlet UITextField *txt_pt_clinician;
    
    __weak IBOutlet APRadioButton *rad_gender;
    __weak IBOutlet APRadioButton *rad_primary_ph;
    __weak IBOutlet APRadioButton *rad_backup_ph;
    
    __weak IBOutlet APRadioButton *rad_invasive_nonInvasive;
    __weak IBOutlet APRadioButton *rad_new_used;
    
    __weak IBOutlet APRadioButton *rad_invasive_nonInvasive1;
    __weak IBOutlet APRadioButton *rad_new_used1;

    __weak IBOutlet APRadioButton *rad_email;

    __weak IBOutlet UITextField *txt_machine_manufacturer;
    __weak IBOutlet UITextField *txt_machine_name;
    __weak IBOutlet UITextField *txt_machine_serial;
    __weak IBOutlet UITextField *txt_machine_model;
    
    __weak IBOutlet UITextField *txt_heater_manufacturer;
    __weak IBOutlet UITextField *txt_heater_name;
    __weak IBOutlet UITextField *txt_heater_serial;
    __weak IBOutlet UITextField *txt_heater_model;

    __weak IBOutlet UITextField *txt_modem_name;
    __weak IBOutlet UITextField *txt_modem_serial;

    __weak IBOutlet UITextField *txt_mask_name;
    __weak IBOutlet UITextField *txt_mask_size;
    __weak IBOutlet UITextField *txt_mask_id;

    __weak IBOutlet UITextView *txt_notes;
    
    CGPoint d_point;
    UITextField *universalTextField;
    
    UIView *addItemsBackgroundView;
    UIView *addItemsView;
    UITableView *addItemsTableView;
        
    // JSON for editable tables
    NSString *json1;
    NSString *json2;
    NSString *json3;
    
    // Editable Tables
    __weak IBOutlet UITableView *table_formTable;
    __weak IBOutlet UITableView *table_formTable1;
    __weak IBOutlet UITableView *table_formTable2;
    
    // Dropdown tables
    UIPopoverController *popoverCon;
    UIViewController *popoverViewCon;
    UITableViewController *dropdownsTableviewCon;
    
    // Dropdown Arrays
    NSArray *arr_dropdown;
    
    NSArray *arr_rt_vendor_listing;
    NSArray *arr_rt_machines_listing;
    NSArray *arr_machine_serial;
    
    NSArray *arr_rt_heater_listing;
    NSArray *arr_heater_name;
    NSArray *arr_heater_serial;
    
    NSArray *arr_rt_modem_listing;
    NSArray *arr_modem_serial;
    
    NSArray *arr_mask_size;
    
    // Editable table arrays
    NSMutableArray *arr_addedItems;
    NSMutableArray *arr_addedItems1;
    NSMutableArray *arr_addedItems2;
    
    UIButton *btnSearch;
    __weak IBOutlet UIButton *btn_add_returns;
    
    int indexOfDropdownCell;
    BOOL isDropdownOpened;
    int indexOfDropdownItem;
    
    int indexOfDropdownCell1;
    BOOL isDropdownOpened1;
    int indexOfDropdownItem1;
    
    int indexOfDropdownCell2;
    BOOL isDropdownOpened2;
    int indexOfDropdownItem2;
    
    int selectListNumber;
    NSMutableDictionary *temp_dict;
    
    __weak IBOutlet UILabel *lbl_returns;
    __weak IBOutlet UILabel *lbl_item_id;
    __weak IBOutlet UILabel *lbl_item_name;
    __weak IBOutlet UILabel *lbl_qty;
    __weak IBOutlet UILabel *lbl_size;
    __weak IBOutlet UILabel *lbl_desc;
    
}

@property (nonatomic, strong) NSMutableDictionary *formData;

// Editable table dataSource search table(s)
@property (nonatomic, strong) UISearchBar *mySearchBar;
@property (nonatomic, strong) UITableView *table_search;

@property (strong, nonatomic) NSMutableArray *arr_rt_item_listing;
@property (strong, nonatomic) NSMutableArray *arr_temp_item_listing;

@property (strong, nonatomic) NSMutableArray *arr_rt_item_listing1;
@property (strong, nonatomic) NSMutableArray *arr_temp_item_listing1;

@property (strong, nonatomic) NSMutableArray *arr_rt_item_listing2;
@property (strong, nonatomic) NSMutableArray *arr_temp_item_listing2;

@property (strong, nonatomic) NSArray *arr_rt_mask_listing;
@property (strong, nonatomic) NSArray *arr_rt_mask_listing_temp;
@property (strong, nonatomic) NSString *pt_id;
@property (strong, nonatomic) NSString *dr_id;
@property (strong, nonatomic) NSDictionary *dict_retrivedData, *dict_retrivedData_local;
@property (strong, nonatomic) NSString *ticket_id;

@end
