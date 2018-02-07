//
//  MachinesVC.m
//  RT APP
//
//  Created by Anil Prasad on 17/08/16.
//  Copyright © 2016 ankit gupta. All rights reserved.
//

#import "MachinesVC.h"
#import "HumidifierVC.h"

@interface MachinesVC (){
    int viewCount;
}


@end

@implementation MachinesVC

-(void)viewWillAppear:(BOOL)animated{
    
    //btn_addMore.hidden = YES;
    
//    txt_1_manufacture.placeholder = @"Item ID";
//    txt_2_manufacture.placeholder = @"Item ID";
//    txt_3_manufacture.placeholder = @"Item ID";
//    txt_4_manufacture.placeholder = @"Item ID";
//    txt_5_manufacture.placeholder = @"Item ID";
//    txt_6_manufacture.placeholder = @"Item ID";
//    txt_7_manufacture.placeholder = @"Item ID";
//    txt_8_manufacture.placeholder = @"Item ID";
//    txt_9_manufacture.placeholder = @"Item ID";
//    txt_10_manufacture.placeholder = @"Item ID";
    
    dict_1 = nil;
    dict_2 = nil;
    dict_3 = nil;
    dict_4 = nil;
    dict_5 = nil;
    dict_6 = nil;
    dict_7 = nil;
    dict_8 = nil;
    dict_9 = nil;
    dict_10 = nil;
    
    arr_addedItems = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr_dropdown = [NSArray new];
    self.arr_rt_serial_listing1 = [NSArray new];
    self.arr_rt_serial_listing2 = [NSArray new];
    self.arr_rt_serial_listing3 = [NSArray new];
    self.arr_rt_serial_listing4 = [NSArray new];
    self.arr_rt_serial_listing5 = [NSArray new];
    self.arr_rt_serial_listing6 = [NSArray new];
    self.arr_rt_serial_listing7 = [NSArray new];
    self.arr_rt_serial_listing8 = [NSArray new];
    self.arr_rt_serial_listing9 = [NSArray new];
    self.arr_rt_serial_listing10 = [NSArray new];
    
    [self callWebserviceForDropdowns];
    //[self getAvailableInventoryList];
    
    dict_1 = [NSMutableDictionary new];
    dict_2 = [NSMutableDictionary new];
    dict_3 = [NSMutableDictionary new];
    dict_4 = [NSMutableDictionary new];
    dict_5 = [NSMutableDictionary new];
    dict_6 = [NSMutableDictionary new];
    dict_7 = [NSMutableDictionary new];
    dict_8 = [NSMutableDictionary new];
    dict_9 = [NSMutableDictionary new];
    dict_10 = [NSMutableDictionary new];
    
    arr_addedItems = [NSMutableArray new];
    
    
    viewCount = 0;
    
    
    d_scrollView.contentSize            = CGSizeMake(752, 800); // 1950
    d_scrollView.contentOffset          = CGPointMake(0,0);
    
    popoverViewCon                              = [[UIViewController alloc]init];
    dropdownsTableviewCon                       = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    popoverViewCon.preferredContentSize         = CGSizeMake(200,500);
    dropdownsTableviewCon.clearsSelectionOnViewWillAppear = NO;
    dropdownsTableviewCon.tableView.delegate    = self;
    dropdownsTableviewCon.tableView.dataSource  = self;
    dropdownsTableviewCon.tableView.frame       = CGRectMake(0, 0, CGRectGetWidth(popoverViewCon.view.bounds),
                                                             CGRectGetHeight(popoverViewCon.view.bounds));
    
    [popoverViewCon.view addSubview:dropdownsTableviewCon.tableView];
    popoverCon                                  = [[UIPopoverController alloc] initWithContentViewController:popoverViewCon];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveData{
    if (![txt_1_quantity.text isEqualToString:@""]) {
        [dict_1 setObject:txt_1_quantity.text forKey:@"quantity"];
    }
    if (![txt_2_quantity.text isEqualToString:@""]) {
        [dict_2 setObject:txt_2_quantity.text forKey:@"quantity"];
    }
    if (![txt_3_quantity.text isEqualToString:@""]) {
        [dict_3 setObject:txt_3_quantity.text forKey:@"quantity"];
    }
    if (![txt_4_quantity.text isEqualToString:@""]) {
        [dict_4 setObject:txt_4_quantity.text forKey:@"quantity"];
    }
    if (![txt_5_quantity.text isEqualToString:@""]) {
        [dict_5 setObject:txt_5_quantity.text forKey:@"quantity"];
    }
    if (![txt_6_quantity.text isEqualToString:@""]) {
        [dict_6 setObject:txt_6_quantity.text forKey:@"quantity"];
    }
    if (![txt_7_quantity.text isEqualToString:@""]) {
        [dict_7 setObject:txt_7_quantity.text forKey:@"quantity"];
    }
    if (![txt_8_quantity.text isEqualToString:@""]) {
        [dict_8 setObject:txt_8_quantity.text forKey:@"quantity"];
    }
    if (![txt_9_quantity.text isEqualToString:@""]) {
        [dict_9 setObject:txt_9_quantity.text forKey:@"quantity"];
    }
    if (![txt_10_quantity.text isEqualToString:@""]) {
        [dict_10 setObject:txt_10_quantity.text forKey:@"quantity"];
    }
    
    
    [arr_addedItems addObject:dict_1];
    [arr_addedItems addObject:dict_2];
    [arr_addedItems addObject:dict_3];
    [arr_addedItems addObject:dict_4];
    [arr_addedItems addObject:dict_5];
    [arr_addedItems addObject:dict_6];
    [arr_addedItems addObject:dict_7];
    [arr_addedItems addObject:dict_8];
    [arr_addedItems addObject:dict_9];
    [arr_addedItems addObject:dict_10];
    
}


-(NSString*)jsonString{
    NSMutableArray *saveArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *saveDict in arr_addedItems) {
        
        NSString *item_quantity = [saveDict valueForKey:@"quantity"];
        if ([saveDict valueForKey:@"quantity"] != nil) {
            
            NSString *machine_id = [saveDict valueForKey:@"item_id"];
            NSString *machine_name = [saveDict valueForKey:@"item_name"];
            
            
            
            NSString *item = [NSString stringWithFormat:@"{\"machine_id\": \"%@\",\"machine_name\": \"%@\",\"quantity\": \"%@\"}", machine_id, machine_name, item_quantity];
            
            [saveArray addObject:item];
        }
        
        
    }
    
    
    NSString *str_itemArray = [saveArray componentsJoinedByString:@","];
    NSString *json_item     = [NSString stringWithFormat:@"{\"json_data\":[%@]}",str_itemArray];
    
    json_item               = [json_item stringByReplacingOccurrencesOfString:@"&" withString:@"and"];
    
    return json_item;
    
}

