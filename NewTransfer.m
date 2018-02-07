//
//  NewTransfer.m
//  RT APP
//
//  Created by Anil Prasad on 10/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "NewTransfer.h"
#import "HistoryCell.h"
#import "TicketFormView.h"
#import "TicketFormModel.h"
#import "NewTransferModel.h"
#import "NewTransferView.h"

@interface NewTransfer (){
    TicketFormView *object_TV;
    NewTransferView *object_TFV;

}

@end

@implementation NewTransfer
@synthesize isFromTransferTicket;

-(void)onKeyboardHide:(NSNotification *)notification
{
    CGPoint point = CGPointMake(0,0);
    [UIView animateWithDuration:0.5 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    d_scrollView.contentSize            = CGSizeMake(880, 1700); // 1950
    d_scrollView.contentOffset          = CGPointMake(0,0);
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    arr_added_listings              = [[NSMutableArray alloc] init];
    btn_submit.enabled              = NO;
    
    NSDateFormatter *FormatDate     = [[NSDateFormatter alloc] init];
    [FormatDate setLocale: [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [FormatDate setDateFormat:@"dd/MM/yy"]; // dd/MM/YYYY
    NSString *dateStr               = [FormatDate stringFromDate:[NSDate date]];
    arryDate                        = (NSMutableArray *)[dateStr componentsSeparatedByString:@"/"];
    NSString *day                   = [arryDate objectAtIndex:0];
    NSString *month                 = [arryDate objectAtIndex:1];
    NSString *year                  = [arryDate objectAtIndex:2];
    NSString *selectedDate          = [NSString stringWithFormat:@"%@/%@/%@", month, day, year];
    txt_date.text                   = selectedDate;
    today_date                      = selectedDate;
    
    // Calendar
    popoverViewConDate              = [UIViewController new];
    popoverViewConDate.view.frame   = CGRectMake(300, 200, 300, 530);
    
    datePicker                      = [[UIDatePicker alloc] initWithFrame:CGRectMake (-160, 10, 650, 600)];
    datePicker.datePickerMode       = UIDatePickerModeDate;
    popoverViewConDate.view         = datePicker;
    
    popoverConDate                  = [[UIPopoverController alloc] initWithContentViewController:popoverViewConDate];
    popoverConDate.popoverContentSize = CGSizeMake(300, 180);
    popoverConDate.delegate         = self;
    
    // States
    popoverViewCon                              = [[UIViewController alloc]init];
    dropdownsTableviewCon                       = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    popoverViewCon.preferredContentSize         = CGSizeMake(200,300);
    dropdownsTableviewCon.tableView.delegate    = self;
    dropdownsTableviewCon.tableView.dataSource  = self;
    
    dropdownsTableviewCon.tableView.frame       = CGRectMake(0, 0, CGRectGetWidth(popoverViewCon.view.bounds),
                                                             CGRectGetHeight(popoverViewCon.view.bounds));
    
    [popoverViewCon.view addSubview:dropdownsTableviewCon.tableView];
    popoverCon = [[UIPopoverController alloc] initWithContentViewController:popoverViewCon];
    popoverViewCon.preferredContentSize = CGSizeMake(200,300);
    [popoverCon setPopoverContentSize:CGSizeMake(200, 200) animated:NO];
    popoverCon.delegate = self;
    
    [self callWebserviceForDropdowns];
}

-(void)callWebserviceForDropdowns{
    
    object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Dropdown", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dicti =[object_TV getArraysForDropdowns:RT_ID];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM  = [[TicketFormModel alloc] initWithDictionary:dicti];
                arr_rt_listing              = [object_TM.arr_rt_listing mutableCopy];
                NSMutableDictionary *headOffice_dict = [NSMutableDictionary new];
                headOffice_dict = [arr_rt_listing[0] mutableCopy];
                [headOffice_dict setObject:@"000" forKey:@"rt_id"];
                [headOffice_dict setObject:@"Head Office" forKey:@"rt_name"];
                NSDictionary *te = headOffice_dict;
                [arr_rt_listing insertObject:te atIndex:0];
                
                
                [dropdownsTableviewCon.tableView reloadData];
                
                if (isFromTransferTicket) {
                    
                    arr_rt_item_listing = self.arr_fromInventory;
                    [n_transfersTable reloadData];
                    
                    [self callWebServiceForSendReceiveItems:RT_ID];
                }
                else{
                    [self callWebServiceForAvailableItemsOfRT:RT_ID];
                }
            }
        });
    });
}

