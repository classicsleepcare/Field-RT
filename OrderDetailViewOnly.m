//
//  OrderDetailViewOnly.m
//  RT APP
//
//  Created by Anil Prasad on 12/03/16.
//  Copyright © 2016 ankit gupta. All rights reserved.
//

#import "OrderDetailViewOnly.h"
#import "HistoryCell.h"
#import "OrderDetailView.h"
#import "OrderDetailModel.h"

@interface OrderDetailViewOnly()<UIGestureRecognizerDelegate>
{
    UITextField *txt_qty;
}
@property (strong, nonatomic) NSMutableArray *arrayForBool;

@end

@implementation OrderDetailViewOnly{
    OrderDetailView *object_OV;
}


-(void)onKeyboardHide:(NSNotification *)notification
{
    CGPoint point = CGPointMake(0,0);
    [UIView animateWithDuration:0.5 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
}

-(void)dismissKeyboard {
    [universalTextField resignFirstResponder];
}

-(void)testingvariable{
    extern NSString *testVar;
    testVar = @"second test...";
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isReadOnly) {
        btn_receiveItems.enabled = NO;
        btn_receiveItems.alpha = 0.5f;
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    lbl_status.text = self.status;
    lbl_date_shipped.text = self.date;
    lbl_items.text = self.items_receiving;
    lbl_order_num.text = self.order_ID;
    lbl_notes.text = self.pt_notes;
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    arr_orderDetailsReceived = [[NSMutableArray alloc] init];
    self.arrayForBool = [[NSMutableArray alloc] init];
    
    
    
    [self callWebServiceForOrderDetails];
}

#pragma mark - API Calls

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
                    NSArray *temp_arr           = [object_OM.arr_items_receiving mutableCopy];
                    arr_orderDetailsReceived    = [object_OM.arr_items_receiving mutableCopy];
                    self.arrayForBool           = [[NSMutableArray alloc] init];
                    
                    arr_orderDetails = [NSMutableArray new];
                    for (NSDictionary *di in temp_arr) {
                        //if (![[di valueForKey:@"quantity"] isEqualToString:@"0"]) {
                            [arr_orderDetails addObject:di];
                        //}
                    }
                    
                    for (int index =0; index <arr_orderDetails.count; index++) {
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:arr_orderDetails[index]];
                        // [dict setValue:@0 forKey:@"quantityActual"];
                        [dict setValue:@"" forKey:@"quantityActual"]; // 15 June 2017
                        NSArray *arr = [dict valueForKey:@"serial_numbers"];
                        NSMutableArray *t_arr = [[NSMutableArray alloc] init];
                        for (NSString *str in arr) {
                            NSDictionary *dt = @{@"serial":str,@"selected":@0};
                            [t_arr addObject:dt];
                        }
                        [dict setValue:t_arr forKey:@"serial_numbers"];
                        [arr_orderDetails replaceObjectAtIndex:index withObject:dict];
                    }
                    
                    
                    for (int i=0; i<arr_orderDetails.count; i++)
                    {
                        if (i == 0)
                        {
                            [self.arrayForBool addObject:[NSNumber numberWithBool:YES]];
                        }
                        else
                        {
                            [self.arrayForBool addObject:[NSNumber numberWithBool:NO]];
                        }
                    }
                    
                    NSLog(@"%@", arr_orderDetails);
                    [self.orderDetailsTable reloadData];
                }
            }
        });
    });
}