-(IBAction)showNextView{
    
    [self saveData];
    NSString *json = [self jsonString];
    
    HumidifierVC *humVc = [self.storyboard instantiateViewControllerWithIdentifier:@"HUM"];
    humVc.json_machines = json;
    [self.navigationController pushViewController:humVc animated:YES];
}

-(IBAction)addMore{
    viewCount = viewCount+1;
    
    if (viewCount == 1) {
        view6.hidden = NO;
    }
    if (viewCount == 2) {
        view6.hidden = NO;
        view7.hidden = NO;
    }
    if (viewCount == 3) {
        view6.hidden = NO;
        view7.hidden = NO;
        view8.hidden = NO;
    }
    if (viewCount == 4) {
        view6.hidden = NO;
        view7.hidden = NO;
        view8.hidden = NO;
        view9.hidden = NO;
    }
    if (viewCount == 5) {
        view6.hidden = NO;
        view7.hidden = NO;
        view8.hidden = NO;
        view9.hidden = NO;
        view10.hidden = NO;
    }
}


-(IBAction)actionForButton:(UIButton*)sender{
    [txt_1_quantity resignFirstResponder];
    [txt_2_quantity resignFirstResponder];
    [txt_3_quantity resignFirstResponder];
    [txt_4_quantity resignFirstResponder];
    [universalTextField resignFirstResponder];
    
    tagNum = sender.tag;
    
    switch (sender.tag) {
        case 11:{
            [self selectOne:sender];
        }
            break;
            
        case 21:{
            [self selectTwo:sender];
        }
            break;
            
        case 31:{
            [self selectThree:sender];
        }
            break;
            
        case 41:{
            [self selectFour:sender];
        }
            break;
            
        case 51:{
            [self selectFive:sender];
        }
            break;
            
        case 61:{
            [self selectSix:sender];
        }
            break;
            
        case 71:{
            [self selectSeven:sender];
        }
            break;
            
        case 81:{
            [self selectEight:sender];
        }
            break;
            
        case 91:{
            [self selectNine:sender];
        }
            break;
            
        case 101:{
            [self selectTen:sender];
        }
            break;
            
            
        case 12:{
            [self selectSerialOne:sender];
        }
            break;
            
        case 22:{
            [self selectSerialTwo:sender];
        }
            break;
            
        case 32:{
            [self selectSerialThree:sender];
        }
            break;
            
        case 42:{
            [self selectSerialFour:sender];
        }
            break;
            
        case 52:{
            [self selectSerialFive:sender];
        }
            break;
            
        case 62:{
            [self selectSerialSix:sender];
        }
            break;
            
        case 72:{
            [self selectSerialSeven:sender];
        }
            break;
            
        case 82:{
            [self selectSerialEight:sender];
        }
            break;
            
        case 92:{
            [self selectSerialNine:sender];
        }
            break;
            
        case 102:{
            [self selectSerialTen:sender];
        }
            break;
            
        default:
            break;
    }
}