-(void)callWebServiceForAvailableItemsOfRT:(NSString*)ID{

    
    object_TFV = [NewTransferView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("NewTransferItems", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        NSDictionary *dict =[object_TFV getItemsOfRT:ID];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dict)
            {
                NewTransferModel *object_TFM = [[NewTransferModel alloc] initWithDictionary:dict];
                arr_rt_item_listing = [object_TFM.arr_inventory_on_hand mutableCopy];
               
                                                 
                [n_transfersTable reloadData];
                
                [self callWebServiceForSendReceiveItems:RT_ID];
            }
        });
    });
}

-(void)callWebServiceForSendReceiveItems:(NSString*)ID{
    object_TFV = [NewTransferView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("NewTransferItems1", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        NSDictionary *dict =[object_TFV getAcknowledgeItemsList:RT_ID];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dict)
            {
                NewTransferModel *object_TFM = [[NewTransferModel alloc] initWithDictionary:dict];
                
                arr_rt_transfer_listing = [object_TFM.arr_rt_transfer_listing mutableCopy];
                [n_transfersTable2 reloadData];
            }
        });
    });
}


-(void)callWebServiceSubmitNewTransfer{
    
    [universalTextField resignFirstResponder];
    
    if (![self checkJSON]) {
        [[AppDelegate sharedInstance] showAlertMessage:@"Transfer quantity can not exceed quantity on hand!"];
    }
    else{
        NSString *json_string = [self jsonString];
        
        if (arr_added_listings.count == 0) {
            [[AppDelegate sharedInstance] showAlertMessage:@"Please select at least one item!"];
        }
        else{
            object_TFV = [NewTransferView new];
            
            dispatch_queue_t myQueue = dispatch_queue_create("NewTransfer", 0);
            
            [[AppDelegate sharedInstance] showCustomLoader:self];
            dispatch_async(myQueue, ^{
                NSDictionary *dict =[object_TFV submitTransferOfRT:RT_ID
                                                             to_id:to_location
                                                     transfer_date:today_date
                                                      json_request:json_string];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[AppDelegate sharedInstance] removeCustomLoader];
                    
                    if(dict)
                    {
                        NewTransferModel *object_TFM = [[NewTransferModel alloc] initWithDictionary:dict];
                        NSLog(@"%@", object_TFM.msg);
                        [[AppDelegate sharedInstance] showAlertMessage:object_TFM.msg];
                        
                        txt_rtName.text     = @"";
                        to_location         = @"";
                        btn_submit.enabled  = NO;
                        // [arr_rt_item_listing removeAllObjects];
                        [self callWebServiceForAvailableItemsOfRT:RT_ID];
                        
                        [n_transfersTable reloadData];
                        
                        CGPoint point = CGPointMake(0,0);
                        [UIView animateWithDuration:0.5 animations:^{
                            [d_scrollView setContentOffset:point animated:NO];
                        }];
                    }
                });
            });
        } // transfer quantity can't exceed transfer on hand!

    }
    
}

