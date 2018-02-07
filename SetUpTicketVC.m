//
//  SetUpTicketVC.m
//  RT APP
//
//  Created by Anil Prasad on 02/12/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "SetUpTicketVC.h"
#import "HistoryCell.h"
#import "SetUpTicketFormOne.h"
#import "SetupTicketView.h"
#import "SetupTicketModel.h"
#import "HistoryView.h"
#import "HistoryModel.h"
#import "PatientInformationViewController.h"

@interface SetUpTicketVC (){
    SetupTicketView *object_SV;
}

@end

@implementation SetUpTicketVC



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
   
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[AppDelegate sharedInstance] removeCustomLoader];
}

-(void)viewDidAppear:(BOOL)animated{
    [self callWebserviceLoadData];
}

-(void)callWebserviceLoadData{
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
                [self detailListResponseObject:object_SM];
            }
        });
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];   
}

-(void)detailListResponseObject:(SetupTicketModel*)object{
   // arr_setupTicket = object.arr_listing;
    
    NSMutableArray *arr_temp_setupTicket = [NSMutableArray new];
    
    for (NSDictionary *a_dict in object.arr_listing) {
        NSString *isFinal = a_dict[@"isFinalSubmit"];
        
        if ([isFinal isEqualToString:@"0"]) {
            [arr_temp_setupTicket addObject:a_dict];
        }
    }
    
    arr_setupTicket = arr_temp_setupTicket;
    
    [table_setupTicket reloadData];
}



-(IBAction)actionForButton:(UIButton*)sender{
    switch (sender.tag) {
        case 11:{
            [self showPendingTableView];
        }
            break;
        case 12:{
            [self showHistoryTableView];
        }
            break;
            
        case 13:{
            [self createNewTicket];
        }
            break;
        case 14:{
            [self showNewSetups];
        }
            break;
            
        default:
            break;
    }
}

-(void)showNewSetups{
    NewSetups *n_setups = [self.storyboard instantiateViewControllerWithIdentifier:@"NST"];
    n_setups.arr_setups = arr_setupTicket;
    [self.navigationController pushViewController:n_setups animated:YES];
}

-(void)showPendingTableView{
    [img_segment_bg setImage:[UIImage imageNamed:@"tab_pending"]];
    
    // Reload Tableview with new data
}

-(void)showHistoryTableView{
    [img_segment_bg setImage:[UIImage imageNamed:@"tab_history"]];
    
    // Reload Tableview with new data


}

-(void)createNewTicket{
    SetUpTicketFormOne *formOne = [self.storyboard instantiateViewControllerWithIdentifier:@"SUTFO"];
    formOne.isNewTicket = YES;
    [self.navigationController pushViewController:formOne animated:YES];
}



#pragma mark -
#pragma mark -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == table_setupTicket) return 1;
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == table_setupTicket) return arr_setupTicket.count;
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"SetUpTicket";
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    [cell customizeLabelInCell];
    
    cell.backgroundView = nil;
    
    NSDictionary *dict          = [arr_setupTicket objectAtIndex:indexPath.row];
    cell.lb_serial.text         = [NSString stringWithFormat:@"%d", indexPath.row+1];
    cell.lb_patientID.text      = dict[@"pt_id"];
    cell.lb_patientName.text    = [NSString stringWithFormat:@"%@ %@", dict[@"pt_first"], dict[@"pt_last"]];
    cell.lb_facility.text       = dict[@"pt_cell"];
    //cell.lb_state.text          = dict[@"Pt_State"];
    cell.lb_doctor.text         = [NSString stringWithFormat:@"%@ %@", dict[@"Dr_First"], dict[@"Dr_Last"]];
    cell.lb_dateCreated.text    = dict[@"date"];
    
    cell.bt_patientName.tag     = indexPath.row;
    [cell.bt_patientName addTarget:self action:@selector(showPatientInformation:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.bt_setAppt.tag         = indexPath.row;
    [cell.bt_setAppt addTarget:self action:@selector(setAppointment:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.bt_view_submit.tag         = indexPath.row;
    if ([dict[@"isFinalSubmit"] isEqualToString:@"0"]) {
        [cell.bt_view_submit setTitle:@"Submit Ticket" forState:UIControlStateNormal];
        cell.bt_view_submit.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    }
    else{
        [cell.bt_view_submit setTitle:@"View Ticket" forState:UIControlStateNormal];
    }
    [cell.bt_view_submit addTarget:self action:@selector(viewSubmitTicket:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary *dict          = [arr_setupTicket objectAtIndex:indexPath.row];
//    
//    SetUpTicketFormOne *formOne = [self.storyboard instantiateViewControllerWithIdentifier:@"SUTFO"];
//    formOne.isNewTicket = NO;
//    formOne.dict = dict;
//    [self.navigationController pushViewController:formOne animated:YES];
    
}

-(void)setAppointment:(UIButton*)sender{
    
    NSDictionary *p_dict            = [arr_setupTicket objectAtIndex:sender.tag];
    SetAppointment *appt            = [self.storyboard instantiateViewControllerWithIdentifier:@"APPT"];
    appt.pt_ID                      = p_dict[@"pt_id"];
    appt.patientName                = [NSString stringWithFormat:@"%@ %@", p_dict[@"pt_first"], p_dict[@"pt_last"]];
    [self.navigationController pushViewController:appt animated:YES];
}

-(void)viewSubmitTicket:(UIButton*)sender{
    
    NSDictionary *dict          = [arr_setupTicket objectAtIndex:sender.tag];
    
    SetUpTicketFormOne *formOne = [self.storyboard instantiateViewControllerWithIdentifier:@"SUTFO"];
    formOne.isNewTicket         = NO;
    if ([dict[@"isFinalSubmit"] isEqualToString:@"0"]) {
        formOne.isNotSubmitted  = YES;
    }
    formOne.dict = dict;
    [self.navigationController pushViewController:formOne animated:YES];
}

-(void)showPatientInformation:(UIButton*)sender{
    
    NSDictionary *p_dict          = [arr_setupTicket objectAtIndex:sender.tag];

    [[AppDelegate sharedInstance] showCustomLoader:self];
    
    dispatch_queue_t myqueue = dispatch_queue_create("Kumar", 0);
    
    dispatch_async(myqueue, ^{
        
        HistoryView *object_HV = [HistoryView new];
        NSDictionary *dict = [object_HV getDetailListForPatientOfId:p_dict[@"pt_id"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            HistoryModel* object_HM = [[HistoryModel alloc]initWithDictionaryForPatientDetail:dict];
            //[self responseForInformation:object_HM];
            PatientInformationViewController *object_PIVC=[self.storyboard instantiateViewControllerWithIdentifier:@"PIVC"];
            
            object_PIVC.dict_patientInfo=object_HM.dict_profileInfo;
            object_PIVC.dict_docInfo=object_HM.dict_docInfo;
            object_PIVC.dict_insInfo=object_HM.dict_insInfo;
            object_PIVC.arr_pdfs=object_HM.arr_pdfs;
            object_PIVC.arr_FileName = object_HM.arr_pdf_name;
            [self.navigationController pushViewController:object_PIVC animated:YES];
            
            
        });
    });
}

// 5


@end
