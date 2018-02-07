//
//  NIVSetupTicket.m
//  RT APP
//
//  Created by Anil Prasad on 14/11/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import "NIVSetupTicket.h"

@interface NIVSetupTicket ()

@end

@implementation NIVSetupTicket
@synthesize formData, dict_retrivedData, dict_retrivedData_local;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    d_scrollView.contentSize            = CGSizeMake(880, 4445); // 1950
    d_scrollView.contentOffset          = CGPointMake(0,0);
    arr_mask_size = [[NSArray alloc] initWithObjects:@"NA", @"Petite/XSmall", @"Small", @"S/M", @"Medium", @"Large", @"XLarge", nil];
    
    popoverViewCon                              = [[UIViewController alloc]init];
    dropdownsTableviewCon                       = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    popoverViewCon.preferredContentSize         = CGSizeMake(200,500);
    dropdownsTableviewCon.clearsSelectionOnViewWillAppear = NO;
    dropdownsTableviewCon.tableView.tag         = 123; // NOT USED
    dropdownsTableviewCon.tableView.delegate    = self;
    dropdownsTableviewCon.tableView.dataSource  = self;
    dropdownsTableviewCon.tableView.frame       = CGRectMake(0, 0, CGRectGetWidth(popoverViewCon.view.bounds),
                                                             CGRectGetHeight(popoverViewCon.view.bounds));
    
    [popoverViewCon.view addSubview:dropdownsTableviewCon.tableView];
    popoverCon                                  = [[UIPopoverController alloc] initWithContentViewController:popoverViewCon];
    
    arr_addedItems = [NSMutableArray new];
    arr_addedItems1 = [NSMutableArray new];
    arr_addedItems2 = [NSMutableArray new];

    formData = [NSMutableDictionary new];
    temp_dict = [NSMutableDictionary new];
    
    btn_add_returns.alpha = 0.3;
    lbl_returns.alpha = 0.3;
    lbl_item_id.alpha = 0.3;
    lbl_item_name.alpha = 0.3;
    lbl_qty.alpha = 0.3;
    lbl_size.alpha = 0.3;
    lbl_desc.alpha = 0.3;
    
    
    [Utils uncheckBoxes:@[btn_has_returns]];
//    self.pt_id = @"53377";
    [self getPatientDetails:self.pt_id];
//
//    if (![self.ticket_id isEqualToString:@"0"]) {
//        [self retriveSetupTicket:self.ticket_id];
//    }
//    else{
//        [self getPatientDetails:self.pt_id];
//    }
//    self.ticket_id = @"76499702";
//   [self retriveSetupTicket:self.ticket_id];
}

#pragma mark -
#pragma mark - Checkboxes
-(IBAction)checkUncheck:(UIButton*)sender{
    btn_add_returns.enabled = [Utils performCheckboxSelection:sender];
    
    if (btn_add_returns.enabled == true) {
        btn_add_returns.alpha = 1.0;
        lbl_returns.alpha = 1.0;
        lbl_item_id.alpha = 1.0;
        lbl_item_name.alpha = 1.0;
        lbl_qty.alpha = 1.0;
        lbl_size.alpha = 1.0;
        lbl_desc.alpha = 1.0;
    }
    else{
        btn_add_returns.alpha = 0.3;
        lbl_returns.alpha = 0.3;
        lbl_item_id.alpha = 0.3;
        lbl_item_name.alpha = 0.3;
        lbl_qty.alpha = 0.3;
        lbl_size.alpha = 0.3;
        lbl_desc.alpha = 0.3;
        [arr_addedItems2 removeAllObjects];
        [table_formTable2 reloadData];
    }
}

#pragma mark -
#pragma mark - API Calls

-(void)retriveSetupTicket:(NSString*)ticket_id{
    NIVTIcketView *object_TV = [NIVTIcketView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("SUTII", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    
    dispatch_async(myQueue, ^{
        NSDictionary *dicti =[object_TV retriveSetupTicketData:@{@"rt_id":RT_ID, @"ticket_id": ticket_id}];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            dict_retrivedData = dicti[@"data"];
            dict_retrivedData_local = dict_retrivedData[@"setup_ticket"];
            NSLog(@"MESSAGE: %@", dict_retrivedData_local);

            if(dicti)
            {
                if ([dicti[@"error"] isEqualToString:@"0"]) {
                    
                }
                else{
                    [[AppDelegate sharedInstance] showAlertMessage:dicti[@"msg"]];
                }
            }
        });
    });
}

-(void)getPatientDetails:(NSString*)pt_id{
    [[AppDelegate sharedInstance] showCustomLoader:self];
    NIVTIcketView *object_HV = [NIVTIcketView new];
    NSDictionary *dict1              = [object_HV getPatientDetails:pt_id];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[AppDelegate sharedInstance] removeCustomLoader];
        if(dict1)
        {
            HistoryModel *object_HM = [[HistoryModel alloc]initWithDictionaryForPatientDetail:dict1];
            NSDictionary *pt_info = object_HM.dict_profileInfo;
            NSDictionary *dr_info = object_HM.dict_docInfo;
            
            [temp_dict setObject:pt_info[@"Pt_First"] forKey:@"Pt_First"];
            [temp_dict setObject:pt_info[@"Pt_Middle"] forKey:@"Pt_Middle"];
            [temp_dict setObject:pt_info[@"Pt_Last"] forKey:@"Pt_Last"];
            [temp_dict setObject:pt_info[@"Pt_ID"] forKey:@"Pt_ID"];
            [temp_dict setObject:dr_info[@"Dr_ID"] forKey:@"Dr_ID"];
            
            txt_pt_name.text = [NSString stringWithFormat:@"%@ %@", pt_info[@"Pt_First"], pt_info[@"Pt_Last"]];
            txt_pt_dob.text = pt_info[@"Pt_Birth_Date"];
            
            if ([pt_info[@"Pt_Sex"] isEqualToString:@"M"]) {
                [rad_gender setSelectedWithTag:0];
            }
            else{
                [rad_gender setSelectedWithTag:1];
            }
            
            txt_pt_address.text = pt_info[@"Pt_Add1"];
            txt_pt_city.text = [NSString stringWithFormat:@"%@ %@ %@", NonNilString(pt_info[@"Pt_City"]), NonNilString(pt_info[@"Pt_State"]), NonNilString(pt_info[@"Pt_Zip"])];
            txt_pt_email.text = pt_info[@"Pt_Email"];
            
            if (![pt_info[@"Pt_Home"] isEqualToString:@""]){
                txt_pt_primary.text = pt_info[@"Pt_Home"];
                [rad_primary_ph setSelectedWithTag:2];
            }
            else if (![pt_info[@"Pt_Cell"] isEqualToString:@""]) {
                txt_pt_primary.text = pt_info[@"Pt_Cell"];
                [rad_primary_ph setSelectedWithTag:0];
            }
            else if (![pt_info[@"Pt_Work"] isEqualToString:@""]){
                txt_pt_primary.text = pt_info[@"Pt_Work"];
                [rad_primary_ph setSelectedWithTag:1];
            }
            else{
                
            }
            
            if (![pt_info[@"Pt_Cell"] isEqualToString:@""]) {
                txt_pt_backup.text = pt_info[@"Pt_Cell"];
                [rad_backup_ph setSelectedWithTag:0];
            }
            else if (![pt_info[@"Pt_Home"] isEqualToString:@""]){
                txt_pt_backup.text = pt_info[@"Pt_Home"];
                [rad_backup_ph setSelectedWithTag:2];
            }
            else if (![pt_info[@"Pt_Work"] isEqualToString:@""]){
                txt_pt_backup.text = pt_info[@"Pt_Work"];
                [rad_backup_ph setSelectedWithTag:1];
            }
            else{
                
            }
            
            txt_pt_facility.text = [NSString stringWithFormat:@"%@ %@ %@", NonNilString(dr_info[@"Dr_First"]), NonNilString(dr_info[@"Dr_Middle"]), NonNilString(dr_info[@"Dr_Last"])];
            txt_pt_clinician.text = [NSString stringWithFormat:@"%@ %@ %@", NonNilString(dr_info[@"Dr_First"]), NonNilString(dr_info[@"Dr_Middle"]), NonNilString(dr_info[@"Dr_Last"])];
            
            // SAVEDATA METHOD
            [formData setObject:dr_info[@"fac_id"] forKey:@"facility_id"];
            [formData setObject:dr_info[@"Dr_ID"] forKey:@"clinician_id"];
            //
            [self callWebserviceForDropdowns];
        }
        
    });
}