-(BOOL)checkJSON{
    
    BOOL status;
    for (NSDictionary *saveDict in arr_added_listings) {
        
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

-(NSString*)jsonString{
    NSMutableArray *saveArray = [[NSMutableArray alloc] init];

    for (NSDictionary *saveDict in arr_added_listings) {
        
        NSString *quantity = [saveDict valueForKey:@"quantity"];
        
        if ([quantity isEqualToString:@""]) {
            quantity = @"0";
        }
         NSString *item = [NSString stringWithFormat:@"{\"item_id\": \"%@\",\"quantity\": %@}", [saveDict valueForKey:@"item_id"], quantity];
        [saveArray addObject:item];

    }
    
    
    NSString *str_itemArray = [saveArray componentsJoinedByString:@","];
    NSString *json_item     = [NSString stringWithFormat:@"{\"items\":[%@]}",str_itemArray];
    
    NSLog(@"ITEM: %@", arr_added_listings);
    return json_item;
    
}

-(NSString*)getJsonItemFromTable{
    NSMutableArray *saveArray = [[NSMutableArray alloc] init];
    
    for (int count = 0; arr_rt_item_listing.count > count; count++) {
        
       
        
        
        
        NSIndexPath *indexPath          = [NSIndexPath indexPathForRow:count inSection:0];
        UITableViewCell *cell           = [n_transfersTable cellForRowAtIndexPath:indexPath];
        NSMutableDictionary *saveDict   = [[NSMutableDictionary alloc] init];
        
        for (UIView *view in cell.contentView.subviews) {
            if ([view isKindOfClass:[UITextField class]]){
                UITextField *txtQty     = (UITextField *)view;
                if ([txtQty.text isEqualToString:@""]) {
                    [saveDict setObject:@"0" forKey:@"amount_to"];
                }
                else{
                    [saveDict setObject:txtQty.text forKey:@"amount_to"];
                }
            }
            
            if ([view isKindOfClass:[UILabel class]]) {
                UILabel *itemID       = (UILabel*)view;
                UILabel *serialNum    = (UILabel*)view;
                UILabel *itemName     = (UILabel*)view;
                UILabel *qty          = (UILabel*)view;
                
                if (itemID.tag == 12) {
                    [saveDict setObject:itemID.text     forKey:@"item_id"];
                }
                if (itemName.tag == 13) {
                    [saveDict setObject:itemName.text   forKey:@"item_name"];
                }
                if (serialNum.tag == 14) {
                    [saveDict setObject:serialNum.text  forKey:@"serial_number"];
                }
                if (qty.tag == 15) {
                    [saveDict setObject:qty.text        forKey:@"quantity"];
                }
            }
        }
        
        if (![[saveDict valueForKey:@"amount_to"] isEqualToString:@"0"]){
            NSString *item = [NSString stringWithFormat:@"{\"item_id\": \"%@\",\"item_name\": \"%@\",\"serial_number\": \"%@\",\"quantity\": %@,\"amount_to\":%@}", [saveDict valueForKey:@"item_id"], [saveDict valueForKey:@"item_name"], [saveDict valueForKey:@"serial_number"], [saveDict valueForKey:@"quantity"], [saveDict valueForKey:@"amount_to"]];
            
            [saveArray addObject:item];
        }
    }
    
    
    NSString *str_itemArray = [saveArray componentsJoinedByString:@","];
    NSString *json_item     = [NSString stringWithFormat:@"{\"items\":[%@]}",str_itemArray];
    
    //NSLog(@"ITEM: %@", json_item);
    return json_item;
}


-(IBAction)actionForButton:(UIButton*)sender{
    switch (sender.tag) {
        case 11:{
            txt_rtName.text     = @"";
            btn_submit.enabled  = NO;
            [arr_rt_item_listing removeAllObjects];
            
            [self callWebServiceForAvailableItemsOfRT:RT_ID];
            
            [n_transfersTable reloadData];
            
            CGPoint point = CGPointMake(0,0);
            [UIView animateWithDuration:0.5 animations:^{
                [d_scrollView setContentOffset:point animated:NO];
            }];
        }
            break;
        case 12:{
            [self callWebServiceSubmitNewTransfer];
        }
            break;
        case 13:{
            [self.navigationController popViewControllerAnimated:NO];
        }
            break;
        case 14:{
            //[self selectDate:sender];
        }
            break;
        case 15:{
            [self selectRTName:sender];
        }
            break;
            
        default:
            break;
    }
}

-(void)selectDate:(UIButton*)sender{
    CGRect frame                    = sender.frame;
    int y                           = frame.origin.y;
    int x                           = frame.origin.x;
    
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    [datePicker setDate:[NSDate date]];
    datePicker.backgroundColor      = [UIColor clearColor];
    
    [dateFormatter setDateFormat:@"dd/MM/yy"];
    [datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    
    [popoverConDate presentPopoverFromRect:CGRectMake(x+90,y+30, 2, 2)
                                    inView:d_scrollView
                  permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (void)dateChanged
{
    NSDateFormatter *FormatDate = [[NSDateFormatter alloc] init];
    [FormatDate setLocale: [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [FormatDate setDateFormat:@"dd/MM/yy"]; // dd/MM/YYYY
    NSString *dateStr           = [FormatDate stringFromDate:[datePicker date]];
    
    [self getSelectedDate:dateStr];
}

- (void)getSelectedDate:(NSString *)daStr {
    
    [arryDate removeAllObjects];
    arryDate                = (NSMutableArray *)[daStr componentsSeparatedByString:@"/"];
    NSString *day           = [arryDate objectAtIndex:0];
    NSString *month         = [arryDate objectAtIndex:1];
    NSString *year          = [arryDate objectAtIndex:2];
    NSString *selectedDate  = [NSString stringWithFormat:@"%@/%@/%@", month, day, year];
    txt_date.text           = selectedDate;
}

-(void)selectRTName:(UIButton*)sender{
    dropdownsTableviewCon.tableView.contentOffset = CGPointMake(0, 0);
    [popoverCon presentPopoverFromRect:CGRectMake(sender.frame.size.width / 2, sender.frame.size.height-5, 1, 1) inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}


#pragma mark - UITableView Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == dropdownsTableviewCon.tableView) {
        return arr_rt_listing.count;
    }
    else if (tableView == n_transfersTable){
        return arr_rt_item_listing.count;
    }
    else
        return arr_rt_transfer_listing.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == dropdownsTableviewCon.tableView) {
        UITableViewCell *cell_table;
        static NSString * strID = @"dropDownList";
        cell_table = [tableView dequeueReusableCellWithIdentifier:strID];
        if (!cell_table) {
            cell_table = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
        }
        
        cell_table.textLabel.text = arr_rt_listing[indexPath.row][@"rt_name"];
        
        return cell_table;
    }
    else if (tableView == n_transfersTable){
        static NSString *str = @"NewTransfer";
        HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        [cell customizeLabelInCell];
        
        cell.lblnt_serial.text      = [NSString stringWithFormat:@"%d", indexPath.row+1];
        cell.lblnt_itemID.text      = arr_rt_item_listing[indexPath.row][@"item_id"];
        cell.lblnt_itemName.text    = arr_rt_item_listing[indexPath.row][@"item_name"];
        cell.lblnt_serialNum.text   = arr_rt_item_listing[indexPath.row][@"serial_number"];
        cell.lblnt_qtyOnHand.text   = arr_rt_item_listing[indexPath.row][@"on_hand"];
        
//        cell.lblnt_amountTo.text    = @"";
        cell.txtnt_amountTo.text    = arr_rt_item_listing[indexPath.row][@"quantity"];
        cell.txtnt_amountTo.tag     = indexPath.row;
        
        return cell;
    }
    else{
        static NSString *str = @"NewTransfer2";
        HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        [cell customizeLabelInCell];
        
        cell.lblnta_serial.text      = [NSString stringWithFormat:@"%d", indexPath.row+1];
        cell.lblnta_itemID.text      = arr_rt_transfer_listing[indexPath.row][@"item_id"];
        cell.lblnta_itemName.text    = arr_rt_transfer_listing[indexPath.row][@"item_name"];
        cell.txtnta_sent.text        = arr_rt_transfer_listing[indexPath.row][@"sent"];
        cell.txtnta_received.text    = arr_rt_transfer_listing[indexPath.row][@"receive"];
        
        [cell.btnta_acknowledge setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
        
        NSDictionary *ddd = [arr_rt_transfer_listing objectAtIndex:indexPath.row];
        int received = [ddd[@"receive"] integerValue];
        
        if (received >= 1) {
            cell.btnta_acknowledge.enabled = YES;
        }
        else{
            cell.btnta_acknowledge.enabled = NO;
        }

        if ([arr_rt_transfer_listing[indexPath.row][@"acknowledge"] isEqual:@"1"]) {
            if (cell.btnta_acknowledge.enabled) {
                [cell.btnta_acknowledge setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
            }
        }
        else{
            [cell.btnta_acknowledge setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
        }
        
        cell.btnta_acknowledge.tag = indexPath.row;
        [cell.btnta_acknowledge addTarget:self action:@selector(acknowledgeCheck:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
}

-(void)acknowledgeCheck:(UIButton*)sender{
    
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    else{
        [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
    
    object_TFV = [NewTransferView new];
    NSDictionary *ddd = [arr_rt_transfer_listing objectAtIndex:sender.tag];
    
    dispatch_queue_t myQueue = dispatch_queue_create("NewTransferItems1", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        NSDictionary *dict =[object_TFV markAcknowledgedForRT:RT_ID forTransfer:ddd[@"transfer_id"] acknowledged:@"1"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dict)
            {
                [self callWebServiceForSendReceiveItems:RT_ID];
            }
        });
    });
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == dropdownsTableviewCon.tableView){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        txt_rtName.text = arr_rt_listing[indexPath.row][@"rt_name"];
        to_location     = arr_rt_listing[indexPath.row][@"rt_id"];
        [popoverCon dismissPopoverAnimated:YES];

//        [arr_rt_item_listing removeAllObjects];
//        [n_transfersTable reloadData];
        btn_submit.enabled  = YES;
        
//        [self callWebServiceForAvailableItemsOfRT:to_location];
        
    }
    
}


#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    universalTextField = textField;
    
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

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [universalTextField resignFirstResponder];
    
    NSMutableDictionary *ddict  = [[NSMutableDictionary alloc] init];
    ddict                       = [NSMutableDictionary dictionaryWithDictionary:[arr_rt_item_listing objectAtIndex:universalTextField.tag]];
    
    [ddict setObject:universalTextField.text forKey:@"quantity"];
    [arr_rt_item_listing replaceObjectAtIndex:universalTextField.tag withObject:ddict];
    
    [arr_added_listings addObject:ddict];
    
    [n_transfersTable beginUpdates];
    [n_transfersTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:universalTextField.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [n_transfersTable endUpdates];
    
}

@end
