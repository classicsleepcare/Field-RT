//
//  SetUpTicketFormOne.h
//  RT APP
//
//  Created by Anil Prasad on 16/12/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"
#import "FormOneModel.h"
#import "CCXFormOne.h"
#import "Utils.h"

@interface SetUpTicketFormOne : UIViewController<UITextFieldDelegate,UIPopoverControllerDelegate,UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate>{
    IBOutlet UIScrollView *d_scrollView;
    IBOutlet UITableView *table_formTable;
    IBOutlet UITableView *table_formTable1;
    IBOutlet UITableView *table_formTable2;

    IBOutlet UIButton *btn_emailMe;
    IBOutlet UIButton *btn_physicalEmailMe;
    IBOutlet UIButton *btn_bothEmailMailMe;
    IBOutlet UIButton *btn_serial_number;
    IBOutlet UIButton *btn_ex_serial_number;
    IBOutlet UIButton *btn_hum_serial_number;
    IBOutlet UIButton *btn_modem_serial_number;

    NSString *json1;
    NSString *json2;
    NSString *json3;

    // Form components
    IBOutlet UITextField *txt_fName;
    IBOutlet UITextField *txt_lName;
    IBOutlet UITextField *txt_dob;
    IBOutlet UITextField *txt_streetAdd;
    IBOutlet UITextField *txt_city;
    IBOutlet UITextField *txt_zip;
    IBOutlet UITextField *txt_hPhone;
    IBOutlet UITextField *txt_cPhone;
    IBOutlet UITextField *txt_wPhone;
    IBOutlet UITextField *txt_email;
    IBOutlet UITextField *txt_CPAPmanufacturer;
    IBOutlet UITextField *txt_model;
    IBOutlet UITextField *txt_CPAPserialNo;
    IBOutlet UITextField *txt_cm;
    IBOutlet UITextField *txt_rampTime;
    IBOutlet UITextField *txt_backUpRate;
    IBOutlet UITextField *txt_modemSerialNo;
    IBOutlet UITextField *txt_humidifierManufacturer;
    IBOutlet UITextField *txt_humidifierSerialNo;
    IBOutlet UITextField *txt_maskType;
    IBOutlet UITextField *txt_maskName;
    IBOutlet UITextField *txt_maskID;
    IBOutlet UIButton *btn_addItems;
    IBOutlet UIButton *btn_next;
    
    IBOutlet UITextField *txt_rtPatient;
    IBOutlet UITextField *txt_state;
    IBOutlet UITextField *txt_rtMachine;
    IBOutlet UITextField *txt_modem;
    IBOutlet UITextField *txt_humidifierModem;
    IBOutlet UITextField *txt_mask;
    
    
    
    __weak IBOutlet UITextField *prev_machine_name;
    __weak IBOutlet UITextField *prev_serial;
    
    IBOutlet UITextField *txt_ex_pick_machine;
    IBOutlet UITextField *txt_ex_machine;
    IBOutlet UITextField *txt_ex_manufacturer;
    IBOutlet UITextField *txt_ex_machine_serial;
    IBOutlet UITextField *txt_ex_hum_serial;
    IBOutlet UITextField *txt_ex_modem_seral;
    IBOutlet UITextField *txt_ex_rt_machine;
    IBOutlet UITextField *txt_ex_rt_manufacturer;
    IBOutlet UITextField *txt_ex_rt_serial;
    IBOutlet UITextField *txt_ex_rt_reference;
    IBOutlet UIView *exchanegView;
    
    IBOutlet UIButton *btn_rtPatient;
    IBOutlet UIButton *btn_state;
    IBOutlet UIButton *btn_rtMachine;
    IBOutlet UIButton *btn_manufacturer;
    IBOutlet UIButton *btn_modem;
    IBOutlet UIButton *btn_humidifierModem;
    IBOutlet UIButton *btn_mask;
    IBOutlet UILabel *lbl_ticketId;
    
    IBOutlet UIButton *btn_delete;
    IBOutlet UIButton *btn_submit;
    IBOutlet UIButton *btn_save;
    IBOutlet UILabel *lbl_readOnly;
    
    NSString *common_serialNum;

    UIView *addItemsBackgroundView;
    UIView *addItemsView;
    UITableView *addItemsTableView;
    
    NSMutableArray *arr_addedItems;
    NSMutableArray *arr_addedItems1;
    NSMutableArray *arr_addedItems2;

    FormOneModel *model;
    
    IBOutlet UIImageView *suppliesHeader;
    
    UIPopoverController *popoverCon;
    UIViewController *popoverViewCon;
    UITableViewController *dropdownsTableviewCon;
    