-(void)callWebserviceForDropdowns{
    
    TicketFormView *object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Dropdown", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        NSDictionary *dicti =[object_TV getArraysForDropdowns:RT_ID];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                NIVTIcketModel *object_TM = [[NIVTIcketModel alloc] initWithDictionary:dicti];
                [self responseDataOfDropdowns:object_TM];
            }
        });
    });
}

-(void)responseDataOfDropdowns:(NIVTIcketModel*)object{
    arr_rt_vendor_listing        = object.arr_rt_vendor_listing;

    NSDictionary *naDict         = @{@"cpap_type": @"NA",
                                     @"item_id": @"NA",
                                     @"item_name": @"NA",
                                     @"serialized": @"NA",
                                     @"type": @"NA",
                                     @"vendor_id": @"NA",
                                     @"vendor_name": @"NA"};
    
    NSMutableArray *temp_heater  = [@[naDict]mutableCopy];
    [temp_heater addObjectsFromArray:object.arr_rt_heater_listing];
    arr_rt_heater_listing        = temp_heater;
    
    NSMutableArray *temp_modem   = [@[naDict]mutableCopy];
    [temp_modem addObjectsFromArray:object.arr_rt_modem_listing];
    arr_rt_modem_listing         = temp_modem;
    
    
    NSMutableArray *temp_mask    = [[NSMutableArray alloc] initWithArray:object.arr_rt_mask_listing];
    NSDictionary *na_mask        = @{@"item_id":@"NA",
                                     @"isFitPack":@"0",
                                     @"mask_id":@"NA",
                                     @"mask_name":@"NA"};
    [temp_mask insertObject:na_mask atIndex:0];
    self.arr_rt_mask_listing      = temp_mask;
    self.arr_rt_mask_listing_temp = temp_mask;
}

-(void)callWebserviceForMachineListingOfVendor:(NSString*)vendor_id{
    
    TicketFormView *object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Dropdown", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        NSDictionary *dicti =[object_TV getMachineListing:RT_ID OfVendor:vendor_id];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM = [[TicketFormModel alloc] initWithDictionary:dicti];
                arr_rt_machines_listing   = object_TM.arr_rt_machines_listing;
                [dropdownsTableviewCon.tableView reloadData];
            }
        });
    });
}

-(void)getSerialNumbersOfItem:(NSDictionary*)dictInfo tag:(int)tag{
    TicketFormView *object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("ModemSerial", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dicti =[object_TV getArraysOfSerialNumbers:RT_ID itemID:dictInfo[@"item_id"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM = [[TicketFormModel alloc] initWithDictionary:dicti];
                
                switch (tag) {
                    case 12:{
                        arr_machine_serial = object_TM.arr_rt_serial_numbers;
                        txt_machine_serial.text = object_TM.arr_rt_serial_numbers[0];
                        
                        NSString *heater_id         = dictInfo[@"humidifier"];
                        for (NSDictionary *he_dict in arr_rt_heater_listing) {
                            if ([he_dict[@"item_id"] isEqualToString:heater_id]) {
                                txt_heater_name.text             = he_dict[@"item_name"];
                                txt_heater_manufacturer.text     = he_dict[@"vendor_name"];
                                txt_heater_model.text            = he_dict[@"item_id"];
                                //heater_id                        = him_dict[@"item_id"];
                                
                                btn_heater_serial.enabled = YES;
                            }
                        }
                        if ([txt_heater_name.text isEqualToString:@""]) {
                            btn_heater_name.enabled = YES;
                            btn_heater_vendor.enabled = YES;
                            btn_heater_serial.enabled = YES;
                        }
                        
                        NSString *modem_id              = dictInfo[@"modem"];
                        for (NSDictionary *modem_dict in arr_rt_modem_listing) {
                            if ([modem_dict[@"item_id"] isEqualToString:modem_id]) {
                                txt_modem_name.text              = modem_dict[@"item_name"];
                                //modem_item_id                    = modem_dict[@"item_id"];
                                
                                btn_modem_serial.enabled = YES;
                            }
                        }
                        if ([txt_modem_name.text isEqualToString:@""]) {
                            btn_modem_name.enabled = YES;
                            btn_modem_serial.enabled = YES;
                        }
                        
                        [self getSerialOfHeater:heater_id modemID:modem_id machine_name:dictInfo[@"item_name"]];
                    }
                        break;
                    case 23:{
                        arr_heater_serial = object_TM.arr_rt_serial_numbers;
                        txt_heater_serial.text = object_TM.arr_rt_serial_numbers[0];
                    }
                        break;
                    case 32:{
                        arr_modem_serial = object_TM.arr_rt_serial_numbers;
                        txt_modem_serial.text = object_TM.arr_rt_serial_numbers[0];
                    }
                        break;
                        
                    default:
                        break;
                }
                
            }
        });
    });
}

-(void)getSerialOfHeater:(NSString*)heater_id modemID:(NSString*)modemItemId machine_name:(NSString*)machine_name{
    TicketFormView *object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("ModemSerial", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dicti =[object_TV getArraysOfSerialNumbers:RT_ID itemID:heater_id];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM = [[TicketFormModel alloc] initWithDictionary:dicti];
                
                arr_heater_serial = object_TM.arr_rt_serial_numbers;
                txt_heater_serial.text = object_TM.arr_rt_serial_numbers[0];
                
                [self getSerialOfModem:modemItemId item_name:machine_name];
            }
        });
    });
}

-(void)getSerialOfModem:(NSString*)itemId item_name:(NSString*)machine_name{
    TicketFormView *object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("ModemSerial", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dicti =[object_TV getArraysOfSerialNumbers:RT_ID itemID:itemId];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM = [[TicketFormModel alloc] initWithDictionary:dicti];
                arr_modem_serial = object_TM.arr_rt_serial_numbers;
                txt_modem_serial.text = object_TM.arr_rt_serial_numbers[0];
            }
        });
    });
}

#pragma mark -
#pragma mark - API-Items


-(void)callWebServiceForAvailableItems:(NSString*)ID table:(UIButton*)sender{
    
    TicketFormView *object_TV                   = [TicketFormView new];
    dispatch_queue_t myQueue    = dispatch_queue_create("ItemsList", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dicti     = [object_TV getAllItemsListOfRT:ID];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM = [[TicketFormModel alloc] initWithDictionary:dicti];
                [self responseDataOfAvailableItems:object_TM table:sender];
            }
        });
    });
    
}