-(void)callWebserviceForDropdowns{
    
    object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Dropdown", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        NSLog(@"RT_ID: %@", RT_ID);
        NSDictionary *dicti =[object_TV getArraysForDropdowns:RT_ID];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM = [[TicketFormModel alloc] initWithDictionary:dicti];
                [self responseDataOfDropdowns:object_TM];
            }
        });
    });
}

-(void)responseDataOfDropdowns:(TicketFormModel*)object{
    
    //    NSMutableArray *arr = [NSMutableArray new];
    //    arr = [object.arr_rt_machines_listing mutableCopy];
    //    [arr addObjectsFromArray:object.arr_rt_new_machines_listing];
    
    self.arr_rt_machine_listing = object.arr_rt_new_machines_listing;
    //self.arr_rt_serial_listing1 = object.arr_rt_new_machines_listing;
    
    NSMutableArray *arr_temp_patient_list = [[self sortedDictionaryByNames:self.arr_rt_machine_listing :@"item_name" ascending:YES] mutableCopy];
    self.arr_rt_machine_listing = arr_temp_patient_list;
    
    
    [dropdownsTableviewCon.tableView reloadData];
}

#pragma mark -
#pragma mark - UITableView Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr_dropdown.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell_table;
    
    static NSString * strID             = @"dropDownList";
    cell_table                          = [tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell_table) {
        cell_table                      = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                                                reuseIdentifier:strID];
    }
    
    cell_table.textLabel.font           = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
    cell_table.textLabel.numberOfLines  = 2;
    
    if (tagNum == 11 || tagNum == 21 || tagNum == 31 || tagNum == 41 || tagNum == 51 || tagNum == 61 || tagNum == 71 || tagNum == 81 || tagNum == 91 || tagNum == 101)
    {
        NSDictionary *cellDict              = [self.arr_dropdown objectAtIndex:indexPath.row];
        cell_table.textLabel.text           = cellDict[@"item_name"];
    }
    else{
        cell_table.textLabel.text           = [self.arr_dropdown objectAtIndex:indexPath.row];
    }
    
    
    return cell_table;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (tagNum == 11 || tagNum == 21 || tagNum == 31 || tagNum == 41 || tagNum == 51 || tagNum == 61 || tagNum == 71 || tagNum == 81 || tagNum == 91 || tagNum == 101)
    {
        NSDictionary *cellDict              = [self.arr_dropdown objectAtIndex:indexPath.row];
        NSString *machine                   = cellDict[@"item_name"];
        NSString *item_id                   = cellDict[@"item_id"];
        
        switch (tagNum) {
                
            case 11:{
                txt_1_machine.text = machine;
//                txt_1_manufacture.text = item_id;
//                txt_1_quantity.enabled = YES;
                //            [txt_1_quantity becomeFirstResponder];
//                [dict_1 setObject:machine forKey:@"item_name"];
//                [dict_1 setObject:cellDict[@"item_id"] forKey:@"item_id"];
//                
//                [self getSerialNumbersOfMachine:cellDict[@"item_id"] tag:tagNum];
            }
                break;
                
            case 21:{
                txt_2_machine.text = machine;
//                txt_2_manufacture.text = item_id;
//                txt_2_quantity.enabled = YES;
//                //            [txt_2_quantity becomeFirstResponder];
//                [dict_2 setObject:machine forKey:@"item_name"];
//                [dict_2 setObject:cellDict[@"item_id"] forKey:@"item_id"];
//                [self getSerialNumbersOfMachine:cellDict[@"item_id"] tag:tagNum];
                
            }
                break;
                
            case 31:{
                txt_3_machine.text = machine;
//                txt_3_manufacture.text = item_id;
//                txt_3_quantity.enabled = YES;
//                //            [txt_3_quantity becomeFirstResponder];
//                [dict_3 setObject:machine forKey:@"item_name"];
//                [dict_3 setObject:cellDict[@"item_id"] forKey:@"item_id"];
//                [self getSerialNumbersOfMachine:cellDict[@"item_id"] tag:tagNum];
                
            }
                break;
                
            case 41:{
                txt_4_machine.text = machine;
//                txt_4_manufacture.text = item_id;
//                txt_4_quantity.enabled = YES;
//                //            [txt_4_quantity becomeFirstResponder];
//                [dict_4 setObject:machine forKey:@"item_name"];
//                [dict_4 setObject:cellDict[@"item_id"] forKey:@"item_id"];
//                [self getSerialNumbersOfMachine:cellDict[@"item_id"] tag:tagNum];
                
            }
                break;
                
            case 51:{
                txt_5_machine.text = machine;
//                txt_5_manufacture.text = item_id;
//                txt_5_quantity.enabled = YES;
//                //            [txt_5_quantity becomeFirstResponder];
//                [dict_5 setObject:machine forKey:@"item_name"];
//                [dict_5 setObject:cellDict[@"item_id"] forKey:@"item_id"];
//                [self getSerialNumbersOfMachine:cellDict[@"item_id"] tag:tagNum];
                
            }
                break;
                
            case 61:{
                txt_6_machine.text = machine;
//                txt_6_manufacture.text = item_id;
//                txt_6_quantity.enabled = YES;
//                //            [txt_6_quantity becomeFirstResponder];
//                [dict_6 setObject:machine forKey:@"item_name"];
//                [dict_6 setObject:cellDict[@"item_id"] forKey:@"item_id"];
//                [self getSerialNumbersOfMachine:cellDict[@"item_id"] tag:tagNum];
                
            }
                break;
                
            case 71:{
                txt_7_machine.text = machine;
//                txt_7_manufacture.text = item_id;
//                txt_7_quantity.enabled = YES;
//                //            [txt_7_quantity becomeFirstResponder];
//                [dict_7 setObject:machine forKey:@"item_name"];
//                [dict_7 setObject:cellDict[@"item_id"] forKey:@"item_id"];
//                [self getSerialNumbersOfMachine:cellDict[@"item_id"] tag:tagNum];
                
            }
                break;
                
            case 81:{
                txt_8_machine.text = machine;
//                txt_8_manufacture.text = item_id;
//                txt_8_quantity.enabled = YES;
//                //            [txt_8_quantity becomeFirstResponder];
//                [dict_8 setObject:machine forKey:@"item_name"];
//                [dict_8 setObject:cellDict[@"item_id"] forKey:@"item_id"];
//                [self getSerialNumbersOfMachine:cellDict[@"item_id"] tag:tagNum];
                
            }
                break;
                
            case 91:{
                txt_9_machine.text = machine;
//                txt_9_manufacture.text = item_id;
//                txt_9_quantity.enabled = YES;
//                //            [txt_9_quantity becomeFirstResponder];
//                [dict_9 setObject:machine forKey:@"item_name"];
//                [dict_9 setObject:cellDict[@"item_id"] forKey:@"item_id"];
//                [self getSerialNumbersOfMachine:cellDict[@"item_id"] tag:tagNum];
                
            }
                break;
                
            case 101:{
                txt_10_machine.text = machine;
//                txt_10_manufacture.text = item_id;
//                txt_10_quantity.enabled = YES;
//                //            [txt_10_quantity becomeFirstResponder];
//                [dict_10 setObject:machine forKey:@"item_name"];
//                [dict_10 setObject:cellDict[@"item_id"] forKey:@"item_id"];
//                [self getSerialNumbersOfMachine:cellDict[@"item_id"] tag:tagNum];
                
            }
                break;
                
                
                
            default:
                break;
        }
    }
    else{
        switch (tagNum) {
                
            case 12:{
                txt_1_serial.text = [self.arr_rt_serial_listing1 objectAtIndex:indexPath.row];
            }
                break;
                
            case 22:{
                txt_2_serial.text = [self.arr_rt_serial_listing2 objectAtIndex:indexPath.row];
            }
                break;
                
            case 32:{
                txt_3_serial.text = [self.arr_rt_serial_listing3 objectAtIndex:indexPath.row];
            }
                break;
                
            case 42:{
                txt_4_serial.text = [self.arr_rt_serial_listing4 objectAtIndex:indexPath.row];
            }
                break;
                
            case 52:{
                txt_5_serial.text = [self.arr_rt_serial_listing5 objectAtIndex:indexPath.row];
            }
                break;
                
            case 62:{
                txt_6_serial.text = [self.arr_rt_serial_listing6 objectAtIndex:indexPath.row];
            }
                break;
                
            case 72:{
                txt_7_serial.text = [self.arr_rt_serial_listing7 objectAtIndex:indexPath.row];
            }
                break;
                
            case 82:{
                txt_8_serial.text = [self.arr_rt_serial_listing8 objectAtIndex:indexPath.row];
            }
                break;
                
            case 92:{
                txt_9_serial.text = [self.arr_rt_serial_listing9 objectAtIndex:indexPath.row];
            }
                break;
                
            case 102:{
                txt_10_serial.text = [self.arr_rt_serial_listing10 objectAtIndex:indexPath.row];
            }
                break;
                
                
            default:
                break;
        }
        
    }
    