    UITextField *universalTextField;
    IBOutlet UIView *disableFormView;
    IBOutlet UIView *disableFormView2;

    int selectListNumber;
    NSString *pt_ID;
    NSString *cpap_item_id;
    NSString *modem_item_id;
    NSString *hum_item_id;
    
    IBOutlet UIView *view_machine;
    IBOutlet UITextView *txt_notes;
    
    IBOutlet UIView *cpap_view;
    IBOutlet UIView *cpap_auto_view;

    IBOutlet UIView *auto_view;

    IBOutlet UIView *stand_view;
    IBOutlet UIView *auto_ResMed_view;
    IBOutlet UIView *auto_sv_view;
    IBOutlet UIView *st_view;
    
    IBOutlet UITextField *txt_cpap_cm;
    IBOutlet UITextField *txt_cpap_ramp;
    
    IBOutlet UITextField *txt_cpap_auto_ramp;
    IBOutlet UITextField *txt_cpap_auto_low;
    IBOutlet UITextField *txt_cpap_auto_high;
    
    IBOutlet UITextField *txt_std_ramp;
    IBOutlet UITextField *txt_std_ipap;
    IBOutlet UITextField *txt_std_epap;
    
    IBOutlet UITextField *txt_auto_ramp;
    IBOutlet UITextField *txt_auto_epap;
    IBOutlet UITextField *txt_auto_ipap;
    IBOutlet UITextField *txt_auto_pres_sup_min;
    IBOutlet UITextField *txt_auto_pres_sup_max;
    
    IBOutlet UITextField *txt_auto_sv_ramp;
    IBOutlet UITextField *txt_auto_sv_epap_min;
    IBOutlet UITextField *txt_auto_sv_epap_max;
    IBOutlet UITextField *txt_auto_sv_backup;
    IBOutlet UITextField *txt_auto_sv_pres_sup_min;
    IBOutlet UITextField *txt_auto_sv_pres_sup_max;
    IBOutlet UITextField *txt_auto_sv_max_pres_sup;
    
    IBOutlet UITextField *txt_st_ramp;
    IBOutlet UITextField *txt_st_ipap;
    IBOutlet UITextField *txt_st_epap;
    IBOutlet UITextField *txt_st_backup;
    
    
    IBOutlet UILabel *lbl_auto_sv_bpm;
    IBOutlet UIImageView *img_auto_sv_bpm;
    
        
    IBOutlet UIView *biLevelView0_one;
    IBOutlet UIView *biLevelView1_one;
    
    IBOutlet UIView *biLevelView0;
    IBOutlet UIView *biLevelView1;
    
    UIButton *btnSearch;
    
    IBOutlet UILabel *lbl_fName;
    IBOutlet UILabel *lbl_lName;
    IBOutlet UILabel *lbl_dob;
    IBOutlet UILabel *lbl_streetAdd;
    IBOutlet UILabel *lbl_city;
    IBOutlet UILabel *lbl_zip;
    IBOutlet UILabel *lbl_hPhone;
    IBOutlet UILabel *lbl_cPhone;
    IBOutlet UILabel *lbl_wPhone;
    IBOutlet UILabel *lbl_email;
    IBOutlet UILabel *lbl_state;
//    IBOutlet UILabel *lbl_male;
//    IBOutlet UILabel *lbl_female;
//    IBOutlet UILabel *lbl_spanish;
    
    IBOutlet UILabel *lbl_rtMachine;
    IBOutlet UILabel *lbl_rtManufacturer;
    IBOutlet UILabel *lbl_rtReference;
    IBOutlet UILabel *lbl_rtSerialNo;
    
    IBOutlet UILabel *lbl_humidifierManufacturer;
    IBOutlet UILabel *lbl_humidifierSerialNo;
    
    IBOutlet UILabel *lbl_modemSerialNo;
    
    IBOutlet UILabel *lbl_maskID;
    IBOutlet UILabel *lbl_maskSize;
    IBOutlet UIButton *btn_mask_size;
    int tag1;
    
    IBOutlet UIView *view_dropdown_hide;
    IBOutlet UIView *view_ex_dropdown_hide;
    
    NSString *json_supplies;
    NSString *json_discardedItems;
    NSString *json_additonalSupplies;
    
    NSMutableArray *removedSupplyObjects;
    NSMutableArray *removedSupplyObjects1;
    NSMutableArray *removedSupplyObjects2;


}

@property (nonatomic, strong) UISearchBar *mySearchBar;
@property (nonatomic, strong) UITableView *table_search;