-(void)responseDataOfAvailableItems:(TicketFormModel*)object table:(UIButton*)sender{
    
    NSDictionary *added_Items = @{@"item_id":@"NA",
                                  @"item_name":@"NA",
                                  @"size":@"NA",
                                  @"quantity":@"NA",
                                  @"adtnl_items":@"NA"};
    if (sender.tag == 120) {
        self.arr_rt_item_listing    = [object.arr_rt_item_listing mutableCopy];
        self.arr_temp_item_listing  = self.arr_rt_item_listing;
        [self.arr_rt_item_listing insertObject:added_Items atIndex:0];
    }
    if (sender.tag == 130) {
        
        self.arr_rt_item_listing1    = [object.arr_rt_item_listing mutableCopy];
        self.arr_temp_item_listing1  = self.arr_rt_item_listing1;
        [self.arr_rt_item_listing1 insertObject:added_Items atIndex:0];
        
    }
    if (sender.tag == 140) {
        self.arr_rt_item_listing2    = [object.arr_rt_item_listing mutableCopy];
        self.arr_temp_item_listing2  = self.arr_rt_item_listing2;
        [self.arr_rt_item_listing2 insertObject:added_Items atIndex:0];
        
    }
    [self.table_search reloadData];
    
}


#pragma mark -
#pragma mark - AUTO FILL
-(void)autoFillForm{
    txt_pt_primary.text = dict_retrivedData_local[@"primary_phone"];
    txt_pt_backup.text = dict_retrivedData_local[@"backup_phone"];
    if ([dict_retrivedData_local[@"primary_phone_type"] isEqualToString:@"0"]) {
        [rad_primary_ph setSelectedWithTag:0];
    } else if ([dict_retrivedData_local[@"primary_phone_type"] isEqualToString:@"1"]) {
        [rad_primary_ph setSelectedWithTag:1];
    } else if ([dict_retrivedData_local[@"primary_phone_type"] isEqualToString:@"2"]) {
        [rad_primary_ph setSelectedWithTag:2];
    }
    if ([dict_retrivedData_local[@"backup_phone_type"] isEqualToString:@"0"]) {
        [rad_backup_ph setSelectedWithTag:0];
    } else if ([dict_retrivedData_local[@"backup_phone_type"] isEqualToString:@"1"]) {
        [rad_backup_ph setSelectedWithTag:1];
    } else if ([dict_retrivedData_local[@"backup_phone_type"] isEqualToString:@"2"]) {
        [rad_backup_ph setSelectedWithTag:2];
    }
    txt_pt_emergency.text = dict_retrivedData_local[@"emergency_contact_name_phone"];
    
   // [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_invasive_nonInvasive.selectedButton.tag] forKey:@"vent_equipment_type"];
  //  [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_new_used.selectedButton.tag] forKey:@"vent_equipment_new_used"]; // [ 0:New;, 1:Used; ]
    
   txt_machine_manufacturer.text = dict_retrivedData_local[@"vent_equipment_machine_manuf"];
    txt_machine_model.text  = dict_retrivedData_local[@"vent_equipment_machine_model"];
    txt_machine_serial.text = dict_retrivedData_local[@"vent_equipment_machine_serial"];
    
    txt_heater_manufacturer.text = dict_retrivedData_local[@"vent_equipment_heater_manuf"];
    txt_heater_model.text = dict_retrivedData_local[@"vent_equipment_heater_model"];
    txt_heater_serial.text = dict_retrivedData_local[@"vent_equipment_heater_serial"];
  
    
 //   [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_has_returns] ? @"1": @"0"] forKey:@"has_returns"]; // [ 0:No returns;, 1:Has Returns; ]
    
    if ([dict_retrivedData_local[@"has_returns"] isEqualToString:@"1"]) {
        [Utils checkBox:btn_has_returns];
    } else if ([dict_retrivedData_local[@"has_returns"] isEqualToString:@"0"]) {
        [Utils uncheckBox:btn_has_returns];
    }
    
    txt_mask_name.text = dict_retrivedData_local[@"mask_name"];
    txt_mask_id.text = dict_retrivedData_local[@"mask_id"];
    txt_mask_size.text = dict_retrivedData_local[@"mask_size"];
}
#pragma mark -
#pragma mark - SAVE

-(void)saveFormData{
    
    [formData setObject:NonNilString(txt_pt_primary.text) forKey:@"primary_phone"];
    [formData setObject:NonNilString(txt_pt_backup.text) forKey:@"backup_phone"];

    switch (rad_primary_ph.selectedButton.tag) {
        case 0:
            [formData setObject:@"0" forKey:@"primary_phone_type"]; // [ 0:Cell;, 1:Work;, 2:Home; ]
            break;
        case 1:
            [formData setObject:@"1" forKey:@"primary_phone_type"]; // [ 0:Cell;, 1:Work;, 2:Home; ]
            break;
        case 2:
            [formData setObject:@"2" forKey:@"primary_phone_type"]; // [ 0:Cell;, 1:Work;, 2:Home; ]
            break;
        default:
            break;
    }
    
    switch (rad_backup_ph.selectedButton.tag) {
        case 0:
            [formData setObject:@"0" forKey:@"backup_phone_type"]; // [ 0:Cell;, 1:Work;, 2:Home; ]
            break;
        case 1:
            [formData setObject:@"1" forKey:@"backup_phone_type"]; // [ 0:Cell;, 1:Work;, 2:Home; ]
            break;
        case 2:
            [formData setObject:@"2" forKey:@"backup_phone_type"]; // [ 0:Cell;, 1:Work;, 2:Home; ]
            break;
        default:
            break;
    }
    
    [formData setObject:NonNilString(txt_pt_emergency.text) forKey:@"emergency_contact_name_phone"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_invasive_nonInvasive.selectedButton.tag] forKey:@"vent_equipment_type"];
    [formData setObject:[NSString stringWithFormat:@"%d", (int)rad_new_used.selectedButton.tag] forKey:@"vent_equipment_new_used"]; // [ 0:New;, 1:Used; ]
    
    [formData setObject:NonNilString(txt_machine_manufacturer.text) forKey:@"vent_equipment_machine_manuf"];
    [formData setObject:NonNilString(txt_machine_model.text) forKey:@"vent_equipment_machine_model"];
    [formData setObject:NonNilString(txt_machine_serial.text) forKey:@"vent_equipment_machine_serial"];
    
    [formData setObject:NonNilString(txt_heater_manufacturer.text) forKey:@"vent_equipment_heater_manuf"];
    [formData setObject:NonNilString(txt_heater_model.text) forKey:@"vent_equipment_heater_model"];
    [formData setObject:NonNilString(txt_heater_serial.text) forKey:@"vent_equipment_heater_serial"];
    [formData setObject:[NSString stringWithFormat:@"%@", [Utils isChecked:btn_has_returns] ? @"1": @"0"] forKey:@"has_returns"]; // [ 0:No returns;, 1:Has Returns; ]
    
#pragma mark - -------------------------------------------------------------PENDING
//    [formData setObject:@"test" forKey:@"mask_type"];
    [formData setObject:NonNilString(txt_mask_name.text) forKey:@"mask_name"];
    [formData setObject:NonNilString(txt_mask_id.text) forKey:@"mask_id"];
    [formData setObject:NonNilString(txt_mask_size.text) forKey:@"mask_size"];
    //[formData setObject:@"" forKey:@"mask_manuf"];
    
    /*
     arr_addedItems = Supplies
     arr_addedItems1 = Discarded Items
     arr_addedItems2 = Returns
    
     Send Discarded items with Supplies ["item_cat":"0" = Supplies; "item_cat":"1" = Discarded items]
     Eg.
     [{"item_id":"36003","item_type":"Normal","item_name":"S9 Elite","quantity":"1","size":"SM","description":"S9 Elite","item_cat":"0"},
     {"item_id":"36004","item_type":"Normal","item_name":"S9 Elite","quantity":"1","size":"M","description":"S9 Elite","item_cat":"1"}]
     */
    