//    btn_next.enabled = YES;
//    btn_next.alpha = 1.0;
    
    [popoverCon dismissPopoverAnimated:YES];
}

#pragma mark - Sorting

-(NSArray*)sortedDictionaryByNames :(NSArray*)array :(NSString*)key ascending:(BOOL)asd
{
    NSArray *sortedArray;
    NSSortDescriptor*cityDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:asd];
    NSArray* sortDescriptors = [NSArray arrayWithObject:cityDescriptor];
    sortedArray = [array sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedArray;
}

-(void)getSerialNumbersOfMachine:(NSString*)machineID tag:(int)tag{
    
    
    object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("MachineSerial", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dicti =[object_TV getArraysOfSerialNumbers:RT_ID itemID:machineID];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM = [[TicketFormModel alloc] initWithDictionary:dicti];
                
                
                switch (tag) {
                        
                        
                    case 11:{
                        self.arr_rt_serial_listing1 = object_TM.arr_rt_serial_numbers;
                        txt_1_serial.text = self.arr_rt_serial_listing1[0];
                        
                        [self getInventoryCountOfItem:machineID tag:(int)tag];
                    }
                        break;
                        
                    case 21:{
                        self.arr_rt_serial_listing2 = object_TM.arr_rt_serial_numbers;
                        txt_2_serial.text = self.arr_rt_serial_listing2[0];
                    }
                        break;
                        
                    case 31:{
                        self.arr_rt_serial_listing3 = object_TM.arr_rt_serial_numbers;
                        txt_3_serial.text = self.arr_rt_serial_listing3[0];
                    }
                        break;
                        
                    case 41:{
                        self.arr_rt_serial_listing4 = object_TM.arr_rt_serial_numbers;
                        txt_4_serial.text = self.arr_rt_serial_listing4[0];
                    }
                        break;
                        
                    case 51:{
                        self.arr_rt_serial_listing5 = object_TM.arr_rt_serial_numbers;
                        txt_5_serial.text = self.arr_rt_serial_listing5[0];
                    }
                        break;
                        
                    case 61:{
                        self.arr_rt_serial_listing6 = object_TM.arr_rt_serial_numbers;
                        txt_6_serial.text = self.arr_rt_serial_listing6[0];
                    }
                        break;
                        
                    case 71:{
                        self.arr_rt_serial_listing7 = object_TM.arr_rt_serial_numbers;
                        txt_7_serial.text = self.arr_rt_serial_listing7[0];
                    }
                        break;
                        
                    case 81:{
                        self.arr_rt_serial_listing8 = object_TM.arr_rt_serial_numbers;
                        txt_8_serial.text = self.arr_rt_serial_listing8[0];
                    }
                        break;
                        
                    case 91:{
                        self.arr_rt_serial_listing9 = object_TM.arr_rt_serial_numbers;
                        txt_9_serial.text = self.arr_rt_serial_listing9[0];
                    }
                        break;
                        
                    case 101:{
                        self.arr_rt_serial_listing10 = object_TM.arr_rt_serial_numbers;
                        txt_10_serial.text = self.arr_rt_serial_listing10[0];
                    }
                        break;
                        
                }
                
            }
        });
    });
    
}

