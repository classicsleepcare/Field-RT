//
//  SetUpTicketFormOne.m
//  RT APP
//
//  Created by Anil Prasad on 16/12/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "SetUpTicketFormOne.h"
#import "HistoryCell.h"
#import <QuartzCore/QuartzCore.h>
#import "SetUpTicketFormTwo.h"
#import "TicketFormModel.h"
#import "TicketFormView.h"
#import "HistoryModel.h"
#import "HistoryView.h"
#import "PatientInformationViewController.h"

#define BLUE_COLOR [[UIColor whiteColor] CGColor]
#define CLEAR_COLOR [[UIColor whiteColor] CGColor]

@interface SetUpTicketFormOne ()<UIGestureRecognizerDelegate>{
    CGPoint d_point;
    int indexOfDropdownCell;
    BOOL isDropdownOpened;
    int indexOfDropdownItem;
    
    int indexOfDropdownCell1;
    BOOL isDropdownOpened1;
    int indexOfDropdownItem1;
    
    int indexOfDropdownCell2;
    BOOL isDropdownOpened2;
    int indexOfDropdownItem2;
    
    TicketFormView *object_TV;
    IBOutlet UIView *vwPrevDME;
    IBOutlet UIButton *btn_hum_serial;
    IBOutlet UIButton *btn_modem_serial;
}

@end

@implementation SetUpTicketFormOne
@synthesize dict,isNewTicket,isFromInventory, isNotSubmitted, isFromSchedule, dict_patient, is_Auto_ResMed, is_Auto_SV_Respironics, is_ST_Respironics, isFitPack;

-(void)hideCPAPViews{
    cpap_view.hidden        = NO;
    cpap_auto_view.hidden   = YES;
    stand_view.hidden       = YES;
    auto_view.hidden        = YES;
    auto_sv_view.hidden     = YES;
    st_view.hidden          = YES;
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self callWebserviceForDropdowns];

    
}

-(void)fillPatientData{
    pt_ID = dict_patient[@"Pt_ID"];
    
    txt_rtPatient.text  = [NSString stringWithFormat:@"%@ %@",dict_patient[@"Pt_First"],dict_patient[@"Pt_Last"]];
    txt_fName.text      = dict_patient[@"Pt_First"];
    txt_lName.text      = dict_patient[@"Pt_Last"];
    
    if (dict_patient[@"pt_dob"] == nil) {
        txt_dob.text    = dict_patient[@"Pt_Birth_Date"];
    }
    else{
        txt_dob.text    = dict_patient[@"pt_dob"];
    }
    
    if ([dict_patient[@"Pt_Sex"] isEqual:@"M"]) {
        [(RadioButton*) self.maleFemaleRadio[0] setSelected:YES];
    }
    else{
        [(RadioButton*) self.maleFemaleRadio[1] setSelected:YES];
    }

    
    txt_streetAdd.text  = [NSString stringWithFormat:@"%@ %@",dict_patient[@"Pt_Add1"],dict_patient[@"Pt_Add2"]];;
    txt_city.text       = dict_patient[@"Pt_City"];
    txt_state.text      = dict_patient[@"Pt_State"];
    txt_zip.text        = dict_patient[@"Pt_Zip"];
    
    
    
    if ([dict_patient[@"Pt_Home"] isEqualToString:@""]) {
        txt_hPhone.text = @"NA";
    }
    else{
        
//        NSMutableString *mu = [NSMutableString stringWithString:dict_patient[@"Pt_Home"]];
//        [mu insertString:@"-" atIndex:3];
//        [mu insertString:@"-" atIndex:7];
        txt_hPhone.text   = dict_patient[@"Pt_Home"];
        
    }
    
    txt_email.text      = dict_patient[@"Pt_Email"];
    if ([dict_patient[@"Pt_Email"] isEqualToString:@""]) {
        //[txt_email becomeFirstResponder];
    }
    
    txt_cPhone.text     = dict_patient[@"Pt_Cell"];
    txt_wPhone.text     = dict_patient[@"Pt_Work"];
}



-(void)autoFillSetupTicket{
    
    
    lbl_ticketId.text   = [NSString stringWithFormat:@"- %@", dict[@"ticket_id"]];
    pt_ID               = dict[@"pt_id"];
    cpap_item_id        = dict[@"cpap_item_id"];
    modem_item_id       = dict[@"modem_item_id"];
    hum_item_id         = dict[@"hum_item_id"];
    
    txt_rtPatient.text  = [NSString stringWithFormat:@"%@ %@",dict[@"pt_first"],dict[@"pt_last"]];
    txt_fName.text      = dict[@"pt_first"];
    txt_lName.text      = dict[@"pt_last"];
    txt_dob.text        = dict[@"pt_dob"];
    txt_notes.text      = dict[@"notes"];
    
    NSString *machine_type = dict[@"machine_type"];
    if ([machine_type isEqualToString:@"0"]) {
        [(RadioButton*) self.cpap_new_old_dmeRadio[0] setSelected:YES];
        
        biLevelView0_one.hidden = YES;
        biLevelView1_one.hidden = YES;
        view_machine.hidden     = YES;

        txt_rtMachine.text          = dict[@"cpap_machine"];
        txt_CPAPmanufacturer.text   = dict[@"cpap_manufacturer"];
        txt_CPAPserialNo.text       = dict[@"cpap_serial"];
        txt_model.text              = dict[@"cpap_model"];
    }
    else if ([machine_type isEqualToString:@"1"]) {
        [(RadioButton*) self.cpap_new_old_dmeRadio[1] setSelected:YES];
        
        biLevelView0_one.hidden = NO;
        biLevelView1_one.hidden = NO;
        view_machine.hidden = YES;

        txt_rtMachine.text          = dict[@"cpap_machine"];
        txt_CPAPmanufacturer.text   = dict[@"cpap_manufacturer"];
        txt_CPAPserialNo.text       = dict[@"cpap_serial"];
        txt_model.text              = dict[@"cpap_model"];
        
    }
    else if ([machine_type isEqualToString:@"2"]) {
        [(RadioButton*) self.cpap_new_old_dmeRadio[2] setSelected:YES];
        
        view_machine.hidden         = NO;
        biLevelView0_one.hidden     = NO;
        biLevelView1_one.hidden     = NO;
        stand_view.hidden           = YES;
        auto_view.hidden            = YES;
        auto_ResMed_view.hidden     = YES;
        auto_sv_view.hidden         = YES;
        st_view.hidden              = YES;
        
        prev_machine_name.text      = dict[@"cpap_machine"];
        prev_serial.text            = dict[@"cpap_serial"];
    }
    else if ([machine_type isEqualToString:@"3"]){
        [(RadioButton*) self.cpap_new_old_dmeRadio[3] setSelected:YES];

        biLevelView0_one.hidden     = NO;
        biLevelView1_one.hidden     = NO;
        exchanegView.hidden         = NO;
        view_machine.hidden         = YES;
        
        txt_ex_pick_machine.text    = dict[@"picked_machine"];
        txt_ex_machine.text         = dict[@"picked_machine_name"];
        txt_ex_manufacturer.text    = dict[@"picked_manufacturer"];
        txt_ex_machine_serial.text  = dict[@"picked_machine_serial"];
        txt_ex_hum_serial.text      = dict[@"picked_hum_serial"];
        txt_ex_modem_seral.text     = dict[@"picked_modem_serial"];
        txt_ex_rt_machine.text      = dict[@"cpap_machine"];
        txt_ex_rt_manufacturer.text = dict[@"cpap_manufacturer"];
        txt_ex_rt_serial.text       = dict[@"cpap_serial"];
        txt_ex_rt_reference.text    = dict[@"cpap_model"];
    }
    
    
    NSString *biLevelOptions1    = dict[@"bi_level1"];
    
    if ([biLevelOptions1 isEqualToString:@"0"]){
        [(RadioButton*) self.biLevelRadio_Options_One[0] setSelected:YES];
        [(RadioButton*) self.biLevelRadio_One[2] setSelected:YES];
    }
    else if ([biLevelOptions1 isEqualToString:@"1"]){
        [(RadioButton*) self.biLevelRadio_Options_One[1] setSelected:YES];
        [(RadioButton*) self.biLevelRadio_One[2] setSelected:YES];
    }
    else if ([biLevelOptions1 isEqualToString:@"2"]){
        [(RadioButton*) self.biLevelRadio_Options_One[2] setSelected:YES];
        [(RadioButton*) self.biLevelRadio_One[2] setSelected:YES];
    }
    else if ([biLevelOptions1 isEqualToString:@"3"]){
        [(RadioButton*) self.biLevelRadio_Options_One[3] setSelected:YES];
        [(RadioButton*) self.biLevelRadio_One[2] setSelected:YES];
    }
    else{
        NSString *cpap1              = dict[@"cpap1"];
        
        if ([cpap1 isEqualToString:@"1"]) {
            [(RadioButton*) self.biLevelRadio_One[0] setSelected:YES];
        }
        if ([cpap1 isEqualToString:@"2"]) {
            [(RadioButton*) self.biLevelRadio_One[1] setSelected:YES];
        }
    }

    
    NSString *biLevelOptions    = dict[@"bi_level"];
    
    if ([biLevelOptions isEqualToString:@"0"]) {
        [(RadioButton*) self.biLevelRadio_Options[0] setSelected:YES];
        [(RadioButton*) self.biLevelRadio[2] setSelected:YES];

        cpap_view.hidden        = YES;
        cpap_auto_view.hidden   = YES;
        stand_view.hidden       = NO;
        auto_view.hidden        = YES;
        auto_sv_view.hidden     = YES;
        st_view.hidden          = YES;
        
        txt_std_ramp.text = dict[@"bi_st_ramp_time"];
        txt_std_ipap.text = dict[@"bi_st_ipap"];
        txt_std_epap.text = dict[@"bi_st_epap"];
    }
    else if ([biLevelOptions isEqualToString:@"1"]) {
        [(RadioButton*) self.biLevelRadio_Options[1] setSelected:YES];
        [(RadioButton*) self.biLevelRadio[2] setSelected:YES];
        
        cpap_view.hidden        = YES;
        cpap_auto_view.hidden   = YES;
        stand_view.hidden       = YES;
        auto_view.hidden        = NO;
        auto_sv_view.hidden     = YES;
        st_view.hidden          = YES;
        
        txt_auto_ramp.text = dict[@"bi_auto_ramp_time"];
        txt_auto_epap.text = dict[@"bi_auto_epap_min"];
        txt_auto_ipap.text = dict[@"bi_auto_epap_max"];
        txt_auto_pres_sup_min.text = dict[@"bi_auto_pressure_support_min"];
        txt_auto_pres_sup_max.text = dict[@"bi_auto_pressure_support_max"];
        
    }
    else if ([biLevelOptions isEqualToString:@"2"]) {
        [(RadioButton*) self.biLevelRadio_Options[2] setSelected:YES];
        [(RadioButton*) self.biLevelRadio[2] setSelected:YES];

        cpap_view.hidden        = YES;
        cpap_auto_view.hidden   = YES;
        stand_view.hidden       = YES;
        auto_view.hidden        = YES;
        auto_sv_view.hidden     = NO;
        st_view.hidden          = YES;
        
        txt_auto_sv_ramp.text = dict[@"bi_auto_sv_ramp_time"];
        txt_auto_sv_epap_min.text = dict[@"bi_auto_sv_epap_min"];
        txt_auto_sv_epap_max.text = dict[@"bi_auto_sv_ipap_max"];
        txt_auto_sv_backup.text = dict[@"bi_auto_sv_backup_rate"];
        txt_auto_sv_pres_sup_min.text = dict[@"bi_auto_sv_pressure_support_min"];
        txt_auto_sv_pres_sup_max.text = dict[@"bi_auto_sv_pressure_support_max"];
        txt_auto_sv_max_pres_sup.text = dict[@"bi_auto_sv_max_pressure_support"];
        
    }
    else if ([biLevelOptions isEqualToString:@"3"]) {
        [(RadioButton*) self.biLevelRadio_Options[3] setSelected:YES];
        [(RadioButton*) self.biLevelRadio[2] setSelected:YES];

        cpap_view.hidden        = YES;
        cpap_auto_view.hidden   = YES;
        stand_view.hidden       = YES;
        auto_view.hidden        = YES;
        auto_sv_view.hidden     = YES;
        st_view.hidden          = NO;
        
        txt_st_ramp.text = dict[@"bi_auto_st_ramp_time"];
        txt_st_ipap.text = dict[@"bi_auto_st_ipap"];
        txt_st_epap.text = dict[@"bi_auto_st_epap"];
        txt_st_backup.text = dict[@"bi_auto_st_backup_rate"];
    }
    else{
        NSString *cpap              = dict[@"cpap"];
        
        if ([cpap isEqualToString:@"1"]) {
            [(RadioButton*) self.biLevelRadio[0] setSelected:YES];
            
            cpap_view.hidden        = NO;
            cpap_auto_view.hidden   = YES;
            stand_view.hidden       = YES;
            auto_view.hidden        = YES;
            auto_sv_view.hidden     = YES;
            st_view.hidden          = YES;
            
            txt_cpap_cm.text = dict[@"cpap_cm"];
            txt_cpap_ramp.text = dict[@"cpap_ramp_time"];
            
        }
        if ([cpap isEqualToString:@"2"]) {
            [(RadioButton*) self.biLevelRadio[1] setSelected:YES];
            
            cpap_view.hidden        = YES;
            cpap_auto_view.hidden   = NO;
            stand_view.hidden       = YES;
            auto_view.hidden        = YES;
            auto_sv_view.hidden     = YES;
            st_view.hidden          = YES;
            
            txt_cpap_auto_ramp.text = dict[@"cpap_auto_ramp_time"];
            txt_cpap_auto_low.text = dict[@"cpap_auto_low_pressure"];
            txt_cpap_auto_high.text = dict[@"cpap_auto_high_pressure"];
        }
    }
    
    
    if ([dict[@"pt_gender"] isEqual:@"male"]) {
        [(RadioButton*) self.maleFemaleRadio[0] setSelected:YES];
    }
    else{
        [(RadioButton*) self.maleFemaleRadio[1] setSelected:YES];
    }
    
    if (dict[@"pt_spanish"]) {
        [self.btn_spanish setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    
    if ([dict[@"email_to_patient"] isEqualToString:@"1"]) {
        [btn_emailMe setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    else if ([dict[@"email_to_patient"] isEqualToString:@"2"]) {
        [btn_physicalEmailMe setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    else if ([dict[@"email_to_patient"] isEqualToString:@"3"]) {
        [btn_bothEmailMailMe setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    else{
        [btn_emailMe setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
        [btn_physicalEmailMe setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
        [btn_bothEmailMailMe setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];

    }
    
    txt_streetAdd.text  = dict[@"pt_add"];
    txt_city.text       = dict[@"pt_city"];
    txt_state.text      = dict[@"pt_state"];
    txt_zip.text        = dict[@"pt_zip"];
    txt_hPhone.text     = dict[@"pt_home"];
    txt_cPhone.text     = dict[@"pt_cell"];
    txt_wPhone.text     = dict[@"pt_work"];
    txt_email.text      = dict[@"pt_email"];
    
    if (dict[@"cpap"]) {
        [self.btn_cpapAuto setImage:[UIImage imageNamed:@"radio_btn_o"] forState:UIControlStateNormal];
    }
    
   
    
    txt_cm.text                 = dict[@"cpap_cm"];
    txt_rampTime.text           = dict[@"cpap_ramp_time"];
    txt_backUpRate.text         = dict[@"cpap_backup_rate"];
    txt_modem.text              = dict[@"modem"];
    
    
    txt_modemSerialNo.text          = dict[@"modem_serial"];
    txt_humidifierModem.text        = dict[@"hum_modem"];
    txt_humidifierManufacturer.text = dict[@"hum_manufacturer"];
    txt_humidifierSerialNo.text     = dict[@"hum_serial"];
    txt_mask.text                   = dict[@"mask"];
    txt_maskType.text               = dict[@"mask_type"];
    txt_maskName.text               = dict[@"mask_name"];
    txt_maskID.text                 = dict[@"mask_id#"];
    
    
    [self callWebserviceSelectedTicketItem:dict[@"ticket_id"]];
}

-(void)callWebserviceSelectedTicketItem:(NSString*)ID{
    object_TV                   = [TicketFormView new];
    dispatch_queue_t myQueue    = dispatch_queue_create("Items", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dicti     = [object_TV getItemsListOfSelectedTicket:ID];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM  = [[TicketFormModel alloc] initWithDictionary:dicti];
                arr_addedItems              = [object_TM.arr_rt_item_listing mutableCopy];
                arr_addedItems1             = [object_TM.arr_rt_discarded_item_listing mutableCopy];
                arr_addedItems2             = [object_TM.arr_rt_adtnl_item_listing mutableCopy];
                

                [table_formTable reloadData];
                [table_formTable1 reloadData];
                [table_formTable2 reloadData];
            }
        });
    });
}

-(IBAction)deselectBiLevelOptions{
    [(RadioButton*)self.biLevelRadio_Options[0] deselectOtherButtons];
    [(RadioButton*)self.biLevelRadio_Options[1] deselectOtherButtons];
    [(RadioButton*)self.biLevelRadio_Options[2] deselectOtherButtons];
    [(RadioButton*)self.biLevelRadio_Options[3] deselectOtherButtons];
    
    [(RadioButton*)self.biLevelRadio_Options[0] setEnabled:NO];
    [(RadioButton*)self.biLevelRadio_Options[1] setEnabled:NO];
    [(RadioButton*)self.biLevelRadio_Options[2] setEnabled:NO];
    [(RadioButton*)self.biLevelRadio_Options[3] setEnabled:NO];

    stand_view.hidden   = YES;
    auto_view.hidden    = YES;
    auto_ResMed_view.hidden = YES;
    auto_sv_view.hidden = YES;
    st_view.hidden      = YES;
}

-(IBAction)selectBiLevelOptions{
    [(RadioButton*)self.biLevelRadio_Options[0] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[1] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[2] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[3] setEnabled:YES];
    
    [(RadioButton*)self.biLevelRadio_Options[0] setSelected:YES];

    biLevelView1.hidden = YES;
    
    [self biLevelSelectedStandard];
}

-(IBAction)deselectBiLevelOptionsOne{
    [(RadioButton*)self.biLevelRadio_Options_One[0] deselectOtherButtons];
    [(RadioButton*)self.biLevelRadio_Options_One[1] deselectOtherButtons];
    [(RadioButton*)self.biLevelRadio_Options_One[2] deselectOtherButtons];
    [(RadioButton*)self.biLevelRadio_Options_One[3] deselectOtherButtons];
    
    [(RadioButton*)self.biLevelRadio_Options_One[0] setEnabled:NO];
    [(RadioButton*)self.biLevelRadio_Options_One[1] setEnabled:NO];
    [(RadioButton*)self.biLevelRadio_Options_One[2] setEnabled:NO];
    [(RadioButton*)self.biLevelRadio_Options_One[3] setEnabled:NO];
    
    btn_rtMachine.enabled = YES;
    btn_manufacturer.enabled = YES;
    
    [self cleanMachineValues];
}

-(IBAction)selectBiLevelOptionsOne{
    [(RadioButton*)self.biLevelRadio_Options_One[0] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options_One[1] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options_One[2] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options_One[3] setEnabled:YES];
    
    [(RadioButton*)self.biLevelRadio_Options_One[0] setSelected:YES];
    btn_rtMachine.enabled = YES;
    btn_manufacturer.enabled = YES;
    biLevelView1_one.hidden = YES;

    [(RadioButton*)self.biLevelRadio[2] setSelected:YES];
    [(RadioButton*)self.biLevelRadio_Options[0] setSelected:YES];
    [(RadioButton*)self.biLevelRadio_Options[0] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[1] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[2] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[3] setEnabled:YES];

    //[self selectBiLevelOptions];
    
    [(RadioButton*)self.biLevelRadio_Options[0] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[1] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[2] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[3] setEnabled:YES];
    
    [(RadioButton*)self.biLevelRadio_Options[0] setSelected:YES];
    
    
    [self biLevelSelectedStandard];

    [self cleanMachineValues];
}

-(void)cleanMachineValues{
    txt_rtMachine.text = @"";
    txt_CPAPmanufacturer.text = @"";
    txt_CPAPserialNo.text = @"";
    txt_rampTime.text = @"";
    txt_model.text = @"";
    
    txt_ex_pick_machine.text = @"";
    txt_ex_machine.text = @"";
    txt_ex_manufacturer.text = @"";
    txt_ex_machine_serial.text = @"";
    txt_ex_hum_serial.text = @"";
    txt_ex_modem_seral.text = @"";
    txt_ex_rt_machine.text = @"";
    txt_ex_rt_manufacturer.text = @"";
    txt_ex_rt_serial.text = @"";
    txt_ex_rt_reference.text = @"";
    prev_machine_name.text = @"";
    prev_serial.text = @"";
    
    
}

-(void)dismissKeyboard {
    [universalTextField resignFirstResponder];
}

#pragma mark UIGestureRecognizerDelegate methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.table_search]) {
        
        return NO;
    }
    
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    //[self defaultColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    //******** Moved from ViewWillAppear - 28 June *********//
    
    btn_delete.enabled      = NO;
    btn_submit.enabled      = NO;
    btn_save.enabled        = NO;
    
    self.arr_mask_size_fitPack = [[NSArray alloc] initWithObjects:@"NA", @"Petite/XSmall", @"Small", @"S/M", @"Medium", @"Large", @"XLarge", nil];
    self.arr_mask_size_WISP = [[NSArray alloc] initWithObjects:@"NA", @"Petite/XSmall", @"Small", @"S/M", @"Medium", @"Large", @"XLarge", nil];
    
    
    if (isFromSchedule) {
        lbl_ticketId.hidden = YES;
        [(RadioButton*)self.biLevelRadio_Options[0] setEnabled:NO];
        [(RadioButton*)self.biLevelRadio_Options[1] setEnabled:NO];
        [(RadioButton*)self.biLevelRadio_Options[2] setEnabled:NO];
        [(RadioButton*)self.biLevelRadio_Options[3] setEnabled:NO];
        
        [(RadioButton*)self.biLevelRadio_Options_One[0] setEnabled:NO];
        [(RadioButton*)self.biLevelRadio_Options_One[1] setEnabled:NO];
        [(RadioButton*)self.biLevelRadio_Options_One[2] setEnabled:NO];
        [(RadioButton*)self.biLevelRadio_Options_One[3] setEnabled:NO];
        
        [self defaultCPAPModeSettings];
        btn_mask_size.enabled = NO;
        [self fillPatientData];
        
        
        txt_notes.userInteractionEnabled = YES;
        
        //[self callWebserviceForDropdowns];
    }
    
    else if (isNewTicket){
        lbl_ticketId.hidden = YES;
        
        [(RadioButton*)self.biLevelRadio_Options[0] setEnabled:NO];
        [(RadioButton*)self.biLevelRadio_Options[1] setEnabled:NO];
        [(RadioButton*)self.biLevelRadio_Options[2] setEnabled:NO];
        [(RadioButton*)self.biLevelRadio_Options[3] setEnabled:NO];
        
        [(RadioButton*)self.biLevelRadio_Options_One[0] setEnabled:NO];
        [(RadioButton*)self.biLevelRadio_Options_One[1] setEnabled:NO];
        [(RadioButton*)self.biLevelRadio_Options_One[2] setEnabled:NO];
        [(RadioButton*)self.biLevelRadio_Options_One[3] setEnabled:NO];
        
        btn_mask_size.enabled = NO;
        txt_maskType.userInteractionEnabled = NO;
        
        [self defaultCPAPModeSettings];
        
        //[self callWebserviceForDropdowns];
        txt_notes.userInteractionEnabled = YES;
        
    }
    else if (isFromInventory) {
        lbl_ticketId.hidden = YES;
        
        [(RadioButton*)self.biLevelRadio_Options[0] setEnabled:NO];
        [(RadioButton*)self.biLevelRadio_Options[1] setEnabled:NO];
        [(RadioButton*)self.biLevelRadio_Options[2] setEnabled:NO];
        [(RadioButton*)self.biLevelRadio_Options[3] setEnabled:NO];
        
        [(RadioButton*)self.biLevelRadio_Options_One[0] setEnabled:NO];
        [(RadioButton*)self.biLevelRadio_Options_One[1] setEnabled:NO];
        [(RadioButton*)self.biLevelRadio_Options_One[2] setEnabled:NO];
        [(RadioButton*)self.biLevelRadio_Options_One[3] setEnabled:NO];
        
        //[(RadioButton*)self.biLevelRadio[0] setSelected:YES];
        //[self cpapSelected];
        [self defaultCPAPModeSettings];
        btn_mask_size.enabled = NO;
        //[self checkBordersOfPatientSection];
        
        txt_notes.userInteractionEnabled = YES;
        
        //[self callWebserviceForDropdowns];
    }
    
    else if (isNotSubmitted){
        lbl_ticketId.hidden = YES;
        [self autoFillSetupTicket];
        //[self callWebserviceForDropdowns];
        
        table_formTable.hidden  = NO;
        suppliesHeader.hidden   = NO;
        
        if ([dict[@"isFinalSubmit"] isEqualToString:@"1"]){
            disableFormView.hidden  = NO;
            disableFormView2.hidden = NO;
            
        }
        
        
        btn_delete.enabled      = NO;
        btn_submit.enabled      = NO;
        btn_save.enabled        = NO;
        //lbl_readOnly.hidden     = NO;
        // btn_addItems.hidden     = YES;
        [self enableFormLabels];
        
    }
    else{
        [self enableFormLabels];
        table_formTable.hidden  = NO;
        suppliesHeader.hidden   = NO;
        
        if ([dict[@"isFinalSubmit"] isEqualToString:@"1"]){
            disableFormView.hidden  = NO;
            disableFormView2.hidden = NO;
            
        }
        
        
        btn_delete.enabled      = NO;
        btn_submit.enabled      = NO;
        btn_save.enabled        = NO;
        //lbl_readOnly.hidden     = NO;
        btn_addItems.hidden     = YES;
        [self autoFillSetupTicket];
    }

    //******************************************************//
    
    [self.btn_spanish setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_emailMe setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    [btn_physicalEmailMe setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    [btn_bothEmailMailMe setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];

    
    d_scrollView.contentSize            = CGSizeMake(880, 4935); // 1950
    d_scrollView.contentOffset          = CGPointMake(0,0);
    isDropdownOpened                    = NO;
    
    for (RadioButton *radioButton in self.maleFemaleRadio) {
        radioButton.ButtonIcon          = [UIImage imageNamed:@"radio_btn"];
        radioButton.ButtonIconSelected  = [UIImage imageNamed:@"radio_btn_o"];
    }
    
    for (RadioButton *radioButton in self.wireRadio) {
        radioButton.ButtonIcon          = [UIImage imageNamed:@"radio_btn"];
        radioButton.ButtonIconSelected  = [UIImage imageNamed:@"radio_btn_o"];
    }
    
    for (RadioButton *radioButton in self.cpap_new_old_dmeRadio) {
        radioButton.ButtonIcon          = [UIImage imageNamed:@"radio_btn"];
        radioButton.ButtonIconSelected  = [UIImage imageNamed:@"radio_btn_o"];
    }
    
    for (RadioButton *radioButton in self.biLevelRadio) {
        radioButton.ButtonIcon          = [UIImage imageNamed:@"radio_btn"];
        radioButton.ButtonIconSelected  = [UIImage imageNamed:@"radio_btn_o"];
    }
    
    for (RadioButton *radioButton in self.biLevelRadio_Options) {
        radioButton.ButtonIcon          = [UIImage imageNamed:@"radio_btn"];
        radioButton.ButtonIconSelected  = [UIImage imageNamed:@"radio_btn_o"];
    }
    
    for (RadioButton *radioButton in self.biLevelRadio_One) {
        radioButton.ButtonIcon          = [UIImage imageNamed:@"radio_btn"];
        radioButton.ButtonIconSelected  = [UIImage imageNamed:@"radio_btn_o"];
    }
    
    for (RadioButton *radioButton in self.biLevelRadio_Options_One) {
        radioButton.ButtonIcon          = [UIImage imageNamed:@"radio_btn"];
        radioButton.ButtonIconSelected  = [UIImage imageNamed:@"radio_btn_o"];
    }
    
    
//    table_formTable.hidden              = YES;
//    suppliesHeader.hidden               = YES;
    
//    NSDictionary *added_Items = @{@"item_id":@"NA",
//                                  @"item_name":@"NA",
//                                  @"item_size":@"NA",
//                                  @"item_quantity":@"NA",
//                                  @"adtnl_items":@"NA"};

    arr_addedItems                       = [[NSMutableArray alloc] init];
    arr_addedItems1                      = [[NSMutableArray alloc] init];
    arr_addedItems2                      = [[NSMutableArray alloc] init];
    
    removedSupplyObjects                 = [[NSMutableArray alloc] init];
    removedSupplyObjects1                = [[NSMutableArray alloc] init];
    removedSupplyObjects2                = [[NSMutableArray alloc] init];
    self.arr_rt_mask_listing_temp        = [[NSMutableArray alloc] init];


//    [arr_addedItems1 addObject:added_Items];
//    [arr_addedItems2 addObject:added_Items];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(onKeyboardHide:)
                                                name:UIKeyboardWillHideNotification
                                              object:nil];


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
    
    
    
    self.arr_rt_states                          = [[NSArray alloc] initWithObjects:@"AL",@"AK",@"AZ",@"AR",@"CA",@"CO",@"CT",@"DE",@"DC",@"FL",@"GA",@"HI",@"ID",@"IL",@"IN",@"IA",@"KS",@"KY",@"LA",@"ME",@"MD",@"MA",@"MI",@"MN",@"MS",@"MO",@"MT",@"NE",@"NV",@"NH",@"NJ",@"NM",@"NY",@"NC",@"ND",@"OH",@"OK",@"OR",@"PA",@"RI",@"SC",@"SD",@"TN",@"TX",@"UT",@"VA",@"VT",@"WA",@"WV",@"WI",@"WY", nil];
    
//    self.arr_hum_modem_dropdown = [[NSArray alloc] initWithObjects:@"NA",@"NH",@"NJ",@"NM", nil];
//    self.arr_modem_dropdown     = [[NSArray alloc] initWithObjects:@"NA",@"NH",@"NJ",@"NM", nil];
    
   
    if (isFromInventory) {
        arr_addedItems = self.arr_fromInventory;
        [table_formTable reloadData];
        table_formTable.hidden = NO;
        suppliesHeader.hidden  = NO;
    }
   
}

-(void)enableFormLabels{
    lbl_fName.textColor = [UIColor blackColor];
    lbl_lName.textColor = [UIColor blackColor];
    lbl_dob.textColor = [UIColor blackColor];
    lbl_streetAdd.textColor = [UIColor blackColor];
    lbl_city.textColor = [UIColor blackColor];
    lbl_zip.textColor = [UIColor blackColor];
    lbl_hPhone.textColor = [UIColor blackColor];
    lbl_cPhone.textColor = [UIColor blackColor];
    lbl_wPhone.textColor = [UIColor blackColor];
    lbl_email.textColor = [UIColor blackColor];
    lbl_state.textColor = [UIColor blackColor];
    lbl_rtMachine.textColor = [UIColor blackColor];
    lbl_rtManufacturer.textColor = [UIColor blackColor];
    lbl_rtReference.textColor = [UIColor blackColor];
    lbl_rtSerialNo.textColor = [UIColor blackColor];
    lbl_humidifierManufacturer.textColor = [UIColor blackColor];
    lbl_humidifierSerialNo.textColor = [UIColor blackColor];
    lbl_modemSerialNo.textColor = [UIColor blackColor];
    lbl_maskID.textColor = [UIColor blackColor];
    lbl_maskSize.textColor = [UIColor blackColor];
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
    self.arr_rt_listing                 = object.arr_rt_listing;
    self.arr_rt_patient_listing         = object.arr_rt_patient_listing;
    //self.arr_rt_machines_listing        = object.arr_rt_machines_listing;
    //self.arr_rt_new_machines_listing    = object.arr_rt_new_machines_listing;
    
    NSMutableArray *temp_mask = [[NSMutableArray alloc] initWithArray:object.arr_rt_mask_listing];
    NSDictionary *na_mask = @{@"item_id":@"NA",
                                  @"isFitPack":@"0",
                                  @"mask_id":@"NA",
                                  @"mask_name":@"NA"};
    [temp_mask insertObject:na_mask atIndex:0];
    self.arr_rt_mask_listing            = temp_mask;
    self.arr_rt_mask_listing_temp       = temp_mask;

    NSDictionary *naDict = @{@"cpap_type": @"NA",
                             @"item_id": @"NA",
                             @"item_name": @"NA",
                             @"serialized": @"NA",
                             @"type": @"NA",
                             @"vendor_id": @"NA",
                             @"vendor_name": @"NA"};
    
    //self.arr_rt_modem                   = object.arr_rt_modem_listing;
    //self.arr_rt_H_modem                 = object.arr_rt_humidifier_listing;
    
    NSMutableArray *temp_hum = [@[naDict]mutableCopy];
    [temp_hum addObjectsFromArray:object.arr_rt_humidifier_listing];
    self.arr_rt_H_modem = temp_hum;
    
    NSMutableArray *temp_modem = [@[naDict]mutableCopy];
    [temp_modem addObjectsFromArray:object.arr_rt_modem_listing];
    self.arr_rt_modem = temp_modem;
    
    self.arr_rt_vendor_listing          = object.arr_rt_vendor_listing;
    
    
    self.arr_rt_new_machines_cpap       = [NSMutableArray new];
    self.arr_rt_new_machines_cpap_auto  = [NSMutableArray new];
    self.arr_rt_new_machines_stand      = [NSMutableArray new];
    self.arr_rt_new_machines_auto       = [NSMutableArray new];
    self.arr_rt_new_machines_auto_sv    = [NSMutableArray new];
    self.arr_rt_new_machines_st         = [NSMutableArray new];
    
    
    /*
    for (NSDictionary *machine in self.arr_rt_new_machines_listing) {
        NSString *cpap = machine[@"cpap_type"];
        
        if ([cpap isEqualToString:@"CPAP"]) {
            [self.arr_rt_new_machines_cpap addObject:machine];
        }
        if ([cpap isEqualToString:@"CPAP AUTO"]) {
            [self.arr_rt_new_machines_cpap_auto addObject:machine];
        }
        if ([cpap isEqualToString:@"Bi-Level Standard"]) {
            [self.arr_rt_new_machines_stand addObject:machine];
        }
        if ([cpap isEqualToString:@"Bi-Level Auto"]) {
            [self.arr_rt_new_machines_auto addObject:machine];
        }
        if ([cpap isEqualToString:@"Bi-Level Auto SV"]) {
            [self.arr_rt_new_machines_auto_sv addObject:machine];
        }
        if ([cpap isEqualToString:@"Bi-Level ST"]) {
            [self.arr_rt_new_machines_st addObject:machine];
        }
        
    }
    
    NSLog(@"self.arr_rt_new_machines_cpap: \n %@", self.arr_rt_new_machines_cpap);
    */
    
    //[dropdownsTableviewCon.tableView reloadData];
}

-(void)callWebserviceForMachineListingOfVendor:(NSString*)vendor_id{
    
    object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Dropdown", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        NSLog(@"RT_ID: %@", RT_ID);
        NSDictionary *dicti =[object_TV getMachineListing:RT_ID OfVendor:vendor_id];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM = [[TicketFormModel alloc] initWithDictionary:dicti];
                self.arr_rt_machines_listing   = object_TM.arr_rt_machines_listing;
                [dropdownsTableviewCon.tableView reloadData];
            }
        });
    });
}