//    [formData setObject:[Utils createJSON:arr_addedItems2] forKey:@"json_returns"]; // JSON String [Returns]
//
//    NSMutableArray *arr_discarded_items = [NSMutableArray new];
//    for (NSMutableDictionary *dict1 in arr_addedItems1) {
//        [dict1 setObject:@"1" forKey:@"item_cat"];
//        [arr_discarded_items addObject:dict1];
//    }
//    NSMutableArray *arr_niv_supplies = [NSMutableArray new];
//    for (NSMutableDictionary *dict in arr_addedItems) {
//        [dict setObject:@"0" forKey:@"item_cat"];
//        [arr_niv_supplies addObject:dict];
//    }
//    [arr_niv_supplies addObjectsFromArray:arr_discarded_items];
//    [formData setObject:[Utils createJSON:arr_niv_supplies] forKey:@"json_supplies"]; // // JSON String [Send Discarded items with Supplies]
 
    
//    [formData setObject:@"test" forKey:@"isFinalSubmit"]; // [ 0:Pending;, 1:Completed; ]
//    [formData setObject:@"" forKey:@"edit"];
    
}

-(BOOL)validateItemsTable:(NSArray*)array{
    
    BOOL status;
    for (NSDictionary *saveDict in array) {
        
        NSString *quantity = [saveDict valueForKey:@"quantity"];
        NSString *on_hand = [saveDict valueForKey:@"on_hand"];
        
        int val_quantity = [[quantity stringByTrimmingCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] intValue];
        int val_on_hand = [[on_hand stringByTrimmingCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] intValue];
        
        if (val_quantity > val_on_hand) {
            status = NO;
        }
        else
            status = YES;
    }
    
    return status;
}

-(IBAction)nextButtonPressed{
    [universalTextField resignFirstResponder];
//    [Utils takeScreenshot:d_scrollView];
    
    [self saveFormData];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"StoryboardTwo" bundle:nil];
    NIVSetupTicketTwo *objectVC     = [mainStoryboard instantiateViewControllerWithIdentifier:@"NIVSetupTicketTwo"];
    [temp_dict setObject:NonNilString(txt_pt_name.text) forKey:@"pt_name"];
    [temp_dict setObject:NonNilString(txt_pt_dob.text) forKey:@"pt_dob"];
    [temp_dict setObject:NonNilString(self.pt_id) forKey:@"pt_id"];
    [temp_dict setObject:NonNilString(txt_heater_model.text) forKey:@"humidifier"];
    [temp_dict setObject:NonNilString(txt_heater_serial.text) forKey:@"serial"];

    objectVC.prevFormData = temp_dict;
    objectVC.pageOneFormData = formData;
    objectVC.dict_retrivedData = dict_retrivedData;
    objectVC.dict_retrivedData_local = dict_retrivedData_local;
    [self.navigationController pushViewController:objectVC animated:YES];
}

-(IBAction)backButtonPressed{
    //[universalTextField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark -
#pragma mark - Radio Action

-(IBAction)selectCheckbox:(APRadioButton*)sender{
    rad_new_used.enabled = YES;
    rad_new_used1.enabled = YES;
    if (sender == rad_new_used || sender == rad_new_used1){
        btn_vendor.enabled = YES;
    }
}

#pragma mark -
#pragma mark - Dropdown Popovers

-(IBAction)dropdown:(UIButton*)sender{
    [self selectedDropdown:sender];

    selectListNumber = (int)sender.tag;
    dropdownsTableviewCon.tableView.contentOffset = CGPointMake(0, 0);
    [popoverCon presentPopoverFromRect:CGRectMake(sender.frame.size.width / 2, sender.frame.size.height / 1, 1, 1) inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    popoverViewCon.preferredContentSize = CGSizeMake(240,500);
    [popoverCon setPopoverContentSize:CGSizeMake(240, 500) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectedDropdown:(UIButton*)sender{
    switch (sender.tag) {
        case 11:arr_dropdown = arr_rt_vendor_listing;
            break;
        case 12:
            arr_dropdown = arr_rt_machines_listing;
            break;
        case 13:
            arr_dropdown = arr_machine_serial;
            break;
            
        case 21:
            arr_dropdown = arr_rt_heater_listing;
            break;
        case 22:
            arr_dropdown = arr_heater_name;
            break;
        case 23:
            arr_dropdown = arr_heater_serial;
            break;
            
        case 31:
            arr_dropdown = arr_rt_modem_listing;
            break;
        case 32:
            arr_dropdown = arr_modem_serial;
            break;
            
        case 41:
            arr_dropdown = self.arr_rt_mask_listing;
            break;
        case 42:
            arr_dropdown = arr_mask_size;
            break;
            
        default:
            break;
    }
    
    [dropdownsTableviewCon.tableView reloadData];
}

#pragma mark -
#pragma mark - Search/Add Items

-(void)removeAddItemsView{
    [addItemsBackgroundView removeFromSuperview];
}

-(IBAction)addItems:(UIButton*)sender{
    addItemsBackgroundView                  = [[UIView alloc]initWithFrame:CGRectMake(0, 0 ,1024,768)];
    [addItemsBackgroundView setBackgroundColor:[UIColor colorWithRed:120.0/255.0 green:120.0/255.0 blue:121.0/255.0 alpha:0.4]];
    [self.view addSubview:addItemsBackgroundView];
    [self.view bringSubviewToFront:addItemsBackgroundView];
    
    addItemsView                            = [[UIView alloc] initWithFrame:CGRectMake(70, 150, 700, 300)];
    addItemsView.backgroundColor            = [UIColor whiteColor];
    [addItemsBackgroundView addSubview:addItemsView];
    
    CGRect myFrame                          = CGRectMake(0, 0, 700, 44);
    self.mySearchBar                        = [[UISearchBar alloc] initWithFrame:myFrame];
    self.mySearchBar.delegate               = self;
    self.mySearchBar.showsCancelButton      = YES;
    [addItemsView addSubview:self.mySearchBar];
    
    myFrame.origin.y                        += 44;
    myFrame.size.height                     = 300 - 44;
    self.table_search                       = [[UITableView alloc] initWithFrame:myFrame style:UITableViewStylePlain];
    self.table_search.delegate              = self;
    self.table_search.dataSource            = self;
    self.table_search.autoresizingMask      = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.table_search.backgroundColor       = [UIColor whiteColor];
    self.table_search.backgroundView        = nil;
    
    [addItemsView addSubview:self.table_search];
    btnSearch = sender;
    if (sender.tag == 120) {
        self.mySearchBar.placeholder = @"CPAP/Bi-Level Supplies";
        
        if (!self.arr_rt_item_listing) {
            [self callWebServiceForAvailableItems:RT_ID table:sender];
        }
    }
    if (sender.tag == 130) {
        self.mySearchBar.placeholder = @"Discarded Items";
        
        if (!self.arr_rt_item_listing1) {
            [self callWebServiceForAvailableItems:RT_ID table:sender];
        }
    }
    if (sender.tag == 140) {
        self.mySearchBar.placeholder = @"Additional Supplies";
        
        if (!self.arr_rt_item_listing2) {
            [self callWebServiceForAvailableItems:RT_ID table:sender];
        }
    }
    
    if (sender.tag == 41) {
        self.mySearchBar.placeholder = @"Search Masks";
        //self.arr_rt_mask_listing
        [self.table_search reloadData];
    }
}

//search button was tapped
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self handleSearch:searchBar.text tag:(int)btnSearch.tag];
    
    [searchBar resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        [addItemsView setFrame:CGRectMake(70, 150, 700, 300)];
    }];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [UIView animateWithDuration:0.3 animations:^{
        [addItemsView setFrame:CGRectMake(70, 27, 700, 300)];
    }];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        [addItemsView setFrame:CGRectMake(70, 150, 700, 300)];
    }];
    
    if (btnSearch.tag == 120) {
        self.arr_rt_item_listing = self.arr_temp_item_listing;
    }
    if (btnSearch.tag == 130) {
        self.arr_rt_item_listing1 = self.arr_temp_item_listing1;
    }
    if (btnSearch.tag == 140) {
        self.arr_rt_item_listing2 = self.arr_temp_item_listing2;
    }
    
    [addItemsBackgroundView removeFromSuperview];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length == 0) {
        if (btnSearch.tag == 41) {
            self.arr_rt_mask_listing = self.arr_rt_mask_listing_temp;
        }
        if (btnSearch.tag == 120) {
            self.arr_rt_item_listing = self.arr_temp_item_listing;
        }
        if (btnSearch.tag == 130) {
            self.arr_rt_item_listing1 = self.arr_temp_item_listing1;
        }
        if (btnSearch.tag == 140) {
            self.arr_rt_item_listing2 = self.arr_temp_item_listing2;
        }
        
        [self.table_search reloadData];
    }
    else{
        [self handleSearch:searchText tag:(int)btnSearch.tag];
    }
}