-(void)getAvailableInventoryList{
    view6.hidden = NO;
    view7.hidden = NO;
    view8.hidden = NO;
    view9.hidden = NO;
    view10.hidden = NO;
    
    object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("InventoryCount", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    
    dispatch_async(myQueue, ^{
        NSDictionary *dicti =[object_TV getStockTakeMachinesListOfRT:RT_ID];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM  = [[TicketFormModel alloc] initWithDictionary:dicti];
                NSArray *temp               = [NSArray new];
                NSDictionary *tempDict      = [NSDictionary new];
                
                
                
                if ([object_TM.msg isEqualToString:@"Record not found"]) {
                    [[[UIAlertView alloc] initWithTitle:@"Message!" message:@"Inventory Record not found!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                }
                else{
                    temp                    = object_TM.arr_inventory_on_hand;
                    tempDict                = temp[0];
                    
                    for (int index = 0; index <=9; index++) {
                        switch (index) {
                            case 0:{
                                if ([temp[index][@"serial_numbers"]count]!=0) {
                                    txt_1_serial.text = temp[index][@"serial_numbers"][0][@"serial_number"];
                                }
                                else{
                                    txt_1_serial.text = @"NA";
                                }
                                
                                txt_1_machine.text = temp[index][@"item_name"];
                                txt_1_manufacture.text = temp[index][@"item_id"];
                                
                                lbl_onHand1.text    = temp[index][@"on_hand"];
                                lbl_available1.text = temp[index][@"available"];
                            }
                                break;
                            case 1:{
                                if ([temp[index][@"serial_numbers"]count]!=0) {
                                    txt_2_serial.text = temp[index][@"serial_numbers"][0][@"serial_number"];
                                }
                                else{
                                    txt_2_serial.text = @"NA";
                                }
                                
                                txt_2_machine.text = temp[index][@"item_name"];
                                txt_2_manufacture.text = temp[index][@"item_id"];
                                
                                lbl_onHand2.text    = temp[index][@"on_hand"];
                                lbl_available2.text = temp[index][@"available"];
                            }
                                break;
                                
                            case 2:{
                                if ([temp[index][@"serial_numbers"]count]!=0) {
                                    txt_3_serial.text = temp[index][@"serial_numbers"][0][@"serial_number"];
                                    
                                }
                                else{
                                    txt_3_serial.text = @"NA";
                                }
                                
                                txt_3_machine.text = temp[index][@"item_name"];
                                txt_3_manufacture.text = temp[index][@"item_id"];
                                
                                lbl_onHand3.text    = temp[index][@"on_hand"];
                                lbl_available3.text = temp[index][@"available"];
                            }
                                break;
                                
                            case 3:{
                                if ([temp[index][@"serial_numbers"]count]!=0) {
                                    txt_4_serial.text = temp[index][@"serial_numbers"][0][@"serial_number"];
                                    
                                }
                                else{
                                    txt_4_serial.text = @"NA";
                                }
                                
                                txt_4_machine.text = temp[index][@"item_name"];
                                txt_4_manufacture.text = temp[index][@"item_id"];
                                
                                lbl_onHand4.text    = temp[index][@"on_hand"];
                                lbl_available4.text = temp[index][@"available"];
                            }
                                break;
                            case 4:{
                                if ([temp[index][@"serial_numbers"]count]!=0) {
                                    txt_5_serial.text = temp[index][@"serial_numbers"][0][@"serial_number"];
                                    
                                }
                                else{
                                    txt_5_serial.text = @"NA";
                                }
                                
                                txt_5_machine.text = temp[index][@"item_name"];
                                txt_5_manufacture.text = temp[index][@"item_id"];
                                
                                lbl_onHand5.text    = temp[index][@"on_hand"];
                                lbl_available5.text = temp[index][@"available"];
                            }
                                break;
                            case 5:{
                                if ([temp[index][@"serial_numbers"]count]!=0) {
                                    txt_6_serial.text = temp[index][@"serial_numbers"][0][@"serial_number"];
                                    
                                }
                                else{
                                    txt_6_serial.text = @"NA";
                                }
                                
                                txt_6_machine.text = temp[index][@"item_name"];
                                txt_6_manufacture.text = temp[index][@"item_id"];
                                
                                lbl_onHand6.text    = temp[index][@"on_hand"];
                                lbl_available6.text = temp[index][@"available"];
                            }
                                break;
                            case 6:{
                                if ([temp[index][@"serial_numbers"]count]!=0) {
                                    txt_7_serial.text = temp[index][@"serial_numbers"][0][@"serial_number"];
                                    
                                }
                                else{
                                    txt_7_serial.text = @"NA";
                                }
                                
                                txt_7_machine.text = temp[index][@"item_name"];
                                txt_7_manufacture.text = temp[index][@"item_id"];
                                
                                lbl_onHand7.text    = temp[index][@"on_hand"];
                                lbl_available7.text = temp[index][@"available"];
                            }
                                break;
                            case 7:{
                                if ([temp[index][@"serial_numbers"]count]!=0) {
                                    txt_8_serial.text = temp[index][@"serial_numbers"][0][@"serial_number"];
                                    
                                }
                                else{
                                    txt_8_serial.text = @"NA";
                                }
                                
                                txt_8_machine.text = temp[index][@"item_name"];
                                txt_8_manufacture.text = temp[index][@"item_id"];
                                
                                lbl_onHand8.text    = temp[index][@"on_hand"];
                                lbl_available8.text = temp[index][@"available"];
                            }
                                break;
                            case 8:{
                                if ([temp[index][@"serial_numbers"]count]!=0) {
                                    txt_9_serial.text = temp[index][@"serial_numbers"][0][@"serial_number"];
                                    
                                }
                                else{
                                    txt_9_serial.text = @"NA";
                                }
                                
                                txt_9_machine.text = temp[index][@"item_name"];
                                txt_9_manufacture.text = temp[index][@"item_id"];
                                
                                lbl_onHand9.text    = temp[index][@"on_hand"];
                                lbl_available9.text = temp[index][@"available"];
                            }
                                break;
                            case 9:{
                                if ([temp[index][@"serial_numbers"]count]!=0) {
                                    txt_10_serial.text = temp[index][@"serial_numbers"][0][@"serial_number"];
                                    
                                }
                                else{
                                    txt_10_serial.text = @"NA";
                                }
                                txt_10_machine.text = temp[index][@"item_name"];
                                txt_10_manufacture.text = temp[index][@"item_id"];
                                
                                lbl_onHand10.text   = temp[index][@"on_hand"];
                                lbl_available10.text= temp[index][@"available"];
                            }
                                break;
                                
                                
                            default:
                                break;
                        }
                    }
                }
            }
        });
    });
}

-(void)getInventoryCountOfItem:(NSString*)item_id tag:(int)tag{
    object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("InventoryCount", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        NSDictionary *dicti =[object_TV getInventoryCountsOfRT:RT_ID item_id:item_id];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM  = [[TicketFormModel alloc] initWithDictionary:dicti];
                NSArray *temp               = [NSArray new];
                NSDictionary *tempDict      = [NSDictionary new];
                
                lbl_onHand1.text    = @"";
                lbl_available1.text = @"";
                lbl_onHand2.text    = @"";
                lbl_available2.text = @"";
                lbl_onHand3.text    = @"";
                lbl_available3.text = @"";
                lbl_onHand4.text    = @"";
                lbl_available4.text = @"";
                lbl_onHand5.text    = @"";
                lbl_available5.text = @"";
                lbl_onHand6.text    = @"";
                lbl_available6.text = @"";
                lbl_onHand7.text    = @"";
                lbl_available7.text = @"";
                lbl_onHand8.text    = @"";
                lbl_available8.text = @"";
                lbl_onHand9.text    = @"";
                lbl_available9.text = @"";
                lbl_onHand10.text   = @"";
                lbl_available10.text= @"";
                
                if ([object_TM.msg isEqualToString:@"Record not found"]) {
                    [[[UIAlertView alloc] initWithTitle:@"Message!" message:@"Inventory Record not found!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                }
                else{
                    temp                    = object_TM.arr_inventory_on_hand;
                    tempDict                = temp[0];
                    
                    
                    switch (tag) {
                            
                        case 11:{
                            lbl_onHand1.text    = tempDict[@"on_hand"];
                            lbl_available1.text = tempDict[@"available"];
                        }
                            break;
                            
                        case 21:{
                            lbl_onHand2.text    = tempDict[@"on_hand"];
                            lbl_available2.text = tempDict[@"available"];
                        }
                            break;
                            
                        case 31:{
                            lbl_onHand3.text    = tempDict[@"on_hand"];
                            lbl_available3.text = tempDict[@"available"];
                        }
                            break;
                            
                        case 41:{
                            lbl_onHand4.text    = tempDict[@"on_hand"];
                            lbl_available4.text = tempDict[@"available"];
                        }
                            break;
                            
                        case 51:{
                            lbl_onHand5.text    = tempDict[@"on_hand"];
                            lbl_available5.text = tempDict[@"available"];
                        }
                            break;
                            
                        case 61:{
                            lbl_onHand6.text    = tempDict[@"on_hand"];
                            lbl_available6.text = tempDict[@"available"];
                        }
                            break;
                            
                        case 71:{
                            lbl_onHand7.text    = tempDict[@"on_hand"];
                            lbl_available7.text = tempDict[@"available"];
                        }
                            break;
                            
                        case 81:{
                            lbl_onHand8.text    = tempDict[@"on_hand"];
                            lbl_available8.text = tempDict[@"available"];
                        }
                            break;
                            
                        case 91:{
                            lbl_onHand9.text    = tempDict[@"on_hand"];
                            lbl_available9.text = tempDict[@"available"];
                        }
                            break;
                            
                        case 101:{
                            lbl_onHand10.text    = tempDict[@"on_hand"];
                            lbl_available10.text = tempDict[@"available"];
                        }
                            break;
                    }
                }
            }
        });
    });
}


