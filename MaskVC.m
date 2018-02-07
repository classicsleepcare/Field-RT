//
//  MaskVC.m
//  RT APP
//
//  Created by Anil Prasad on 21/09/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "MaskVC.h"
#import "StockTakeModel.h"
#import "StockTakeView.h"

@interface MaskVC (){
    int viewCount;
    StockTakeView *object_STV;
}

@end

@implementation MaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr_dropdown = [NSArray new];
    
    txt_1_type.placeholder = @"ID";
    txt_2_type.placeholder = @"ID";
    txt_3_type.placeholder = @"ID";
    txt_4_type.placeholder = @"ID";
    txt_5_type.placeholder = @"ID";
    txt_6_type.placeholder = @"ID";
    txt_7_type.placeholder = @"ID";
    txt_8_type.placeholder = @"ID";
    txt_9_type.placeholder = @"ID";
    txt_10_type.placeholder = @"ID";
    txt_1_mask.placeholder = @"Select Mask";
    txt_2_mask.placeholder = @"Select Mask";
    txt_3_mask.placeholder = @"Select Mask";
    txt_4_mask.placeholder = @"Select Mask";
    txt_5_mask.placeholder = @"Select Mask";
    txt_6_mask.placeholder = @"Select Mask";
    txt_7_mask.placeholder = @"Select Mask";
    txt_8_mask.placeholder = @"Select Mask";
    txt_9_mask.placeholder = @"Select Mask";
    txt_10_mask.placeholder = @"Select Mask";
    
    /*
    txt_1_quantity.enabled = NO;
    txt_2_quantity.enabled = NO;
    txt_3_quantity.enabled = NO;
    txt_4_quantity.enabled = NO;
    txt_5_quantity.enabled = NO;
    txt_6_quantity.enabled = NO;
    txt_7_quantity.enabled = NO;
    txt_8_quantity.enabled = NO;
    txt_9_quantity.enabled = NO;
    txt_10_quantity.enabled = NO;
     */
    
    //btn_submit.alpha = 0.5;
    //btn_submit.enabled = NO;
    
    [self callWebserviceForDropdowns];
    
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
    popoverViewCon.preferredContentSize         = CGSizeMake(250, 300);
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
            
            NSString *machine_id = [saveDict valueForKey:@"mask_id"];
            NSString *machine_name = [saveDict valueForKey:@"mask_name"];
            
            NSString *item = [NSString stringWithFormat:@"{\"mask_id\": \"%@\",\"mask_name\": \"%@\",\"quantity\": \"%@\"}", machine_id, machine_name, item_quantity];
            
            [saveArray addObject:item];
        }
        
        
    }
    
    
    NSString *str_itemArray = [saveArray componentsJoinedByString:@","];
    NSString *json_item     = [NSString stringWithFormat:@"{\"json_data\":[%@]}",str_itemArray];
    
    json_item               = [json_item stringByReplacingOccurrencesOfString:@"&" withString:@"and"];
    
    return json_item;
    
}