- (void)handleSearch:(NSString *)searchKeyword tag:(int)tag{
    TicketFormView *object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Search", 0);
    
    dispatch_async(myQueue, ^{
        
        NSMutableArray *array = [NSMutableArray new];
        if (tag == 41) {
            NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"mask_name contains[cd] %@ OR mask_id contains[cd] %@", searchKeyword, searchKeyword];
            array = [[[self.arr_rt_mask_listing_temp mutableCopy] filteredArrayUsingPredicate:resultPredicate] mutableCopy];
        }
        if (tag == 120) {
            array =[object_TV startSearchingFromItemsList:self.arr_temp_item_listing keyword:searchKeyword];
        }
        if (tag == 130) {
            array =[object_TV startSearchingFromItemsList:self.arr_temp_item_listing1 keyword:searchKeyword];
        }
        if (tag == 140) {
            array =[object_TV startSearchingFromItemsList:self.arr_temp_item_listing2 keyword:searchKeyword];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(array)
            {
                if (btnSearch.tag == 41) {
                    self.arr_rt_mask_listing = array;
                }
                if (btnSearch.tag == 120) {
                    self.arr_rt_item_listing = array;
                }
                if (btnSearch.tag == 130) {
                    self.arr_rt_item_listing1 = array;
                }
                if (btnSearch.tag == 140) {
                    self.arr_rt_item_listing2 = array;
                }
                
                [self.table_search reloadData];
            }
        });
    });
}


