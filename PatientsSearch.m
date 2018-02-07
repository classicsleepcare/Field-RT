//
//  PatientsSearch.m
//  RT APP
//
//  Created by Anil Prasad on 12/08/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "PatientsSearch.h"
#import "HistoryCell.h"
#import "TicketFormModel.h"
#import "TicketFormView.h"
#import "SetAppointment.h"
#import "SetUpTicketFormOne.h"
#import "HistoryView.h"
#import "HistoryModel.h"
#import "PatientInformationViewController.h"
#import "CreateSchedule.h"

@interface PatientsSearch (){
    IBOutlet UITableView *table_patients;
    TicketFormView *object_TV;
    IBOutlet UISearchBar *searchbar;
}

@property (strong, nonatomic) NSMutableArray *arr_rt_patient_listing;
@property (strong, nonatomic) NSArray *arr_copy_rt_patient_listing;
@property (strong, nonatomic) NSArray *arr_temp_rt_patient_listing;


@end

@implementation PatientsSearch

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.arr_temp_rt_patient_listing = [[NSArray alloc] init];
    searchbar.text = @"";
    
    [self loadPatientsList];
}
-(void)viewDidAppear:(BOOL)animated{
    
}

-(void)loadPatientsList{
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
    
    self.arr_rt_patient_listing         = [object.arr_rt_patient_listing mutableCopy];
    self.arr_copy_rt_patient_listing    = [object.arr_rt_patient_listing mutableCopy];
    
    [table_patients reloadData];

}

