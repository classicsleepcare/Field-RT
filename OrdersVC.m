//
//  OrdersVC.m
//  RT APP
//
//  Created by Anil Prasad on 08/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "OrdersVC.h"
#import "HistoryCell.h"
#import "OrderDetailView.h"
#import "OrderDetailModel.h"

@interface OrdersVC (){
    OrderDetailView *object_OV;
}

@end

@implementation OrdersVC
@synthesize isViewMode;

-(void)onKeyboardHide:(NSNotification *)notification
{
    CGPoint point = CGPointMake(0,0);
    [UIView animateWithDuration:0.5 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    btn_red.enabled = NO;
    
    if (isViewMode) {
        btn_grey.enabled = NO;
        btn_grey.alpha = 0.5;
    }

    lbl_status.text = self.status;
    lbl_date_shipped.text = self.date;
    lbl_items.text = self.items_receiving;
    lbl_order_num.text = self.order_ID;
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    arr_orderDetailsReceived = [[NSMutableArray alloc] init];
    
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
    
    [self callWebServiceForOrderDetails];
}

-(void)callWebServiceForOrderDetails{
    object_OV = [OrderDetailView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Orders", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        NSDictionary *dict =[object_OV getOrderDetailsOfRT:RT_ID orderID:self.order_ID];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            
            if(dict)
            {
                OrderDetailModel *object_OM = [[OrderDetailModel alloc] initWithDictionary:dict];
                if ([object_OM.msg isEqualToString:@"records not found"]) {
                    [[AppDelegate sharedInstance] showAlertMessage:@"No Orders available yet"];
                }
                else{
                    from_Id                     = object_OM.from_location;
                    transfer_id                 = object_OM.transfer_id;
                    arr_orderDetails            = [object_OM.arr_items_receiving mutableCopy];
                    arr_orderDetailsReceived    = [object_OM.arr_items_receiving mutableCopy];
                    
                    
                    lbl_status.text = object_OM.status;
                    lbl_date_shipped.text = object_OM.date_shipped;
                    //lbl_order_num.text = self.order_ID;
                    
                    NSMutableArray *aaaa = [NSMutableArray new];
                    for (NSDictionary *ddd in object_OM.arr_items_receiving) {
                        [aaaa addObject:ddd[@"item_name"]];
                    }
                    
                    NSString *items = [aaaa componentsJoinedByString:@","];
                    lbl_items.text = items;

                    [orderDetailsTable reloadData];
                    [editableOrdersTable reloadData];
                }
            }
        });
    });
}

-(void)callWebServiceReceiveItems{
    
    [universalTextField resignFirstResponder];

    object_OV = [OrderDetailView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Orders", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        NSDictionary *dict =[object_OV receiveOrderOfRT:RT_ID transfer_id:transfer_id from_id:from_Id json_request:[self jsonString]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            
            if(dict)
            {
                OrderDetailModel *object_OM = [[OrderDetailModel alloc] initWithDictionary:dict];
                
                NSLog(@"%@", object_OM.msg);
//                [btn_grey setTitle:@"RECEIVE ITEMS" forState:UIControlStateNormal];
                //[btn_red setTitle:@"Close Order" forState:UIControlStateNormal];
                
                btn_red.enabled = NO;
                
                orderDetailsTable.hidden    = NO;
                editableOrdersTable.hidden  = YES;
                
                //[[AppDelegate sharedInstance] showAlertMessage:object_OM.msg];
                [[[UIAlertView alloc] initWithTitle:@"Message!" message:object_OM.msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            }
        });
    });

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSString*)jsonString{
    NSMutableArray *saveArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *saveDict in arr_orderDetails) {
        
        NSString *serial_number = [saveDict valueForKey:@"serial_number"];
        NSString *item_name     = [saveDict valueForKey:@"item_name"];
        
        if ([serial_number isEqualToString:@""]) {
            serial_number = @"0";
        }
        
        NSString *quantityReceived = [saveDict valueForKey:@"quantity"];
        
        
        
        NSString *item = [NSString stringWithFormat:@"{\"item_id\": \"%@\",\"quantityReceived\": %@}", [saveDict valueForKey:@"item_id"], quantityReceived];
        [saveArray addObject:item];
    }
    
    
    NSString *str_itemArray = [saveArray componentsJoinedByString:@","];
    NSString *json_item     = [NSString stringWithFormat:@"{\"items\":[%@]}",str_itemArray];
    
    NSLog(@"ITEM: %@", arr_orderDetails);
    return json_item;
    
}