-(void)receiveAllItems{
    [universalTextField resignFirstResponder];
    
    if ([[self jsonString] isEqualToString:@"NA"]) {
        receiveAlert = [[UIAlertView alloc] initWithTitle:@"Message!" message:@"Please input 'To Receive' quantity for each item." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [receiveAlert show];
    }
    else if (![self checkJSON]) {
        [[AppDelegate sharedInstance] showAlertMessage:@"Receive quantity can not exceed sent quantity!"];
    }
    else{
        object_OV = [OrderDetailView new];
        
        dispatch_queue_t myQueue = dispatch_queue_create("Orders", 0);
        
        [[AppDelegate sharedInstance] showCustomLoader:self];
        dispatch_async(myQueue, ^{
            NSDictionary *dict =[object_OV receiveOrderRT_ID:RT_ID transfer_id:transfer_id order_id:self.order_ID from_id:from_Id json_request:[self jsonString]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AppDelegate sharedInstance] removeCustomLoader];
                [[[UIAlertView alloc] initWithTitle:@"Message!" message:@"Items Received!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                
                if(dict)
                {
                    OrderDetailModel *object_OM = [[OrderDetailModel alloc] initWithDictionary:dict];
                    
                    NSLog(@"%@", object_OM.msg);
                }
            });
        });
    }
}

-(void)receiveItems:(int)sender{
    
    [universalTextField resignFirstResponder];
    
    object_OV = [OrderDetailView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Orders", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        NSString *json_item     = [NSString stringWithFormat:@"{\"items\":[%@]}",[self singleJson:sender]];
        
        NSDictionary *dict =[object_OV receiveOrderRT_ID:RT_ID transfer_id:transfer_id order_id:self.order_ID from_id:from_Id json_request:json_item];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            [[[UIAlertView alloc] initWithTitle:@"Message!" message:@"Items Received!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            
            if(dict)
            {
                OrderDetailModel *object_OM = [[OrderDetailModel alloc] initWithDictionary:dict];
                
                NSLog(@"%@", object_OM.msg);
            }
        });
    });
}

-(NSString*)singleJson:(int)sender{
    NSDictionary *saveDict = arr_orderDetails[sender];
    
    NSArray *serial_numbers        = [saveDict valueForKey:@"serial_numbers"];
    
    NSMutableArray *serials = [NSMutableArray new];
    if (serial_numbers.count != 0) {
        for (NSDictionary *serialDict in serial_numbers) {
            if ([serialDict[@"selected"] boolValue]) {
                [serials addObject:[NSString stringWithFormat:@"\"%@\"", serialDict[@"serial"]]];
            }
        }
    }
    
    NSString *item_id           = [saveDict valueForKey:@"item_id"];
    NSString *serialized        = [saveDict valueForKey:@"serialized"];
    NSString *quantityReceived  = [saveDict valueForKey:@"quantity"];
    NSString *quantityActual    = [saveDict valueForKey:@"quantityActual"];
    NSString *serial_list       = [NSString stringWithFormat:@"[%@]", [serials componentsJoinedByString:@","]];
    
    
    NSString *item = [NSString stringWithFormat:@"{\"item_id\":\"%@\",\"serialized\":%@, \"quantityReceived\":%@, \"quantityActual\":%@, \"serial_list\":%@}", item_id, serialized, quantityReceived, quantityActual, serial_list];
    
    
    NSString *json_item     = [NSString stringWithFormat:@"{\"items\":[%@]}",item];
    
    NSLog(@"ITEM: %@", json_item);
    
    return item;
}

-(NSString*)jsonString{
    NSMutableArray *saveArray = [[NSMutableArray alloc] init];
    BOOL invalidJson;
    for (NSDictionary *saveDict in arr_orderDetails) {
        
        
        NSArray *serial_numbers        = [saveDict valueForKey:@"serial_numbers"];
        
        NSMutableArray *serials = [NSMutableArray new];
        if (serial_numbers.count != 0) {
            for (NSDictionary *serialDict in serial_numbers) {
                if ([serialDict[@"selected"] boolValue]) {
                    [serials addObject:[NSString stringWithFormat:@"\"%@\"", serialDict[@"serial"]]];
                }
            }
        }
        
        NSString *item_id           = [saveDict valueForKey:@"item_id"];
        NSString *serialized        = [saveDict valueForKey:@"serialized"];
        NSString *quantityReceived  = [saveDict valueForKey:@"quantity"];
        NSString *quantityActual    = [saveDict valueForKey:@"quantityActual"];
        
        if ([quantityActual intValue] == 0) {
            invalidJson = YES;
            break;
        }
        
        NSString *serial_list       = [NSString stringWithFormat:@"[%@]", [serials componentsJoinedByString:@","]];
        
        NSString *item = [NSString stringWithFormat:@"{\"item_id\": \"%@\",\"serialized\": %@, \"quantityReceived\": %@, \"quantityActual\": %@, \"serial_list\": %@}", item_id, serialized, quantityReceived, quantityActual, serial_list];
        
        [saveArray addObject:item];
    }
    
    NSString *str_itemArray = [saveArray componentsJoinedByString:@","];
    NSString *json_item     = [NSString stringWithFormat:@"{\"items\":[%@]}",str_itemArray];
    NSLog(@"ITEM: %@", json_item);
    
    if (invalidJson) {
        return @"NA";
    }
    else
        return json_item;
}