@property (strong, nonatomic) IBOutletCollection(RadioButton) NSArray *wireRadio;
@property (strong, nonatomic) IBOutletCollection(RadioButton) NSArray *maleFemaleRadio;

@property (strong, nonatomic) IBOutletCollection(RadioButton) NSArray *biLevelRadio_One;
@property (strong, nonatomic) IBOutletCollection(RadioButton) NSArray *biLevelRadio_Options_One;

@property (strong, nonatomic) IBOutletCollection(RadioButton) NSArray *biLevelRadio;
@property (strong, nonatomic) IBOutletCollection(RadioButton) NSArray *biLevelRadio_Options;


@property (strong, nonatomic) IBOutletCollection(RadioButton) NSArray *cpap_new_old_dmeRadio;
@property (strong, nonatomic) IBOutletCollection(RadioButton) NSArray *cpap_auto_biLevelRadio;


@property (weak,nonatomic) IBOutlet UIButton *btn_spanish;
@property (weak,nonatomic) IBOutlet UIButton *btn_cpapAuto;

-(IBAction)checkUncheckBtnSpanish:(id)sender;
-(IBAction)checkUncheckBtnEmailMe:(id)sender;
-(IBAction)checkUncheckBtnPhysicalMailMe:(id)sender;
-(IBAction)checkUncheckBtnBothEmailMail:(id)sender;


-(IBAction)radioCpapAuto:(UIButton*)sender;

@property (strong, nonatomic) NSDictionary *dict;
@property (strong, nonatomic) NSMutableArray *arr_rt_item_listing;
@property (strong, nonatomic) NSMutableArray *arr_temp_item_listing;

@property (strong, nonatomic) NSMutableArray *arr_rt_item_listing1;
@property (strong, nonatomic) NSMutableArray *arr_temp_item_listing1;

@property (strong, nonatomic) NSMutableArray *arr_rt_item_listing2;
@property (strong, nonatomic) NSMutableArray *arr_temp_item_listing2;
@property (strong, nonatomic) NSArray *arr_rt_serial_numbers;
@property (strong, nonatomic) NSArray *arr_rt_exSerial_numbers;

@property (strong, nonatomic) NSDictionary *temp_cellDict;

@property (strong, nonatomic) NSArray *arr_rt_listing;
@property (strong, nonatomic) NSArray *arr_rt_patient_listing;
@property (strong, nonatomic) NSArray *arr_rt_machines_listing;
@property (strong, nonatomic) NSMutableArray *arr_rt_old_machines_listing;

@property (strong, nonatomic) NSArray *arr_rt_new_machines_listing;
@property (strong, nonatomic) NSArray *arr_rt_mask_listing;
@property (strong, nonatomic) NSArray *arr_rt_mask_listing_temp;

@property (strong, nonatomic) NSArray *arr_rt_states;
@property (strong, nonatomic) NSArray *arr_rt_modem;
@property (strong, nonatomic) NSArray *arr_rt_H_modem;
@property (strong, nonatomic) NSArray *arr_dropdown;
@property (strong, nonatomic) NSArray *arr_mask_size_fitPack;
@property (strong, nonatomic) NSArray *arr_mask_size_WISP;
@property (strong, nonatomic) NSArray *arr_rt_vendor_listing;

@property (strong, nonatomic) NSMutableArray *arr_rt_new_machines_cpap;
@property (strong, nonatomic) NSMutableArray *arr_rt_new_machines_cpap_auto;
@property (strong, nonatomic) NSMutableArray *arr_rt_new_machines_stand;
@property (strong, nonatomic) NSMutableArray *arr_rt_new_machines_auto;
@property (strong, nonatomic) NSMutableArray *arr_rt_new_machines_auto_sv;
@property (strong, nonatomic) NSMutableArray *arr_rt_new_machines_st;
@property (strong, nonatomic) NSMutableArray *arr_rt_supply_listing;


@property (strong, nonatomic) NSArray *arr_machine_dropdown;
@property (strong, nonatomic) NSArray *arr_modem_dropdown;
@property (strong, nonatomic) NSArray *arr_hum_modem_dropdown;


@property (strong, nonatomic) NSMutableArray *arr_fromInventory;

@property (nonatomic) BOOL isNewTicket;
@property (nonatomic) BOOL isFromInventory;
@property (nonatomic) BOOL isNotSubmitted;
@property (nonatomic) BOOL isFromSchedule;
@property (nonatomic) BOOL is_Auto_ResMed;
@property (nonatomic) BOOL is_Auto_SV_Respironics;
@property (nonatomic) BOOL is_ST_Respironics;
@property (nonatomic) BOOL isFitPack;

@property (nonatomic, strong) NSDictionary *dict_patient;

@end