#pragma mark - Tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr_rt_patient_listing.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str      = @"PatientSearch";
    HistoryCell *cell         = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (!cell) {
        cell = [[HistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    [cell customizeLabelInCell];
    
    cell.backgroundView       = nil;
    
    
    cell.lbp_serial.text      = [NSString stringWithFormat:@"%d", indexPath.row+1];
    cell.lbp_patientID.text   = self.arr_rt_patient_listing[indexPath.row][@"Pt_ID"];
    cell.lbp_patientName.text = [NSString stringWithFormat:@"  %@ %@", self.arr_rt_patient_listing[indexPath.row][@"Pt_First"], self.arr_rt_patient_listing[indexPath.row][@"Pt_Last"]];
    
    NSString *phone           = self.arr_rt_patient_listing[indexPath.row][@"Pt_Home"];
    if ([phone isEqualToString:@""] || [phone isEqualToString:@"NA"]) {
        cell.lbp_phone.text   = @"-";
        cell.lbp_phone.textColor = [UIColor blackColor];
        [cell.btp_phone removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    }
    else{
        
        NSMutableString *mu = [NSMutableString stringWithString:phone];
        [mu insertString:@"-" atIndex:3];
        [mu insertString:@"-" atIndex:7];
        cell.lbp_phone.text   = mu;
        cell.lbp_phone.textColor = [UIColor colorWithRed:47.0/255.0 green:98.0/255.0 blue:136.0/255.0 alpha:1];
        [cell.btp_phone       addTarget:self action:@selector(copyPhoneNumber:)           forControlEvents:UIControlEventTouchUpInside];

    }
    
    cell.btp_setAppt.tag      = indexPath.row;
    cell.btp_setupTicket.tag  = indexPath.row;
    cell.btp_patientName.tag  = indexPath.row;
    
    [cell.btp_patientName addTarget:self action:@selector(viewPatientDetails:)        forControlEvents:UIControlEventTouchUpInside];

    if ([self.arr_rt_patient_listing[indexPath.row][@"sut_done"] isEqualToString:@"0"]) {
        [cell.btp_setAppt     addTarget:self action:@selector(pushToAppointmentView:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btp_setupTicket addTarget:self action:@selector(setupTicketForPatient:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btp_setupTicket setBackgroundColor:[UIColor colorWithRed:47.0/255.0 green:98.0/255.0 blue:136.0/255.0 alpha:1]];
        [cell.btp_setupTicket setTitle:@"Setup Ticket" forState:UIControlStateNormal];
        
        if ([self.arr_rt_patient_listing[indexPath.row][@"apt_id"] isEqualToString:@""]) {
            [cell.btp_setAppt setBackgroundColor:[UIColor colorWithRed:22.0/255.0 green:125.0/255.0 blue:164.0/255.0 alpha:1.0]];
            [cell.btp_setAppt setTitle:@"Set Appt." forState:UIControlStateNormal];
        }
        else{
            [cell.btp_setAppt setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:165.0/255.0 blue:0.0/255.0 alpha:1.0]];
            [cell.btp_setAppt setTitle:@"View Appt." forState:UIControlStateNormal];
        }
    }
    else{
        [cell.btp_setAppt setBackgroundColor:[UIColor grayColor]];
        [cell.btp_setAppt setTitle:@"Setup Done" forState:UIControlStateNormal];
        [cell.btp_setAppt removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [cell.btp_setupTicket setBackgroundColor:[UIColor grayColor]];
        [cell.btp_setupTicket setTitle:@"Setup Done" forState:UIControlStateNormal];
        [cell.btp_setupTicket removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    }
    
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33;
}

#pragma mark - Tableview Actions

-(void)copyPhoneNumber:(UIButton*)sender{
   // UNCOMMENT IT - 14 NOV 2017
    NSString *phone = self.arr_rt_patient_listing[sender.tag][@"Pt_Home"];
    
    UIPasteboard *pb          = [UIPasteboard generalPasteboard];
    [pb setString:phone];
    [[[UIAlertView alloc] initWithTitle:@"Message!" message:@"Phone number copied!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    
}

-(void)pushToAppointmentView:(UIButton*)sender{
    
   
    
    NSDictionary *p_dict            = [self.arr_rt_patient_listing objectAtIndex:sender.tag];
    
//    CreateSchedule *createSch       = [self.storyboard instantiateViewControllerWithIdentifier:@"CSVC"];
//    createSch.isNewSchedule         = YES;
//    createSch.patientName           = [NSString stringWithFormat:@"%@ %@", p_dict[@"Pt_First"], p_dict[@"Pt_Last"]];
//    createSch.selectedPatientID     = p_dict[@"Pt_ID"];
//    
//    [self.navigationController pushViewController:createSch animated:YES];
    
    SetAppointment *appt            = [self.storyboard instantiateViewControllerWithIdentifier:@"APPT"];

    if ([p_dict[@"apt_id"] isEqualToString:@""]) {
        appt.pt_ID                      = p_dict[@"Pt_ID"];
        appt.patientName                = [NSString stringWithFormat:@"%@ %@", p_dict[@"Pt_First"], p_dict[@"Pt_Last"]];
        appt.isViewMode                 = NO;
    }
    else{
        appt.isViewMode                 = YES;
        appt.patientName                = [NSString stringWithFormat:@"%@ %@", p_dict[@"Pt_First"], p_dict[@"Pt_Last"]];
        appt.pt_ID                      = p_dict[@"Pt_ID"];
        appt.apt_id                     = p_dict[@"apt_id"];
    }
    [self.navigationController pushViewController:appt animated:YES];

}


-(void)setupTicketForPatient:(UIButton*)sender{
    [searchbar resignFirstResponder];
    
    NSDictionary *p_dict            = [self.arr_rt_patient_listing objectAtIndex:sender.tag];
    if ([p_dict[@"is_niv"] isEqualToString:@"1"]) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"NIVStoryboardOne" bundle:nil];
        NIVSetupTicket *niv_navigation = [mainStoryboard instantiateViewControllerWithIdentifier:@"NIVSetupTicket"];
        niv_navigation.pt_id = p_dict[@"Pt_ID"];
        
        
        
        [self.navigationController pushViewController:niv_navigation animated:YES];
    } else {
        SetUpTicketFormOne *formOne     = [self.storyboard instantiateViewControllerWithIdentifier:@"SUTFO"];
        formOne.isFromSchedule          = YES;
        formOne.isNewTicket             = YES;
        formOne.dict_patient            = p_dict;
        
        [Utils setEditingMode:NO];
        
        [self.navigationController pushViewController:formOne animated:YES];
    }
}

-(void)viewPatientDetails:(UIButton*)sender{
    [searchbar resignFirstResponder];
    
    HistoryView *object_HV          = [HistoryView new];
    NSDictionary *p_dict            = [self.arr_rt_patient_listing objectAtIndex:sender.tag];
    NSDictionary *dict              = [object_HV getDetailListForPatientOfId:p_dict[@"Pt_ID"]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[AppDelegate sharedInstance] removeCustomLoader];
        if(dict)
        {
            HistoryModel* object_HM = [[HistoryModel alloc]initWithDictionaryForPatientDetail:dict];
            PatientInformationViewController *object_PIVC   = [self.storyboard instantiateViewControllerWithIdentifier:@"PIVC"];
            object_PIVC.dict_patientInfo                    = object_HM.dict_profileInfo;
            object_PIVC.dict_docInfo                        = object_HM.dict_docInfo;
            object_PIVC.dict_insInfo                        = object_HM.dict_insInfo;
            object_PIVC.arr_pdfs                            = object_HM.arr_pdfs;
            
            [self.navigationController pushViewController:object_PIVC animated:YES];
        }
        
    });
}

- (void)filterContentForSearchText:(NSString*)searchText
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"Pt_First contains[cd] %@ OR Pt_Last contains[cd] %@", searchText, searchText];
    
    self.arr_temp_rt_patient_listing = [self.arr_rt_patient_listing filteredArrayUsingPredicate:resultPredicate];

}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length != 0) {
        [self filterContentForSearchText:searchText];
        
        self.arr_rt_patient_listing = [self.arr_temp_rt_patient_listing mutableCopy];
        [table_patients reloadData];
        
    }
    else{
        self.arr_rt_patient_listing = [self.arr_copy_rt_patient_listing mutableCopy];
        [table_patients reloadData];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchbar resignFirstResponder];
    self.arr_rt_patient_listing = [self.arr_copy_rt_patient_listing mutableCopy];
    [table_patients reloadData];
    
}

@end