-(IBAction)submitData{
    
    [self saveData];
    NSString *maskData = [self jsonString];
    
    object_STV = [StockTakeView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Submit", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        NSLog(@"RT_ID: %@", RT_ID);
        NSDictionary *dicti =[object_STV submitInventoryOfRT:RT_ID machinesJson:self.json_machines
                                               hum_modemJson:self.json_humidifiers
                                                   modemJson:self.json_modem
                                                    maskJson:maskData];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                StockTakeModel *object_STM = [[StockTakeModel alloc] initWithDictionary:dicti];
                [[[UIAlertView alloc] initWithTitle:@"Message!" message:object_STM.msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            }
        });
    });
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    self.arr_rt_mask_listing = object.arr_rt_mask_listing ;
    
    
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
    NSDictionary *cellDict              = [self.arr_dropdown objectAtIndex:indexPath.row];
    cell_table.textLabel.text           = cellDict[@"mask_name"];
    
    
    return cell_table;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *cellDict              = [self.arr_dropdown objectAtIndex:indexPath.row];
    NSString *machine                   = cellDict[@"mask_name"];
    NSString *mask_id                   = cellDict[@"mask_id"];
    switch (tagNum) {
        case 11:{
            txt_1_mask.text = machine;
//            txt_1_type.text = mask_id;
//            txt_1_quantity.enabled = YES;
//            [txt_1_quantity becomeFirstResponder];
//            [dict_1 setObject:machine forKey:@"mask_name"];
//            [dict_1 setObject:cellDict[@"mask_id"] forKey:@"mask_id"];
            
        }
            break;
            
        case 21:{
            txt_2_mask.text = machine;
//            txt_2_type.text = mask_id;
//            txt_2_quantity.enabled = YES;
//            [txt_2_quantity becomeFirstResponder];
//            [dict_2 setObject:machine forKey:@"mask_name"];
//            [dict_2 setObject:cellDict[@"mask_id"] forKey:@"mask_id"];
        }
            break;
            
        case 31:{
            txt_3_mask.text = machine;
//            txt_3_type.text = mask_id;
//            txt_3_quantity.enabled = YES;
//            [txt_3_quantity becomeFirstResponder];
//            [dict_3 setObject:machine forKey:@"mask_name"];
//            [dict_3 setObject:cellDict[@"mask_id"] forKey:@"mask_id"];
        }
            break;
            
        case 41:{
            txt_4_mask.text = machine;
//            txt_4_type.text = mask_id;
//            txt_4_quantity.enabled = YES;
//            [txt_4_quantity becomeFirstResponder];
//            [dict_4 setObject:machine forKey:@"mask_name"];
//            [dict_4 setObject:cellDict[@"mask_id"] forKey:@"mask_id"];
        }
            break;
            
        case 51:{
            txt_5_mask.text = machine;
//            txt_5_type.text = mask_id;
//            txt_5_quantity.enabled = YES;
//            [txt_5_quantity becomeFirstResponder];
//            [dict_5 setObject:machine forKey:@"mask_name"];
//            [dict_5 setObject:cellDict[@"mask_id"] forKey:@"mask_id"];
        }
            break;
            
        case 61:{
            txt_6_mask.text = machine;
//            txt_6_type.text = mask_id;
//            txt_6_quantity.enabled = YES;
//            [txt_6_quantity becomeFirstResponder];
//            [dict_6 setObject:machine forKey:@"mask_name"];
//            [dict_6 setObject:cellDict[@"mask_id"] forKey:@"mask_id"];
        }
            break;
            
        case 71:{
            txt_7_mask.text = machine;
//            txt_7_type.text = mask_id;
//            txt_7_quantity.enabled = YES;
//            [txt_7_quantity becomeFirstResponder];
//            [dict_7 setObject:machine forKey:@"mask_name"];
//            [dict_7 setObject:cellDict[@"mask_id"] forKey:@"mask_id"];
        }
            break;
            
        case 81:{
            txt_8_mask.text = machine;
//            txt_8_type.text = mask_id;
//            txt_8_quantity.enabled = YES;
//            [txt_8_quantity becomeFirstResponder];
//            [dict_8 setObject:machine forKey:@"mask_name"];
//            [dict_8 setObject:cellDict[@"mask_id"] forKey:@"mask_id"];
        }
            break;
            
        case 91:{
            txt_9_mask.text = machine;
//            txt_9_type.text = mask_id;
//            txt_9_quantity.enabled = YES;
//            [txt_9_quantity becomeFirstResponder];
//            [dict_9 setObject:machine forKey:@"mask_name"];
//            [dict_9 setObject:cellDict[@"mask_id"] forKey:@"mask_id"];
        }
            break;
            
        case 101:{
            txt_10_mask.text = machine;
//            txt_10_type.text = mask_id;
//            txt_10_quantity.enabled = YES;
//            [txt_10_quantity becomeFirstResponder];
//            [dict_10 setObject:machine forKey:@"mask_name"];
//            [dict_10 setObject:cellDict[@"mask_id"] forKey:@"mask_id"];
        }
            break;
            
            
        default:
            break;
    }
    
    btn_submit.enabled = YES;
    btn_submit.alpha = 1.0;
    
    [popoverCon dismissPopoverAnimated:YES];
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
    self.arr_dropdown = self.arr_rt_mask_listing;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(300,300);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 300) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectTwo:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_mask_listing;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250, 300);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 300) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectThree:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_mask_listing;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250, 300);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 300) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectFour:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_mask_listing;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250, 300);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 300) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectFive:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_mask_listing;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250, 300);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 300) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectSix:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_mask_listing;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250, 300);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 300) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectSeven:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_mask_listing;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250, 300);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 300) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectEight:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_mask_listing;
    
    [self showPopoverDown:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250, 300);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 300) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectNine:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_mask_listing;
    
    [self showPopoverDown:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250, 300);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 300) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectTen:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_mask_listing;
    
    [self showPopoverDown:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250, 300);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 300) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}


#pragma mark - UITextField Delegate

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