#pragma mark - Popovers

-(void)showPopover:(UIButton*)sender{
    dropdownsTableviewCon.tableView.contentOffset = CGPointMake(0, 0);
    [popoverCon presentPopoverFromRect:CGRectMake(sender.frame.size.width / 2, sender.frame.size.height / 1, 1, 1) inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(void)showPopoverDown:(UIButton*)sender{
    dropdownsTableviewCon.tableView.contentOffset = CGPointMake(0, 0);
    [popoverCon presentPopoverFromRect:CGRectMake(sender.frame.size.width / 2, sender.frame.size.height / 1-40, 1, 1) inView:sender permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

-(void)selectOne:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_machine_listing;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250,500);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectTwo:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_machine_listing;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250,500);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectThree:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_machine_listing;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250,500);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectFour:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_machine_listing;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250,500);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectFive:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_machine_listing;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250,500);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectSix:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_machine_listing;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250,500);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectSeven:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_machine_listing;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250,500);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectEight:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_machine_listing;
    
    [self showPopoverDown:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250,500);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectNine:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_machine_listing;
    
    [self showPopoverDown:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250,500);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectTen:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_machine_listing;
    
    [self showPopoverDown:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250,500);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

#pragma mark - Serials



-(void)selectSerialOne:(UIButton*)sender{
    
    self.arr_dropdown = self.arr_rt_serial_listing1;
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(200,500);
    [popoverCon setPopoverContentSize:CGSizeMake(200, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectSerialTwo:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_serial_listing2;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(200,500);
    [popoverCon setPopoverContentSize:CGSizeMake(200, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectSerialThree:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_serial_listing3;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(200,500);
    [popoverCon setPopoverContentSize:CGSizeMake(200, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectSerialFour:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_serial_listing4;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(200,500);
    [popoverCon setPopoverContentSize:CGSizeMake(200, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectSerialFive:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_serial_listing5;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(200,500);
    [popoverCon setPopoverContentSize:CGSizeMake(200, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectSerialSix:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_serial_listing6;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(200,500);
    [popoverCon setPopoverContentSize:CGSizeMake(200, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectSerialSeven:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_serial_listing7;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(200,500);
    [popoverCon setPopoverContentSize:CGSizeMake(200, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectSerialEight:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_serial_listing8;
    
    [self showPopoverDown:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(200,500);
    [popoverCon setPopoverContentSize:CGSizeMake(200, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectSerialNine:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_serial_listing9;
    
    [self showPopoverDown:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(200,500);
    [popoverCon setPopoverContentSize:CGSizeMake(200, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectSerialTen:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_serial_listing10;
    
    [self showPopoverDown:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(200,500);
    [popoverCon setPopoverContentSize:CGSizeMake(200, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}



#pragma mark - UITextField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    universalTextField = textField;
    
    d_point = d_scrollView.contentOffset;
    
    CGPoint point;
    CGRect rect = [textField bounds];
    rect        = [textField convertRect:rect toView:d_scrollView];
    point       = rect.origin;
    point.x     = 0;
    point.y     -= 120;
    [UIView animateWithDuration:0.5 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
    
}





@end
