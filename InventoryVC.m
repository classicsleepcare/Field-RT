//
//  InventoryVC.m
//  RT APP
//
//  Created by Anil Prasad on 02/12/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "InventoryVC.h"
#import "HistoryCell.h"
#import "InventoryModel.h"
#import "InventoryView.h"
#import "SetUpTicketFormOne.h"
#import "NewTransfer.h"
#import "SetupTicketView.h"
#import "SetupTicketModel.h"
#import "OrdersVC.h"

@interface InventoryVC (){
    InventoryView *object_IV;
    SetupTicketView *object_SV;

    int dataCount;
}

@end

@implementation InventoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    dataCount = 1;
    [self loadInventorylistingOfPage:@"1" limit:@"10000"];
}

-(void)loadInventorylistingOfPage:(NSString*)page limit:(NSString*)limit{
    object_IV = [InventoryView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Inventory", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dict =[object_IV getListOfInventoryWithID:RT_ID page:page limit:limit];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.0 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear animations:^{
                CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI * 0.05);
                refresh_btn.transform = transform;
                
            } completion:NULL];
            if(dict)
            {
                InventoryModel *object_IM = [[InventoryModel alloc] initWithDictionary:dict];
                [self detailListResponseObject:object_IM];
            }
        });
    });
}

-(void)detailListResponseObject:(InventoryModel*)object{
    
    arr_serialized = [NSMutableArray new];
    arr_Unserialized = [NSMutableArray new];
    
    if (arr_serialized.count == 0) {
        arr_serialized = [object.arr_serialized mutableCopy];
        arr_Unserialized = [object.arr_unSerialized mutableCopy];
    }
    else{
        [arr_serialized addObjectsFromArray:[object.arr_serialized mutableCopy]];
        [arr_Unserialized addObjectsFromArray:[object.arr_unSerialized mutableCopy]];
    }
    
    
    NSMutableArray *jjj = [NSMutableArray new];

    for (NSDictionary *diii in arr_serialized) {
        NSString *item_id = diii[@"item_id"];
        NSString *status = diii[@"status"];
        
        if ([item_id isEqualToString:@"DSXHCP"] && [status isEqualToString:@"On hand"]) {
            [jjj addObject:diii];
            //NSLog(@"SERIALS: %@", diii[@"serial_number"]);
        }
    }
    
    
    [table_inventory reloadData];
    [table_unserializedInventory reloadData];
    [[AppDelegate sharedInstance] removeCustomLoader];

}

-(IBAction)actionForButton:(UIButton*)sender{
    switch (sender.tag) {
        case 11:{
            [self showSerializedList];
        }
            break;
        case 12:{
            [self showUnserializedList];
        }
            break;
        case 13:{
            // btn_adjust
        }
            break;
            
        default:
            break;
    }
}

-(void)showSerializedList{
    
    [img_segment_bg setImage:[UIImage imageNamed:@"tab_serial.png"]];

    table_unserializedInventory.hidden = YES;
    table_inventory.hidden = NO;
    
    lbl_serialNum.text = @"Serial No.";
    lbl_status.text = @"Status";
    lbl_patient.text = @"Patient";
    lbl_action.text = @"Action";
}

-(void)showUnserializedList{
    
    [img_segment_bg setImage:[UIImage imageNamed:@"tab_unserial.png"]];
    
    table_inventory.hidden = YES;
    table_unserializedInventory.hidden = NO;
    
    lbl_serialNum.text = @"In Transit";
    lbl_status.text = @"On Hand";
    lbl_patient.text = @"Committed";
    lbl_action.text = @"Available";
}

