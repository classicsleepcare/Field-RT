//
//  OrdersAndTransfersVC.m
//  RT APP
//
//  Created by Anil Prasad on 02/12/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "OrdersAndTransfersVC.h"
#import "HistoryCell.h"
#import "OrdersVC.h"
#import "TransfersVC.h"
#import "NewTransfer.h" 
#import "OrdersTransfersModel.h"
#import "OrdersTransfersView.h"
#import "OrderDetailVC.h"
#import "OrderDetailViewOnly.h"

NSString *testVar = @"first test";

@interface OrdersAndTransfersVC ()
{
    OrdersTransfersView *object_OV;
}
@end

@implementation OrdersAndTransfersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // [self showOrdersList];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showOrdersList];
}

-(IBAction)actionForButton:(UIButton*)sender{
    switch (sender.tag) {
        case 11:{
            [self showOrdersList];
        }
            break;
        case 12:{
            [self showTransfersList];
        }
            break;
        case 13:{
            [self createNewTransfer];
        }
            break;
            
        default:
            break;
    }
}

-(void)showOrdersList{
    
    object_OV = [OrdersTransfersView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Orders", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        NSDictionary *dict =[object_OV getOrderListings:RT_ID]; //RT_ID
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dict)
            {
                OrdersTransfersModel *object_OM = [[OrdersTransfersModel alloc] initWithDictionary:dict];
                
                [img_segment_bg setImage:[UIImage imageNamed:@"tab_order.png"]];
                transfersTable.hidden   = YES;
                ordersTable.hidden      = NO;
                btn_newTransfer.hidden  = NO;
                lbl_header.text         = @"In Transit Orders to Recieve";
                
                if ([object_OM.msg isEqualToString:@"records not found"]) {
                    [[AppDelegate sharedInstance] showAlertMessage:@"No Orders available yet"];
                }
                else{
                    
//                    [img_segment_bg setImage:[UIImage imageNamed:@"tab_order.png"]];
//                    transfersTable.hidden   = YES;
//                    ordersTable.hidden      = NO;
//                    btn_newTransfer.hidden  = NO;
//                    lbl_header.text         = @"In Transit Orders to Recieve";
                    
//                    arr_rt_order_listing = object_OM.arr_rt_order_listing;
                    
                    NSMutableArray *tempOrders = [NSMutableArray new];
                    for (NSDictionary *order in object_OM.arr_rt_order_listing) {
                        if (![order[@"status"] isEqualToString:@"Closed"]) {
                            [tempOrders addObject:order];
                        }
                    }
                    
                    arr_rt_order_listing = [tempOrders mutableCopy];
                    
                    [ordersTable reloadData];
                }
            }
        });
    });
}

-(void)showTransfersList{
    
    object_OV = [OrdersTransfersView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Transfers", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        NSLog(@"RT_ID: %@", RT_ID);
        NSDictionary *dict =[object_OV getTransferListings:RT_ID]; //RT_ID
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dict)
            {
                OrdersTransfersModel *object_OM = [[OrdersTransfersModel alloc] initWithDictionary:dict];
                
                [img_segment_bg setImage:[UIImage imageNamed:@"tab_transfer.png"]];
                lbl_header.text         = @"Transfers To Receive";
                ordersTable.hidden      = YES;
                transfersTable.hidden   = NO;
                btn_newTransfer.hidden  = YES;
                
                if ([object_OM.msg isEqualToString:@"records not found"]) {
                    [[AppDelegate sharedInstance] showAlertMessage:@"No Transfers available yet"];
                }
                else{
                    
//                    [img_segment_bg setImage:[UIImage imageNamed:@"tab_transfer.png"]];
//                    lbl_header.text         = @"Transfers To Receive";
//                    ordersTable.hidden      = YES;
//                    transfersTable.hidden   = NO;
//                    btn_newTransfer.hidden  = YES;
                    
                    arr_rt_transfer_listing = object_OM.arr_rt_transfer_listing;
                    [transfersTable reloadData];
                }
            }
        });
    });
}

-(void)createNewTransfer{
    NewTransfer *n_transfer = [self.storyboard instantiateViewControllerWithIdentifier:@"NTR"];
    [self.navigationController pushViewController:n_transfer animated:NO];
}