-(void)onKeyboardHide:(NSNotification *)notification
{
    CGRect frame = addItemsView.frame;
    if (frame.origin.y == 27) {
        [UIView animateWithDuration:0.3 animations:^{
            [addItemsView setFrame:CGRectMake(70, 150, 700, 300)];
        }];
    }
}



#pragma mark - 
#pragma mark -

-(void)highlightMachineDropdown{
//    txt_rtMachine.layer.borderColor = BLUE_COLOR;
//    txt_rtMachine.layer.borderWidth = 1.0;
    //[self checkBordersOfMachineData];
    //[txt_rtMachine becomeFirstResponder];
}

-(void)uncheckMachineData{
    txt_rtMachine.layer.borderColor = CLEAR_COLOR;
    txt_rtMachine.layer.borderWidth = 1.0;
    
    txt_CPAPmanufacturer.layer.borderColor = CLEAR_COLOR;
    txt_CPAPmanufacturer.layer.borderWidth = 1.0;
    
    txt_CPAPserialNo.layer.borderColor = CLEAR_COLOR;
    txt_CPAPserialNo.layer.borderWidth = 1.0;
    
    txt_model.layer.borderColor = CLEAR_COLOR;
    txt_model.layer.borderWidth = 1.0;
    

}

-(void)enableCPAPMachineLabels{
    lbl_rtMachine.textColor = [UIColor blackColor];
    lbl_rtManufacturer.textColor = [UIColor blackColor];
    lbl_rtReference.textColor = [UIColor blackColor];
    lbl_rtSerialNo.textColor = [UIColor blackColor];
}

-(void)disableCPAPMachineLabels{
    lbl_rtMachine.textColor = [UIColor lightGrayColor];
    lbl_rtManufacturer.textColor = [UIColor lightGrayColor];
    lbl_rtReference.textColor = [UIColor lightGrayColor];
    lbl_rtSerialNo.textColor = [UIColor lightGrayColor];
}

-(IBAction)getListOfNewMachines{
    [self clearModeSettingValues];
    txt_humidifierModem.text = @"";
    txt_humidifierManufacturer.text  = @"";
    txt_humidifierSerialNo.text = @"";
    txt_modem.text = @"";
    txt_modemSerialNo.text = @"";
    txt_mask.text = @"";
    txt_maskType.text = @"";
    txt_maskID.text = @"";
    modem_item_id = @"";
    hum_item_id = @"";
    
    [universalTextField resignFirstResponder];
    vwPrevDME.hidden = YES;
    btn_humidifierModem.enabled = YES;
    btn_hum_serial.enabled = YES;
    btn_modem.enabled = YES;
    btn_modem_serial.enabled = YES;
    btn_mask.enabled = YES;
  /*
    if (![txt_fName.text isEqualToString:@""] &&
        ![txt_lName.text isEqualToString:@""] &&
        ![txt_dob.text isEqualToString:@""] &&
        ![txt_streetAdd.text isEqualToString:@""] &&
        ![txt_city.text isEqualToString:@""] &&
        ![txt_zip.text isEqualToString:@""] &&
        ![txt_hPhone.text isEqualToString:@""] &&
        ![txt_cPhone.text isEqualToString:@""] &&
        ![txt_wPhone.text isEqualToString:@""] &&
        ![txt_email.text isEqualToString:@""] &&
        ![txt_state.text isEqualToString:@""] )
    {
        
     */
    biLevelView0.hidden = NO;
    biLevelView1.hidden = NO;
    
    
        view_machine.hidden = YES;
        biLevelView0_one.hidden = YES;
       // biLevelView1_one.hidden = YES;
        exchanegView.hidden = YES;
        
//        txt_rtMachine.layer.borderColor = CLEAR_COLOR;
//        txt_rtMachine.layer.borderWidth = 1.0;
    
      //  [self disableCPAPMachineLabels];
        //[self uncheckMachineData];
        [self cleanMachineValues];
        [(RadioButton*)self.biLevelRadio_One[0] setSelected:NO];
        [(RadioButton*)self.biLevelRadio_One[1] setSelected:NO];
        [(RadioButton*)self.biLevelRadio_One[2] setSelected:NO];
        btn_rtMachine.enabled = NO;
        btn_manufacturer.enabled = NO;

        //[self checkBordersOfPatientSection];
    /*
    }
     */
    
   
}

-(IBAction)getListOfOldLoanerMachines{
    [self clearModeSettingValues];
    txt_humidifierModem.text = @"";
    txt_humidifierManufacturer.text  = @"";
    txt_humidifierSerialNo.text = @"";
    txt_modem.text = @"";
    txt_modemSerialNo.text = @"";
    txt_mask.text = @"";
    txt_maskType.text = @"";
    txt_maskID.text = @"";
    modem_item_id = @"";
    hum_item_id = @"";
    
    [universalTextField resignFirstResponder];
    vwPrevDME.hidden = YES;
    btn_humidifierModem.enabled = YES;
    btn_hum_serial.enabled = YES;
    btn_modem.enabled = YES;
    btn_modem_serial.enabled = YES;
    btn_mask.enabled = YES;
    
    
    /*
    if (![txt_fName.text isEqualToString:@""] &&
        ![txt_lName.text isEqualToString:@""] &&
        ![txt_dob.text isEqualToString:@""] &&
        ![txt_streetAdd.text isEqualToString:@""] &&
        ![txt_city.text isEqualToString:@""] &&
        ![txt_zip.text isEqualToString:@""] &&
        ![txt_hPhone.text isEqualToString:@""] &&
//        ![txt_cPhone.text isEqualToString:@""] &&
//        ![txt_wPhone.text isEqualToString:@""] &&
        ![txt_email.text isEqualToString:@""] &&
        ![txt_state.text isEqualToString:@""] )
    {
     */
    
    [self setModeSettings];

    biLevelView0.hidden = NO;
    biLevelView1.hidden = NO;
    
        view_machine.hidden = YES;
        biLevelView0_one.hidden = YES;
        biLevelView1_one.hidden = NO;
        exchanegView.hidden = YES;
        
        btn_rtMachine.enabled = YES;
        btn_manufacturer.enabled = YES;

        //[self enableCPAPMachineLabels];
        [self highlightMachineDropdown];
        [self cleanMachineValues];
        
        //[self checkBordersOfPatientSection];
    /*
    }
     */
    
}


-(IBAction)enterMachineDataManually{
    [self clearModeSettingValues];
    txt_humidifierModem.text = @"";
    txt_humidifierManufacturer.text  = @"";
    txt_humidifierSerialNo.text = @"";
    txt_modem.text = @"";
    txt_modemSerialNo.text = @"";
    txt_mask.text = @"";
    txt_maskType.text = @"";
    txt_maskID.text = @"";
    modem_item_id = @"";
    hum_item_id = @"";
    
    [universalTextField resignFirstResponder];
    vwPrevDME.hidden = NO;
    btn_humidifierModem.enabled = NO;
    btn_hum_serial.enabled = NO;
    btn_modem.enabled = NO;
    btn_modem_serial.enabled = NO;
    //btn_mask.enabled = NO;
    btn_mask_size.enabled = YES;
    
    /*
    if (![txt_fName.text isEqualToString:@""] &&
        ![txt_lName.text isEqualToString:@""] &&
        ![txt_dob.text isEqualToString:@""] &&
        ![txt_streetAdd.text isEqualToString:@""] &&
        ![txt_city.text isEqualToString:@""] &&
        ![txt_zip.text isEqualToString:@""] &&
        ![txt_hPhone.text isEqualToString:@""] &&
//        ![txt_cPhone.text isEqualToString:@""] &&
//        ![txt_wPhone.text isEqualToString:@""] &&
        ![txt_email.text isEqualToString:@""] &&
        ![txt_state.text isEqualToString:@""] )
    {
     */
    
    [self setModeSettings];
    
        view_machine.hidden = NO;
        
        stand_view.hidden   = YES;
        auto_view.hidden    = YES;
        auto_ResMed_view.hidden = YES;
        auto_sv_view.hidden = YES;
        st_view.hidden      = YES;
        
        biLevelView0_one.hidden = NO;
        biLevelView1_one.hidden = NO;
        exchanegView.hidden = YES;
        
        prev_machine_name.text = @"";
        prev_serial.text = @"";
        
//        prev_machine_name.layer.borderColor = BLUE_COLOR;
//        prev_machine_name.layer.borderWidth = 1.0;
        //[prev_machine_name becomeFirstResponder];
        
//        prev_serial.layer.borderColor = BLUE_COLOR;
//        prev_serial.layer.borderWidth = 1.0;
    
        [self cleanMachineValues];
        //[self checkBordersOfPatientSection];
       // [self checkBordersOfPrevDME];
    /*
    }
    */
}

-(IBAction)getListForExchangeMachines{
    [self clearModeSettingValues];
    txt_humidifierModem.text = @"";
    txt_humidifierManufacturer.text  = @"";
    txt_humidifierSerialNo.text = @"";
    txt_modem.text = @"";
    txt_modemSerialNo.text = @"";
    txt_mask.text = @"";
    txt_maskType.text = @"";
    txt_maskID.text = @"";
    modem_item_id = @"";
    hum_item_id = @"";
    
    vwPrevDME.hidden = YES;
    btn_humidifierModem.enabled = YES;
    btn_hum_serial.enabled = YES;
    btn_modem.enabled = YES;
    btn_modem_serial.enabled = YES;
    btn_mask.enabled = YES;
    //[universalTextField resignFirstResponder];
    
    /*
    if (![txt_fName.text isEqualToString:@""] &&
        ![txt_lName.text isEqualToString:@""] &&
        ![txt_dob.text isEqualToString:@""] &&
        ![txt_streetAdd.text isEqualToString:@""] &&
        ![txt_city.text isEqualToString:@""] &&
        ![txt_zip.text isEqualToString:@""] &&
        ![txt_hPhone.text isEqualToString:@""] &&
//        ![txt_cPhone.text isEqualToString:@""] &&
//        ![txt_wPhone.text isEqualToString:@""] &&
        ![txt_email.text isEqualToString:@""] &&
        ![txt_state.text isEqualToString:@""] )
    {
     */
    
    [self setModeSettings];
    
        biLevelView0_one.hidden = NO;
        biLevelView1_one.hidden = NO;
        exchanegView.hidden = NO;
        view_machine.hidden = YES;
        
//        txt_ex_pick_machine.layer.borderColor = BLUE_COLOR;
//        txt_ex_pick_machine.layer.borderWidth = 1.0;
    
        //[txt_ex_pick_machine becomeFirstResponder];
        
        [self cleanMachineValues];
        //[self checkBordersOfPatientSection];
        //[self checkBordersOfExchangeSection];
    /*
    }
     */
}

-(void)setModeSettings{
    biLevelView0.hidden = YES;
    
    [(RadioButton*)self.biLevelRadio[0] setSelected:YES];
    
    [(RadioButton*)self.biLevelRadio_Options[0] setSelected:NO];
    [(RadioButton*)self.biLevelRadio_Options[0] setEnabled:NO];
    [(RadioButton*)self.biLevelRadio_Options[1] setEnabled:NO];
    [(RadioButton*)self.biLevelRadio_Options[2] setEnabled:NO];
    [(RadioButton*)self.biLevelRadio_Options[3] setEnabled:NO];
    
    [self cpapSelected];
}

-(IBAction)getListOfCPAPMachines{
     [self cleanMachineValues];
    //[self enableCPAPMachineLabels];
    [self highlightMachineDropdown];
    
    biLevelView1_one.hidden = NO;
    [(RadioButton*)self.biLevelRadio[0] setSelected:YES];

    [(RadioButton*)self.biLevelRadio_Options[0] setSelected:NO];
    [(RadioButton*)self.biLevelRadio_Options[0] setEnabled:NO];
    [(RadioButton*)self.biLevelRadio_Options[1] setEnabled:NO];
    [(RadioButton*)self.biLevelRadio_Options[2] setEnabled:NO];
    [(RadioButton*)self.biLevelRadio_Options[3] setEnabled:NO];
    
    [self cpapSelected];
    //[self checkBordersOfMachineData];
}

-(IBAction)getListOfCPAPAutoMachines{
    [self cleanMachineValues];
    
    biLevelView1_one.hidden = NO;
    
    [(RadioButton*)self.biLevelRadio[1] setSelected:YES];
    
    [(RadioButton*)self.biLevelRadio_Options[0] setSelected:NO];
    [(RadioButton*)self.biLevelRadio_Options[0] setEnabled:NO];
    [(RadioButton*)self.biLevelRadio_Options[1] setEnabled:NO];
    [(RadioButton*)self.biLevelRadio_Options[2] setEnabled:NO];
    [(RadioButton*)self.biLevelRadio_Options[3] setEnabled:NO];
    
    [self cpapAutoSelected];
    
    [self enableCPAPMachineLabels];
    //[self checkBordersOfMachineData];
}

-(IBAction)getListOfBiStandMachines{
     [self cleanMachineValues];
    
    [(RadioButton*)self.biLevelRadio[2] setSelected:YES];
    [(RadioButton*)self.biLevelRadio_Options[0] setSelected:YES];
    [(RadioButton*)self.biLevelRadio_Options[0] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[1] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[2] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[3] setEnabled:YES];
    
    [self biLevelSelectedStandard];
    
    //[self enableCPAPMachineLabels];
    [self highlightMachineDropdown];
    //[self checkBordersOfMachineData];
}

-(IBAction)getListOfBiAutoMachines{
     [self cleanMachineValues];
    
    [(RadioButton*)self.biLevelRadio[2] setSelected:YES];
    [(RadioButton*)self.biLevelRadio_Options[1] setSelected:YES];
    [(RadioButton*)self.biLevelRadio_Options[0] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[1] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[2] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[3] setEnabled:YES];
    
    [self biLevelSelectedAuto];
    
    //[self enableCPAPMachineLabels];
    [self highlightMachineDropdown];
    //[self checkBordersOfMachineData];
}