-(void)showPopover:(UIButton*)sender{
    dropdownsTableviewCon.tableView.contentOffset = CGPointMake(0, 0);
    [popoverCon presentPopoverFromRect:CGRectMake(sender.frame.size.width / 2, sender.frame.size.height / 1, 1, 1) inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(void)showSerialNumbers:(UIButton*)sender{
    
    self.arr_serialNumbers = arr_orderDetails[sender.tag][@"serial_numbers"];
    self.arr_dropdown = self.arr_serialNumbers;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(230,200);
    [popoverCon setPopoverContentSize:CGSizeMake(230, 200) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
    
}

#pragma mark - Button Actions

-(IBAction)actionForButton:(UIButton*)sender{
    switch (sender.tag) {
        case 11:{
            
            orderDetailsTable.hidden    = NO;
            editableOrdersTable.hidden  = YES;
            
            [btn_grey setTitle:@"RECEIVE ITEMS" forState:UIControlStateNormal];
            //[btn_red setTitle:@"Close Order" forState:UIControlStateNormal];
            
            btn_red.enabled = NO;
            
            
        }
            break;
        case 12:{
            [self callWebServiceReceiveItems];
            
//            if ([sender.titleLabel.text isEqualToString:@"RECEIVE ITEMS"]) {
//                [self showReceiveItemsTable];
//            }
//            else{
//                [self callWebServiceReceiveItems];
//            }
        }
            break;
            
        case 13:{
            [self.navigationController popViewControllerAnimated:NO];
        }
            break;
            
        default:
            break;
    }
}

-(void)showReceiveItemsTable{
    [btn_grey setTitle:@"SUBMIT"    forState:UIControlStateNormal];
    //[btn_red setTitle:@"Cancel"     forState:UIControlStateNormal];
    
    btn_red.enabled = YES;
    
    editableOrdersTable.hidden  = NO;
    orderDetailsTable.hidden    = YES;
}


#pragma mark - UITableView Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:dropdownsTableviewCon.tableView]) {
        return self.arr_dropdown.count;
    }
    if (tableView == orderDetailsTable) {
        return  arr_orderDetails.count;
    }
    else
        return arr_orderDetailsReceived.count;
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
        cell_table.textLabel.textAlignment = NSTextAlignmentCenter;
        cell_table.textLabel.text   = [self.arr_dropdown objectAtIndex:indexPath.row];
        
        return cell_table;
    }
    else if (tableView == orderDetailsTable) {
        static NSString *str        = @"OrderDetail";
        HistoryCell *cell           = [tableView dequeueReusableCellWithIdentifier:str];
        [cell customizeLabelInCell];
        
        cell.lbld_serial.text       = [NSString stringWithFormat:@"%d", indexPath.row+1];
        cell.lbld_itemID.text       = arr_orderDetails[indexPath.row][@"item_id"];
        cell.lbld_itemName.text     = arr_orderDetails[indexPath.row][@"item_name"];
        //cell.lbld_serialNum.text    = arr_orderDetails[indexPath.row][@"serial_number"];
        cell.lbld_qtySent.text      = arr_orderDetails[indexPath.row][@"quantity"];
        //cell.lbld_qtyReceived.text  = @"";
        
        cell.lbld_action.text       = @"NA";
        
        cell.btnd_viewSerial.tag    = indexPath.row;
        
        self.arr_serialNumbers = arr_orderDetails[indexPath.row][@"serial_numbers"];

        if (self.arr_serialNumbers.count == 0) {
            [cell.btnd_viewSerial setTitle:@"No Serial" forState:UIControlStateNormal];
            [cell.btnd_viewSerial setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        else{
            [cell.btnd_viewSerial setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [cell.btnd_viewSerial addTarget:self action:@selector(showSerialNumbers:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        return cell;
    }
    else{
        static NSString *str        = @"EditOrderDetail";
        HistoryCell *cell           = [tableView dequeueReusableCellWithIdentifier:str];
        [cell customizeLabelInCell];
        
        cell.lbled_serial.text       = [NSString stringWithFormat:@"%d", indexPath.row+1];
        cell.lbled_itemID.text       = arr_orderDetailsReceived[indexPath.row][@"item_id"];
        cell.lbled_itemName.text     = arr_orderDetailsReceived[indexPath.row][@"item_name"];
        cell.lbled_serialNum.text    = arr_orderDetailsReceived[indexPath.row][@"serial_number"];
        cell.lbled_qtySent.text      = arr_orderDetailsReceived[indexPath.row][@"quantity"];
        //cell.lbled_qtyReceived.text  = arr_orderDetailsReceived[indexPath.row][@"quantityReceived"];
        cell.txted_qtyReceived.text  = arr_orderDetailsReceived[indexPath.row][@"quantityReceived"];
        cell.lbled_action.text       = @"NA";
        
        cell.txted_qtyReceived.tag   = indexPath.row;
        
        return cell;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%lu", (long)indexPath.row);
    [popoverCon dismissPopoverAnimated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    ddict                       = [NSMutableDictionary dictionaryWithDictionary:[arr_orderDetailsReceived objectAtIndex:universalTextField.tag]];
    
    [ddict setObject:universalTextField.text forKey:@"quantityReceived"];
    [arr_orderDetailsReceived replaceObjectAtIndex:universalTextField.tag withObject:ddict];
    
    [editableOrdersTable beginUpdates];
    [editableOrdersTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:universalTextField.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [editableOrdersTable endUpdates];
    
}




@end