#pragma mark - UITableView Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == transfersTable) {
        return arr_rt_transfer_listing.count;
    }
    else
        return arr_rt_order_listing.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == ordersTable) {
        static NSString *str            = @"Orders";
        HistoryCell *cell               = [tableView dequeueReusableCellWithIdentifier:str];
        
        cell.lblO_orderNum.text         = arr_rt_order_listing[indexPath.row][@"order_number"];
        cell.lblO_dateShipped.text      = arr_rt_order_listing[indexPath.row][@"date_shipped"];
        NSArray *items_receiving        = arr_rt_order_listing[indexPath.row][@"items_receiving"];
        NSString *items                 = [items_receiving componentsJoinedByString:@","];
        
        cell.lblO_items.text            = items;
        cell.lblO_status.text           = arr_rt_order_listing[indexPath.row][@"status"];
        
        return cell;
    }
    else{
        static NSString *str            = @"Transfers";
        HistoryCell *cell               = [tableView dequeueReusableCellWithIdentifier:str];
        
        cell.lblt_transferTitle.text    = [NSString stringWithFormat:
                                           @"Transfer from %@",arr_rt_transfer_listing[indexPath.row][@"from_location_name"]];
        cell.lblt_date.text             = arr_rt_transfer_listing[indexPath.row][@"transfer_date"];
        cell.lblt_notes.text            = arr_rt_transfer_listing[indexPath.row][@"note"];
        
        NSArray *items_receiving        = arr_rt_transfer_listing[indexPath.row][@"items_receiving"];
        NSString *items                 = [items_receiving componentsJoinedByString:@","];
        
        cell.lblt_items.text            = items;
        

        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == ordersTable){
        OrderDetailVC *orderDetail      = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderDetailVC"];
        orderDetail.order_ID            = arr_rt_order_listing[indexPath.row][@"id"];
        orderDetail.date                = arr_rt_order_listing[indexPath.row][@"date_shipped"];
        
        NSArray *items_receiving        = arr_rt_order_listing[indexPath.row][@"items_receiving"];
        NSString *items                 = [items_receiving componentsJoinedByString:@","];
        orderDetail.items_receiving     = items;
        orderDetail.status              = arr_rt_order_listing[indexPath.row][@"status"];
        orderDetail.pt_notes            = arr_rt_order_listing[indexPath.row][@"pt_notes"];

        [orderDetail testingvariable];
        
        OrderDetailViewOnly
        *orderDetailViewOnly            = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderDetailViewOnly"];
        orderDetailViewOnly.order_ID            = arr_rt_order_listing[indexPath.row][@"id"];
        orderDetailViewOnly.date                = arr_rt_order_listing[indexPath.row][@"date_shipped"];
        orderDetailViewOnly.items_receiving     = items;
        orderDetailViewOnly.status              = arr_rt_order_listing[indexPath.row][@"status"];
        orderDetailViewOnly.pt_notes            = arr_rt_order_listing[indexPath.row][@"pt_notes"];
        
        [orderDetailViewOnly testingvariable];
        
        NSString *status = arr_rt_order_listing[indexPath.row][@"status"];
        if ([status isEqualToString:@"In Process"] ||
            [status isEqualToString:@"Ready To Ship"]) {
            orderDetailViewOnly.isReadOnly = YES;
            [self.navigationController pushViewController:orderDetailViewOnly animated:NO];
        }
        else{
            [self.navigationController pushViewController:orderDetail animated:NO];
        }
        
    }
    else{
        TransfersVC *transferDetail     = [self.storyboard instantiateViewControllerWithIdentifier:@"TDS"];
        transferDetail.transfer_ID      = arr_rt_transfer_listing[indexPath.row][@"id"];
        transferDetail.notes            = arr_rt_transfer_listing[indexPath.row][@"note"];
        NSArray *items_receiving        = arr_rt_transfer_listing[indexPath.row][@"items_receiving"];
        NSString *items                 = [items_receiving componentsJoinedByString:@","];
        transferDetail.items_receiving  = items;
        transferDetail.date             = arr_rt_transfer_listing[indexPath.row][@"transfer_date"];
        


        [self.navigationController pushViewController:transferDetail animated:NO];
    }
    
    
}

@end