-(IBAction)getListOfBiAutoSVMachines{
     [self cleanMachineValues];
    
    [(RadioButton*)self.biLevelRadio[2] setSelected:YES];
    [(RadioButton*)self.biLevelRadio_Options[2] setSelected:YES];
    [(RadioButton*)self.biLevelRadio_Options[0] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[1] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[2] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[3] setEnabled:YES];
    
    [self biLevelSelectedAutoSV];
    
    //[self enableCPAPMachineLabels];
    [self highlightMachineDropdown];
    //[self checkBordersOfMachineData];
}

-(IBAction)getListOfBiSTMachines{
     [self cleanMachineValues];
    
    [(RadioButton*)self.biLevelRadio[2] setSelected:YES];
    [(RadioButton*)self.biLevelRadio_Options[3] setSelected:YES];
    [(RadioButton*)self.biLevelRadio_Options[0] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[1] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[2] setEnabled:YES];
    [(RadioButton*)self.biLevelRadio_Options[3] setEnabled:YES];
    
    [self biLevelSelectedST];
    
    
    //[self enableCPAPMachineLabels];
    [self highlightMachineDropdown];
    //[self checkBordersOfMachineData];
}

-(void)viewPatientDetails{
    
    HistoryView *object_HV          = [HistoryView new];
    NSDictionary *dict1              = [object_HV getDetailListForPatientOfId:pt_ID];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[AppDelegate sharedInstance] removeCustomLoader];
        if(dict1)
        {
            HistoryModel* object_HM = [[HistoryModel alloc]initWithDictionaryForPatientDetail:dict1];
            PatientInformationViewController *object_PIVC   = [self.storyboard instantiateViewControllerWithIdentifier:@"PIVC"];
            object_PIVC.dict_patientInfo                    = object_HM.dict_profileInfo;
            object_PIVC.dict_docInfo                        = object_HM.dict_docInfo;
            object_PIVC.dict_insInfo                        = object_HM.dict_insInfo;
            object_PIVC.arr_pdfs                            = object_HM.arr_files_info;
            
            [self.navigationController pushViewController:object_PIVC animated:YES];
        }
        
    });
}