-(BOOL)checkJSON{
    
    BOOL status;
    for (NSDictionary *saveDict in arr_orderDetails) {
        
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

#pragma mark - Button Actions

-(IBAction)actionForButton:(UIButton*)sender{
    switch (sender.tag) {
        case 11:{
            
        }
            break;
        case 12:{
            [self receiveAllItems];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [arr_orderDetails count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[self.arrayForBool objectAtIndex:indexPath.section] boolValue]) {
        return 33;
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 33;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ViewOrderDetail";
    
    HistoryCell *cell = [self.orderDetailsTable dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[HistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell customizeLabelInCell];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    [cell setNeedsLayout];
    
    BOOL manyCells  = [[self.arrayForBool objectAtIndex:indexPath.section] boolValue];
    
    if (!manyCells)
    {
    }
    else
    {
        self.arr_serialNumbers = arr_orderDetails[indexPath.section][@"serial_numbers"];
        
        if ([arr_orderDetails[indexPath.section][@"serialized"] isEqualToString:@"0"]) {
            cell.lbledv_serialNum.text   = @"Unserialized";
        }
        else{
            cell.lbledv_serialNum.text    = @"No Serial";
            if (self.arr_serialNumbers.count > 0) {
                cell.lbledv_serialNum.text = [[self.arr_serialNumbers objectAtIndex:indexPath.row] valueForKey:@"serial"];
//                cell.btned_check.selected = [self.arr_serialNumbers[indexPath.row][@"selected"] boolValue];
//                
//                [cell.btned_check addTarget:self action:@selector(onClickCheck:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    
    
    
//    cell.lbled_serial.text       = @"";
//    cell.lbled_itemID.text       = @"";
//    cell.lbled_itemName.text     = @"";
//    cell.lbled_qtySent.text      = @"";
//    cell.txted_qtyReceived.text  = @"";
//    cell.lbled_qtyReceived.text  = @"";
//
//    if (indexPath.row == 0) {
//        [cell.btned_action addTarget:self action:@selector(receiveItem:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    else{
//        [cell.btned_action setTitle:@"" forState:UIControlStateNormal];
//    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * headerView              = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 33)];
    headerView.layer.borderColor    = [UIColor grayColor].CGColor;
    headerView.layer.borderWidth    = 1.0f;
    headerView.tag                  = section;
    //    headerView.backgroundColor      = [UIColor colorWithRed:22.0/255.0 green:125.0/255.0 blue:164.0/255.0 alpha:1.0];
    headerView.backgroundColor      = [UIColor lightGrayColor];
    
    NSDictionary *orderDict         = [arr_orderDetails objectAtIndex:section];
    
    /*
    UITextField *txt_qtySent        = [[UITextField alloc] initWithFrame:CGRectMake(439+32, 0, 98-32, 33)]; //x: 439
    txt_qtySent.userInteractionEnabled = NO;
    txt_qtySent.text                = orderDict[@"quantity"];
    txt_qtySent.textAlignment       = NSTextAlignmentCenter;
    txt_qtySent.layer.borderColor   = [UIColor grayColor].CGColor;
    txt_qtySent.layer.borderWidth   = 1.0f;
    txt_qtySent.textColor           = [UIColor whiteColor];
    txt_qtySent.font                = [UIFont fontWithName:@"HelveticaNeue" size:15.0f];
    //    txt_qtySent.backgroundColor     = [UIColor colorWithRed:28.0/255.0 green:163.0/255.0 blue:217.0/255.0 alpha:1.0];
    txt_qtySent.backgroundColor     = [UIColor lightGrayColor];
    [headerView addSubview:txt_qtySent];
    */
    
    txt_qty            = [[UITextField alloc] initWithFrame:CGRectMake(536, 0, 113+106, 33)]; //536
    txt_qty.keyboardType            = UIKeyboardTypeNumberPad;
    txt_qty.text                    = [NSString stringWithFormat:@"%@", orderDict[@"total_quantity"]];
    txt_qty.tag                     = section;
    txt_qty.delegate                = self;
    //txt_qty.userInteractionEnabled  = ![orderDict[@"serialized"] boolValue];
    //if (!txt_qty.userInteractionEnabled) txt_qty.alpha = 0.0;
    txt_qty.userInteractionEnabled  = false;
    txt_qty.textAlignment           = NSTextAlignmentCenter;
    txt_qty.layer.borderColor       = [UIColor grayColor].CGColor;
    txt_qty.layer.borderWidth       = 1.0f;
    txt_qty.textColor               = [UIColor whiteColor];
    txt_qty.font                    = [UIFont fontWithName:@"HelveticaNeue" size:15.0f];
    //    txt_qty.backgroundColor         = [UIColor colorWithRed:28.0/255.0 green:163.0/255.0 blue:217.0/255.0 alpha:1.0];
    txt_qty.backgroundColor         = [UIColor lightGrayColor];
    [headerView addSubview:txt_qty];
    /*
    if ([arr_orderDetails[section][@"quantity"] isEqualToString:@"0"]) {
        txt_qty.userInteractionEnabled = NO;
        txt_qty.alpha = 0.5;
    }
    
    if ([orderDict[@"serialized"] boolValue]) {
        NSDictionary *dict = arr_orderDetails[section];
        NSArray *arrSer = [dict valueForKey:@"serial_numbers"];
        int count = 0;
        for (NSDictionary*dictSer in arrSer)
        {
            if ([[dictSer valueForKey:@"selected"] boolValue] == 1) {
                count++;
            }
        }
        
        NSNumber *quantityActual = dict[@"quantityActual"];
        quantityActual = [NSNumber numberWithInt:count];
        txt_qty.text = [NSString stringWithFormat:@"%@", quantityActual]; // 20 June 2017
        
        NSMutableDictionary *ddict  = [[NSMutableDictionary alloc] init];
        ddict                       = [NSMutableDictionary dictionaryWithDictionary:[arr_orderDetails objectAtIndex:section]];
        [ddict setObject:[NSNumber numberWithInteger:(int)count] forKey:@"quantityActual"];
        [arr_orderDetails replaceObjectAtIndex:section withObject:ddict];
    }
    
    BOOL manyCells = [[self.arrayForBool objectAtIndex:section] boolValue];
    */
    UILabel *headerSerial           = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 65, 33)];
    headerSerial.layer.borderColor  = [UIColor grayColor].CGColor;
    headerSerial.layer.borderWidth  = 1.0f;
    headerSerial.textAlignment      = NSTextAlignmentCenter;
    headerSerial.text               = [NSString stringWithFormat:@"%d", section+1];
    headerSerial.font               = [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0f];
    headerSerial.textColor          = [UIColor whiteColor];
    headerSerial.backgroundColor    = [UIColor clearColor];
    [headerView addSubview:headerSerial];
    
    UILabel *headerItemID           = [[UILabel alloc] initWithFrame:CGRectMake(64, 0, 102, 33)];
    headerItemID.layer.borderColor  = [UIColor grayColor].CGColor;
    headerItemID.layer.borderWidth  = 1.0f;
    headerItemID.textAlignment      = NSTextAlignmentCenter;
    headerItemID.text               = orderDict[@"item_id"];
    headerItemID.font               = [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0f];
    headerItemID.textColor          = [UIColor whiteColor];
    headerItemID.backgroundColor    = [UIColor clearColor];
    [headerView addSubview:headerItemID];
    
    UILabel *headerItemName           = [[UILabel alloc] initWithFrame:CGRectMake(164, 0, 164, 33)];
    headerItemName.layer.borderColor  = [UIColor grayColor].CGColor;
    headerItemName.layer.borderWidth  = 1.0f;
    headerItemName.text               = [NSString stringWithFormat:@"  %@", orderDict[@"item_name"]];
    headerItemName.font               = [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0f];
    headerItemName.textAlignment      = NSTextAlignmentLeft;
    headerItemName.textColor          = [UIColor whiteColor];
    headerItemName.backgroundColor    = [UIColor clearColor];
    [headerView addSubview:headerItemName];
    
    UILabel *headerItemType           = [[UILabel alloc] initWithFrame:CGRectMake(327, 0, 210, 33)]; //w: 113
    headerItemType.layer.borderColor  = [UIColor grayColor].CGColor;
    headerItemType.layer.borderWidth  = 1.0f;
    headerItemType.textAlignment      = NSTextAlignmentCenter;
    
    
    if ([orderDict[@"serialized"] boolValue]) {
        headerItemType.text           = @"Serialized";
        //up or down arrow depending on the bool
        /*
         UIImageView *upDownArrow        = [[UIImageView alloc] initWithImage:manyCells ? [UIImage imageNamed:@"upArrowBlack"] : [UIImage imageNamed:@"downArrowBlack"]];
         upDownArrow.autoresizingMask    = UIViewAutoresizingFlexibleLeftMargin;
         upDownArrow.frame               = CGRectMake(self.view.frame.size.width-40, 2, 30, 30);
         upDownArrow.tintColor = [UIColor whiteColor];
         [headerView addSubview:upDownArrow];
         
         */
    }
    else{
        headerItemType.text           = @"Unserialized";
        
        /*
         UIButton *btnReceive            = [UIButton buttonWithType:UIButtonTypeCustom];
         [btnReceive setFrame:CGRectMake(648, 0, 106, 32)];
         [btnReceive setTitle:@"Receive" forState:UIControlStateNormal];
         btnReceive.tag                  = section;
         [btnReceive setTitleColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
         btnReceive.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15.0f];
         [btnReceive addTarget:self action:@selector(receiveUnserializedItem:) forControlEvents:UIControlEventTouchUpInside];
         [headerView addSubview:btnReceive];
         */
    }
    
    headerItemType.font               = [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0f];
    headerItemType.textColor          = [UIColor whiteColor];
    headerItemType.backgroundColor    = [UIColor clearColor];
    [headerView addSubview:headerItemType];
    
    /*
    UILabel *lbl_back_order_qty           = [[UILabel alloc] initWithFrame:CGRectMake(327+80-1, 0, 66, 33)];
    lbl_back_order_qty.layer.borderColor  = [UIColor grayColor].CGColor;
    lbl_back_order_qty.layer.borderWidth  = 1.0f;
    if (orderDict[@"back_order_qty"] == nil) {
        lbl_back_order_qty.text           = @"0"; // orderDict[@"back_order_qty"]
    }
    else{
        lbl_back_order_qty.text           = orderDict[@"back_order_qty"];
    }
    lbl_back_order_qty.font               = [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0f];
    lbl_back_order_qty.textAlignment      = NSTextAlignmentCenter;
    lbl_back_order_qty.textColor          = [UIColor whiteColor];
    lbl_back_order_qty.backgroundColor    = [UIColor clearColor];
    [headerView addSubview:lbl_back_order_qty];
    */
    
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    [headerView addGestureRecognizer:headerTapped];
    
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[self.arrayForBool objectAtIndex:section] boolValue])
    {
        NSArray *arr = arr_orderDetails[section][@"serial_numbers"];
        if (arr.count == 0) {
            return 0;
        }
        else{
            return arr.count;
        }
    }
    return 1;
}

#pragma mark - gesture tapped

-(void)onClickCheck:(UIButton*)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.orderDetailsTable];
    NSIndexPath *indexPath = [self.orderDetailsTable indexPathForRowAtPoint:buttonPosition];
    NSLog(@"S: %ld, R: %ld", (long)indexPath.section, (long)indexPath.row);
    if (indexPath != nil)
    {
        
        sender.selected = !sender.selected;
        
        NSMutableDictionary *item_dict      = [[NSMutableDictionary alloc] initWithDictionary:arr_orderDetails[indexPath.section]];
        NSMutableArray *serial_numbers      = [item_dict valueForKey:@"serial_numbers"];
        NSMutableDictionary *serial_dict    = [[NSMutableDictionary alloc] initWithDictionary:[serial_numbers objectAtIndex:indexPath.row]];
        
        [serial_dict setValue:[NSNumber numberWithBool:sender.selected] forKey:@"selected"];
        [serial_numbers replaceObjectAtIndex:indexPath.row withObject:serial_dict];
        [item_dict setValue:serial_numbers forKey:@"serial_numbers"];
        
        [arr_orderDetails replaceObjectAtIndex:indexPath.section withObject:item_dict];
    }
    
    [self.orderDetailsTable reloadData];
}

-(void)receiveItem:(UIButton*)sender{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.orderDetailsTable];
    NSIndexPath *indexPath = [self.orderDetailsTable indexPathForRowAtPoint:buttonPosition];
    NSLog(@"S: %ld", (long)indexPath.section);
    
    int quantitytoReceive   = [arr_orderDetails[indexPath.section][@"quantityActual"] integerValue];
    int quantitySent        = [arr_orderDetails[indexPath.section][@"quantity"] integerValue];
    
    if (quantitytoReceive == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Quantity to receive can't be '0'" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
    else if (quantitytoReceive <= quantitySent) {
        [self receiveItems:indexPath.section];
    }
    else{
        [[[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Quantity to receive must be less than or equal to quantity sent and not 0!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
}

-(void)receiveUnserializedItem:(UIButton*)sender{
    
    int quantitytoReceive   = [arr_orderDetails[sender.tag][@"quantityActual"] integerValue];
    int quantitySent        = [arr_orderDetails[sender.tag][@"quantity"] integerValue];
    
    if (quantitytoReceive == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Quantity to receive can't be '0'" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
    else if (quantitytoReceive <= quantitySent) {
        [self receiveItems:sender.tag];
    }
    else{
        [[[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Quantity to receive must be less than or equal to quantity sent and not 0!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
}

- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    if (indexPath.row == 0)
    {
        
        BOOL collapsed  = [[self.arrayForBool objectAtIndex:indexPath.section] boolValue];
        collapsed       = !collapsed;
        
        for (int s=0; s< [self.arrayForBool count]; s++) {
            if ([[self.arrayForBool objectAtIndex:s]isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                [self.arrayForBool replaceObjectAtIndex:s withObject:[NSNumber numberWithBool:NO]];
            }
        }
        
        [self.arrayForBool replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:collapsed]];
        
        NSRange range = NSMakeRange(0, [self numberOfSectionsInTableView:self.orderDetailsTable]);
        NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.orderDetailsTable reloadSections:sections withRowAnimation:UITableViewRowAnimationFade];
        
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
    point.y     -= 140;
    [UIView animateWithDuration:0.5 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField == txt_qty)
    {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    else
        return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [universalTextField resignFirstResponder];
    
    NSMutableDictionary *ddict  = [[NSMutableDictionary alloc] init];
    ddict                       = [NSMutableDictionary dictionaryWithDictionary:[arr_orderDetails objectAtIndex:universalTextField.tag]];
    
    int quantityActual = [universalTextField.text integerValue];
    [ddict setObject:[NSNumber numberWithInt:quantityActual] forKey:@"quantityActual"];
    [arr_orderDetails replaceObjectAtIndex:universalTextField.tag withObject:ddict];
    
    [self.orderDetailsTable reloadData];
    
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView != receiveAlert) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        
    }
}



@end