#pragma mark - UITableView Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == table_inventory){
        return arr_serialized.count;
    }
    else{
        return arr_Unserialized.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == table_inventory) {
        return 50;
    }
    else
        return 33;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == table_inventory) {
        static NSString *str    = @"Inventory";
        HistoryCell *cell       = [tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
        
        [cell customizeLabelInCell];
        
        NSDictionary *dict              = [arr_serialized objectAtIndex:indexPath.row];
        cell.lbb_serial.text            = [NSString stringWithFormat:@"%d", indexPath.row+1];
        cell.lbb_itemID.text            = [dict valueForKey:@"item_id"];
        cell.lbb_itemName.text          = [dict valueForKey:@"item_name"];
        cell.lbb_serialNo.text          = [dict valueForKey:@"serial_number"];
        cell.lbb_status.text            = [dict valueForKey:@"status"];
        cell.lbb_patient.text           = [dict valueForKey:@"patient_name"];
        cell.lbb_action.text            = @"";
        [cell.btbb_action0 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [cell.btbb_action1 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];

        
        if ([[dict valueForKey:@"item_id"] isEqualToString:@"DSXHCP"] &&
            [[dict valueForKey:@"status"] isEqualToString:@"On hand"]){
            NSLog(@"SERIALS:%@ - %@",[NSString stringWithFormat:@"%d", indexPath.row+1], [dict valueForKey:@"serial_number"]);
        }
        
        
        if ([[dict valueForKey:@"status"] isEqualToString:@"On hand"]) {
            //cell.lbb_action0.text       = @"Setup";
            //cell.lbb_action1.text       = @"Transfer";
            
            cell.lbb_action0.textColor  = [UIColor blueColor];
            cell.lbb_action1.textColor  = [UIColor blueColor];
            
            cell.btbb_action0.tag       = indexPath.row;
            cell.btbb_action1.tag       = indexPath.row;
            
            [cell.btbb_action0 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
            [cell.btbb_action1 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
            
            //[cell.btbb_action0 addTarget:self action:@selector(actionSelectedZero:) forControlEvents:UIControlEventTouchUpInside];
            //[cell.btbb_action1 addTarget:self action:@selector(actionSelectedOne:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        if ([[dict valueForKey:@"status"] isEqualToString:@"Committed"]){
            //cell.lbb_action.text        = @"View Ticket";
            cell.lbb_action.textColor   = [UIColor blueColor];
            cell.lbb_action0.text       = @"";
            cell.lbb_action1.text       = @"";
            
            cell.btbb_action0.tag       = indexPath.row;
            cell.btbb_action1.tag       = indexPath.row;
            
            [cell.btbb_action0 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
            [cell.btbb_action1 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];

            //[cell.btbb_action0 addTarget:self action:@selector(actionSelectedZero:) forControlEvents:UIControlEventTouchUpInside];
            //[cell.btbb_action1 addTarget:self action:@selector(actionSelectedOne:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if ([[dict valueForKey:@"status"] isEqualToString:@"In-transit"]){
            cell.lbb_action.text        = @"View Order";
            cell.lbb_action.textColor   = [UIColor blueColor];
            cell.lbb_action0.text       = @"";
            cell.lbb_action1.text       = @"";
            
            cell.btbb_action0.tag       = indexPath.row;
            cell.btbb_action1.tag       = indexPath.row;
            
            [cell.btbb_action0 addTarget:self action:@selector(actionSelectedZero:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btbb_action1 addTarget:self action:@selector(actionSelectedOne:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        if (indexPath.row == [arr_serialized count] - 1)
        {
            dataCount = dataCount+1;
            //[self loadInventorylistingOfPage:[NSString stringWithFormat:@"%d", dataCount] limit:@"100"];
            
            
        }
        
        
        return cell;
    }
    else{
        static NSString *str            = @"UnserializedInventory";
        HistoryCell *cell               = [tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
        [cell customizeLabelInCell];
        
        NSDictionary *dict              = [arr_Unserialized objectAtIndex:indexPath.row];
        cell.lbbu_serial.text           = [NSString stringWithFormat:@"%d", indexPath.row+1];
        cell.lbbu_itemID.text           = [dict valueForKey:@"item_id"];
        cell.lbbu_itemName.text         = [dict valueForKey:@"item_name"];
        cell.lbbu_InTransit.text        = [dict valueForKey:@"in_transit"];
        cell.lbbu_OnHand.text           = [dict valueForKey:@"on_hand"];
        cell.lbbu_Commiitted.text       = [dict valueForKey:@"committed"];
        cell.lbbu_available.text        = [dict valueForKey:@"available"];
        
        if (indexPath.row == [arr_Unserialized count] - 1)
        {
            dataCount = dataCount+1;
            //[self loadInventorylistingOfPage:[NSString stringWithFormat:@"%d", dataCount] limit:@"100"];
            
        }
        
        return cell;
    }
}


#pragma mark - Actions

-(void)actionSelectedZero:(UIButton*)sender{
    
    NSDictionary *dict_item = [arr_serialized objectAtIndex:sender.tag];

    if ([[dict_item valueForKey:@"status"] isEqualToString:@"Committed"]){
        
        object_IV = [InventoryView new];
        
        dispatch_queue_t myQueue = dispatch_queue_create("Ticket", 0);
        
        [[AppDelegate sharedInstance] showCustomLoader:self];
        dispatch_async(myQueue, ^{
            
            NSDictionary *dict =[object_IV getTicketNumOfItem:[dict_item valueForKey:@"item_id"] withSerial:[dict_item valueForKey:@"serial_number"]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AppDelegate sharedInstance] removeCustomLoader];
                
                if(dict)
                {
                    InventoryModel *object_IM = [[InventoryModel alloc] initWithDictionary:dict];
                    NSString *ticket_ID = object_IM.ticket_id;
                    
                    object_SV = [SetupTicketView new];
                    dispatch_queue_t myQueue = dispatch_queue_create("Setup", 0);
                    [[AppDelegate sharedInstance] showCustomLoader:self];
                    
                    dispatch_async(myQueue, ^{
                        
                        NSDictionary *dict =[object_SV getListOfSetupTicketWithID:RT_ID andOption:@"1"];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[AppDelegate sharedInstance] removeCustomLoader];
                            
                            if(dict)
                            {
                                SetupTicketModel *object_SM = [[SetupTicketModel alloc] initWithDictionary:dict];
                                for (NSDictionary *dict_ticket in object_SM.arr_listing) {
                                    
                                    
                                    if ([[dict_ticket valueForKey:@"ticket_id"] isEqualToString:ticket_ID]) {
                                        
                                        SetUpTicketFormOne *formOne = [self.storyboard instantiateViewControllerWithIdentifier:@"SUTFO"];
                                        formOne.isNewTicket = NO;
                                        formOne.dict = dict_ticket;
                                        [self.navigationController pushViewController:formOne animated:YES];
                                    }
                                }
                            }
                        });
                    });
                }
            });
        });
    }
    
    if ([[dict_item valueForKey:@"status"] isEqualToString:@"In-transit"]){
        
        OrdersVC *orderDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"ODS"];
        NSString *order_id = [dict_item valueForKey:@"order_id"];
        orderDetail.order_ID  = order_id;
       
        if ([order_id  isEqualToString:@"0"]){
            [[[UIAlertView alloc] initWithTitle:@"Message:" message:@"Order ID cannot be '0'" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }
        else{
            [self.navigationController pushViewController:orderDetail animated:NO];
        }
        
    }
    
    if ([[dict_item valueForKey:@"status"] isEqualToString:@"On hand"]){
        
        SetUpTicketFormOne *formOne = [self.storyboard instantiateViewControllerWithIdentifier:@"SUTFO"];
        formOne.isFromInventory = YES;
        formOne.isNewTicket = NO;
        
        NSMutableArray *arr_temp = [NSMutableArray new];
        [arr_temp addObject:arr_serialized[sender.tag]];
        formOne.arr_fromInventory = arr_temp;
        
        [self.navigationController pushViewController:formOne animated:YES];
    }
    
}

-(void)actionSelectedOne:(UIButton*)sender{
    
    NSDictionary *dict_item = [arr_serialized objectAtIndex:sender.tag];

    if ([[dict_item valueForKey:@"status"] isEqualToString:@"Committed"]){
        
        object_IV = [InventoryView new];
        
        dispatch_queue_t myQueue = dispatch_queue_create("Ticket", 0);
        
        [[AppDelegate sharedInstance] showCustomLoader:self];
        dispatch_async(myQueue, ^{
            
            NSDictionary *dict =[object_IV getTicketNumOfItem:[dict_item valueForKey:@"item_id"] withSerial:[dict_item valueForKey:@"serial_number"]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AppDelegate sharedInstance] removeCustomLoader];
                
                if(dict)
                {
                    InventoryModel *object_IM = [[InventoryModel alloc] initWithDictionary:dict];
                    NSString *ticket_ID = object_IM.ticket_id;
                    
                    object_SV = [SetupTicketView new];
                    dispatch_queue_t myQueue = dispatch_queue_create("Setup", 0);
                    [[AppDelegate sharedInstance] showCustomLoader:self];
                    
                    dispatch_async(myQueue, ^{
                        
                        NSDictionary *dict =[object_SV getListOfSetupTicketWithID:RT_ID andOption:@"1"];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[AppDelegate sharedInstance] removeCustomLoader];
                            
                            if(dict)
                            {
                                SetupTicketModel *object_SM = [[SetupTicketModel alloc] initWithDictionary:dict];
                                for (NSDictionary *dict_ticket in object_SM.arr_listing) {
                                    
                                    
                                    if ([[dict_ticket valueForKey:@"ticket_id"] isEqualToString:ticket_ID]) {
                                        
                                        SetUpTicketFormOne *formOne = [self.storyboard instantiateViewControllerWithIdentifier:@"SUTFO"];
                                        formOne.isNewTicket         = NO;
                                        formOne.dict                = dict_ticket;
                                        [self.navigationController pushViewController:formOne animated:YES];
                                    }
                                }
                            }
                        });
                    });
                }
            });
        });
    }
    
    if ([[dict_item valueForKey:@"status"] isEqualToString:@"In-transit"]){
        
        OrdersVC *orderDetail           = [self.storyboard instantiateViewControllerWithIdentifier:@"ODS"];
        orderDetail.order_ID            = [dict_item valueForKey:@"order_id"];
        [self.navigationController pushViewController:orderDetail animated:NO];
    }
    
    if ([[dict_item valueForKey:@"status"] isEqualToString:@"On hand"]){
        NewTransfer *n_transfer         = [self.storyboard instantiateViewControllerWithIdentifier:@"NTR"];
        n_transfer.isFromTransferTicket = YES;
        
        NSMutableDictionary *dict_temp  = [NSMutableDictionary dictionaryWithDictionary:arr_serialized[sender.tag]];
        [dict_temp setValue:@"1" forKey:@"on_hand"];
        
        NSMutableArray *arr_temp        = [NSMutableArray new];
        [arr_temp addObject:dict_temp ];
        n_transfer.arr_fromInventory    = arr_temp;
        
        [self.navigationController pushViewController:n_transfer animated:NO];
    }
    
}

-(IBAction)reloadInventory{
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear animations:^{
        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI);
        refresh_btn.transform = transform;
    } completion:NULL];
    
    [self loadInventorylistingOfPage:@"1" limit:@"10000"];

}

@end