-(IBAction)actionForButton:(UIButton*)sender{
    [universalTextField resignFirstResponder];
    selectListNumber = sender.tag;
    //self.arr_dropdown = nil;
    
    switch (sender.tag) {
        case 11:{
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
            break;
            
        case 12:{
            [self selectExLeftVendor:sender];
        }
            break;
            
        case 13:{
            [self selectExRightVendor:sender];
        }
            break;
            
        case 14:{
            [self selectVendor:sender];
        }
            break;
            
        case 15:{
            [self viewPatientDetails];
        }
            break;
            
        case 120:{
            [self addItems:sender];
            btnSearch = sender;
        }
            break;
            
        case 130:{
            [self addItems:sender];
            btnSearch = sender;
        }
            break;
            
        case 140:{
            [self addItems:sender];
            btnSearch = sender;
        }
            break;
            
        case 121:{
            [self nextButtonPressed];
        }
            break;
        
        case 771:{
           // [self selectExPickupMachine:sender];
        }
            break;
            
        case 772:{ // Right
            [self selectExRtMachine:sender];
        }
            break;
            
        case 773:{ // Left
            [self selectExMachine:sender];
        }
            break;
            
        case 991:{
            [self selectPatient:sender];
        }
            break;
        case 992:{
            [self selectState:sender];
        }
            break;
        case 993:{
            [self selectMachine:sender];
        }
            break;
        case 994:{
            [self selectModem:sender];
        }
            break;
        case 995:{
            [self selectHumidifierModem:sender];
        }
            break;
        case 996:{
            //[self selectMask:sender];
            [self addItems:sender];
            btnSearch = sender;
        }
            break;
        case 997:{
            [self selectMaskSize:sender];
        }
            break;
        case 883:{ //998
            [self selectModemSerial:sender];
        }
            break;
        case 999:{
            [self selectMachineReferenceNumber:sender];
        }
            break;
        case 882:{ //888
            [self selectHumModemSerial:sender];
        }
            break;
        case 889:{
            [self selectSerialNumber:sender];
        }
            break;
        case 881:{
            [self selectExSerialNumber:sender];
        }
            break;
            
        default: 
            break;
    }
}
#pragma mark - BiLevel Popovers

-(void)defaultCPAPModeSettings{
    cpap_view.hidden        = NO;
    cpap_auto_view.hidden   = YES;
    stand_view.hidden       = YES;
    auto_view.hidden        = YES;
    auto_sv_view.hidden     = YES;
    st_view.hidden          = YES;
    
    txt_cpap_cm.userInteractionEnabled = NO;
    txt_cpap_ramp.userInteractionEnabled = NO;
}

-(IBAction)cpapSelected{
    [self clearModeSettingValues];
    [self cleaExMachineValues];
    /*
    if
    (
     (![txt_rtMachine.text isEqualToString:@""]&&
      ![txt_CPAPmanufacturer.text isEqualToString:@""]&&
      ![txt_CPAPserialNo.text isEqualToString:@""]&&
      ![txt_model.text isEqualToString:@""]) ||
     
     (![txt_rtMachine.text isEqualToString:@""]&&
      ![txt_CPAPmanufacturer.text isEqualToString:@""]&&
      ![txt_CPAPserialNo.text isEqualToString:@""]&&
      ![txt_model.text isEqualToString:@""]) ||
     
     (![prev_machine_name.text isEqualToString:@""]&&
      ![prev_serial.text isEqualToString:@""]
      ) ||
     
     (![prev_machine_name.text isEqualToString:@""]&&
      ![prev_serial.text isEqualToString:@""]
      ) ||
     
     (
      ![txt_ex_pick_machine.text isEqualToString:@""]&&
      ![txt_ex_machine.text isEqualToString:@""]&&
      ![txt_ex_manufacturer.text isEqualToString:@""]&&
      ![txt_ex_machine_serial.text isEqualToString:@""]&&
      ![txt_ex_hum_serial.text isEqualToString:@""]&&
      ![txt_ex_modem_seral.text isEqualToString:@""]&&
      ![txt_ex_rt_machine.text isEqualToString:@""]&&
      ![txt_ex_rt_manufacturer.text isEqualToString:@""]&&
      ![txt_ex_rt_serial.text isEqualToString:@""]&&
      ![txt_ex_rt_reference.text isEqualToString:@""]
      )
    )
    {
        */
    
    biLevelView1.hidden = NO;
    
        txt_cpap_cm.userInteractionEnabled = YES;
        txt_cpap_ramp.userInteractionEnabled = YES;
        cpap_view.hidden        = NO;
        cpap_auto_view.hidden   = YES;
        stand_view.hidden       = YES;
        auto_view.hidden        = YES;
        auto_sv_view.hidden     = YES;
        st_view.hidden          = YES;
        
        //[txt_cpap_cm becomeFirstResponder];
        
        //[self checkBordersOfCPAPModeSettings];
    /*
    }
     */
    
    
    
    
}

-(IBAction)cpapAutoSelected{
    [self clearModeSettingValues];
    [self cleaExMachineValues];
    /*
    if
        (
         (![txt_rtMachine.text isEqualToString:@""]&&
          ![txt_CPAPmanufacturer.text isEqualToString:@""]&&
          ![txt_CPAPserialNo.text isEqualToString:@""]&&
          ![txt_model.text isEqualToString:@""]) ||
         
         (![txt_rtMachine.text isEqualToString:@""]&&
          ![txt_CPAPmanufacturer.text isEqualToString:@""]&&
          ![txt_CPAPserialNo.text isEqualToString:@""]&&
          ![txt_model.text isEqualToString:@""]) ||
         
         (![prev_machine_name.text isEqualToString:@""]&&
          ![prev_serial.text isEqualToString:@""]
          ) ||
         
         (![prev_machine_name.text isEqualToString:@""]&&
          ![prev_serial.text isEqualToString:@""]
          ) ||
         
         (
          ![txt_ex_pick_machine.text isEqualToString:@""]&&
          ![txt_ex_machine.text isEqualToString:@""]&&
          ![txt_ex_manufacturer.text isEqualToString:@""]&&
          ![txt_ex_machine_serial.text isEqualToString:@""]&&
          ![txt_ex_hum_serial.text isEqualToString:@""]&&
          ![txt_ex_modem_seral.text isEqualToString:@""]&&
          ![txt_ex_rt_machine.text isEqualToString:@""]&&
          ![txt_ex_rt_manufacturer.text isEqualToString:@""]&&
          ![txt_ex_rt_serial.text isEqualToString:@""]&&
          ![txt_ex_rt_reference.text isEqualToString:@""]
          )
         )
    {
     */
    
    biLevelView1.hidden = NO;
    
        cpap_view.hidden        = YES;
        cpap_auto_view.hidden   = NO;
        stand_view.hidden       = YES;
        auto_view.hidden        = YES;
        auto_sv_view.hidden     = YES;
        st_view.hidden          = YES;
        
       // [txt_cpap_auto_ramp becomeFirstResponder];
        
        //[self checkBordersOfCPAPModeSettings];
    /*
    }
     */
    
    
}

-(IBAction)biLevelSelectedStandard{
    [self clearModeSettingValues];
    [self cleaExMachineValues];
    /*
    if
        (
         (![txt_rtMachine.text isEqualToString:@""]&&
          ![txt_CPAPmanufacturer.text isEqualToString:@""]&&
          ![txt_CPAPserialNo.text isEqualToString:@""]&&
          ![txt_model.text isEqualToString:@""]) ||
         
         (![txt_rtMachine.text isEqualToString:@""]&&
          ![txt_CPAPmanufacturer.text isEqualToString:@""]&&
          ![txt_CPAPserialNo.text isEqualToString:@""]&&
          ![txt_model.text isEqualToString:@""]) ||
         
         (![prev_machine_name.text isEqualToString:@""]&&
          ![prev_serial.text isEqualToString:@""]
          ) ||
         
         (![prev_machine_name.text isEqualToString:@""]&&
          ![prev_serial.text isEqualToString:@""]
          ) ||
         
         (
          ![txt_ex_pick_machine.text isEqualToString:@""]&&
          ![txt_ex_machine.text isEqualToString:@""]&&
          ![txt_ex_manufacturer.text isEqualToString:@""]&&
          ![txt_ex_machine_serial.text isEqualToString:@""]&&
          ![txt_ex_hum_serial.text isEqualToString:@""]&&
          ![txt_ex_modem_seral.text isEqualToString:@""]&&
          ![txt_ex_rt_machine.text isEqualToString:@""]&&
          ![txt_ex_rt_manufacturer.text isEqualToString:@""]&&
          ![txt_ex_rt_serial.text isEqualToString:@""]&&
          ![txt_ex_rt_reference.text isEqualToString:@""]
          )
         )
    {
     */
        cpap_view.hidden        = YES;
        cpap_auto_view.hidden   = YES;
        stand_view.hidden       = NO;
        auto_view.hidden        = YES;
        auto_sv_view.hidden     = YES;
        st_view.hidden          = YES;
        
        //[txt_std_ramp becomeFirstResponder];
        
        //[self checkBordersOfCPAPModeSettings];
    /*
    }
     */
   
    
}

-(IBAction)biLevelSelectedAuto{
    [self clearModeSettingValues];
    [self cleaExMachineValues];
    /*
    if
        (
         (![txt_rtMachine.text isEqualToString:@""]&&
          ![txt_CPAPmanufacturer.text isEqualToString:@""]&&
          ![txt_CPAPserialNo.text isEqualToString:@""]&&
          ![txt_model.text isEqualToString:@""]) ||
         
         (![txt_rtMachine.text isEqualToString:@""]&&
          ![txt_CPAPmanufacturer.text isEqualToString:@""]&&
          ![txt_CPAPserialNo.text isEqualToString:@""]&&
          ![txt_model.text isEqualToString:@""]) ||
         
         (![prev_machine_name.text isEqualToString:@""]&&
          ![prev_serial.text isEqualToString:@""]
          ) ||
         
         (![prev_machine_name.text isEqualToString:@""]&&
          ![prev_serial.text isEqualToString:@""]
          ) ||
         
         (
          ![txt_ex_pick_machine.text isEqualToString:@""]&&
          ![txt_ex_machine.text isEqualToString:@""]&&
          ![txt_ex_manufacturer.text isEqualToString:@""]&&
          ![txt_ex_machine_serial.text isEqualToString:@""]&&
          ![txt_ex_hum_serial.text isEqualToString:@""]&&
          ![txt_ex_modem_seral.text isEqualToString:@""]&&
          ![txt_ex_rt_machine.text isEqualToString:@""]&&
          ![txt_ex_rt_manufacturer.text isEqualToString:@""]&&
          ![txt_ex_rt_serial.text isEqualToString:@""]&&
          ![txt_ex_rt_reference.text isEqualToString:@""]
          )
         )
    {
     */
        cpap_view.hidden        = YES;
        cpap_auto_view.hidden   = YES;
        stand_view.hidden       = YES;
        auto_view.hidden        = NO;
        auto_sv_view.hidden     = YES;
        st_view.hidden          = YES;
        
        //[txt_auto_ramp becomeFirstResponder];
        
        //[self checkBordersOfCPAPModeSettings];
    /*
    }
     */
    
}

-(IBAction)biLevelSelectedAutoSV{
    [self clearModeSettingValues];
    [self cleaExMachineValues];
    /*
    if
        (
         (![txt_rtMachine.text isEqualToString:@""]&&
          ![txt_CPAPmanufacturer.text isEqualToString:@""]&&
          ![txt_CPAPserialNo.text isEqualToString:@""]&&
          ![txt_model.text isEqualToString:@""]) ||
         
         (![txt_rtMachine.text isEqualToString:@""]&&
          ![txt_CPAPmanufacturer.text isEqualToString:@""]&&
          ![txt_CPAPserialNo.text isEqualToString:@""]&&
          ![txt_model.text isEqualToString:@""]) ||
         
         (![prev_machine_name.text isEqualToString:@""]&&
          ![prev_serial.text isEqualToString:@""]
          ) ||
         
         (![prev_machine_name.text isEqualToString:@""]&&
          ![prev_serial.text isEqualToString:@""]
          ) ||
         
         (
          ![txt_ex_pick_machine.text isEqualToString:@""]&&
          ![txt_ex_machine.text isEqualToString:@""]&&
          ![txt_ex_manufacturer.text isEqualToString:@""]&&
          ![txt_ex_machine_serial.text isEqualToString:@""]&&
          ![txt_ex_hum_serial.text isEqualToString:@""]&&
          ![txt_ex_modem_seral.text isEqualToString:@""]&&
          ![txt_ex_rt_machine.text isEqualToString:@""]&&
          ![txt_ex_rt_manufacturer.text isEqualToString:@""]&&
          ![txt_ex_rt_serial.text isEqualToString:@""]&&
          ![txt_ex_rt_reference.text isEqualToString:@""]
          )
         )
    {
     */
        cpap_view.hidden        = YES;
        cpap_auto_view.hidden   = YES;
        stand_view.hidden       = YES;
        auto_view.hidden        = YES;
        auto_sv_view.hidden     = NO;
        st_view.hidden          = YES;
        
        //[txt_auto_sv_ramp becomeFirstResponder];
        
       // [self checkBordersOfCPAPModeSettings];
    /*
    }
     */
    
    
}

-(IBAction)biLevelSelectedST{
    [self clearModeSettingValues];
    [self cleaExMachineValues];
    /*
    if
        (
         (![txt_rtMachine.text isEqualToString:@""]&&
          ![txt_CPAPmanufacturer.text isEqualToString:@""]&&
          ![txt_CPAPserialNo.text isEqualToString:@""]&&
          ![txt_model.text isEqualToString:@""]) ||
         
         (![txt_rtMachine.text isEqualToString:@""]&&
          ![txt_CPAPmanufacturer.text isEqualToString:@""]&&
          ![txt_CPAPserialNo.text isEqualToString:@""]&&
          ![txt_model.text isEqualToString:@""]) ||
         
         (![prev_machine_name.text isEqualToString:@""]&&
          ![prev_serial.text isEqualToString:@""]
          ) ||
         
         (![prev_machine_name.text isEqualToString:@""]&&
          ![prev_serial.text isEqualToString:@""]
          ) ||
         
         (
          ![txt_ex_pick_machine.text isEqualToString:@""]&&
          ![txt_ex_machine.text isEqualToString:@""]&&
          ![txt_ex_manufacturer.text isEqualToString:@""]&&
          ![txt_ex_machine_serial.text isEqualToString:@""]&&
          ![txt_ex_hum_serial.text isEqualToString:@""]&&
          ![txt_ex_modem_seral.text isEqualToString:@""]&&
          ![txt_ex_rt_machine.text isEqualToString:@""]&&
          ![txt_ex_rt_manufacturer.text isEqualToString:@""]&&
          ![txt_ex_rt_serial.text isEqualToString:@""]&&
          ![txt_ex_rt_reference.text isEqualToString:@""]
          )
         )
    {
     */
        cpap_view.hidden        = YES;
        cpap_auto_view.hidden   = YES;
        stand_view.hidden       = YES;
        auto_view.hidden        = YES;
        auto_sv_view.hidden     = YES;
        st_view.hidden          = NO;
        //[txt_st_ramp becomeFirstResponder];
        
        //[self checkBordersOfCPAPModeSettings];
    /*
    }
     */
   
    
}

-(void)clearModeSettingValues{
    txt_cpap_cm.text = @"";
    txt_cpap_ramp.text = @"";
    txt_cpap_auto_ramp.text = @"";
    txt_cpap_auto_low.text = @"";
    txt_cpap_auto_high.text = @"";
    txt_std_ramp.text = @"";
    txt_std_ipap.text = @"";
    txt_std_epap.text = @"";
    txt_auto_ramp.text = @"";
    txt_auto_epap.text = @"";
    txt_auto_ipap.text = @"";
    txt_auto_pres_sup_min.text = @"";
    txt_auto_pres_sup_max.text = @"";
    txt_auto_sv_ramp.text = @"";
    txt_auto_sv_epap_min.text = @"";
    txt_auto_sv_epap_max.text = @"";
    txt_auto_sv_backup.text = @"";
    txt_auto_sv_pres_sup_min.text = @"";
    txt_auto_sv_pres_sup_max.text = @"";
    txt_auto_sv_max_pres_sup.text = @"";
    txt_st_ramp.text = @"";
    txt_st_ipap.text = @"";
    txt_st_epap.text = @"";
    txt_st_backup.text = @"";
}

-(void)cleaExMachineValues{
    txt_ex_pick_machine.text = @"";
    txt_ex_machine.text = @"";
    txt_ex_manufacturer.text = @"";
    txt_ex_machine_serial.text = @"";
    txt_ex_hum_serial.text = @"";
    txt_ex_modem_seral.text = @"";
    txt_ex_rt_machine.text = @"";
    txt_ex_rt_manufacturer.text = @"";
    txt_ex_rt_serial.text = @"";
    txt_ex_rt_reference.text = @"";
}

#pragma mark - Popovers

-(void)showPopover:(UIButton*)sender{
    dropdownsTableviewCon.tableView.contentOffset = CGPointMake(0, 0);
    [popoverCon presentPopoverFromRect:CGRectMake(sender.frame.size.width / 2, sender.frame.size.height / 1, 1, 1) inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}



-(void)selectPatient:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_patient_listing;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(200,500);
    [popoverCon setPopoverContentSize:CGSizeMake(200, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
    
}

-(void)selectExPickupMachine:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_machines_listing;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(300,500);
    [popoverCon setPopoverContentSize:CGSizeMake(300, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
    
}

-(void)selectExMachine:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_old_machines_listing;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(300,500);
    [popoverCon setPopoverContentSize:CGSizeMake(300, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
    
}

-(void)selectExLeftVendor:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_vendor_listing;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(300,500);
    [popoverCon setPopoverContentSize:CGSizeMake(300, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
    
}

-(void)selectExRightVendor:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_vendor_listing;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(300,500);
    [popoverCon setPopoverContentSize:CGSizeMake(300, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
    
}

-(void)selectVendor:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_vendor_listing;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(300,500);
    [popoverCon setPopoverContentSize:CGSizeMake(300, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
    
}

-(void)selectExRtMachine:(UIButton*)sender{
    //self.arr_dropdown = self.arr_rt_old_machines_listing;
   // self.arr_dropdown = self.arr_rt_new_machines_listing;
    
    NSString *biLevel = [(RadioButton*)self.biLevelRadio[0] selectedButton].titleLabel.text;
    NSString *biLevelOptions = [(RadioButton*)self.biLevelRadio_Options[0] selectedButton].titleLabel.text;
    
    if ([biLevel isEqualToString:@"CPAP"]) {
        self.arr_dropdown = self.arr_rt_new_machines_cpap;
        txt_rampTime.enabled = YES;
    }
    else if ([biLevel isEqualToString:@"CPAP Auto"]){
        self.arr_dropdown = self.arr_rt_new_machines_cpap_auto;
        txt_rampTime.enabled = YES;
    }
    else if ([biLevel isEqualToString:@"Bi Level"]){
        
        if ([biLevelOptions isEqualToString:@"Standard"]) {
            self.arr_dropdown = self.arr_rt_new_machines_stand;
            txt_rampTime.enabled = YES;
        }
        else if ([biLevelOptions isEqualToString:@"Auto"]){
            self.arr_dropdown = self.arr_rt_new_machines_auto;
            txt_rampTime.enabled = YES;
        }
        else if ([biLevelOptions isEqualToString:@"Auto SV"]){
            self.arr_dropdown = self.arr_rt_new_machines_auto_sv;
            txt_rampTime.enabled = YES;
        }
        else if ([biLevelOptions isEqualToString:@"ST"]) {
            self.arr_dropdown = self.arr_rt_new_machines_st;
            txt_rampTime.enabled = YES;
        }
        else{
            self.arr_dropdown = @[@""];
            txt_rampTime.enabled = NO;
        }
    }
    else{
        
        txt_rampTime.enabled = NO;
    }

    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(300,500);
    [popoverCon setPopoverContentSize:CGSizeMake(300, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];

}

-(void)selectState:(UIButton*)sender{
   
    self.arr_dropdown = self.arr_rt_states;

    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(120,300);
    [popoverCon setPopoverContentSize:CGSizeMake(120, 200) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];

}

-(void)selectMachine:(UIButton*)sender{
    
    
    
    NSString *machinesOption = [(RadioButton*)self.cpap_new_old_dmeRadio[0] selectedButton].titleLabel.text;

    if ([machinesOption isEqualToString:@"New"]) {
        
        NSString *biLevelOne = [(RadioButton*)self.biLevelRadio_One[0] selectedButton].titleLabel.text;
        NSString *biLevelOneOptions = [(RadioButton*)self.biLevelRadio_Options_One[0] selectedButton].titleLabel.text;

        if ([biLevelOne isEqualToString:@"CPAP1"]) {
            self.arr_dropdown = self.arr_rt_new_machines_cpap;
            txt_rampTime.enabled = YES;
        }
        else if ([biLevelOne isEqualToString:@"CPAP Auto1"]){
            self.arr_dropdown = self.arr_rt_new_machines_cpap_auto;
            txt_rampTime.enabled = YES;
        }
        else if ([biLevelOne isEqualToString:@"Bi Level1"]){
            
            if ([biLevelOneOptions isEqualToString:@"Standard1"]) {
                self.arr_dropdown = self.arr_rt_new_machines_stand;
                txt_rampTime.enabled = YES;
            }
            else if ([biLevelOneOptions isEqualToString:@"Auto1"]){
                self.arr_dropdown = self.arr_rt_new_machines_auto;
                txt_rampTime.enabled = YES;
            }
            else if ([biLevelOneOptions isEqualToString:@"Auto SV1"]){
                self.arr_dropdown = self.arr_rt_new_machines_auto_sv;
                txt_rampTime.enabled = YES;
            }
            else if ([biLevelOneOptions isEqualToString:@"ST1"]) {
                self.arr_dropdown = self.arr_rt_new_machines_st;
                txt_rampTime.enabled = YES;
            }
            else{
                self.arr_dropdown = @[@""];
                txt_rampTime.enabled = NO;
            }
        }
        else{
            
            txt_rampTime.enabled = NO;
        }
        
        
    }
    if ([machinesOption isEqualToString:@"Used"]){
        //self.arr_dropdown = self.arr_rt_old_machines_listing;

        NSString *biLevel = [(RadioButton*)self.biLevelRadio[0] selectedButton].titleLabel.text;
        NSString *biLevelOptions = [(RadioButton*)self.biLevelRadio_Options[0] selectedButton].titleLabel.text;
        
        if ([biLevel isEqualToString:@"CPAP"]) {
            self.arr_dropdown = self.arr_rt_new_machines_cpap;
            txt_rampTime.enabled = YES;
        }
        else if ([biLevel isEqualToString:@"CPAP Auto"]){
            self.arr_dropdown = self.arr_rt_new_machines_cpap_auto;
            txt_rampTime.enabled = YES;
        }
        else if ([biLevel isEqualToString:@"Bi Level"]){
            
            if ([biLevelOptions isEqualToString:@"Standard"]) {
                self.arr_dropdown = self.arr_rt_new_machines_stand;
                txt_rampTime.enabled = YES;
            }
            else if ([biLevelOptions isEqualToString:@"Auto"]){
                self.arr_dropdown = self.arr_rt_new_machines_auto;
                txt_rampTime.enabled = YES;
            }
            else if ([biLevelOptions isEqualToString:@"Auto SV"]){
                self.arr_dropdown = self.arr_rt_new_machines_auto_sv;
                txt_rampTime.enabled = YES;
            }
            else if ([biLevelOptions isEqualToString:@"ST"]) {
                self.arr_dropdown = self.arr_rt_new_machines_st;
                txt_rampTime.enabled = YES;
            }
            else{
                self.arr_dropdown = @[@""];
                txt_rampTime.enabled = NO;
            }
        }
        else{
            
            txt_rampTime.enabled = NO;
        }
    }
    
    
    if ([machinesOption isEqualToString:@"Prev DME"]) {
        
    }
    
    
    //self.arr_dropdown = self.arr_rt_machines_listing;


    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(300,500);
    [popoverCon setPopoverContentSize:CGSizeMake(300, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];

}

-(void)selectSerialNumber:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_serial_numbers;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(200,500);
    [popoverCon setPopoverContentSize:CGSizeMake(200, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectExSerialNumber:(UIButton*)sender{
    self.arr_dropdown = self.arr_rt_serial_numbers;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(200,500);
    [popoverCon setPopoverContentSize:CGSizeMake(200, 400) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectModem:(UIButton*)sender{
    
    /*
    if (![txt_notes.text isEqualToString:@""]) {
     */
        self.arr_dropdown = self.arr_rt_modem;
        
        
        [self showPopover:sender];
        popoverViewCon.preferredContentSize = CGSizeMake(250,300);
        [popoverCon setPopoverContentSize:CGSizeMake(250, 200) animated:NO];
        [dropdownsTableviewCon.tableView reloadData];
    /*
    }
     */
    

}

-(void)selectHumidifierModem:(UIButton*)sender{
    
    /*
    if (
        (![txt_cpap_cm.text isEqualToString:@""]&&
         ![txt_cpap_ramp.text isEqualToString:@""]) ||
        
        (![txt_cpap_auto_ramp.text isEqualToString:@""]&&
         ![txt_cpap_auto_low.text isEqualToString:@""]&&
         ![txt_cpap_auto_high.text isEqualToString:@""]) ||
        
        (![txt_std_ramp.text isEqualToString:@""]&&
         ![txt_std_ipap.text isEqualToString:@""]&&
         ![txt_std_epap.text isEqualToString:@""]) ||
        
        (![txt_auto_ramp.text isEqualToString:@""]&&
         ![txt_auto_epap.text isEqualToString:@""]&&
         ![txt_auto_ipap.text isEqualToString:@""]&&
         ![txt_auto_pres_sup_min.text isEqualToString:@""]&&
         ![txt_auto_pres_sup_max.text isEqualToString:@""]) ||
        
        (![txt_auto_sv_ramp.text isEqualToString:@""]&&
         ![txt_auto_sv_epap_min.text isEqualToString:@""]&&
         ![txt_auto_sv_epap_max.text isEqualToString:@""]&&
         ![txt_auto_sv_backup.text isEqualToString:@""]&&
         ![txt_auto_sv_pres_sup_min.text isEqualToString:@""]&&
         ![txt_auto_sv_pres_sup_max.text isEqualToString:@""]&&
         ![txt_auto_sv_max_pres_sup.text isEqualToString:@""]) ||
        
        (![txt_st_ramp.text isEqualToString:@""]&&
         ![txt_st_ipap.text isEqualToString:@""]&&
         ![txt_st_epap.text isEqualToString:@""]&&
         ![txt_st_backup.text isEqualToString:@""])
        
        )
        
    {
     */
        //[self checkBordersOfCPAPModeSettings];
        
        self.arr_dropdown = self.arr_rt_H_modem;
        [dropdownsTableviewCon.tableView reloadData];
        
        
        [self showPopover:sender];
        popoverViewCon.preferredContentSize = CGSizeMake(300,500);
        [popoverCon setPopoverContentSize:CGSizeMake(300, 400) animated:NO];
    /*
    }
     */
    
}

-(void)selectMask:(UIButton*)sender{
    
    /*
    if (![txt_modemSerialNo.text isEqualToString:@""]) {
     
     */
        self.arr_dropdown = self.arr_rt_mask_listing;
        
        [self showPopover:sender];
        popoverViewCon.preferredContentSize = CGSizeMake(300,500);
        [popoverCon setPopoverContentSize:CGSizeMake(300, 400) animated:NO];
    
        [dropdownsTableviewCon.tableView reloadData];
    /*
    }
     */
}

-(void)selectMaskSize:(UIButton*)sender{
    if (isFitPack) {
        self.arr_dropdown = self.arr_mask_size_fitPack;
        [self showPopover:sender];
        popoverViewCon.preferredContentSize = CGSizeMake(200,225);
        [popoverCon setPopoverContentSize:CGSizeMake(200, 225) animated:NO];
        [dropdownsTableviewCon.tableView reloadData];
    }
    else{
        self.arr_dropdown = self.arr_mask_size_WISP;
        [self showPopover:sender];
        popoverViewCon.preferredContentSize = CGSizeMake(200,225);
        [popoverCon setPopoverContentSize:CGSizeMake(200, 225) animated:NO];
        [dropdownsTableviewCon.tableView reloadData];
    }
    
    isFitPack             = NO;
}

-(void)selectModemSerial:(UIButton*)sender{
    
    self.arr_dropdown = self.arr_modem_dropdown;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250,300);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 200) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectHumModemSerial:(UIButton*)sender{
    
    self.arr_dropdown = self.arr_hum_modem_dropdown;
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(250,300);
    [popoverCon setPopoverContentSize:CGSizeMake(250, 200) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

-(void)selectMachineReferenceNumber:(UIButton*)sender{
    NSString *machinesOption = [(RadioButton*)self.cpap_new_old_dmeRadio[0] selectedButton].titleLabel.text;
    
    if ([machinesOption isEqualToString:@"New"]) {
        self.arr_dropdown = self.arr_rt_new_machines_listing;
    }
    if ([machinesOption isEqualToString:@"Used"]){
        //self.arr_dropdown = self.arr_rt_machines_listing;
        self.arr_dropdown = self.arr_rt_new_machines_listing;
        
    }
    if ([machinesOption isEqualToString:@"Prev DME"]) {
        
    }
    
    //self.arr_dropdown = self.arr_rt_machines_listing;
    
    
    [self showPopover:sender];
    popoverViewCon.preferredContentSize = CGSizeMake(150,300);
    [popoverCon setPopoverContentSize:CGSizeMake(150, 200) animated:NO];
    [dropdownsTableviewCon.tableView reloadData];
}

#pragma mark - Email Validator

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark -
#pragma mark - UISearchBar Delegate


-(void)nextButtonPressed{
    
    if (isNewTicket){
        [self validateFilledForm:YES];
        //[self saveFormData];
    }
    else if (isNotSubmitted){
        [self validateFilledForm:NO];
    }
    else{
        SetUpTicketFormTwo *formTwoVC   = [self.storyboard instantiateViewControllerWithIdentifier:@"SUTFT"];
        formTwoVC.dict_form             = self.dict;
        [self.navigationController pushViewController:formTwoVC animated:YES];
    }
    
}

-(void)showAlertForImcompleteForm{
    [[AppDelegate sharedInstance] showAlertMessage:@"All field(s) are mandatory!"];
}

-(void)validateFilledForm:(BOOL)NewTicket{
    
   // [self saveFormData:NewTicket];
    
    /*
    
    NSString *bi_level      = [(RadioButton*)self.biLevelRadio[0]           selectedButton].titleLabel.text;
    NSString *gender        = [(RadioButton*)self.maleFemaleRadio[0]        selectedButton].titleLabel.text;
    NSString *modem_type    = [(RadioButton*)self.wireRadio[0]              selectedButton].titleLabel.text;
    NSString *machine_type  = [(RadioButton*)self.cpap_new_old_dmeRadio[0]  selectedButton].titleLabel.text;
    
    if (bi_level == nil) {
        [self showAlertForImcompleteForm];
    }
    else if (machine_type == nil){
        [self showAlertForImcompleteForm];
    }
    else if (gender == nil){
        [self showAlertForImcompleteForm];
    }
    else if (modem_type == nil){
        [self showAlertForImcompleteForm];
    }
    else if ([txt_rtPatient.text isEqualToString:@""]) {
        [self showAlertForImcompleteForm];
    }
    else if ([txt_fName.text isEqualToString:@""]){
        [self showAlertForImcompleteForm];
        
    }
    else if ([txt_lName.text isEqualToString:@""]){
        [self showAlertForImcompleteForm];
        
    }
    else if ([txt_streetAdd.text isEqualToString:@""]){
        [self showAlertForImcompleteForm];
        
    }
    else if ([txt_city.text isEqualToString:@""]){
        [self showAlertForImcompleteForm];
        
    }
    else if ([txt_state.text isEqualToString:@""]){
        [self showAlertForImcompleteForm];
        
    }
    else if ([txt_zip.text isEqualToString:@""]){
        [self showAlertForImcompleteForm];
        
    }
    else if ([txt_hPhone.text isEqualToString:@""]){
        [self showAlertForImcompleteForm];
        
    }
    else if ([txt_cPhone.text isEqualToString:@""]){
        [self showAlertForImcompleteForm];
        
    }
    else if ([txt_wPhone.text isEqualToString:@""]){
        [self showAlertForImcompleteForm];
        
    }
    else if ([txt_email.text isEqualToString:@""]){
        [self showAlertForImcompleteForm];
    }
    else if (![self validateEmailWithString:txt_email.text]){
        [[AppDelegate sharedInstance] showAlertMessage:@"'Email' format is incorrect!"];
    }
    else if ([txt_rtMachine.text isEqualToString:@""]){
        [self showAlertForImcompleteForm];
        
    }
    else if ([txt_CPAPmanufacturer.text isEqualToString:@""]){
        [self showAlertForImcompleteForm];
        
    }
    else if ([txt_model.text isEqualToString:@""]){
        [self showAlertForImcompleteForm];
        
    }
    else if ([txt_CPAPserialNo.text isEqualToString:@""]){
        [self showAlertForImcompleteForm];
        
    }
    else if ([txt_cm.text isEqualToString:@""]){
        [self showAlertForImcompleteForm];
        
    }
    else if ([txt_rampTime.text isEqualToString:@""]){
        [self showAlertForImcompleteForm];
        
    }
    else 
     
    if (![txt_humidifierModem.text isEqualToString:@""] &&
    ([txt_humidifierManufacturer.text isEqualToString:@""] ||
    [txt_humidifierSerialNo.text isEqualToString:@""])) {
        
        [self showCustomAlert:@"Please fill all the details of Humidifier"];
        
    }
    
    else if (![txt_modem.text isEqualToString:@""] &&
    [txt_modemSerialNo.text isEqualToString:@""]){
        [self showCustomAlert:@"Please select Modem Serial No.!"];
        
    }

    else if (![txt_mask.text isEqualToString:@""] &&
    ([txt_maskName.text isEqualToString:@""] ||
    [txt_maskID.text isEqualToString:@""])){
        
        [self showCustomAlert:@"Please fill all the details of Mask"];
    }
  */
    
     if ([txt_mask.text isEqualToString:@""]){
        [self showAlertForImcompleteForm];
    }
    else if ([txt_maskName.text isEqualToString:@""]){
        [self showAlertForImcompleteForm];
    }
    else if ([txt_maskID.text isEqualToString:@""]){
        [self showAlertForImcompleteForm];
    }
/*
    else if ([btn_emailMe.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] ||
             [btn_physicalEmailMe.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]] ||
             [btn_bothEmailMailMe.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]){
        [self showCustomAlert:@"Please select at least one mail notification method"];
    }
    */
    else if (arr_addedItems.count == 0){
        [self showAlertForImcompleteForm];
    }
    else if (arr_addedItems1.count == 0){
        [self showAlertForImcompleteForm];
    }
    else if (arr_addedItems2.count == 0){
        [self showAlertForImcompleteForm];
    }
    else if ([txt_notes.text isEqualToString:@""]){
        [self showAlertForImcompleteForm];
    }
    else{
        [self saveFormData:NewTicket];
    }
     
     
}

-(void)showCustomAlert:(NSString*)msg{
    [[AppDelegate sharedInstance] showAlertMessage:msg];
}


-(void)saveFormData:(BOOL)NewTicket{
    [Utils takeScreenshot:d_scrollView];
    NSMutableDictionary *formOneData = [[NSMutableDictionary alloc] init];
    
    [formOneData setObject:RT_ID forKey:@"rt_id"];
    [formOneData setObject:pt_ID forKey:@"pt_id"];
    [formOneData setObject:txt_fName.text forKey:@"pt_first"];
    [formOneData setObject:txt_lName.text forKey:@"pt_last"];
    [formOneData setObject:@"pending" forKey:@"status"];
    
    
    NSString *machine_type = [(RadioButton*)self.cpap_new_old_dmeRadio[0] selectedButton].titleLabel.text;
    
    if ([machine_type isEqualToString:@"New"]) {
        [formOneData setObject:@"0" forKey:@"machine_type"];
    }
    if ([machine_type isEqualToString:@"Used"]) {
        [formOneData setObject:@"1" forKey:@"machine_type"];
    }
    if ([machine_type isEqualToString:@"Prev DME"]) {
        [formOneData setObject:@"2" forKey:@"machine_type"];
    }
    if ([machine_type isEqualToString:@"Exchange"]) {
        [formOneData setObject:@"3" forKey:@"machine_type"];
    }
    
    if (cpap_item_id == nil) {
        [formOneData setObject:@"0" forKey:@"cpap_item_id"];
    }else{
        [formOneData setObject:cpap_item_id forKey:@"cpap_item_id"];
    }
    
    if (modem_item_id == nil) {
        [formOneData setObject:@"0" forKey:@"modem_item_id"];
    }
    else{
        [formOneData setObject:modem_item_id forKey:@"modem_item_id"];
    }
    
    if (hum_item_id == nil) {
        [formOneData setObject:@"0" forKey:@"hum_item_id"];
    }
    else{
        [formOneData setObject:hum_item_id forKey:@"hum_item_id"];
    }


    [formOneData setObject:[(RadioButton*)self.maleFemaleRadio[0] selectedButton].titleLabel.text forKey:@"pt_gender"];
    
    if ([self.btn_spanish.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [formOneData setObject:@"0" forKey:@"pt_spanish"];
    }else{
        [formOneData setObject:@"1" forKey:@"pt_spanish"];
    }
    
    if ([btn_emailMe.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"1" forKey:@"email_to_patient"];
    }
    else if ([btn_physicalEmailMe.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"2" forKey:@"email_to_patient"];
    }
    else if ([btn_bothEmailMailMe.imageView.image isEqual:[UIImage imageNamed:@"chk_box_o.png"]]) {
        [formOneData setObject:@"3" forKey:@"email_to_patient"];
    }
    else{
        [formOneData setObject:@"0" forKey:@"email_to_patient"];
    }
    
   
    
    
    [formOneData setObject:txt_streetAdd.text forKey:@"pt_add"];
    [formOneData setObject:txt_city.text forKey:@"pt_city"];
    [formOneData setObject:txt_state.text forKey:@"pt_state"];
    [formOneData setObject:txt_zip.text forKey:@"pt_zip"];
    [formOneData setObject:txt_hPhone.text forKey:@"pt_home"];
    [formOneData setObject:txt_cPhone.text forKey:@"pt_cell"];
    [formOneData setObject:txt_wPhone.text forKey:@"pt_work"];
    [formOneData setObject:txt_email.text forKey:@"pt_email"];
    [formOneData setObject:txt_dob.text forKey:@"pt_dob"];
    [formOneData setObject:txt_notes.text forKey:@"notes"];
    
    
    
    
    //************
    
    
    
    NSString *cpap1      = [(RadioButton*)self.biLevelRadio_One[0] selectedButton].titleLabel.text;
    
    if ([cpap1 isEqualToString:@"CPAP1"]) {
        [formOneData setObject:@"1" forKey:@"cpap1"];
    }
    else if ([cpap1 isEqualToString:@"CPAP Auto1"]) {
        [formOneData setObject:@"2" forKey:@"cpap1"];
    }
    else if ([cpap1 isEqualToString:@"Bi Level1"]) {
        [formOneData setObject:@"3" forKey:@"cpap1"];
    }
    else{
        [formOneData setObject:@"" forKey:@"cpap1"];
    }
    
    NSString *level1      = [(RadioButton*)self.biLevelRadio_Options_One[0] selectedButton].titleLabel.text;
    
    if ([level1 isEqualToString:@"Standard1"]) {
        [formOneData setObject:@"0" forKey:@"level1"];
    }
    else if ([level1 isEqualToString:@"Auto1"]) {
        [formOneData setObject:@"1" forKey:@"level1"];
    }
    else if ([level1 isEqualToString:@"Auto SV1"]) {
        [formOneData setObject:@"2" forKey:@"level1"];
    }
    else if ([level1 isEqualToString:@"ST1"]) {
        [formOneData setObject:@"3" forKey:@"level1"];
    }
    else{
        [formOneData setObject:@"" forKey:@"level1"];
    }
    
    
    NSString *cpap      = [(RadioButton*)self.biLevelRadio[0] selectedButton].titleLabel.text;

    if ([cpap isEqualToString:@"CPAP"]) {
        [formOneData setObject:@"1" forKey:@"cpap"];
    }
    else if ([cpap isEqualToString:@"CPAP Auto"]) {
        [formOneData setObject:@"2" forKey:@"cpap"];
    }
    else if ([cpap isEqualToString:@"Bi Level"]) {
        [formOneData setObject:@"3" forKey:@"cpap"];
    }
    else{
        [formOneData setObject:@"" forKey:@"cpap"];
    }
    
    NSString *level      = [(RadioButton*)self.biLevelRadio_Options[0] selectedButton].titleLabel.text;

    if ([level isEqualToString:@"Standard"]) {
        [formOneData setObject:@"0" forKey:@"level"];
    }
    else if ([level isEqualToString:@"Auto"]) {
        [formOneData setObject:@"1" forKey:@"level"];
    }
    else if ([level isEqualToString:@"Auto SV"]) {
        [formOneData setObject:@"2" forKey:@"level"];
    }
    else if ([level isEqualToString:@"ST"]) {
        [formOneData setObject:@"3" forKey:@"level"];
    }
    else{
        [formOneData setObject:@"" forKey:@"level"];
    }
    
    if ([[formOneData valueForKey:@"cpap1"] isEqualToString:@"1"]||
        [[formOneData valueForKey:@"cpap1"] isEqualToString:@"2"]){
        [formOneData setObject:@"" forKey:@"level1"];
    }
    
    if ([[formOneData valueForKey:@"cpap"] isEqualToString:@"1"]||
        [[formOneData valueForKey:@"cpap"] isEqualToString:@"2"]){
        [formOneData setObject:@"" forKey:@"level"];
    }
    
    if ([[formOneData valueForKey:@"machine_type"] isEqualToString:@"0"]||
        [[formOneData valueForKey:@"machine_type"] isEqualToString:@"1"]){
        [formOneData setObject:@"" forKey:@"cpap"];
        [formOneData setObject:@"" forKey:@"level"];
    }
    
    if ([[formOneData valueForKey:@"machine_type"] isEqualToString:@"2"]||
        [[formOneData valueForKey:@"machine_type"] isEqualToString:@"3"]){
        [formOneData setObject:@"" forKey:@"cpap1"];
        [formOneData setObject:@"" forKey:@"level1"];
    }
    
    
    
    //********//********//********
    
    if ([txt_cpap_cm.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"cpap_cm"];
    }
    else{
        [formOneData setObject:txt_cpap_cm.text forKey:@"cpap_cm"];
    }
    
    if ([txt_cpap_ramp.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"cpap_ramp_time"];
    }
    else{
        [formOneData setObject:txt_cpap_ramp.text forKey:@"cpap_ramp_time"];
    }
    
    if ([txt_cpap_auto_ramp.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"cpap_auto_ramp_time"];
    }
    else{
        [formOneData setObject:txt_cpap_auto_ramp.text forKey:@"cpap_auto_ramp_time"];
    }
    
    if ([txt_cpap_auto_low.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"cpap_auto_low_pressure"];
    }
    else{
        [formOneData setObject:txt_cpap_auto_low.text forKey:@"cpap_auto_low_pressure"];
    }
    
    if ([txt_cpap_auto_high.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"cpap_auto_high_pressure"];
    }
    else{
        [formOneData setObject:txt_cpap_auto_high.text forKey:@"cpap_auto_high_pressure"];
    }
    
    if ([txt_std_ramp.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"bi_st_ramp_time"];
    }
    else{
        [formOneData setObject:txt_std_ramp.text forKey:@"bi_st_ramp_time"];
    }
    
    if ([txt_std_ipap.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"bi_st_ipap"];
    }
    else{
        [formOneData setObject:txt_std_ipap.text forKey:@"bi_st_ipap"];
    }
    
    if ([txt_std_epap.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"bi_st_epap"];
    }
    else{
        [formOneData setObject:txt_std_epap.text forKey:@"bi_st_epap"];
    }
    
    if ([txt_auto_ramp.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"bi_auto_ramp_time"];
    }
    else{
        [formOneData setObject:txt_auto_ramp.text forKey:@"bi_auto_ramp_time"];
    }
    
    if ([txt_auto_epap.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"bi_auto_epap_min"];
    }
    else{
        [formOneData setObject:txt_auto_epap.text forKey:@"bi_auto_epap_min"];
    }
    
    if ([txt_auto_ipap.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"bi_auto_epap_max"];
    }
    else{
        [formOneData setObject:txt_auto_ipap.text forKey:@"bi_auto_epap_max"];
    }
    
    if ([txt_auto_pres_sup_min.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"bi_auto_pressure_support_min"];
    }
    else{
        [formOneData setObject:txt_auto_pres_sup_min.text forKey:@"bi_auto_pressure_support_min"];
    }
    
    if ([txt_auto_pres_sup_max.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"bi_auto_pressure_support_max"];
    }
    else{
        [formOneData setObject:txt_auto_pres_sup_max.text forKey:@"bi_auto_pressure_support_max"];
    }
    
    if ([txt_auto_sv_ramp.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"bi_auto_sv_ramp_time"];
    }
    else{
        [formOneData setObject:txt_auto_sv_ramp.text forKey:@"bi_auto_sv_ramp_time"];
    }
    
    if ([txt_auto_sv_epap_min.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"bi_auto_sv_epap_min"];
    }
    else{
        [formOneData setObject:txt_auto_sv_epap_min.text forKey:@"bi_auto_sv_epap_min"];
    }
    
    if ([txt_auto_sv_epap_max.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"bi_auto_sv_ipap_max"];
    }
    else{
        [formOneData setObject:txt_auto_sv_epap_max.text forKey:@"bi_auto_sv_ipap_max"];
    }
    
    if ([txt_auto_sv_backup.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"bi_auto_sv_backup_rate"];
    }
    else{
        [formOneData setObject:txt_auto_sv_backup.text forKey:@"bi_auto_sv_backup_rate"];
    }
    
    if ([txt_auto_sv_pres_sup_min.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"bi_auto_sv_pressure_support_min"];
    }
    else{
        [formOneData setObject:txt_auto_sv_pres_sup_min.text forKey:@"bi_auto_sv_pressure_support_min"];
    }
    
    if ([txt_auto_sv_pres_sup_max.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"bi_auto_sv_pressure_support_max"];
    }
    else{
        [formOneData setObject:txt_auto_sv_pres_sup_max.text forKey:@"bi_auto_sv_pressure_support_max"];
    }
    
    if ([txt_auto_sv_max_pres_sup.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"bi_auto_sv_max_pressure_support"];
    }
    else{
        [formOneData setObject:txt_auto_sv_max_pres_sup.text forKey:@"bi_auto_sv_max_pressure_support"];
    }
    
    if ([txt_st_ramp.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"bi_auto_st_ramp_time"];
    }
    else{
        [formOneData setObject:txt_st_ramp.text forKey:@"bi_auto_st_ramp_time"];
    }
    
    if ([txt_st_ipap.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"bi_auto_st_ipap"];
    }
    else{
        [formOneData setObject:txt_st_ipap.text forKey:@"bi_auto_st_ipap"];
    }
    
    if ([txt_st_epap.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"bi_auto_st_epap"];
    }
    else{
        [formOneData setObject:txt_st_epap.text forKey:@"bi_auto_st_epap"];
    }
    
    if ([txt_st_backup.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"bi_auto_st_backup_rate"];
    }
    else{
        [formOneData setObject:txt_st_backup.text forKey:@"bi_auto_st_backup_rate"];
    }
    
    //*****************//**********//******
    if ([txt_ex_pick_machine.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"picked_machine"];
    }
    else{
        [formOneData setObject:txt_ex_pick_machine.text forKey:@"picked_machine"];
    }
    
    if ([txt_ex_machine.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"picked_machine_name"];
    }
    else{
        [formOneData setObject:txt_ex_machine.text forKey:@"picked_machine_name"];
    }
    
    if ([txt_ex_manufacturer.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"picked_manufacturer"];
    }
    else{
        [formOneData setObject:txt_ex_manufacturer.text forKey:@"picked_manufacturer"];
    }
    
    if ([txt_ex_machine_serial.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"picked_machine_serial"];
    }
    else{
        [formOneData setObject:txt_ex_machine_serial.text forKey:@"picked_machine_serial"];
    }
    
    if ([txt_ex_hum_serial.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"picked_hum_serial"];
    }
    else{
        [formOneData setObject:txt_ex_hum_serial.text forKey:@"picked_hum_serial"];
    }
    
    if ([txt_ex_modem_seral.text isEqualToString:@""]) {
        [formOneData setObject:@"-" forKey:@"picked_modem_serial"];
    }
    else{
        [formOneData setObject:txt_ex_hum_serial.text forKey:@"picked_modem_serial"];
    }
    

    
    /*
    if ([txt_rtMachine.text isEqualToString:@""] && [prev_machine_name.text isEqualToString:@""]) {
        [formOneData setObject:txt_ex_rt_machine.text forKey:@"machine"];
    }
    else if ([txt_ex_rt_machine.text isEqualToString:@""] && [prev_machine_name.text isEqualToString:@""]) {
        [formOneData setObject:txt_rtMachine.text forKey:@"machine"];
    }
    else{
        [formOneData setObject:prev_machine_name.text forKey:@"machine"];
    }
     
    if ([txt_CPAPserialNo.text isEqualToString:@""] && [prev_serial.text isEqualToString:@""]) {
        [formOneData setObject:txt_ex_rt_serial.text forKey:@"serial"];
    }
    else if ([txt_ex_rt_serial.text isEqualToString:@""] && [prev_serial.text isEqualToString:@""]) {
        [formOneData setObject:txt_CPAPserialNo.text forKey:@"serial"];
    }
    else{
        [formOneData setObject:prev_serial.text forKey:@"serial"];
    }
    */
    
    
    if (![txt_rtMachine.text isEqualToString:@""]) [formOneData setObject:txt_rtMachine.text forKey:@"machine"];
    if (![prev_machine_name.text isEqualToString:@""]) [formOneData setObject:prev_machine_name.text forKey:@"machine"];
    if (![txt_ex_rt_machine.text isEqualToString:@""]) [formOneData setObject:txt_ex_rt_machine.text forKey:@"machine"];

    if (![txt_CPAPserialNo.text isEqualToString:@""]) [formOneData setObject:txt_CPAPserialNo.text forKey:@"serial"];
    if (![prev_serial.text isEqualToString:@""]) [formOneData setObject:prev_machine_name.text forKey:@"serial"];
    if (![txt_ex_rt_serial.text isEqualToString:@""]) [formOneData setObject:txt_ex_rt_machine.text forKey:@"serial"];
    
    
    
    if ([txt_CPAPmanufacturer.text isEqualToString:@""]) {
        [formOneData setObject:txt_ex_rt_manufacturer.text forKey:@"manufacturer"];
    }
    else{
        [formOneData setObject:txt_CPAPmanufacturer.text forKey:@"manufacturer"];
    }
    
    
    
    if ([txt_model.text isEqualToString:@""]) {
        [formOneData setObject:txt_ex_rt_reference.text forKey:@"model"];
    }
    else{
        [formOneData setObject:txt_model.text forKey:@"model"];
    }
    
    
    
    [formOneData setObject:txt_modem.text forKey:@"modem"];
    [formOneData setObject:txt_modemSerialNo.text forKey:@"modem_serial"];
    [formOneData setObject:txt_humidifierModem.text forKey:@"hum_modem"];
    [formOneData setObject:txt_humidifierManufacturer.text forKey:@"hum_manufacturer"];
    [formOneData setObject:txt_humidifierSerialNo.text forKey:@"hum_serial"];
    [formOneData setObject:txt_mask.text forKey:@"mask"];
    [formOneData setObject:txt_maskName.text forKey:@"mask_name"];
    [formOneData setObject:txt_maskID.text forKey:@"mask_id"];
    
    [formOneData setObject:[self jsonString] forKey:@"json_item"];
    [formOneData setObject:[self jsonString1] forKey:@"json_discarded_item"];
    [formOneData setObject:[self jsonString2] forKey:@"json_adtnl_items"];

    NSLog(@"\n1.%@ \n\n2.%@ \n\n3.%@", [self jsonString], [self jsonString1], [self jsonString2]);
    
    [[NSUserDefaults standardUserDefaults] setObject:formOneData forKey:@"formOneData"];
    
    /*
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"StoryboardTwo" bundle:nil];
    CCXFormOne *formVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"CCXFormOne"];
    formVC.formOneData = formOneData;
    [self.navigationController pushViewController:formVC animated:YES];
    */
    
    SetUpTicketFormTwo *formTwoVC   = [self.storyboard instantiateViewControllerWithIdentifier:@"SUTFT"];
    formTwoVC.isNewTicket           = NewTicket;
    
    if (!NewTicket) {
        formTwoVC.dict_form             = self.dict;
        formTwoVC.isNotSubmitted        = YES;
    }
    formTwoVC.formOneData           = formOneData;
    formTwoVC.arr_rt_states         = self.arr_rt_states;
    [self.navigationController pushViewController:formTwoVC animated:NO];
    
}


-(NSString*)jsonString{
    NSMutableArray *saveArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *saveDict in arr_addedItems) {
        
        NSString *item_quantity = [saveDict valueForKey:@"quantity"];
        if ([saveDict valueForKey:@"quantity"] == nil) {
            item_quantity = @"0";
        }
        
        NSString *item_size = [saveDict valueForKey:@"item_size"];
        if ([saveDict valueForKey:@"item_size"] == nil) {
            item_size = @"NA";
        }
        
//        NSString *item_type = [saveDict valueForKey:@"item_type"];
//        if ([saveDict valueForKey:@"item_type"] == nil) {
//            item_size = @"NA";
//        }
//        
//        NSString *description = [saveDict valueForKey:@"description"]; // adtnl_items
//        if ([saveDict valueForKey:@"description"] == nil) {
//            item_size = @"NA";
//        }
        
        NSString *adtnl_items = [saveDict valueForKey:@"adtnl_items"]; // adtnl_items
        if ([saveDict valueForKey:@"adtnl_items"] == nil ||
            [[saveDict valueForKey:@"adtnl_items"] isEqualToString:@""]) {
            adtnl_items = @"NA";
        }
        
        NSString *item = [NSString stringWithFormat:@"{\"item_id\": \"%@\",\"item_type\": \"%@\",\"item_name\": \"%@\",\"item_quantity\": %@,\"item_size\":\"%@\",\"description\": \"%@\", \"adtnl_items\": \"%@\"}", [saveDict valueForKey:@"item_id"], @"NA", [saveDict valueForKey:@"item_name"], item_quantity, item_size, @"NA", adtnl_items];
        
        [saveArray addObject:item];
    }
    
    
    NSString *str_itemArray = [saveArray componentsJoinedByString:@","];
    json1     = [NSString stringWithFormat:@"{\"ticket_items\":[%@]}",str_itemArray];
    
    json1               = [json1 stringByReplacingOccurrencesOfString:@"&" withString:@"and"];
    json_supplies = json1;
    return json1;
    
}

-(NSString*)jsonString1{
    NSMutableArray *saveArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *saveDict in arr_addedItems1) {
        
        NSString *item_quantity = [saveDict valueForKey:@"item_quantity"];
        if ([saveDict valueForKey:@"item_quantity"] == nil) {
            item_quantity = @"0";
        }
        
        NSString *item_size = [saveDict valueForKey:@"item_size"];
        if ([saveDict valueForKey:@"item_size"] == nil) {
            item_size = @"NA";
        }
       
        
        NSString *adtnl_items = [saveDict valueForKey:@"adtnl_items"]; // adtnl_items
        if ([saveDict valueForKey:@"adtnl_items"] == nil ||
            [[saveDict valueForKey:@"adtnl_items"] isEqualToString:@""]) {
            adtnl_items = @"NA";
        }
        
        
        NSString *item = [NSString stringWithFormat:@"{\"item_id\": \"%@\",\"item_type\": \"%@\",\"item_name\": \"%@\",\"item_quantity\": %@,\"item_size\":\"%@\",\"description\": \"%@\", \"adtnl_items\": \"%@\"}", [saveDict valueForKey:@"item_id"], @"NA", [saveDict valueForKey:@"item_name"], item_quantity, item_size, @"NA", adtnl_items];
        
        [saveArray addObject:item];
    }
    
    
    NSString *str_itemArray = [saveArray componentsJoinedByString:@","];
    json2     = [NSString stringWithFormat:@"{\"ticket_items\":[%@]}",str_itemArray];
    
    json2               = [json2 stringByReplacingOccurrencesOfString:@"&" withString:@"and"];
    json_discardedItems = json2;
    return json2;
    
}

-(NSString*)jsonString2{
    NSMutableArray *saveArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *saveDict in arr_addedItems2) {
        
        NSString *item_quantity = [saveDict valueForKey:@"item_quantity"];
        if ([saveDict valueForKey:@"item_quantity"] == nil) {
            item_quantity = @"0";
        }
        
        NSString *item_size = [saveDict valueForKey:@"item_size"];
        if ([saveDict valueForKey:@"item_size"] == nil) {
            item_size = @"NA";
        }
        
        NSString *adtnl_items = [saveDict valueForKey:@"adtnl_items"]; // adtnl_items
        if ([saveDict valueForKey:@"adtnl_items"] == nil ||
            [[saveDict valueForKey:@"adtnl_items"] isEqualToString:@""]) {
            adtnl_items = @"NA";
        }
        
        NSString *item = [NSString stringWithFormat:@"{\"item_id\": \"%@\",\"item_type\": \"%@\",\"item_name\": \"%@\",\"item_quantity\": %@,\"item_size\":\"%@\",\"description\": \"%@\", \"adtnl_items\": \"%@\"}", [saveDict valueForKey:@"item_id"], @"NA", [saveDict valueForKey:@"item_name"], item_quantity, item_size, @"NA", adtnl_items];
        
        [saveArray addObject:item];
    }
    
    
    NSString *str_itemArray = [saveArray componentsJoinedByString:@","];
    json3     = [NSString stringWithFormat:@"{\"ticket_items\":[%@]}",str_itemArray];
    
    json3               = [json3 stringByReplacingOccurrencesOfString:@"&" withString:@"and"];
    json_additonalSupplies = json3;
    return json3;
    
}

#pragma mark - Search/Add Items

-(void)removeAddItemsView{
    [addItemsBackgroundView removeFromSuperview];
}

-(void)addItems:(UIButton*)sender{
    
    
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
    
    if (sender.tag == 996) {
        self.mySearchBar.placeholder = @"Search Masks";
        //self.arr_rt_mask_listing
        //[self.table_search reloadData];

    }
   
}

-(void)callWebServiceForAvailableItems:(NSString*)ID table:(UIButton*)sender{
    
    object_TV                   = [TicketFormView new];
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
                                  @"item_size":@"NA",
                                  @"item_quantity":@"NA",
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

//search button was tapped
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self handleSearch:searchBar.text tag:btnSearch.tag];
    
    
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
        if (btnSearch.tag == 996) {
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
        [self handleSearch:searchText tag:btnSearch.tag];
    }
}

- (void)handleSearch:(NSString *)searchKeyword tag:(int)tag{
    object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Search", 0);
    
    dispatch_async(myQueue, ^{
        
        NSMutableArray *array = [NSMutableArray new];
        if (tag == 996) {
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
                if (btnSearch.tag == 996) {
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
        return self.arr_dropdown.count;
    }
    else if (tableView == self.table_search) {
        if (btnSearch.tag == 996){
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
        
        if (selectListNumber == 996) {
            
            CGFloat lenght              = 0.0f;
            NSDictionary *cellDict      = [self.arr_dropdown objectAtIndex:indexPath.row];
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
        NSDictionary *cellDict              = [self.arr_dropdown objectAtIndex:indexPath.row];
        
//        if (selectListNumber == 771){
//            cell_table.textLabel.text       = cellDict[@"machine_name"];
//        }
        
        if (selectListNumber == 12){
            cell_table.textLabel.text       = cellDict[@"vendor_name"];
        }
        else if (selectListNumber == 13){
            cell_table.textLabel.text       = cellDict[@"vendor_name"];
        }
        else if (selectListNumber == 14){
            cell_table.textLabel.text       = cellDict[@"vendor_name"];
        }
        else if (selectListNumber == 772){
            cell_table.textLabel.text       = cellDict[@"item_name"];
        }
        else if (selectListNumber == 773){
            cell_table.textLabel.text       = cellDict[@"item_name"];
        }
        else if (selectListNumber == 991) {
            cell_table.textLabel.text       = [NSString stringWithFormat:@"%@ %@",cellDict[@"Pt_First"], cellDict[@"Pt_Last"]];
        }
        else if (selectListNumber == 992){
            cell_table.textLabel.text       = [self.arr_dropdown objectAtIndex:indexPath.row];
        }
        else if (selectListNumber == 993){
            cell_table.textLabel.text       = cellDict[@"item_name"];
        }
        else if (selectListNumber == 994){
            cell_table.textLabel.text       = cellDict[@"item_name"];
        }
        else if (selectListNumber == 995){
            cell_table.textLabel.text       = cellDict[@"item_name"];
        }
        else if (selectListNumber == 996){
            cell_table.textLabel.text       = cellDict[@"mask_name"];
        }
        else if (selectListNumber == 997){
            cell_table.textLabel.text       = [self.arr_dropdown objectAtIndex:indexPath.row];
        }
        else if (selectListNumber == 998){
            cell_table.textLabel.text       = cellDict[@"serial_number"];
        }
        else if (selectListNumber == 999){
            cell_table.textLabel.text       = cellDict[@"item_id"];
        }
        else if (selectListNumber == 888){
            cell_table.textLabel.text       = cellDict[@"serial_number"];
        }
        else if (selectListNumber == 889){
            cell_table.textLabel.text       = [self.arr_dropdown objectAtIndex:indexPath.row];
        }
        else if (selectListNumber == 881){
            cell_table.textLabel.text       = [self.arr_dropdown objectAtIndex:indexPath.row];
        }
        else if (selectListNumber == 883){
            cell_table.textLabel.text       = [self.arr_dropdown objectAtIndex:indexPath.row];
        }
        else if (selectListNumber == 882){
            cell_table.textLabel.text       = [self.arr_dropdown objectAtIndex:indexPath.row];
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
        
        if (btnSearch.tag == 996) {
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
    else if ([tableView isEqual:table_formTable1]){
        static NSString *str                = @"TicketForm1";
        HistoryCell *cell                   = [tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
        [cell customizeLabelInCell];
        [cell setBackgroundColor:[UIColor clearColor]];
        NSDictionary *item                  = [arr_addedItems1 objectAtIndex:indexPath.row];
        
        cell.lbf1_itemID.text            = item[@"item_id"];
        cell.lbf1_itemName.text          = item[@"item_name"];
        cell.lbf1_size.text              = item[@"item_size"];
        
        cell.btnf1_size.titleLabel.text  = item[@"item_size"];
        cell.txtf1_quantity.text         = item[@"item_quantity"];
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
    else if ([tableView isEqual:table_formTable2]){
        static NSString *str                = @"TicketForm2";
        HistoryCell *cell                   = [tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
        [cell customizeLabelInCell];
        [cell setBackgroundColor:[UIColor clearColor]];
        NSDictionary *item                  = [arr_addedItems2 objectAtIndex:indexPath.row];
        
        cell.lbf2_itemID.text            = item[@"item_id"];
        cell.lbf2_itemName.text          = item[@"item_name"];
        cell.lbf2_size.text              = item[@"item_size"];
        
        cell.btnf2_size.titleLabel.text  = item[@"item_size"];
        cell.lbf2_size.text              = item[@"item_size"];
        cell.txtf2_quantity.text         = item[@"item_quantity"];
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
    else{
        static NSString *str                = @"TicketForm";
        HistoryCell *cell                   = [tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
        [cell customizeLabelInCell];
        [cell setBackgroundColor:[UIColor clearColor]];
        NSDictionary *item                  = [arr_addedItems objectAtIndex:indexPath.row];
        
        cell.lbf_itemID.text            = item[@"item_id"];
        cell.lbf_itemName.text          = item[@"item_name"];
        cell.lbf_size.text              = item[@"item_size"];
        
        cell.btnf_size.titleLabel.text  = item[@"item_size"];
        cell.txtf_quantity.text         = item[@"quantity"];
        cell.txtf_quantity.tag          = indexPath.row;
        
        cell.txtf_additionalItems.text  = item[@"description"];
        //cell.txtf_additionalItems.tag   = indexPath.row;
        
        cell.btnf_size.tag  = indexPath.row;
        [cell.btnf_size addTarget:self action:@selector(didSelectSizeAtIndexPath:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.btnf_Psize.tag = indexPath.row;
        cell.btnf_Ssize.tag = indexPath.row;
        cell.btnf_SMsize.tag = indexPath.row;
        cell.btnf_Msize.tag = indexPath.row;
        cell.btnf_Wsize.tag = indexPath.row;
        cell.btnf_Lsize.tag = indexPath.row;
        cell.btnf_XLsize.tag = indexPath.row;
        
        [cell.btnf_Psize addTarget:self action:@selector(selectedSize:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnf_Ssize addTarget:self action:@selector(selectedSize:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnf_SMsize addTarget:self action:@selector(selectedSize:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnf_Msize addTarget:self action:@selector(selectedSize:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnf_Wsize addTarget:self action:@selector(selectedSize:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnf_Lsize addTarget:self action:@selector(selectedSize:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnf_XLsize addTarget:self action:@selector(selectedSize:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tv == table_formTable) {
        NSDictionary *item  = [arr_addedItems objectAtIndex:indexPath.row];
        [arr_addedItems removeObject:item];
        
        /*
        for (NSDictionary *dict1 in removedSupplyObjects) {
            if ([item[@"item_id"] isEqualToString:dict1[@"item_id"]]) {
                [self.arr_temp_item_listing addObject:dict1];
            }
        }
         */
        
        [table_formTable reloadData];
    }
    
    if (tv == table_formTable1) {
        NSDictionary *item  = [arr_addedItems1 objectAtIndex:indexPath.row];
        [arr_addedItems1 removeObject:item];
        /*
        for (NSDictionary *dict1 in removedSupplyObjects1) {
            if ([item[@"item_id"] isEqualToString:dict1[@"item_id"]]) {
                [self.arr_temp_item_listing1 addObject:dict1];
            }
        }
         */
        [table_formTable1 reloadData];
    }
    
    if (tv == table_formTable2) {
        NSDictionary *item  = [arr_addedItems2 objectAtIndex:indexPath.row];
        [arr_addedItems2 removeObject:item];
        
        /*
        for (NSDictionary *dict1 in removedSupplyObjects2) {
            if ([item[@"item_id"] isEqualToString:dict1[@"item_id"]]) {
                [self.arr_temp_item_listing2 addObject:dict1];
            }
        }
         */
        [table_formTable2 reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.table_search) {
        if (btnSearch.tag == 996) {
            NSDictionary *cellDict              = [self.arr_rt_mask_listing objectAtIndex:indexPath.row];

            txt_mask.text               = cellDict[@"mask_name"];
            if ([cellDict[@"mask_name"] isEqualToString:@"NA"]) {
                txt_maskName.text       = @"NA";
            }
            else{
                txt_maskName.text       = @"";
            }
            txt_maskID.text             = cellDict[@"mask_id"];
            NSString *maskSize          = cellDict[@"isFitPack"];
            
            lbl_maskID.textColor = [UIColor blackColor];
            lbl_maskSize.textColor = [UIColor blackColor];
            
            btn_mask_size.enabled = YES;
            
            isFitPack                   = NO;
            
            if ([maskSize isEqualToString:@"1"]) {
                isFitPack = YES;
            }
            
            if (isFitPack) {
                lbl_maskSize.text = @"Size Preference :";
            }
            else{
                lbl_maskSize.text = @"Mask Size :";
            }
            [addItemsBackgroundView removeFromSuperview];

        }
        if (btnSearch.tag == 120) {
            NSMutableDictionary *item      = [self.arr_rt_item_listing objectAtIndex:indexPath.row];
            
            /*
            if (arr_addedItems.count == 0) {
                [arr_addedItems addObject:item];
            }
            else{
                for (NSDictionary *kkk in arr_addedItems) {
                    if ([item[@"item_id"] isEqualToString:kkk[@"item_id"]]) {
                        [[[UIAlertView alloc] initWithTitle:@"Message!" message:@"Item already exists!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                    }
                    else{
                        [[arr_addedItems mutableCopy] addObject:item];
                    }
                }
            }
            */
            
            
            if (![arr_addedItems containsObject:item]) {
                [arr_addedItems addObject:item];
                
                NSArray *temp  = [[arr_addedItems reverseObjectEnumerator] allObjects];
                arr_addedItems = [temp mutableCopy];
            }
            
            //[self.arr_temp_item_listing removeObject:item];
           // [removedSupplyObjects addObject:item];
        
            
            table_formTable.hidden  = NO;
            suppliesHeader.hidden   = NO;
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
            
            //[self.arr_temp_item_listing1 removeObject:item];
            //[removedSupplyObjects1 addObject:item];

            table_formTable1.hidden  = NO;
            suppliesHeader.hidden   = NO;
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
            
            //[self.arr_temp_item_listing2 removeObject:item];
            //[removedSupplyObjects2 addObject:item];

            table_formTable2.hidden  = NO;
            suppliesHeader.hidden   = NO;
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
        
        NSDictionary *cellDict          = [self.arr_dropdown objectAtIndex:indexPath.row];
        
        if (selectListNumber == 991) {
            [self updatePatientData:cellDict];
            
            
        }
        else if (selectListNumber == 992){
            txt_state.text              = [self.arr_dropdown objectAtIndex:indexPath.row];
//            txt_zip.layer.borderColor = BLUE_COLOR;
//            txt_zip.layer.borderWidth = 1.0;
//            
//            txt_state.layer.borderColor = CLEAR_COLOR;
//            txt_state.layer.borderWidth = 1.0;
        }
//        else if (selectListNumber == 771){
//            txt_ex_pick_machine.text = cellDict[@"machine_name"];
//            
//        }
        else if (selectListNumber == 772){
            
            [arr_addedItems removeAllObjects];
            [table_formTable reloadData];
            
            txt_ex_rt_machine.text          = cellDict[@"item_name"];
            txt_ex_rt_reference.text        = cellDict[@"item_id"];
            txt_ex_rt_serial.text           = @""; //farisolusa
            
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
            
            //[self getSerialNumbersOfExchangeMachine:cellDict[@"item_id"] dictInfo:cellDict tag:selectListNumber];
            [self getSerialNumbersOfMachine:cellDict[@"item_id"] dictInfo:cellDict isNewMachine:NO isExchangeMachine:YES];
        }
        else if (selectListNumber == 773){
            txt_ex_machine.text          = cellDict[@"item_name"];
            

        }
        else if (selectListNumber == 993){
            
            [arr_addedItems removeAllObjects];
            txt_CPAPserialNo.text       = @"";
            txt_humidifierSerialNo.text = @"";
            txt_modemSerialNo.text      = @"";
            
            txt_rtMachine.text          = cellDict[@"item_name"];
            cpap_item_id                = cellDict[@"item_id"];
            txt_model.text              = cellDict[@"item_id"]; // Reference
            
            /*
            NSString *machine_type = [(RadioButton*)self.cpap_new_old_dmeRadio[0] selectedButton].titleLabel.text;
            
            if ([machine_type isEqualToString:@"New"]) {
               */
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
                
                [self getSerialNumbersOfMachine:cellDict[@"item_id"] dictInfo:cellDict isNewMachine:YES isExchangeMachine:NO];
            /*}
            if ([machine_type isEqualToString:@"Used"]) {
                [self getSerialNumbersOfMachine:cellDict[@"item_id"] dictInfo:cellDict isNewMachine:NO isExchangeMachine:NO];
            }
            */

            
           /*
            
            NSString *humidifier = cellDict[@"humidifier"];
            NSString *manufacturer = cellDict[@"manufacturer"];
            NSString *modem = cellDict[@"modem"];

            
            if (![humidifier isEqualToString:@"0"]) {
                txt_humidifierModem.text = humidifier;
                txt_humidifierManufacturer.text = manufacturer;
            }
            else{
                txt_humidifierModem.text = @"";
                txt_humidifierManufacturer.text = @"";
                txt_humidifierSerialNo.text = @"";
            }
            
            NSString *machineName = cellDict[@"machine_name"];
            if ([machineName localizedCaseInsensitiveContainsString:@"ICON"]) {
                txt_humidifierModem.text = @"Integrated";
            }
           
            if (![modem isEqualToString:@"0"]) {
                txt_modem.text = modem;
            }
            else{
                txt_modem.text = @"";
                txt_modemSerialNo.text = @"";
            }
            
            if ([machineName localizedCaseInsensitiveContainsString:@"S10"]) {
                txt_modem.text = @"Integrated";
                
                txt_humidifierModem.text = @"NA";
                txt_humidifierManufacturer.text = @"NA";
                txt_humidifierSerialNo.text = @"NA";
            }
            
            
            
            txt_rtMachine.text          = cellDict[@"machine_name"];
            txt_CPAPmanufacturer.text   = cellDict[@"manufacturer"];
            cpap_item_id                = cellDict[@"machine_id"];
            txt_model.text              = cellDict[@"machine_id"]; // Reference
            
            is_Auto_ResMed              = NO;
            is_Auto_SV_Respironics      = NO;
            is_ST_Respironics           = NO;
            
            NSString *auto_status       = cellDict[@"manufacturer"];
            NSString *auto_sv_status    = cellDict[@"manufacturer"];
            NSString *auto_st_status    = cellDict[@"manufacturer"];
            
            if ([auto_status isEqualToString:@"ResMed"]) {
                is_Auto_ResMed          = YES;
            }
            if ([auto_sv_status isEqualToString:@"Respironics"]) {
                is_Auto_SV_Respironics  = YES;
            }
            if ([auto_st_status isEqualToString:@"Respironics"]) {
                is_ST_Respironics       = YES;
            }
            
            //[self checkBordersOfMachineData];
            //[self uncheckMachineData];
            
            */
        }
        else if (selectListNumber == 994){
            txt_modem.text              = cellDict[@"item_name"];
            modem_item_id               = cellDict[@"item_id"];
//            lbl_modemSerialNo.textColor = [UIColor blackColor];
            
//            txt_modem.layer.borderColor = CLEAR_COLOR;
//            txt_modem.layer.borderWidth = 1.0;
//            
//            txt_notes.layer.borderColor = CLEAR_COLOR;
//            txt_notes.layer.borderWidth = 1.0;
//            
//            txt_mask.layer.borderColor = BLUE_COLOR;
//            txt_mask.layer.borderWidth = 1.0;
            if ([cellDict[@"item_name"] isEqualToString:@"NA"]) {
                txt_modemSerialNo.text = @"NA";
            }
            else{
                [self getSerialNumbersOfModem:modem_item_id tag:selectListNumber];
            }
        }
        else if (selectListNumber == 995){
            txt_humidifierModem.text        = cellDict[@"item_name"];
            txt_humidifierManufacturer.text = cellDict[@"vendor_name"];
            hum_item_id                     = cellDict[@"item_id"];
            
//            lbl_humidifierManufacturer.textColor = [UIColor blackColor];
//            lbl_humidifierSerialNo.textColor = [UIColor blackColor];
            
//            txt_humidifierModem.layer.borderColor = CLEAR_COLOR;
//            txt_humidifierModem.layer.borderWidth = 1.0;
            
//            txt_notes.userInteractionEnabled = YES;
            //[txt_notes becomeFirstResponder];
//            txt_notes.layer.borderColor = BLUE_COLOR;
//            txt_notes.layer.borderWidth = 1.0;
            
            if ([cellDict[@"item_name"] isEqualToString:@"NA"]) {
                txt_humidifierSerialNo.text = @"NA";
            }
            else{
                [self getSerialNumbersOfHumModem:hum_item_id tag:selectListNumber];
            }
        }
        else if (selectListNumber == 996){
            txt_mask.text               = cellDict[@"mask_name"];
            if ([cellDict[@"mask_name"] isEqualToString:@"NA"]) {
                txt_maskName.text       = @"NA";
            }
            else{
                txt_maskName.text       = @"";
            }
            txt_maskID.text             = cellDict[@"mask_id"];
            NSString *maskSize          = cellDict[@"isFitPack"];
       
            lbl_maskID.textColor = [UIColor blackColor];
            lbl_maskSize.textColor = [UIColor blackColor];
            
            btn_mask_size.enabled = YES;
            
            isFitPack                   = NO;
            
            if ([maskSize isEqualToString:@"1"]) {
                isFitPack = YES;
            }
            
            if (isFitPack) {
                lbl_maskSize.text = @"Size Preference :";
            }
            else{
                lbl_maskSize.text = @"Mask Size :";
            }
            
        }
        else if (selectListNumber == 12){
            txt_ex_manufacturer.text     = cellDict[@"vendor_name"];
            txt_ex_machine.text          = @"";
            [self getOldMachinesListing:cellDict[@"vendor_id"]];

        }
        else if (selectListNumber == 13){
            txt_ex_rt_manufacturer.text  = cellDict[@"vendor_name"];
            txt_ex_rt_machine.text          = @"";
            txt_ex_rt_reference.text        = @"";
            txt_ex_rt_serial.text           = @"";
            
           // [self getOldMachinesListing:cellDict[@"vendor_id"]];
            [self getNewMachinesListing:cellDict isExchangeMachine:YES];

        }
        else if (selectListNumber == 14){
            txt_CPAPmanufacturer.text = cellDict[@"vendor_name"];
            txt_rtMachine.text = @"";
            txt_CPAPserialNo.text = @"";
            txt_model.text = @"";
            txt_humidifierModem.text = @"";
            txt_humidifierManufacturer.text = @"";
            txt_humidifierSerialNo.text = @"";
            
            txt_modem.text = @"";
            txt_modemSerialNo.text = @"";
            txt_mask.text = @"";
            txt_maskType.text = @"";
            txt_maskID.text = @"";
            modem_item_id = @"";
            hum_item_id = @"";
            
            /*
            NSString *machine_type = [(RadioButton*)self.cpap_new_old_dmeRadio[0] selectedButton].titleLabel.text;
            
            if ([machine_type isEqualToString:@"New"]) {
                [self getNewMachinesListing:cellDict isExchangeMachine:NO];
            }
            if ([machine_type isEqualToString:@"Used"]) {
                [self getOldMachinesListing:cellDict[@"vendor_id"]];
            }
            */
            
            [self getNewMachinesListing:cellDict isExchangeMachine:NO];

        }
        else if (selectListNumber == 997){
            
//            txt_maskName.layer.borderColor = CLEAR_COLOR;
//            txt_maskName.layer.borderWidth = 1.0;
            
            txt_maskName.text = [self.arr_dropdown objectAtIndex:indexPath.row];
        }
        else if (selectListNumber == 998){
            txt_modemSerialNo.text = cellDict[@"serial_number"];
        }
        else if (selectListNumber == 999){
            txt_model.text = cellDict[@"machine_id"];
        }
        else if (selectListNumber == 888){
            txt_humidifierSerialNo.text = cellDict[@"serial_number"];
        }
        else if (selectListNumber == 881) {
            txt_ex_rt_serial.text = [self.arr_rt_serial_numbers objectAtIndex:indexPath.row];
        }
        else if (selectListNumber == 882) {
            txt_humidifierSerialNo.text = [self.arr_hum_modem_dropdown objectAtIndex:indexPath.row];
        }
        else if (selectListNumber == 883) {
            txt_modemSerialNo.text = [self.arr_modem_dropdown objectAtIndex:indexPath.row];
        }
        else if (selectListNumber == 889){
            
            txt_CPAPserialNo.text = [self.arr_rt_serial_numbers objectAtIndex:indexPath.row];
            
            /*
            common_serialNum = [self.arr_rt_serial_numbers objectAtIndex:indexPath.row];
            txt_CPAPserialNo.text = common_serialNum;

            if (![common_serialNum isEqual:[NSNull null]]) {
                
                
                if (tag1 == 772) {
                    txt_ex_rt_serial.text = common_serialNum;
                }
                else{
                
                    
                    
                    
                    NSString *humidifier = self.temp_cellDict[@"humidifier"];
                    if (![humidifier isEqualToString:@"0"]){
                        
                        NSString *machine_type = [(RadioButton*)self.cpap_new_old_dmeRadio[0] selectedButton].titleLabel.text;
                        if ([machine_type isEqualToString:@"Used"]) {
                            txt_humidifierModem.text = common_serialNum;
                            txt_modem.text = common_serialNum;
                        }
                        
                        txt_humidifierSerialNo.text = [common_serialNum substringFromIndex:[common_serialNum length] - 3];
                        
                        if (![self.temp_cellDict[@"modem"] isEqualToString:@"0"]) {
                            txt_modemSerialNo.text = [common_serialNum substringFromIndex:[common_serialNum length] - 3];
                        }
                    }
                    
                    NSString *machineName = self.temp_cellDict[@"machine_name"];
                    if ([machineName localizedCaseInsensitiveContainsString:@"ICON"]) {
                        NSString *machine_type = [(RadioButton*)self.cpap_new_old_dmeRadio[0] selectedButton].titleLabel.text;
                        if ([machine_type isEqualToString:@"Used"]) {
                            txt_humidifierModem.text = common_serialNum;
                            txt_modem.text = common_serialNum;
                        }
                        
                        txt_humidifierSerialNo.text = common_serialNum;
                        
                        if (![self.temp_cellDict[@"modem"] isEqualToString:@"0"]) {
                            txt_modemSerialNo.text = common_serialNum;
                        }
                        
                        txt_humidifierManufacturer.text = @"NA";
                    }
                    
                    if ([machineName localizedCaseInsensitiveContainsString:@"S10"]) {
                        NSString *machine_type = [(RadioButton*)self.cpap_new_old_dmeRadio[0] selectedButton].titleLabel.text;
                        if ([machine_type isEqualToString:@"Used"]) {
                            txt_modem.text = common_serialNum;
                        }
                        if (![self.temp_cellDict[@"modem"] isEqualToString:@"0"]) {
                            txt_modemSerialNo.text = [common_serialNum substringFromIndex:[common_serialNum length] - 3];
                        }
                    }
                    
                    table_formTable.hidden  = NO;
                    suppliesHeader.hidden   = NO;
                    
                    [self getSupplyListingOfMachine:machineName];
                    
                }
                // [self checkBordersOfMachineData];
            }
            else{
                
                if (tag1 == 772) {
                    txt_ex_rt_serial.text = @"NA";
                }
                else{
                    txt_CPAPserialNo.text = @"NA";
                    common_serialNum = @"NA";
                }
                //[self checkBordersOfMachineData];
            }
            */
        }
        else{
            
        }
        
        [popoverCon dismissPopoverAnimated:YES];
    }
}

#pragma mark -
#pragma mark -


-(void)getOldMachinesListing:(NSString*)vendor_id{
    
    self.arr_rt_old_machines_listing = [NSMutableArray new];
    
    for (NSDictionary *machine in self.arr_rt_machines_listing) {
        NSString *vendor = machine[@"vendor_id"];
        
        if ([vendor isEqualToString:vendor_id]) {
            [self.arr_rt_old_machines_listing addObject:machine];
        }
    }
    
    [dropdownsTableviewCon.tableView reloadData];

}

-(void)getNewMachinesListing:(NSDictionary*)dictInfo isExchangeMachine:(BOOL)isExchangeMachine{
    object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("ModemSerial", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dicti =[object_TV getArrayOfMachines:RT_ID vendorId:dictInfo[@"vendor_id"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM = [[TicketFormModel alloc] initWithDictionary:dicti];
                self.arr_rt_new_machines_listing = object_TM.arr_rt_new_machines_listing;
                
                //self.arr_rt_H_modem = object_TM.arr_rt_humidifier_listing;
                //self.arr_rt_modem   = object_TM.arr_rt_modem_listing;
                
                NSDictionary *naDict = @{@"cpap_type": @"NA",
                                         @"item_id": @"NA",
                                         @"item_name": @"NA",
                                         @"type": @"NA",
                                         @"vendor_id": @"NA",
                                         @"vendor_name": @"NA"};
                
                NSMutableArray *temp_hum = [@[naDict]mutableCopy];
                [temp_hum addObjectsFromArray:object_TM.arr_rt_humidifier_listing];
                self.arr_rt_H_modem = temp_hum;
                
                NSMutableArray *temp_modem = [@[naDict]mutableCopy];
                [temp_modem addObjectsFromArray:object_TM.arr_rt_modem_listing];
                self.arr_rt_modem = temp_modem;
                
               // if (!isExchangeMachine) {
                    [self.arr_rt_new_machines_cpap          removeAllObjects];
                    [self.arr_rt_new_machines_cpap_auto     removeAllObjects];
                    [self.arr_rt_new_machines_stand         removeAllObjects];
                    [self.arr_rt_new_machines_auto          removeAllObjects];
                    [self.arr_rt_new_machines_auto_sv       removeAllObjects];
                    [self.arr_rt_new_machines_st            removeAllObjects];
                    
                    for (NSDictionary *machine in self.arr_rt_new_machines_listing) {
                        NSString *cpap = machine[@"cpap_type"];
                        
                        if ([cpap isEqualToString:@"CPAP"]) {
                            [self.arr_rt_new_machines_cpap addObject:machine];
                        }
                        if ([cpap isEqualToString:@"CPAP AUTO"]) {
                            [self.arr_rt_new_machines_cpap_auto addObject:machine];
                        }
                        if ([cpap isEqualToString:@"Bi-Level Standard"]) {
                            [self.arr_rt_new_machines_stand addObject:machine];
                        }
                        if ([cpap isEqualToString:@"Bi-Level Auto"]) {
                            [self.arr_rt_new_machines_auto addObject:machine];
                        }
                        if ([cpap isEqualToString:@"Bi-Level Auto SV"]) {
                            [self.arr_rt_new_machines_auto_sv addObject:machine];
                        }
                        if ([cpap isEqualToString:@"Bi-Level ST"]) {
                            [self.arr_rt_new_machines_st addObject:machine];
                        }
                        
                    }
              //  }
                
                
               // NSLog(@"self.arr_rt_new_machines_cpap: \n %@", self.arr_rt_new_machines_cpap);
                
                [dropdownsTableviewCon.tableView reloadData];
            }
        });
    });
}

-(void)getSupplyListingOfMachine:(NSString*)machineName{
    object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("ModemSerial", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dicti =[object_TV getArrayOfSupplyItems:machineName];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM = [[TicketFormModel alloc] initWithDictionary:dicti];
                arr_addedItems = [object_TM.arr_rt_supply_listing mutableCopy];
                [table_formTable reloadData];
            }
        });
    });
}

-(void)getSerialNumbersOfMachine:(NSString*)machineID dictInfo:(NSDictionary*)dictInfo isNewMachine:(BOOL)isNewMachine isExchangeMachine:(BOOL)isExchangeMachine{
    object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("MachineSerial", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dicti =[object_TV getArraysOfSerialNumbers:RT_ID itemID:machineID];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM      = [[TicketFormModel alloc] initWithDictionary:dicti];
                self.arr_rt_serial_numbers      = object_TM.arr_rt_serial_numbers;
          
                if (isExchangeMachine) {
                    txt_ex_rt_serial.text = object_TM.arr_rt_serial_numbers[0];
                }
                else{
                    txt_CPAPserialNo.text = object_TM.arr_rt_serial_numbers[0];
                }
                
                if (isNewMachine || isExchangeMachine) {
                    NSString *humidifier_id         = dictInfo[@"humidifier"];
                    txt_humidifierModem.text        = @"";
                    txt_humidifierManufacturer.text = @"";
                    
                    for (NSDictionary *him_dict in self.arr_rt_H_modem) {
                        
                        if ([him_dict[@"item_id"] isEqualToString:humidifier_id]) {
                            
                            txt_humidifierModem.text        = him_dict[@"item_name"];
                            txt_humidifierManufacturer.text = him_dict[@"vendor_name"];
                            hum_item_id                     = him_dict[@"item_id"];
                        }
                    }
                    
                    NSString *modem_id              = dictInfo[@"modem"];
                    txt_modem.text                  = @"";
                    for (NSDictionary *modem_dict in self.arr_rt_modem) {
                        
                        if ([modem_dict[@"item_id"] isEqualToString:modem_id]) {
                            
                            txt_modem.text          = modem_dict[@"item_name"];
                            modem_item_id           = modem_dict[@"item_id"];
                        }
                    }
                    
                    txt_humidifierSerialNo.text = @"";
                    txt_modemSerialNo.text      = @"";
                    
                    
                    
                    [self getSerialOfNewHumidifier:humidifier_id modemID:modem_id machine_name:dictInfo[@"item_name"]];
                }
                
                
                
                /*
                if (![object_TM.serial_number isEqual:[NSNull null]]) {
                    
                    
                    if (tag == 772) {
                        txt_ex_rt_serial.text = object_TM.serial_number;
                    }
                    else{
                        txt_CPAPserialNo.text = object_TM.serial_number;
                        common_serialNum = object_TM.serial_number;
                        
                        NSString *humidifier = dictInfo[@"humidifier"];
                        if (![humidifier isEqualToString:@"0"]){
                            
                            NSString *machine_type = [(RadioButton*)self.cpap_new_old_dmeRadio[0] selectedButton].titleLabel.text;
                            if ([machine_type isEqualToString:@"Used"]) {
                                txt_humidifierModem.text = common_serialNum;
                                txt_modem.text = common_serialNum;
                            }
                            
                            txt_humidifierSerialNo.text = [common_serialNum substringFromIndex:[common_serialNum length] - 3];
                            
                            if (![dictInfo[@"modem"] isEqualToString:@"0"]) {
                                txt_modemSerialNo.text = [common_serialNum substringFromIndex:[common_serialNum length] - 3];
                            }
                        }
                        
                        NSString *machineName = dictInfo[@"machine_name"];
                        if ([machineName localizedCaseInsensitiveContainsString:@"ICON"]) {
                            NSString *machine_type = [(RadioButton*)self.cpap_new_old_dmeRadio[0] selectedButton].titleLabel.text;
                            if ([machine_type isEqualToString:@"Used"]) {
                                txt_humidifierModem.text = common_serialNum;
                                txt_modem.text = common_serialNum;
                            }
                            
                            txt_humidifierSerialNo.text = common_serialNum;
                            
                            if (![dictInfo[@"modem"] isEqualToString:@"0"]) {
                                txt_modemSerialNo.text = common_serialNum;
                            }
                            
                            txt_humidifierManufacturer.text = @"NA";
                        }
                        
                        if ([machineName localizedCaseInsensitiveContainsString:@"S10"]) {
                            NSString *machine_type = [(RadioButton*)self.cpap_new_old_dmeRadio[0] selectedButton].titleLabel.text;
                            if ([machine_type isEqualToString:@"Used"]) {
                                txt_modem.text = common_serialNum;
                            }
                            if (![dictInfo[@"modem"] isEqualToString:@"0"]) {
                                txt_modemSerialNo.text = [common_serialNum substringFromIndex:[common_serialNum length] - 3];
                            }
                        }
                        
                        table_formTable.hidden  = NO;
                        suppliesHeader.hidden   = NO;
                        
                        [self getSupplyListingOfMachine:machineName];
                        
                    }
                    //[self checkBordersOfMachineData];
                    
                    
                }
                else{
                    
                    if (tag == 772) {
                        txt_ex_rt_serial.text = @"NA";
                    }
                    else{
                        txt_CPAPserialNo.text = @"NA";
                        common_serialNum = @"NA";
                    }
                    //[self checkBordersOfMachineData];
                }
                
                */
            }
        });
    });
    
    
}

-(void)getSerialNumbersOfExchangeMachine:(NSString*)machineID dictInfo:(NSDictionary*)dictInfo tag:(int)tag{
    tag1 = tag;
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
                self.arr_rt_serial_numbers = object_TM.arr_rt_serial_numbers;
                txt_ex_rt_serial.text = object_TM.arr_rt_serial_numbers[0];
                
               
                
//                if (!self.arr_rt_serial_numbers) {
//                    view_ex_dropdown_hide.hidden = NO;
//                    btn_ex_serial_number.enabled = NO;
//                }
//                else{
//                    view_ex_dropdown_hide.hidden = YES;
//                    btn_ex_serial_number.enabled = YES;
//                }
                
                
            }
        });
    });
    
}

-(void)getSerialNumbersOfModem:(NSString*)itemId tag:(int)tag{
    object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("ModemSerial", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dicti =[object_TV getArraysOfSerialNumbers:RT_ID itemID:itemId];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM = [[TicketFormModel alloc] initWithDictionary:dicti];
                self.arr_modem_dropdown = object_TM.arr_rt_serial_numbers;
                txt_modemSerialNo.text = object_TM.arr_rt_serial_numbers[0];

//                if (![object_TM.serial_number isEqual:[NSNull null]]) {
//                    txt_modemSerialNo.text = object_TM.serial_number;
//                }
//                else{
//                    txt_modemSerialNo.text = @"--";
//                }

            }
        });
    });
}


-(void)getSerialNumbersOfHumModem:(NSString*)itemId tag:(int)tag{
    object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("HumModemSerial", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dicti =[object_TV getArraysOfSerialNumbers:RT_ID itemID:itemId];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM = [[TicketFormModel alloc] initWithDictionary:dicti];
                self.arr_hum_modem_dropdown = object_TM.arr_rt_serial_numbers;
                txt_humidifierSerialNo.text = object_TM.arr_rt_serial_numbers[0];

//                if (![object_TM.serial_number isEqual:[NSNull null]]) {
//                    txt_humidifierSerialNo.text = object_TM.serial_number;
//                }
//                else{
//                    txt_humidifierSerialNo.text = @"--";
//                }
            }
        });
    });
}


-(void)getSerialOfNewHumidifier:(NSString*)humItemId modemID:(NSString*)modemItemId machine_name:(NSString*)machine_name{
    object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("ModemSerial", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dicti =[object_TV getArraysOfSerialNumbers:RT_ID itemID:humItemId];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM = [[TicketFormModel alloc] initWithDictionary:dicti];
                
                self.arr_hum_modem_dropdown = object_TM.arr_rt_serial_numbers;
                txt_humidifierSerialNo.text = object_TM.arr_rt_serial_numbers[0];
                
                [self getSerialOfNewModem:modemItemId machine_name:machine_name];
            }
        });
    });
}

-(void)getSerialOfNewModem:(NSString*)itemId machine_name:(NSString*)machine_name{
    object_TV = [TicketFormView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("ModemSerial", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dicti =[object_TV getArraysOfSerialNumbers:RT_ID itemID:itemId];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dicti)
            {
                TicketFormModel *object_TM = [[TicketFormModel alloc] initWithDictionary:dicti];
                self.arr_modem_dropdown = object_TM.arr_rt_serial_numbers;
                txt_modemSerialNo.text = object_TM.arr_rt_serial_numbers[0];
                
                //[self getSupplyListingOfMachine:machine_name];
            }
        });
    });
}



-(void)defaultColor{
    
    lbl_fName.textColor = [UIColor blackColor];
    lbl_lName.textColor = [UIColor blackColor];
    lbl_dob.textColor = [UIColor blackColor];
    lbl_streetAdd.textColor = [UIColor blackColor];
    lbl_city.textColor = [UIColor blackColor];
    lbl_zip.textColor = [UIColor blackColor];
    lbl_hPhone.textColor = [UIColor blackColor];
    lbl_cPhone.textColor = [UIColor blackColor];
    lbl_wPhone.textColor = [UIColor blackColor];
    lbl_email.textColor = [UIColor blackColor];
    lbl_state.textColor = [UIColor blackColor];
    
    
    lbl_rtMachine.textColor = [UIColor blackColor];
    lbl_rtManufacturer.textColor = [UIColor blackColor];
    lbl_rtReference.textColor = [UIColor blackColor];
    lbl_rtSerialNo.textColor = [UIColor blackColor];
    
    lbl_humidifierManufacturer.textColor = [UIColor blackColor];
    lbl_humidifierSerialNo.textColor = [UIColor blackColor];
    
    lbl_modemSerialNo.textColor = [UIColor blackColor];
    
    lbl_maskID.textColor = [UIColor blackColor];
    lbl_maskSize.textColor = [UIColor blackColor];
    
    
    txt_fName.layer.borderColor =  CLEAR_COLOR;
    txt_lName.layer.borderColor =  CLEAR_COLOR;
    txt_dob.layer.borderColor =  CLEAR_COLOR;
    txt_streetAdd.layer.borderColor =  CLEAR_COLOR;
    txt_city.layer.borderColor =  CLEAR_COLOR;
    txt_zip.layer.borderColor =  CLEAR_COLOR;
    txt_hPhone.layer.borderColor =  CLEAR_COLOR;
    txt_cPhone.layer.borderColor =  CLEAR_COLOR;
    txt_wPhone.layer.borderColor =  CLEAR_COLOR;
    txt_email.layer.borderColor =  CLEAR_COLOR;
    txt_CPAPmanufacturer.layer.borderColor =  CLEAR_COLOR;
    txt_model.layer.borderColor =  CLEAR_COLOR;
    txt_CPAPserialNo.layer.borderColor =  CLEAR_COLOR;
    txt_modemSerialNo.layer.borderColor =  CLEAR_COLOR;
    txt_humidifierManufacturer.layer.borderColor =  CLEAR_COLOR;
    txt_humidifierSerialNo.layer.borderColor =  CLEAR_COLOR;
    txt_maskType.layer.borderColor =  CLEAR_COLOR;
    txt_maskName.layer.borderColor =  CLEAR_COLOR;
    txt_maskID.layer.borderColor =  CLEAR_COLOR;
    txt_rtPatient.layer.borderColor =  CLEAR_COLOR;
    txt_state.layer.borderColor =  CLEAR_COLOR;
    txt_rtMachine.layer.borderColor =  CLEAR_COLOR;
    txt_modem.layer.borderColor =  CLEAR_COLOR;
    txt_humidifierModem.layer.borderColor =  CLEAR_COLOR;
    txt_mask.layer.borderColor =  CLEAR_COLOR;
    txt_notes.layer.borderColor =  CLEAR_COLOR;
    txt_cpap_cm.layer.borderColor =  CLEAR_COLOR;
    txt_cpap_ramp.layer.borderColor =  CLEAR_COLOR;
    txt_cpap_auto_ramp.layer.borderColor =  CLEAR_COLOR;
    txt_cpap_auto_low.layer.borderColor =  CLEAR_COLOR;
    txt_cpap_auto_high.layer.borderColor =  CLEAR_COLOR;
    txt_std_ramp.layer.borderColor =  CLEAR_COLOR;
    txt_std_ipap.layer.borderColor =  CLEAR_COLOR;
    txt_std_epap.layer.borderColor =  CLEAR_COLOR;
    txt_auto_ramp.layer.borderColor =  CLEAR_COLOR;
    txt_auto_epap.layer.borderColor =  CLEAR_COLOR;
    txt_auto_ipap.layer.borderColor =  CLEAR_COLOR;
    txt_auto_pres_sup_min.layer.borderColor =  CLEAR_COLOR;
    txt_auto_pres_sup_max.layer.borderColor =  CLEAR_COLOR;
    txt_auto_sv_ramp.layer.borderColor =  CLEAR_COLOR;
    txt_auto_sv_epap_min.layer.borderColor =  CLEAR_COLOR;
    txt_auto_sv_epap_max.layer.borderColor =  CLEAR_COLOR;
    txt_auto_sv_backup.layer.borderColor =  CLEAR_COLOR;
    txt_auto_sv_pres_sup_min.layer.borderColor =  CLEAR_COLOR;
    txt_auto_sv_pres_sup_max.layer.borderColor =  CLEAR_COLOR;
    txt_auto_sv_max_pres_sup.layer.borderColor =  CLEAR_COLOR;
    txt_st_ramp.layer.borderColor =  CLEAR_COLOR;
    txt_st_ipap.layer.borderColor =  CLEAR_COLOR;
    txt_st_epap.layer.borderColor =  CLEAR_COLOR;
    txt_st_backup.layer.borderColor =  CLEAR_COLOR;
    txt_ex_pick_machine.layer.borderColor =  CLEAR_COLOR;
    txt_ex_machine.layer.borderColor =  CLEAR_COLOR;
    txt_ex_manufacturer.layer.borderColor =  CLEAR_COLOR;
    txt_ex_machine_serial.layer.borderColor =  CLEAR_COLOR;
    txt_ex_hum_serial.layer.borderColor =  CLEAR_COLOR;
    txt_ex_modem_seral.layer.borderColor =  CLEAR_COLOR;
    txt_ex_rt_machine.layer.borderColor =  CLEAR_COLOR;
    txt_ex_rt_manufacturer.layer.borderColor =  CLEAR_COLOR;
    txt_ex_rt_serial.layer.borderColor =  CLEAR_COLOR;
    txt_ex_rt_reference.layer.borderColor =  CLEAR_COLOR;
    prev_machine_name.layer.borderColor =  CLEAR_COLOR;
    prev_serial.layer.borderColor =  CLEAR_COLOR;
    
    txt_fName.layer.borderWidth = 1.0;
    txt_lName.layer.borderWidth = 1.0;
    txt_dob.layer.borderWidth = 1.0;
    txt_streetAdd.layer.borderWidth = 1.0;
    txt_city.layer.borderWidth = 1.0;
    txt_zip.layer.borderWidth = 1.0;
    txt_hPhone.layer.borderWidth = 1.0;
    txt_cPhone.layer.borderWidth = 1.0;
    txt_wPhone.layer.borderWidth = 1.0;
    txt_email.layer.borderWidth = 1.0;
    txt_CPAPmanufacturer.layer.borderWidth = 1.0;
    txt_model.layer.borderWidth = 1.0;
    txt_CPAPserialNo.layer.borderWidth = 1.0;
    txt_modemSerialNo.layer.borderWidth = 1.0;
    txt_humidifierManufacturer.layer.borderWidth = 1.0;
    txt_humidifierSerialNo.layer.borderWidth = 1.0;
    txt_maskType.layer.borderWidth = 1.0;
    txt_maskName.layer.borderWidth = 1.0;
    txt_maskID.layer.borderWidth = 1.0;
    txt_rtPatient.layer.borderWidth = 1.0;
    txt_state.layer.borderWidth = 1.0;
    txt_rtMachine.layer.borderWidth = 1.0;
    txt_modem.layer.borderWidth = 1.0;
    txt_humidifierModem.layer.borderWidth = 1.0;
    txt_mask.layer.borderWidth = 1.0;
    txt_notes.layer.borderWidth = 1.0;
    txt_cpap_cm.layer.borderWidth = 1.0;
    txt_cpap_ramp.layer.borderWidth = 1.0;
    txt_cpap_auto_ramp.layer.borderWidth = 1.0;
    txt_cpap_auto_low.layer.borderWidth = 1.0;
    txt_cpap_auto_high.layer.borderWidth = 1.0;
    txt_std_ramp.layer.borderWidth = 1.0;
    txt_std_ipap.layer.borderWidth = 1.0;
    txt_std_epap.layer.borderWidth = 1.0;
    txt_auto_ramp.layer.borderWidth = 1.0;
    txt_auto_epap.layer.borderWidth = 1.0;
    txt_auto_ipap.layer.borderWidth = 1.0;
    txt_auto_pres_sup_min.layer.borderWidth = 1.0;
    txt_auto_pres_sup_max.layer.borderWidth = 1.0;
    txt_auto_sv_ramp.layer.borderWidth = 1.0;
    txt_auto_sv_epap_min.layer.borderWidth = 1.0;
    txt_auto_sv_epap_max.layer.borderWidth = 1.0;
    txt_auto_sv_backup.layer.borderWidth = 1.0;
    txt_auto_sv_pres_sup_min.layer.borderWidth = 1.0;
    txt_auto_sv_pres_sup_max.layer.borderWidth = 1.0;
    txt_auto_sv_max_pres_sup.layer.borderWidth = 1.0;
    txt_st_ramp.layer.borderWidth = 1.0;
    txt_st_ipap.layer.borderWidth = 1.0;
    txt_st_epap.layer.borderWidth = 1.0;
    txt_st_backup.layer.borderWidth = 1.0;
    txt_ex_pick_machine.layer.borderWidth = 1.0;
    txt_ex_machine.layer.borderWidth = 1.0;
    txt_ex_manufacturer.layer.borderWidth = 1.0;
    txt_ex_machine_serial.layer.borderWidth = 1.0;
    txt_ex_hum_serial.layer.borderWidth = 1.0;
    txt_ex_modem_seral.layer.borderWidth = 1.0;
    txt_ex_rt_machine.layer.borderWidth = 1.0;
    txt_ex_rt_manufacturer.layer.borderWidth = 1.0;
    txt_ex_rt_serial.layer.borderWidth = 1.0;
    txt_ex_rt_reference.layer.borderWidth = 1.0;
    prev_machine_name.layer.borderWidth = 1.0;
    prev_serial.layer.borderWidth = 1.0;


}

-(void)applyBorder:(NSDictionary*)dictionary{
    
    
    
    if ([dictionary[@"Pt_Email"] isEqualToString:@""]) {
        txt_email.layer.borderColor = BLUE_COLOR;
        txt_email.layer.borderWidth = 1.0;
        //[txt_email becomeFirstResponder];
        
        
    }
    else{
        txt_email.layer.borderColor = CLEAR_COLOR;
        txt_email.layer.borderWidth = 1.0;
    }
    
    if ([dictionary[@"Pt_Work"] isEqualToString:@""]) {
        txt_wPhone.layer.borderColor = BLUE_COLOR;
        txt_wPhone.layer.borderWidth = 1.0;
        //[txt_wPhone becomeFirstResponder];
        
        
    }
    else{
        txt_wPhone.layer.borderColor = CLEAR_COLOR;
        txt_wPhone.layer.borderWidth = 1.0;
    }
    
    if ([dictionary[@"Pt_Cell"] isEqualToString:@""]) {
        txt_cPhone.layer.borderColor = BLUE_COLOR;
        txt_cPhone.layer.borderWidth = 1.0;
        //[txt_cPhone becomeFirstResponder];
        
        
    }
    else{
        txt_cPhone.layer.borderColor = CLEAR_COLOR;
        txt_cPhone.layer.borderWidth = 1.0;
    }
    
    if ([dictionary[@"Pt_Home"] isEqualToString:@""]) {
        txt_hPhone.layer.borderColor = BLUE_COLOR;
        txt_hPhone.layer.borderWidth = 1.0;
       // [txt_hPhone becomeFirstResponder];
        
        
    }
    else{
        txt_hPhone.layer.borderColor = CLEAR_COLOR;
        txt_hPhone.layer.borderWidth = 1.0;
    }
    
    if ([dictionary[@"Pt_Zip"] isEqualToString:@""]) {
        txt_zip.layer.borderColor = BLUE_COLOR;
        txt_zip.layer.borderWidth = 1.0;
       // [txt_zip becomeFirstResponder];
        
        
    }
    else{
        txt_zip.layer.borderColor = CLEAR_COLOR;
        txt_zip.layer.borderWidth = 1.0;
    }
    
    if ([dictionary[@"Pt_State"] isEqualToString:@""]) {
        txt_state.layer.borderColor = BLUE_COLOR;
        txt_state.layer.borderWidth = 1.0;
        
    }
    else{
        txt_state.layer.borderColor = CLEAR_COLOR;
        txt_state.layer.borderWidth = 1.0;
    }
    
    if ([dictionary[@"Pt_City"] isEqualToString:@""]) {
        txt_city.layer.borderColor = BLUE_COLOR;
        txt_city.layer.borderWidth = 1.0;
        //[txt_city becomeFirstResponder];
        
        
    }
    else{
        txt_city.layer.borderColor = CLEAR_COLOR;
        txt_city.layer.borderWidth = 1.0;
    }
    
    if ([dictionary[@"pt_dob"] isEqualToString:@""]) {
        txt_dob.layer.borderColor = BLUE_COLOR;
        txt_dob.layer.borderWidth = 1.0;
        [txt_dob becomeFirstResponder];
        
        
    }
    else{
        txt_dob.layer.borderColor = CLEAR_COLOR;
        txt_dob.layer.borderWidth = 1.0;
    }
    
    if ([[NSString stringWithFormat:@"%@ %@", dictionary[@"Pt_Add1"], dictionary[@"Pt_Add2"]] isEqualToString:@""]) {
        txt_streetAdd.layer.borderColor = BLUE_COLOR;
        txt_streetAdd.layer.borderWidth = 1.0;
        [txt_streetAdd becomeFirstResponder];
        
        
    }
    else{
        txt_streetAdd.layer.borderColor = CLEAR_COLOR;
        txt_streetAdd.layer.borderWidth = 1.0;
    }
    
    if ([dictionary[@"Pt_Last"] isEqualToString:@""]) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        [txt_lName becomeFirstResponder];
        
        
    }
    else{
        txt_lName.layer.borderColor = CLEAR_COLOR;
        txt_lName.layer.borderWidth = 1.0;
    }
    
    if ([dictionary[@"Pt_First"] isEqualToString:@""]) {
        txt_fName.layer.borderColor = BLUE_COLOR;
        txt_fName.layer.borderWidth = 1.0;
        [txt_fName becomeFirstResponder];
        
        
    }
    else{
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }

}
-(void)updatePatientData:(NSDictionary*)dictionary{
    
    // Enables labels
    lbl_fName.textColor = [UIColor blackColor];
    lbl_lName.textColor = [UIColor blackColor];
    lbl_dob.textColor = [UIColor blackColor];
    lbl_streetAdd.textColor = [UIColor blackColor];
    lbl_city.textColor = [UIColor blackColor];
    lbl_zip.textColor = [UIColor blackColor];
    lbl_hPhone.textColor = [UIColor blackColor];
    lbl_cPhone.textColor = [UIColor blackColor];
    lbl_wPhone.textColor = [UIColor blackColor];
    lbl_email.textColor = [UIColor blackColor];
    lbl_state.textColor = [UIColor blackColor];
    //
    
    
    
    
    txt_rtPatient.text  = [NSString stringWithFormat:@"%@ %@",dictionary[@"Pt_First"], dictionary[@"Pt_Last"]];
    
    
    txt_fName.text      = dictionary[@"Pt_First"];
    txt_lName.text      = dictionary[@"Pt_Last"];
    txt_dob.text        = dictionary[@"pt_dob"];
    
    if ([dictionary[@"Pt_Sex"] isEqual:@"M"]) {
        [(RadioButton*) self.maleFemaleRadio[0] setSelected:YES];
    }
    if ([dictionary[@"Pt_Sex"] isEqual:@"F"]){
        [(RadioButton*) self.maleFemaleRadio[1] setSelected:YES];
    }
    
    if (dictionary[@"pt_spanish"]) {
        [self.btn_spanish setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    else{
        [self.btn_spanish setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
    
    txt_streetAdd.text  = [NSString stringWithFormat:@"%@ %@", dictionary[@"Pt_Add1"], dictionary[@"Pt_Add2"]];
    txt_city.text       = dictionary[@"Pt_City"];
    txt_state.text      = dictionary[@"Pt_State"];
    txt_zip.text        = dictionary[@"Pt_Zip"];
    txt_hPhone.text     = dictionary[@"Pt_Home"];
    txt_cPhone.text     = dictionary[@"Pt_Cell"];
    txt_wPhone.text     = dictionary[@"Pt_Work"];
    txt_email.text      = dictionary[@"Pt_Email"];
    
    pt_ID               = dictionary[@"Pt_ID"];
    
    //[self applyBorder:dictionary];
//    txt_rtPatient.layer.borderColor = CLEAR_COLOR;
//    txt_rtPatient.layer.borderWidth = 1.0;
}


-(void)selectedSize:(UIButton*)sender{
    isDropdownOpened            = NO;
    indexOfDropdownItem         = sender.tag;
    
    NSMutableDictionary *ddict  = [[NSMutableDictionary alloc] init];
    ddict                       = [NSMutableDictionary dictionaryWithDictionary:[arr_addedItems objectAtIndex:indexOfDropdownItem]];

    if ([sender.titleLabel.text isEqualToString:@"Petite"]) {
        [ddict setObject:@"P" forKey:@"item_size"];
    }
    if ([sender.titleLabel.text isEqualToString:@"Small"]){
        [ddict setObject:@"S" forKey:@"item_size"];
    }
    if([sender.titleLabel.text isEqualToString:@"S/M"]){
        [ddict setObject:@"SM" forKey:@"item_size"];
    }
    if([sender.titleLabel.text isEqualToString:@"Medium"]){
        [ddict setObject:@"M" forKey:@"item_size"];
    }
    if([sender.titleLabel.text isEqualToString:@"Wide"]){
        [ddict setObject:@"W" forKey:@"item_size"];
    }
    if([sender.titleLabel.text isEqualToString:@"Large"]){
        [ddict setObject:@"L" forKey:@"item_size"];
    }
    if([sender.titleLabel.text isEqualToString:@"X-Large"]){
        [ddict setObject:@"XL" forKey:@"item_size"];
    }
    
    [arr_addedItems replaceObjectAtIndex:indexOfDropdownItem withObject:ddict];

    
    [table_formTable beginUpdates];
    [table_formTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [table_formTable endUpdates];
}

-(void)selectedSize1:(UIButton*)sender{
    isDropdownOpened1            = NO;
    indexOfDropdownItem1         = sender.tag;
    
    NSMutableDictionary *ddict  = [[NSMutableDictionary alloc] init];
    ddict                       = [NSMutableDictionary dictionaryWithDictionary:[arr_addedItems1 objectAtIndex:indexOfDropdownItem1]];
    
    if ([sender.titleLabel.text isEqualToString:@"Small (S)"]) {
        [ddict setObject:@"S" forKey:@"item_size"];
    }
    if ([sender.titleLabel.text isEqualToString:@"Medium (M)"]){
        [ddict setObject:@"M" forKey:@"item_size"];
    }
    if([sender.titleLabel.text isEqualToString:@"Large (L)"]){
        [ddict setObject:@"L" forKey:@"item_size"];
    }
    [arr_addedItems1 replaceObjectAtIndex:indexOfDropdownItem1 withObject:ddict];
    
    
    [table_formTable1 beginUpdates];
    [table_formTable1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [table_formTable1 endUpdates];
}

-(void)selectedSize2:(UIButton*)sender{
    isDropdownOpened2            = NO;
    indexOfDropdownItem2         = sender.tag;
    
    NSMutableDictionary *ddict  = [[NSMutableDictionary alloc] init];
    ddict                       = [NSMutableDictionary dictionaryWithDictionary:[arr_addedItems2 objectAtIndex:indexOfDropdownItem2]];
    
    if ([sender.titleLabel.text isEqualToString:@"Small (S)"]) {
        [ddict setObject:@"S" forKey:@"item_size"];
    }
    if ([sender.titleLabel.text isEqualToString:@"Medium (M)"]){
        [ddict setObject:@"M" forKey:@"item_size"];
    }
    if([sender.titleLabel.text isEqualToString:@"Large (L)"]){
        [ddict setObject:@"L" forKey:@"item_size"];
    }
    [arr_addedItems2 replaceObjectAtIndex:indexOfDropdownItem2 withObject:ddict];
    
    
    [table_formTable2 beginUpdates];
    [table_formTable2 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [table_formTable2 endUpdates];
}


-(void)didSelectSizeAtIndexPath:(UIButton*)sender{
    
    
    if (isDropdownOpened) {
        isDropdownOpened = NO;
    }
    else{
        indexOfDropdownCell         = sender.tag;
        isDropdownOpened            = YES;
        
        CGPoint point               = CGPointMake(0,1150); //680
        [UIView animateWithDuration:0.5 animations:^{
            [d_scrollView setContentOffset:point animated:NO];
        }];
    }
    
    [table_formTable beginUpdates];
    [table_formTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [table_formTable endUpdates];
}

-(void)didSelectSizeAtIndexPath1:(UIButton*)sender{
    
    
    if (isDropdownOpened1) {
        isDropdownOpened1 = NO;
    }
    else{
        indexOfDropdownCell1         = sender.tag;
        isDropdownOpened1            = YES;
        
        CGPoint point               = CGPointMake(0,1700); //680
        [UIView animateWithDuration:0.5 animations:^{
            [d_scrollView setContentOffset:point animated:NO];
        }];
    }
    
    [table_formTable1 beginUpdates];
    [table_formTable1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [table_formTable1 endUpdates];
}

-(void)didSelectSizeAtIndexPath2:(UIButton*)sender{
    
    
    if (isDropdownOpened2) {
        isDropdownOpened2 = NO;
    }
    else{
        indexOfDropdownCell2         = sender.tag;
        isDropdownOpened2            = YES;
        
        CGPoint point               = CGPointMake(0,2000); //680
        [UIView animateWithDuration:0.5 animations:^{
            [d_scrollView setContentOffset:point animated:NO];
        }];
    }
    
    [table_formTable2 beginUpdates];
    [table_formTable2 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [table_formTable2 endUpdates];
}


-(IBAction)checkUncheckBtnSpanish:(UIButton*)sender{
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
    }
    else{
        [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
}

-(IBAction)checkUncheckBtnEmailMe:(UIButton*)sender{
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
        [btn_physicalEmailMe setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
        [btn_bothEmailMailMe setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
    else{
        [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
}

-(IBAction)checkUncheckBtnPhysicalMailMe:(UIButton*)sender{
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
        [btn_emailMe setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
        [btn_bothEmailMailMe setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
    else{
        [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
}

-(IBAction)checkUncheckBtnBothEmailMail:(UIButton*)sender{
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"chk_box.png"]]) {
        [sender setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateNormal];
        [btn_emailMe setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
        [btn_physicalEmailMe setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
    else{
        [sender setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
    }
}

-(IBAction)radioCpapAuto:(UIButton*)sender{
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"radio_btn.png"]]) {
        [sender setImage:[UIImage imageNamed:@"radio_btn_o.png"] forState:UIControlStateNormal];
    }
    else{
        [sender setImage:[UIImage imageNamed:@"radio_btn.png"] forState:UIControlStateNormal];
    }
}

-(IBAction)radioWireless:(UIButton*)sender{
    
}

#pragma mark - UITextView Delegate

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    
//    return textView.text.length + (text.length - range.length) <= 140; // limit char limit to 140
//}

- (void)textViewDidBeginEditing:(UITextView *)textView{
   
    CGPoint point;
    CGRect rect = [textView bounds];
    rect        = [textView convertRect:rect toView:d_scrollView];
    point       = rect.origin;
    point.x     = 0;
    point.y     -= 50;
    [UIView animateWithDuration:0.5 animations:^{
        [d_scrollView setContentOffset:point animated:NO];
    }];
    
//    txt_modem.layer.borderColor = BLUE_COLOR;
//    txt_modem.layer.borderWidth = 1.0;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    
    
}

#pragma mark - UITextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    
//    if (textField == txt_cpap_ramp) {
//        txt_humidifierModem.layer.borderColor = BLUE_COLOR;
//        txt_lName.layer.borderWidth = 1.0;
//    }
//    
//    if (textField == txt_cpap_auto_high) {
//        txt_humidifierModem.layer.borderColor = BLUE_COLOR;
//        txt_lName.layer.borderWidth = 1.0;
//    }
//    
//    if (textField == txt_std_epap) {
//        txt_humidifierModem.layer.borderColor = BLUE_COLOR;
//        txt_lName.layer.borderWidth = 1.0;
//    }
//    
//    if (textField == txt_auto_pres_sup_min || textField == txt_auto_pres_sup_max) {
//        txt_humidifierModem.layer.borderColor = BLUE_COLOR;
//        txt_lName.layer.borderWidth = 1.0;
//    }
//    
//    if (textField == txt_auto_sv_backup || textField == txt_auto_sv_max_pres_sup) {
//        txt_humidifierModem.layer.borderColor = BLUE_COLOR;
//        txt_lName.layer.borderWidth = 1.0;
//    }
//    
//    if (textField == txt_st_backup) {
//        txt_humidifierModem.layer.borderColor = BLUE_COLOR;
//        txt_lName.layer.borderWidth = 1.0;
//    }
    
    
    /*
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_lName) {
        txt_streetAdd.layer.borderColor = BLUE_COLOR;
        txt_streetAdd.layer.borderWidth = 1.0;
        
        txt_lName.layer.borderColor = CLEAR_COLOR;
        txt_lName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_streetAdd) {
        txt_dob.layer.borderColor = BLUE_COLOR;
        txt_dob.layer.borderWidth = 1.0;
        
        txt_streetAdd.layer.borderColor = CLEAR_COLOR;
        txt_streetAdd.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_dob) {
        txt_city.layer.borderColor = BLUE_COLOR;
        txt_city.layer.borderWidth = 1.0;
        
        txt_dob.layer.borderColor = CLEAR_COLOR;
        txt_dob.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_city) {
        txt_state.layer.borderColor = BLUE_COLOR;
        txt_state.layer.borderWidth = 1.0;
        
        txt_city.layer.borderColor = CLEAR_COLOR;
        txt_city.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_state) {
        txt_zip.layer.borderColor = BLUE_COLOR;
        txt_zip.layer.borderWidth = 1.0;
        
        txt_state.layer.borderColor = CLEAR_COLOR;
        txt_state.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_zip) {
        txt_hPhone.layer.borderColor = BLUE_COLOR;
        txt_hPhone.layer.borderWidth = 1.0;
        
        txt_zip.layer.borderColor = CLEAR_COLOR;
        txt_zip.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_hPhone) {
        txt_cPhone.layer.borderColor = BLUE_COLOR;
        txt_cPhone.layer.borderWidth = 1.0;
        
        txt_hPhone.layer.borderColor = CLEAR_COLOR;
        txt_hPhone.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_cPhone) {
        txt_wPhone.layer.borderColor = BLUE_COLOR;
        txt_wPhone.layer.borderWidth = 1.0;
        
        txt_cPhone.layer.borderColor = CLEAR_COLOR;
        txt_cPhone.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_wPhone) {
        txt_email.layer.borderColor = BLUE_COLOR;
        txt_email.layer.borderWidth = 1.0;
        
        txt_wPhone.layer.borderColor = CLEAR_COLOR;
        txt_wPhone.layer.borderWidth = 1.0;
    }
     
     */
    
    /*
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    if (textField == txt_fName) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }
    
    */


    
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
                [ddict setObject:universalTextField.text forKey:@"item_quantity"];
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
                [ddict setObject:universalTextField.text forKey:@"item_quantity"];
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
        //[self checkBordersOfPatientSection];
       // [self checkBordersOfExchangeSection];
        //[self checkBordersOfPrevDME];
        //[self checkBordersOfMachineData];
    }
    
   
}


-(void)checkBordersOfCPAPModeSettings{
    if ([txt_cpap_cm.text isEqualToString:@""]) {
        txt_cpap_cm.layer.borderColor = BLUE_COLOR;
        txt_cpap_cm.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_cpap_cm.layer.borderColor = CLEAR_COLOR;
        txt_cpap_cm.layer.borderWidth = 1.0;
    }
    
    if ([txt_cpap_ramp.text isEqualToString:@""]) {
        txt_cpap_ramp.layer.borderColor = BLUE_COLOR;
        txt_cpap_ramp.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_cpap_ramp.layer.borderColor = CLEAR_COLOR;
        txt_cpap_ramp.layer.borderWidth = 1.0;
    }
    
    
    if ([txt_cpap_auto_ramp.text isEqualToString:@""]) {
        txt_cpap_auto_ramp.layer.borderColor = BLUE_COLOR;
        txt_cpap_auto_ramp.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_cpap_auto_ramp.layer.borderColor = CLEAR_COLOR;
        txt_cpap_auto_ramp.layer.borderWidth = 1.0;
    }
    
    if ([txt_cpap_auto_low.text isEqualToString:@""]) {
        txt_cpap_auto_low.layer.borderColor = BLUE_COLOR;
        txt_cpap_auto_low.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_cpap_auto_low.layer.borderColor = CLEAR_COLOR;
        txt_cpap_auto_low.layer.borderWidth = 1.0;
    }
    
    if ([txt_cpap_auto_high.text isEqualToString:@""]) {
        txt_cpap_auto_high.layer.borderColor = BLUE_COLOR;
        txt_cpap_auto_high.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_cpap_auto_high.layer.borderColor = CLEAR_COLOR;
        txt_cpap_auto_high.layer.borderWidth = 1.0;
    }
    
    
    if ([txt_std_ramp.text isEqualToString:@""]) {
        txt_std_ramp.layer.borderColor = BLUE_COLOR;
        txt_std_ramp.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_std_ramp.layer.borderColor = CLEAR_COLOR;
        txt_std_ramp.layer.borderWidth = 1.0;
    }
    
    if ([txt_std_ipap.text isEqualToString:@""]) {
        txt_std_ipap.layer.borderColor = BLUE_COLOR;
        txt_std_ipap.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_std_ipap.layer.borderColor = CLEAR_COLOR;
        txt_std_ipap.layer.borderWidth = 1.0;
    }
    
    if ([txt_std_epap.text isEqualToString:@""]) {
        txt_std_epap.layer.borderColor = BLUE_COLOR;
        txt_std_epap.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_std_epap.layer.borderColor = CLEAR_COLOR;
        txt_std_epap.layer.borderWidth = 1.0;
    }
    
    
    if ([txt_auto_ramp.text isEqualToString:@""]) {
        txt_auto_ramp.layer.borderColor = BLUE_COLOR;
        txt_auto_ramp.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_auto_ramp.layer.borderColor = CLEAR_COLOR;
        txt_auto_ramp.layer.borderWidth = 1.0;
    }
    
    if ([txt_auto_epap.text isEqualToString:@""]) {
        txt_auto_epap.layer.borderColor = BLUE_COLOR;
        txt_auto_epap.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_auto_epap.layer.borderColor = CLEAR_COLOR;
        txt_auto_epap.layer.borderWidth = 1.0;
    }
    
    if ([txt_auto_ipap.text isEqualToString:@""]) {
        txt_auto_ipap.layer.borderColor = BLUE_COLOR;
        txt_auto_ipap.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_auto_ipap.layer.borderColor = CLEAR_COLOR;
        txt_auto_ipap.layer.borderWidth = 1.0;
    }
    
    if ([txt_auto_pres_sup_min.text isEqualToString:@""]) {
        txt_auto_pres_sup_min.layer.borderColor = BLUE_COLOR;
        txt_auto_pres_sup_min.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_auto_pres_sup_min.layer.borderColor = CLEAR_COLOR;
        txt_auto_pres_sup_min.layer.borderWidth = 1.0;
    }
    
    if ([txt_auto_pres_sup_max.text isEqualToString:@""]) {
        txt_auto_pres_sup_max.layer.borderColor = BLUE_COLOR;
        txt_auto_pres_sup_max.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_auto_pres_sup_max.layer.borderColor = CLEAR_COLOR;
        txt_auto_pres_sup_max.layer.borderWidth = 1.0;
    }
    
    
    if ([txt_auto_sv_ramp.text isEqualToString:@""]) {
        txt_auto_sv_ramp.layer.borderColor = BLUE_COLOR;
        txt_auto_sv_ramp.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_auto_sv_ramp.layer.borderColor = CLEAR_COLOR;
        txt_auto_sv_ramp.layer.borderWidth = 1.0;
    }
    
    if ([txt_auto_sv_epap_min.text isEqualToString:@""]) {
        txt_auto_sv_epap_min.layer.borderColor = BLUE_COLOR;
        txt_auto_sv_epap_min.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_auto_sv_epap_min.layer.borderColor = CLEAR_COLOR;
        txt_auto_sv_epap_min.layer.borderWidth = 1.0;
    }
    
    if ([txt_auto_sv_epap_max.text isEqualToString:@""]) {
        txt_auto_sv_epap_max.layer.borderColor = BLUE_COLOR;
        txt_auto_sv_epap_max.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_auto_sv_epap_max.layer.borderColor = CLEAR_COLOR;
        txt_auto_sv_epap_max.layer.borderWidth = 1.0;
    }
    
    if ([txt_auto_sv_backup.text isEqualToString:@""]) {
        txt_auto_sv_backup.layer.borderColor = BLUE_COLOR;
        txt_auto_sv_backup.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_auto_sv_backup.layer.borderColor = CLEAR_COLOR;
        txt_auto_sv_backup.layer.borderWidth = 1.0;
    }
    
    if ([txt_auto_sv_pres_sup_min.text isEqualToString:@""]) {
        txt_auto_sv_pres_sup_min.layer.borderColor = BLUE_COLOR;
        txt_auto_sv_pres_sup_min.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_auto_sv_pres_sup_min.layer.borderColor = CLEAR_COLOR;
        txt_auto_sv_pres_sup_min.layer.borderWidth = 1.0;
    }
    
    if ([txt_auto_sv_pres_sup_max.text isEqualToString:@""]) {
        txt_auto_sv_pres_sup_max.layer.borderColor = BLUE_COLOR;
        txt_auto_sv_pres_sup_max.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_auto_sv_pres_sup_max.layer.borderColor = CLEAR_COLOR;
        txt_auto_sv_pres_sup_max.layer.borderWidth = 1.0;
    }
    
    if ([txt_auto_sv_max_pres_sup.text isEqualToString:@""]) {
        txt_auto_sv_max_pres_sup.layer.borderColor = BLUE_COLOR;
        txt_auto_sv_max_pres_sup.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_auto_sv_max_pres_sup.layer.borderColor = CLEAR_COLOR;
        txt_auto_sv_max_pres_sup.layer.borderWidth = 1.0;
    }
    
    
    if ([txt_st_ramp.text isEqualToString:@""]) {
        txt_st_ramp.layer.borderColor = BLUE_COLOR;
        txt_st_ramp.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_st_ramp.layer.borderColor = CLEAR_COLOR;
        txt_st_ramp.layer.borderWidth = 1.0;
    }
    
    if ([txt_st_ipap.text isEqualToString:@""]) {
        txt_st_ipap.layer.borderColor = BLUE_COLOR;
        txt_st_ipap.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_st_ipap.layer.borderColor = CLEAR_COLOR;
        txt_st_ipap.layer.borderWidth = 1.0;
    }
    
    if ([txt_st_epap.text isEqualToString:@""]) {
        txt_st_epap.layer.borderColor = BLUE_COLOR;
        txt_st_epap.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_st_epap.layer.borderColor = CLEAR_COLOR;
        txt_st_epap.layer.borderWidth = 1.0;
    }
    
    if ([txt_st_backup.text isEqualToString:@""]) {
        txt_st_backup.layer.borderColor = BLUE_COLOR;
        txt_st_backup.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_st_backup.layer.borderColor = CLEAR_COLOR;
        txt_st_backup.layer.borderWidth = 1.0;
    }
    
    
    
    

}

-(void)checkBordersOfMachineData{
    
    
    if ([txt_CPAPmanufacturer.text isEqualToString:@""]) {
        txt_CPAPmanufacturer.layer.borderColor = BLUE_COLOR;
        txt_CPAPmanufacturer.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_CPAPmanufacturer.layer.borderColor = CLEAR_COLOR;
        txt_CPAPmanufacturer.layer.borderWidth = 1.0;
    }
    
    if ([txt_CPAPserialNo.text isEqualToString:@""]) {
        txt_CPAPserialNo.layer.borderColor = BLUE_COLOR;
        txt_CPAPserialNo.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_CPAPserialNo.layer.borderColor = CLEAR_COLOR;
        txt_CPAPserialNo.layer.borderWidth = 1.0;
    }
    
    if ([txt_model.text isEqualToString:@""]) {
        txt_model.layer.borderColor = BLUE_COLOR;
        txt_model.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_model.layer.borderColor = CLEAR_COLOR;
        txt_model.layer.borderWidth = 1.0;
    }
}

-(void)checkBordersOfPrevDME{
    if ([prev_machine_name.text isEqualToString:@""]) {
        prev_machine_name.layer.borderColor = BLUE_COLOR;
        prev_machine_name.layer.borderWidth = 1.0;
        
        
    }
    else{
        prev_machine_name.layer.borderColor = CLEAR_COLOR;
        prev_machine_name.layer.borderWidth = 1.0;
    }
    
    if ([prev_serial.text isEqualToString:@""]) {
        prev_serial.layer.borderColor = BLUE_COLOR;
        prev_serial.layer.borderWidth = 1.0;
        
        
    }
    else{
        prev_serial.layer.borderColor = CLEAR_COLOR;
        prev_serial.layer.borderWidth = 1.0;
    }
}

-(void)checkBordersOfExchangeSection{
    if ([txt_ex_pick_machine.text isEqualToString:@""]) {
        txt_ex_pick_machine.layer.borderColor = BLUE_COLOR;
        txt_ex_pick_machine.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_ex_pick_machine.layer.borderColor = CLEAR_COLOR;
        txt_ex_pick_machine.layer.borderWidth = 1.0;
    }
    
    if ([txt_ex_machine.text isEqualToString:@""]) {
        txt_ex_machine.layer.borderColor = BLUE_COLOR;
        txt_ex_machine.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_ex_machine.layer.borderColor = CLEAR_COLOR;
        txt_ex_machine.layer.borderWidth = 1.0;
    }
    
    if ([txt_ex_manufacturer.text isEqualToString:@""]) {
        txt_ex_manufacturer.layer.borderColor = BLUE_COLOR;
        txt_ex_manufacturer.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_ex_manufacturer.layer.borderColor = CLEAR_COLOR;
        txt_ex_manufacturer.layer.borderWidth = 1.0;
    }
    
    if ([txt_ex_machine_serial.text isEqualToString:@""]) {
        txt_ex_machine_serial.layer.borderColor = BLUE_COLOR;
        txt_ex_machine_serial.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_ex_machine_serial.layer.borderColor = CLEAR_COLOR;
        txt_ex_machine_serial.layer.borderWidth = 1.0;
    }
    
    if ([txt_ex_hum_serial.text isEqualToString:@""]) {
        txt_ex_hum_serial.layer.borderColor = BLUE_COLOR;
        txt_ex_hum_serial.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_ex_hum_serial.layer.borderColor = CLEAR_COLOR;
        txt_ex_hum_serial.layer.borderWidth = 1.0;
    }
    
    if ([txt_ex_modem_seral.text isEqualToString:@""]) {
        txt_ex_modem_seral.layer.borderColor = BLUE_COLOR;
        txt_ex_modem_seral.layer.borderWidth = 1.0;
        
    }
    else{
        txt_ex_modem_seral.layer.borderColor = CLEAR_COLOR;
        txt_ex_modem_seral.layer.borderWidth = 1.0;
    }
    
    if ([txt_ex_rt_machine.text isEqualToString:@""]) {
        txt_ex_rt_machine.layer.borderColor = BLUE_COLOR;
        txt_ex_rt_machine.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_ex_rt_machine.layer.borderColor = CLEAR_COLOR;
        txt_ex_rt_machine.layer.borderWidth = 1.0;
    }
    
    if ([txt_ex_rt_manufacturer.text isEqualToString:@""]) {
        txt_ex_rt_manufacturer.layer.borderColor = BLUE_COLOR;
        txt_ex_rt_manufacturer.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_ex_rt_manufacturer.layer.borderColor = CLEAR_COLOR;
        txt_ex_rt_manufacturer.layer.borderWidth = 1.0;
    }
    
    if ([txt_ex_rt_serial.text isEqualToString:@""]) {
        txt_ex_rt_serial.layer.borderColor = BLUE_COLOR;
        txt_ex_rt_serial.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_ex_rt_serial.layer.borderColor = CLEAR_COLOR;
        txt_ex_rt_serial.layer.borderWidth = 1.0;
    }
    
    if ([txt_ex_rt_reference.text isEqualToString:@""]) {
        txt_ex_rt_reference.layer.borderColor = BLUE_COLOR;
        txt_ex_rt_reference.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_ex_rt_reference.layer.borderColor = CLEAR_COLOR;
        txt_ex_rt_reference.layer.borderWidth = 1.0;
    }
    
    
}

-(void)checkBordersOfPatientSection{
    if ([txt_email.text isEqualToString:@""]) {
        txt_email.layer.borderColor = BLUE_COLOR;
        txt_email.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_email.layer.borderColor = CLEAR_COLOR;
        txt_email.layer.borderWidth = 1.0;
    }
    
    if ([txt_wPhone.text isEqualToString:@""]) {
        txt_wPhone.layer.borderColor = BLUE_COLOR;
        txt_wPhone.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_wPhone.layer.borderColor = CLEAR_COLOR;
        txt_wPhone.layer.borderWidth = 1.0;
    }
    
    if ([txt_cPhone.text isEqualToString:@""]) {
        txt_cPhone.layer.borderColor = BLUE_COLOR;
        txt_cPhone.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_cPhone.layer.borderColor = CLEAR_COLOR;
        txt_cPhone.layer.borderWidth = 1.0;
    }
    
    if ([txt_hPhone.text isEqualToString:@""]) {
        txt_hPhone.layer.borderColor = BLUE_COLOR;
        txt_hPhone.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_hPhone.layer.borderColor = CLEAR_COLOR;
        txt_hPhone.layer.borderWidth = 1.0;
    }
    
    if ([txt_zip.text isEqualToString:@""]) {
        txt_zip.layer.borderColor = BLUE_COLOR;
        txt_zip.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_zip.layer.borderColor = CLEAR_COLOR;
        txt_zip.layer.borderWidth = 1.0;
    }
    
    if ([txt_state.text isEqualToString:@""]) {
        txt_state.layer.borderColor = BLUE_COLOR;
        txt_state.layer.borderWidth = 1.0;
        
    }
    else{
        txt_state.layer.borderColor = CLEAR_COLOR;
        txt_state.layer.borderWidth = 1.0;
    }
    
    if ([txt_city.text isEqualToString:@""]) {
        txt_city.layer.borderColor = BLUE_COLOR;
        txt_city.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_city.layer.borderColor = CLEAR_COLOR;
        txt_city.layer.borderWidth = 1.0;
    }
    
    if ([txt_dob.text isEqualToString:@""]) {
        txt_dob.layer.borderColor = BLUE_COLOR;
        txt_dob.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_dob.layer.borderColor = CLEAR_COLOR;
        txt_dob.layer.borderWidth = 1.0;
    }
    
    if ([txt_streetAdd.text isEqualToString:@""]) {
        txt_streetAdd.layer.borderColor = BLUE_COLOR;
        txt_streetAdd.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_streetAdd.layer.borderColor = CLEAR_COLOR;
        txt_streetAdd.layer.borderWidth = 1.0;
    }
    
    if ([txt_lName.text isEqualToString:@""]) {
        txt_lName.layer.borderColor = BLUE_COLOR;
        txt_lName.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_lName.layer.borderColor = CLEAR_COLOR;
        txt_lName.layer.borderWidth = 1.0;
    }
    
    if ([txt_fName.text isEqualToString:@""]) {
        txt_fName.layer.borderColor = BLUE_COLOR;
        txt_fName.layer.borderWidth = 1.0;
        
        
    }
    else{
        txt_fName.layer.borderColor = CLEAR_COLOR;
        txt_fName.layer.borderWidth = 1.0;
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
        if (textField == txt_fName) {
            [txt_lName becomeFirstResponder];
        }
        else if (textField == txt_lName){
            [txt_streetAdd becomeFirstResponder];
        }
        else if (textField == txt_streetAdd){
            [txt_dob becomeFirstResponder];
        }
        else if (textField == txt_dob){
            [txt_city becomeFirstResponder];
        }
        else if (textField == txt_city){
            [txt_zip becomeFirstResponder];
//            txt_state.layer.borderColor =  BLUE_COLOR;
//            txt_state.layer.borderWidth = 1.0;
        }
        else if (textField == txt_zip){
            [txt_hPhone becomeFirstResponder];
        }
        else if (textField == txt_hPhone){
            [txt_cPhone becomeFirstResponder];
        }
        else if (textField == txt_cPhone){
            [txt_wPhone becomeFirstResponder];
        }
        else if (textField == txt_wPhone){
            [txt_email becomeFirstResponder];
        }
        else if (textField == txt_email){
            //[txt_CPAPmanufacturer becomeFirstResponder];
            [textField resignFirstResponder];
        }
    
        else if (textField == prev_machine_name){
            [prev_serial becomeFirstResponder];
        }
        else if (textField == prev_serial){
            [textField resignFirstResponder];
        }
        else if (textField == txt_ex_machine_serial){
            [txt_ex_hum_serial becomeFirstResponder];
        }
        else if (textField == txt_ex_hum_serial){
            [txt_ex_modem_seral becomeFirstResponder];
        }
        else if (textField == txt_ex_modem_seral){
            [textField resignFirstResponder];
        }
        else if (textField == txt_ex_pick_machine){
            [textField resignFirstResponder];
        }
        else if (textField == txt_cpap_cm){
            [txt_cpap_ramp becomeFirstResponder];
        }
        else if (textField == txt_cpap_ramp){
            [textField resignFirstResponder];
        }
    
        else if (textField == txt_cpap_auto_ramp){
            [txt_cpap_auto_low becomeFirstResponder];
        }
        else if (textField == txt_cpap_auto_low){
            [txt_cpap_auto_high becomeFirstResponder];
        }
        else if (textField == txt_cpap_auto_high){
            [textField resignFirstResponder];
        }
    
        else if (textField == txt_std_ramp){
            [txt_std_ipap becomeFirstResponder];
        }
        else if (textField == txt_std_ipap){
            [txt_std_epap becomeFirstResponder];
        }
        else if (textField == txt_std_epap){
            [textField resignFirstResponder];
        }
    
        else if (textField == txt_auto_ramp){
            [txt_auto_epap becomeFirstResponder];
        }
        else if (textField == txt_auto_epap){
            [txt_auto_ipap becomeFirstResponder];
        }
        else if (textField == txt_auto_ipap){
            [txt_auto_pres_sup_min becomeFirstResponder];
        }
        else if (textField == txt_auto_pres_sup_min){
            [txt_auto_pres_sup_max becomeFirstResponder];
        }
        else if (textField == txt_auto_pres_sup_max){
            [textField resignFirstResponder];
        }
        else if (textField == txt_auto_sv_ramp){
            [txt_auto_sv_epap_min becomeFirstResponder];
        }
        else if (textField == txt_auto_sv_epap_min){
            [txt_auto_sv_epap_max becomeFirstResponder];
        }
        else if (textField == txt_auto_sv_epap_max){
            [txt_auto_sv_backup becomeFirstResponder];
        }
        else if (textField == txt_auto_sv_backup){
            [txt_auto_sv_pres_sup_min becomeFirstResponder];
        }
        else if (textField == txt_auto_sv_pres_sup_min){
            [txt_auto_sv_pres_sup_max becomeFirstResponder];
        }
        else if (textField == txt_auto_sv_pres_sup_max){
            [txt_auto_sv_max_pres_sup becomeFirstResponder];
        }
        else if (textField == txt_auto_sv_max_pres_sup){
            [textField resignFirstResponder];
        }
        else if (textField == txt_st_ramp){
            [txt_st_ipap becomeFirstResponder];
        }
        else if (textField == txt_st_ipap){
            [txt_st_epap becomeFirstResponder];
        }
        else if (textField == txt_st_epap){
            [txt_st_backup becomeFirstResponder];
        }
        else if (textField == txt_st_backup){
            [textField resignFirstResponder];
        }
    
    
    
    
    
        else if (textField == txt_CPAPmanufacturer){
            [txt_model becomeFirstResponder];
        }
        else if (textField == txt_model){
            [txt_CPAPserialNo becomeFirstResponder];
        }
        else if (textField == txt_CPAPserialNo){
            [txt_cm becomeFirstResponder];
        }
//        else if (textField == txt_cm){
//            [txt_rampTime becomeFirstResponder];
//        }
        else if (textField == txt_cm){
            [txt_backUpRate becomeFirstResponder];
        }
        else if (textField == txt_backUpRate){
            [txt_modemSerialNo becomeFirstResponder];
        }
        else if (textField == txt_modemSerialNo){
            [txt_humidifierManufacturer becomeFirstResponder];
        }
        else if (textField == txt_humidifierManufacturer){
            [txt_humidifierSerialNo becomeFirstResponder];
        }
        else if (textField == txt_humidifierSerialNo){
            [txt_maskType becomeFirstResponder];
        }
        else if (textField == txt_maskType){
            [txt_maskName becomeFirstResponder];
        }
        else if (textField == txt_maskName){
            [txt_maskID becomeFirstResponder];
        }
        else{
            CGPoint point = CGPointMake(0,1150);
            [UIView animateWithDuration:0.5 animations:^{
                [d_scrollView setContentOffset:point animated:NO];
            }];
            [textField resignFirstResponder];
        }

    
    return YES;
}













@end