#pragma mark -
#pragma mark - UITableView Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == dropdownsTableviewCon.tableView) {
        return arr_dropdown.count;
    }
    else if (tableView == self.table_search) {
        if (btnSearch.tag == 41){
            return self.arr_rt_mask_listing.count;
        }
        else if (btnSearch.tag == 120) {
            return self.arr_rt_item_listing.count;
        }
        else if (btnSearch.tag == 130){
            return self.arr_rt_item_listing1.count;
        }
        else{
            return self.arr_rt_item_listing2.count;
        }
        
    }
    else if (tableView == table_formTable){
        return arr_addedItems.count;
    }
    else if (tableView == table_formTable1){
        return arr_addedItems1.count;
    }
    else if (tableView == table_formTable2){
        return arr_addedItems2.count;
    }
    else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == table_formTable){
        if(isDropdownOpened && indexPath.row == indexOfDropdownCell) {
            return 178;
        }
        else if (!isDropdownOpened){
            return 33;
        }
        else
            return 33;
    }
    if (tableView == table_formTable1){
        if(isDropdownOpened1 && indexPath.row == indexOfDropdownCell1) {
            return 100;
        }
        else if (!isDropdownOpened1){
            return 33;
        }
        else
            return 33;
    }
    if (tableView == table_formTable2){
        if(isDropdownOpened2 && indexPath.row == indexOfDropdownCell2) {
            return 100;
        }
        else if (!isDropdownOpened2){
            return 33;
        }
        else
            return 33;
    }
    else if (tableView == dropdownsTableviewCon.tableView){
        
        if (selectListNumber == 41) {
            
            CGFloat lenght              = 0.0f;
            NSDictionary *cellDict      = [arr_dropdown objectAtIndex:indexPath.row];
            NSString *cellText          = cellDict[@"mask_name"];
            
            NSDictionary *attributes    = @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]};
            CGRect rect                 = [cellText boundingRectWithSize:CGSizeMake(350, CGFLOAT_MAX)
                                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                                              attributes:attributes
                                                                 context:nil];
            lenght = rect.size.height;
            if (lenght >20) {
                return 47;
            }
            else
                return 32;
            
        }
        else
            return 32;
    }
    else
        return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell_table;
    
    if ([tableView isEqual:dropdownsTableviewCon.tableView]) {
        static NSString * strID             = @"dropDownList";
        cell_table                          = [tableView dequeueReusableCellWithIdentifier:strID];
        if (!cell_table) {
            cell_table                      = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                                                    reuseIdentifier:strID];
        }
        
        cell_table.textLabel.font           = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
        cell_table.textLabel.numberOfLines  = 2;
        NSDictionary *cellDict              = [arr_dropdown objectAtIndex:indexPath.row];
        
        // MACHINE
        if (selectListNumber == 11){
            cell_table.textLabel.text       = cellDict[@"vendor_name"];
        }
        else if (selectListNumber == 12){
            cell_table.textLabel.text       = cellDict[@"item_name"];
        }
        else if (selectListNumber == 13){
            cell_table.textLabel.text       = arr_dropdown[indexPath.row];
        }
        
        // HEATER
        else if (selectListNumber == 21){
            cell_table.textLabel.text       = cellDict[@"item_name"];
        }
        else if (selectListNumber == 22){
            cell_table.textLabel.text       = cellDict[@"item_name"];
        }
        else if (selectListNumber == 23) {
            cell_table.textLabel.text       = arr_dropdown[indexPath.row];
        }
        
        // MODEM
        else if (selectListNumber == 31){
            cell_table.textLabel.text       = cellDict[@"item_name"];
        }
        else if (selectListNumber == 32){
            cell_table.textLabel.text       = arr_dropdown[indexPath.row];
        }
        
        // MASK
        else if (selectListNumber == 41){
            cell_table.textLabel.text       = cellDict[@"mask_name"];
        }
        else if (selectListNumber == 42){
            cell_table.textLabel.text       = arr_dropdown[indexPath.row];;
        }
        else{
            
        }
        
        return cell_table;
    }
    else if ([tableView isEqual:self.table_search]){
        
        UITableViewCell *cell               = nil;
        static NSString *cellIdentifier     = @"Celll";
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier:cellIdentifier];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        if (btnSearch.tag == 41) {
            NSDictionary *cellDict              = [self.arr_rt_mask_listing objectAtIndex:indexPath.row];
            cell.textLabel.text                 = cellDict[@"mask_name"];
            cell.detailTextLabel.text           = cellDict[@"mask_id"];
            cell.detailTextLabel.textAlignment  = NSTextAlignmentRight;
        }
        
        if (btnSearch.tag == 120) {
            NSDictionary *dicti             = [self.arr_rt_item_listing objectAtIndex:indexPath.row];
            cell.textLabel.text                 = dicti[@"item_name"];
            cell.detailTextLabel.text           = dicti[@"item_id"];
            cell.detailTextLabel.textAlignment  = NSTextAlignmentRight;
        }
        if (btnSearch.tag == 130) {
            NSDictionary *dicti             = [self.arr_rt_item_listing1 objectAtIndex:indexPath.row];
            cell.textLabel.text                 = dicti[@"item_name"];
            cell.detailTextLabel.text           = dicti[@"item_id"];
            cell.detailTextLabel.textAlignment  = NSTextAlignmentRight;
        }
        if (btnSearch.tag == 140) {
            NSDictionary *dicti             = [self.arr_rt_item_listing2 objectAtIndex:indexPath.row];
            cell.textLabel.text                 = dicti[@"item_name"];
            cell.detailTextLabel.text           = dicti[@"item_id"];
            cell.detailTextLabel.textAlignment  = NSTextAlignmentRight;
        }
        
        return cell;
    }
    else if ([tableView isEqual:table_formTable1]){ // Discarded Items
        static NSString *str                = @"TicketForm1";
        HistoryCell *cell                   = [tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
        [cell customizeLabelInCell];
        [cell setBackgroundColor:[UIColor clearColor]];
        NSDictionary *item                  = [arr_addedItems1 objectAtIndex:indexPath.row];
        
        cell.lbf1_itemID.text            = item[@"item_id"];
        cell.lbf1_itemName.text          = item[@"item_name"];
        cell.lbf1_size.text              = item[@"size"];
        
        cell.btnf1_size.titleLabel.text  = item[@"size"];
        cell.txtf1_quantity.text         = item[@"quantity"];
        cell.txtf1_quantity.tag          = indexPath.row;
        
        cell.txtf1_additionalItems.text  = item[@"adtnl_items"];
        //cell.txtf1_additionalItems.tag   = indexPath.row;
        cell.txtf1_additionalItems.enabled = NO;
        
        cell.btnf1_size.tag  = indexPath.row;
        [cell.btnf1_size addTarget:self action:@selector(didSelectSizeAtIndexPath1:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.btnf1_Ssize.tag = indexPath.row;
        cell.btnf1_Msize.tag = indexPath.row;
        cell.btnf1_Lsize.tag = indexPath.row;
        
        [cell.btnf1_Ssize addTarget:self action:@selector(selectedSize1:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnf1_Msize addTarget:self action:@selector(selectedSize1:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnf1_Lsize addTarget:self action:@selector(selectedSize1:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    else if ([tableView isEqual:table_formTable2]){  // Returns
        static NSString *str                = @"TicketForm2";
        HistoryCell *cell                   = [tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
        [cell customizeLabelInCell];
        [cell setBackgroundColor:[UIColor clearColor]];
        NSDictionary *item                  = [arr_addedItems2 objectAtIndex:indexPath.row];
        
        cell.lbf2_itemID.text            = item[@"item_id"];
        cell.lbf2_itemName.text          = item[@"item_name"];
        cell.lbf2_size.text              = item[@"size"];
        
        cell.btnf2_size.titleLabel.text  = item[@"size"];
        cell.lbf2_size.text              = item[@"size"];
        cell.txtf2_quantity.text         = item[@"quantity"];
        cell.txtf2_quantity.tag          = indexPath.row;
        
        cell.txtf2_additionalItems.text  = item[@"adtnl_items"];
        //cell.txtf2_additionalItems.tag   = indexPath.row;
        cell.txtf2_additionalItems.enabled = NO;
        
        cell.btnf2_size.tag  = indexPath.row;
        [cell.btnf2_size addTarget:self action:@selector(didSelectSizeAtIndexPath2:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.btnf2_Ssize.tag = indexPath.row;
        cell.btnf2_Msize.tag = indexPath.row;
        cell.btnf2_Lsize.tag = indexPath.row;
        
        [cell.btnf2_Ssize addTarget:self action:@selector(selectedSize2:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnf2_Msize addTarget:self action:@selector(selectedSize2:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnf2_Lsize addTarget:self action:@selector(selectedSize2:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    else{ // NIV Supplies
        static NSString *str                = @"NIVTicketForm";
        HistoryCell *cell                   = [tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
        [cell customizeLabelInCell];
        [cell setBackgroundColor:[UIColor clearColor]];
        NSDictionary *item                  = [arr_addedItems objectAtIndex:indexPath.row];
        
        cell.lbni_itemID.text            = item[@"item_id"];
        cell.lbni_itemName.text          = item[@"item_name"];
        cell.lbni_size.text              = item[@"size"];

        cell.btnni_size.titleLabel.text  = item[@"size"];
        cell.txtni_quantity.text         = item[@"quantity"];
        cell.txtni_quantity.tag          = indexPath.row;

        cell.txtni_additionalItems.text  = item[@"description"];
        //cell.txtf_additionalItems.tag   = indexPath.row;
        
        cell.btnni_size.tag  = indexPath.row;
        [cell.btnni_size addTarget:self action:@selector(didSelectSizeAtIndexPath:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.btnni_Psize.tag = indexPath.row;
        cell.btnni_Ssize.tag = indexPath.row;
        cell.btnni_SMsize.tag = indexPath.row;
        cell.btnni_Msize.tag = indexPath.row;
        cell.btnni_Wsize.tag = indexPath.row;
        cell.btnni_Lsize.tag = indexPath.row;
        cell.btnni_XLsize.tag = indexPath.row;
        
        [cell.btnni_Psize addTarget:self action:@selector(selectedSize:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnni_Ssize addTarget:self action:@selector(selectedSize:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnni_SMsize addTarget:self action:@selector(selectedSize:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnni_Msize addTarget:self action:@selector(selectedSize:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnni_Wsize addTarget:self action:@selector(selectedSize:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnni_Lsize addTarget:self action:@selector(selectedSize:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnni_XLsize addTarget:self action:@selector(selectedSize:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView == table_formTable ) {
        
        HistoryCell *cell = (HistoryCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        if (!isDropdownOpened) {
            cell.cell_dropdownView.hidden = YES;
            return UITableViewCellEditingStyleDelete;
        }
        else
            return UITableViewCellEditingStyleNone;
        
        
    }
    else if(tableView == table_formTable1 ) {
        
        HistoryCell *cell = (HistoryCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        if (!isDropdownOpened1) {
            cell.cell1_dropdownView.hidden = YES;
            return UITableViewCellEditingStyleDelete;
        }
        else
            return UITableViewCellEditingStyleNone;
        
        
    }
    else if(tableView == table_formTable2 ) {
        
        HistoryCell *cell = (HistoryCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        if (!isDropdownOpened2) {
            cell.cell2_dropdownView.hidden = YES;
            return UITableViewCellEditingStyleDelete;
        }
        else
            return UITableViewCellEditingStyleNone;
        
        
    }
    else{
        return UITableViewCellEditingStyleNone;
    }
    
}

- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tv == table_formTable) {
        NSDictionary *item  = [arr_addedItems objectAtIndex:indexPath.row];
        [arr_addedItems removeObject:item];
        
        [table_formTable reloadData];
    }
    
    if (tv == table_formTable1) {
        NSDictionary *item  = [arr_addedItems1 objectAtIndex:indexPath.row];
        [arr_addedItems1 removeObject:item];
        
        [table_formTable1 reloadData];
    }
    
    if (tv == table_formTable2) {
        NSDictionary *item  = [arr_addedItems2 objectAtIndex:indexPath.row];
        [arr_addedItems2 removeObject:item];
        
        [table_formTable2 reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.table_search) {
        if (btnSearch.tag == 41) {
            NSDictionary *cellDict              = [self.arr_rt_mask_listing objectAtIndex:indexPath.row];
            
            txt_mask_name.text               = cellDict[@"mask_name"];
            if ([cellDict[@"mask_name"] isEqualToString:@"NA"]) {
                txt_mask_name.text       = @"NA";
            }
            else{
                txt_mask_name.text       = @"";
            }
            txt_mask_id.text             = cellDict[@"mask_id"];
        }
        if (btnSearch.tag == 120) {
            
            NSMutableDictionary *item      = [self.arr_rt_item_listing objectAtIndex:indexPath.row];

            if (![arr_addedItems containsObject:item]) {
                [arr_addedItems addObject:item];
                
                NSArray *temp  = [[arr_addedItems reverseObjectEnumerator] allObjects];
                arr_addedItems = [temp mutableCopy];
            }
            
            [table_formTable reloadData];
            
            [self.mySearchBar resignFirstResponder];
            [UIView animateWithDuration:0.3 animations:^{
                [addItemsView setFrame:CGRectMake(70, 150, 700, 300)];
            }];
            
            self.arr_rt_item_listing = self.arr_temp_item_listing;
            [self.table_search reloadData];
            
            [addItemsBackgroundView removeFromSuperview];
        }
        
        if (btnSearch.tag == 130){
            NSMutableDictionary *item      = [self.arr_rt_item_listing1 objectAtIndex:indexPath.row];
            
            if (![arr_addedItems1 containsObject:item]) {
                [arr_addedItems1 addObject:item];
                
                NSArray *temp  = [[arr_addedItems1 reverseObjectEnumerator] allObjects];
                arr_addedItems1 = [temp mutableCopy];
            }

            [table_formTable1 reloadData];
            
            [self.mySearchBar resignFirstResponder];
            [UIView animateWithDuration:0.3 animations:^{
                [addItemsView setFrame:CGRectMake(70, 150, 700, 300)];
            }];
            
            self.arr_rt_item_listing1 = self.arr_temp_item_listing1;
            [self.table_search reloadData];
            
            [addItemsBackgroundView removeFromSuperview];
        }
        if (btnSearch.tag == 140){
            NSMutableDictionary *item      = [self.arr_rt_item_listing2 objectAtIndex:indexPath.row];
            
            if (![arr_addedItems2 containsObject:item]) {
                [arr_addedItems2 addObject:item];
                
                NSArray *temp  = [[arr_addedItems2 reverseObjectEnumerator] allObjects];
                arr_addedItems2 = [temp mutableCopy];
            }

            [table_formTable2 reloadData];
            
            [self.mySearchBar resignFirstResponder];
            [UIView animateWithDuration:0.3 animations:^{
                [addItemsView setFrame:CGRectMake(70, 150, 700, 300)];
            }];
            
            self.arr_rt_item_listing2 = self.arr_temp_item_listing2;
            [self.table_search reloadData];
            
            [addItemsBackgroundView removeFromSuperview];
        }
        
        
    }
    if (tableView == dropdownsTableviewCon.tableView) {
        NSDictionary *cellDict          = [arr_dropdown objectAtIndex:indexPath.row];
        
        // MACHINE
        if (selectListNumber == 11){
            btn_machine_name.enabled = NO;
            btn_machine_serial.enabled = NO;
            
            btn_heater_name.enabled = NO;
            btn_heater_vendor.enabled = NO;
            btn_heater_serial.enabled = NO;
            
            btn_modem_name.enabled = NO;
            btn_modem_serial.enabled = NO;
            
            txt_machine_manufacturer.text   = @"";
            txt_machine_name.text = @"";
            txt_machine_serial.text = @"";
            txt_machine_model.text = @"";
            
            txt_heater_manufacturer.text = @"";
            txt_heater_name.text = @"";
            txt_heater_serial.text = @"";
            txt_heater_model.text = @"";
            
            txt_modem_name.text = @"";
            txt_modem_serial.text = @"";
            
            txt_mask_name.text = @"";
            txt_mask_size.text = @"";
            txt_mask_id.text = @"";
            
            txt_machine_manufacturer.text   = cellDict[@"vendor_name"];
            [self callWebserviceForMachineListingOfVendor:cellDict[@"vendor_id"]];
            btn_machine_name.enabled = YES;
        }
        else if (selectListNumber == 12){
            
            [arr_addedItems removeAllObjects];
            [table_formTable reloadData];
            
            arr_addedItems = [cellDict[@"item_supply_list"] mutableCopy];
            NSMutableArray *tempA = [NSMutableArray new];
            for (NSDictionary *dict1 in arr_addedItems) {
                if ([dict1[@"item_id"] hasPrefix:@"B-"]) {
                    [tempA addObject:dict1];
                }
            }
            
            [arr_addedItems removeAllObjects];
            arr_addedItems = tempA;
            [table_formTable reloadData];
            
            btn_mask_name.enabled = YES;
            btn_mask_size.enabled = YES;
            
            txt_machine_serial.text = @"";
            txt_machine_model.text = @"";
            
            txt_heater_manufacturer.text = @"";
            txt_heater_name.text = @"";
            txt_heater_serial.text = @"";
            txt_heater_model.text = @"";
            
            txt_modem_name.text = @"";
            txt_modem_serial.text = @"";
            
            txt_mask_name.text = @"";
            txt_mask_size.text = @"";
            txt_mask_id.text = @"";
            
            txt_machine_name.text           = cellDict[@"item_name"];
            txt_machine_model.text          = cellDict[@"item_id"];
            [self getSerialNumbersOfItem:cellDict tag:selectListNumber];
            btn_machine_serial.enabled = YES;
            
        }
        else if (selectListNumber == 13){
            txt_machine_serial.text         = arr_dropdown[indexPath.row];
        }
        
        // HEATER
        else if (selectListNumber == 21){
            txt_heater_manufacturer.text     = cellDict[@"item_name"];
        }
        else if (selectListNumber == 22){
            txt_heater_name.text              = cellDict[@"item_name"];
            txt_heater_model.text             = @"";
        }
        else if (selectListNumber == 23) {
            txt_heater_serial.text            = arr_dropdown[indexPath.row];;
        }
        
        // MODEM
        else if (selectListNumber == 31){
            txt_modem_name.text              = cellDict[@"item_name"];
            [self getSerialNumbersOfItem:cellDict tag:selectListNumber];
        }
        else if (selectListNumber == 32){
            txt_modem_serial.text             = arr_dropdown[indexPath.row];;
        }
        
        // MASK
        else if (selectListNumber == 41){
            txt_mask_name.text               = cellDict[@"mask_name"];
            txt_mask_id.text                 = cellDict[@"mask_id"];
            if ([cellDict[@"mask_name"] isEqualToString:@"NA"]) txt_mask_size.text = @"NA";
        }
        else if (selectListNumber == 42){
            txt_mask_size.text              = arr_dropdown[indexPath.row];
        }
        else{
            
        }
        
        [popoverCon dismissPopoverAnimated:NO];
    }
}
#pragma mark -
#pragma mark - Tableview Helpers
-(void)didSelectSizeAtIndexPath:(UIButton*)sender{ // NIV Supplies
    
    
    if (isDropdownOpened) {
        isDropdownOpened = NO;
    }
    else{
        indexOfDropdownCell         = (int)sender.tag;
        isDropdownOpened            = YES;
        
        CGPoint point               = CGPointMake(0,1000); //680
        [UIView animateWithDuration:0.5 animations:^{
            [d_scrollView setContentOffset:point animated:NO];
        }];
    }
    
    [table_formTable beginUpdates];
    [table_formTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [table_formTable endUpdates];
}

-(void)didSelectSizeAtIndexPath1:(UIButton*)sender{ // Discarded Items
    
    
    if (isDropdownOpened1) {
        isDropdownOpened1 = NO;
    }
    else{
        indexOfDropdownCell1         = (int)sender.tag;
        isDropdownOpened1            = YES;
        
        CGPoint point               = CGPointMake(0,1650); //680
        [UIView animateWithDuration:0.5 animations:^{
            [d_scrollView setContentOffset:point animated:NO];
        }];
    }
    
    [table_formTable1 beginUpdates];
    [table_formTable1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [table_formTable1 endUpdates];
}

-(void)didSelectSizeAtIndexPath2:(UIButton*)sender{ // Returns
    
    
    if (isDropdownOpened2) {
        isDropdownOpened2 = NO;
    }
    else{
        indexOfDropdownCell2         = (int)sender.tag;
        isDropdownOpened2            = YES;
        
        CGPoint point               = CGPointMake(0,1300); //680
        [UIView animateWithDuration:0.5 animations:^{
            [d_scrollView setContentOffset:point animated:NO];
        }];
    }
    
    [table_formTable2 beginUpdates];
    [table_formTable2 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [table_formTable2 endUpdates];
}

-(void)selectedSize:(UIButton*)sender{
    isDropdownOpened            = NO;
    indexOfDropdownItem         = (int)sender.tag;
    
    NSMutableDictionary *ddict  = [[NSMutableDictionary alloc] init];
    ddict                       = [NSMutableDictionary dictionaryWithDictionary:[arr_addedItems objectAtIndex:indexOfDropdownItem]];
    
    if ([sender.titleLabel.text isEqualToString:@"Petite"]) {
        [ddict setObject:@"P" forKey:@"size"];
    }
    if ([sender.titleLabel.text isEqualToString:@"Small"]){
        [ddict setObject:@"S" forKey:@"size"];
    }
    if([sender.titleLabel.text isEqualToString:@"S/M"]){
        [ddict setObject:@"SM" forKey:@"size"];
    }
    if([sender.titleLabel.text isEqualToString:@"Medium"]){
        [ddict setObject:@"M" forKey:@"size"];
    }
    if([sender.titleLabel.text isEqualToString:@"Wide"]){
        [ddict setObject:@"W" forKey:@"size"];
    }
    if([sender.titleLabel.text isEqualToString:@"Large"]){
        [ddict setObject:@"L" forKey:@"size"];
    }
    if([sender.titleLabel.text isEqualToString:@"X-Large"]){
        [ddict setObject:@"XL" forKey:@"size"];
    }
    
    [arr_addedItems replaceObjectAtIndex:indexOfDropdownItem withObject:ddict];
    
    
    [table_formTable beginUpdates];
    [table_formTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [table_formTable endUpdates];
}

-(void)selectedSize1:(UIButton*)sender{
    isDropdownOpened1            = NO;
    indexOfDropdownItem1         = (int)sender.tag;
    
    NSMutableDictionary *ddict  = [[NSMutableDictionary alloc] init];
    ddict                       = [NSMutableDictionary dictionaryWithDictionary:[arr_addedItems1 objectAtIndex:indexOfDropdownItem1]];
    
    if ([sender.titleLabel.text isEqualToString:@"Small (S)"]) {
        [ddict setObject:@"S" forKey:@"size"];
    }
    if ([sender.titleLabel.text isEqualToString:@"Medium (M)"]){
        [ddict setObject:@"M" forKey:@"size"];
    }
    if([sender.titleLabel.text isEqualToString:@"Large (L)"]){
        [ddict setObject:@"L" forKey:@"size"];
    }
    [arr_addedItems1 replaceObjectAtIndex:indexOfDropdownItem1 withObject:ddict];
    
    
    [table_formTable1 beginUpdates];
    [table_formTable1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [table_formTable1 endUpdates];
}

-(void)selectedSize2:(UIButton*)sender{
    isDropdownOpened2            = NO;
    indexOfDropdownItem2         = (int)sender.tag;
    
    NSMutableDictionary *ddict  = [[NSMutableDictionary alloc] init];
    ddict                       = [NSMutableDictionary dictionaryWithDictionary:[arr_addedItems2 objectAtIndex:indexOfDropdownItem2]];
    
    if ([sender.titleLabel.text isEqualToString:@"Small (S)"]) {
        [ddict setObject:@"S" forKey:@"size"];
    }
    if ([sender.titleLabel.text isEqualToString:@"Medium (M)"]){
        [ddict setObject:@"M" forKey:@"size"];
    }
    if([sender.titleLabel.text isEqualToString:@"Large (L)"]){
        [ddict setObject:@"L" forKey:@"size"];
    }
    [arr_addedItems2 replaceObjectAtIndex:indexOfDropdownItem2 withObject:ddict];
    
    
    [table_formTable2 beginUpdates];
    [table_formTable2 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [table_formTable2 endUpdates];
}


#pragma mark -
#pragma mark - UITextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.returnKeyType == UIReturnKeyDone) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    universalTextField = textField;
    
    d_point = d_scrollView.contentOffset;
    CGPoint point;
    CGRect rect = [textField bounds];
    rect        = [textField convertRect:rect toView:d_scrollView];
    point       = rect.origin;
    point.x     = 0;
    point.y     -= 80;
    [UIView animateWithDuration:0.5 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (universalTextField.tag != 5000) {
        
        [universalTextField resignFirstResponder];
        
        if (btnSearch.tag == 120) {
            BOOL valid;
            NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
            NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:universalTextField.text];
            valid = [alphaNums isSupersetOfSet:inStringSet];
            
            NSMutableDictionary *ddict  = [[NSMutableDictionary alloc] init];
            ddict                       = [NSMutableDictionary dictionaryWithDictionary:[arr_addedItems objectAtIndex:universalTextField.tag]];
            
            if (valid) { // Not numeric
                [ddict setObject:universalTextField.text forKey:@"quantity"];
                [arr_addedItems replaceObjectAtIndex:universalTextField.tag withObject:ddict];
            }
            else{
                [ddict setObject:universalTextField.text forKey:@"adtnl_items"];
                [arr_addedItems replaceObjectAtIndex:universalTextField.tag withObject:ddict];
                
            }
            
            [table_formTable beginUpdates];
            [table_formTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:universalTextField.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            [table_formTable endUpdates];
        }
        
        if (btnSearch.tag == 130) {
            BOOL valid;
            NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
            NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:universalTextField.text];
            valid = [alphaNums isSupersetOfSet:inStringSet];
            
            NSMutableDictionary *ddict  = [[NSMutableDictionary alloc] init];
            ddict                       = [NSMutableDictionary dictionaryWithDictionary:[arr_addedItems1 objectAtIndex:universalTextField.tag]];
            
            if (valid) { // Not numeric
                [ddict setObject:universalTextField.text forKey:@"quantity"];
                [arr_addedItems1 replaceObjectAtIndex:universalTextField.tag withObject:ddict];
            }
            else{
                [ddict setObject:universalTextField.text forKey:@"adtnl_items"];
                [arr_addedItems1 replaceObjectAtIndex:universalTextField.tag withObject:ddict];
                
            }
            
            [table_formTable1 beginUpdates];
            [table_formTable1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:universalTextField.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            [table_formTable1 endUpdates];
        }
        
        if (btnSearch.tag == 140) {
            BOOL valid;
            NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
            NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:universalTextField.text];
            valid = [alphaNums isSupersetOfSet:inStringSet];
            
            NSMutableDictionary *ddict  = [[NSMutableDictionary alloc] init];
            ddict                       = [NSMutableDictionary dictionaryWithDictionary:[arr_addedItems2 objectAtIndex:universalTextField.tag]];
            
            if (valid) { // Not numeric
                [ddict setObject:universalTextField.text forKey:@"quantity"];
                [arr_addedItems2 replaceObjectAtIndex:universalTextField.tag withObject:ddict];
            }
            else{
                [ddict setObject:universalTextField.text forKey:@"adtnl_items"];
                [arr_addedItems2 replaceObjectAtIndex:universalTextField.tag withObject:ddict];
                
            }
            
            [table_formTable2 beginUpdates];
            [table_formTable2 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:universalTextField.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            [table_formTable2 endUpdates];
        }
    }
    else{

    }   
}

//#pragma mark -
//#pragma mark - UITextView Delegate
//
////- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
////
////    return textView.text.length + (text.length - range.length) <= 140; // limit char limit to 140
////}
//
//- (void)textViewDidBeginEditing:(UITextView *)textView{
//
//    CGPoint point;
//    CGRect rect = [textView bounds];
//    rect        = [textView convertRect:rect toView:d_scrollView];
//    point       = rect.origin;
//    point.x     = 0;
//    point.y     -= 50;
//    [UIView animateWithDuration:0.5 animations:^{
//        [d_scrollView setContentOffset:point animated:NO];
//    }];
//}
//
//- (void)textViewDidEndEditing:(UITextView *)textView{
//
//}

@end
