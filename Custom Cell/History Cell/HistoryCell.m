//
//  HistoryCell.m
//  RAP APP
//
//  Created by Anil Prasad on 5/30/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "HistoryCell.h"

@implementation HistoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if ([reuseIdentifier isEqualToString:@"TicketForm"]) {
//            [self.btnf_size addTarget:self action:@selector(hideUnhideDropdown) forControlEvents:UIControlEventTouchUpInside];
//            self.cell_dropdownView.hidden = YES;
        }

    }
    return self;
}

-(void)hideUnhideDropdown{
    self.cell_dropdownView.hidden = NO;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)customizeLabelInCell
{
    if([self.reuseIdentifier isEqualToString:@"StatsTallyCell"])
    {
        self.lbl_monthDate = [self customizeBoldLabel:_lbl_monthDate];
        self.lbl_totalApp = [self customizeBoldLabel:_lbl_totalApp];
        self.lbl_totalSetup = [self customizeBoldLabel:_lbl_totalSetup];
        self.lbl_totalDen = [self customizeBoldLabel:_lbl_totalDen];
        self.lbl_totalRef = [self customizeBoldLabel:_lbl_totalRef];
    }
    else if([self.reuseIdentifier isEqualToString:@"ScheduleCell"]){
        self.lbl_date = [self customizeLable:_lbl_date];
        self.lbl_time = [self customizeLable:_lbl_time];
        self.lbl_type = [self customizeLable:_lbl_type];
        self.lbl_user = [self customizeLable:_lbl_user];
        self.lbl_notes = [self customizeLable:_lbl_notes];
    }
    else if([self.reuseIdentifier isEqualToString:@"medicationProfile"]){
        self.lbmp_medication = [self customizeLable:_lbmp_medication];
        self.lbmp_date = [self customizeLable:_lbmp_date];
        self.lbmp_frequency = [self customizeLable:_lbmp_frequency];
        self.lbmp_route = [self customizeLable:_lbmp_route];
        self.lbmp_date_start = [self customizeLable:_lbmp_date_start];
        self.lbmp_date_end = [self customizeLable:_lbmp_date_end];
    }
    else if ([self.reuseIdentifier isEqualToString:@"PatientSearch"]){
        self.lbp_serial = [self customizeLable:_lbp_serial];
        self.lbp_patientID = [self customizeLable:_lbp_patientID];
        self.lbp_patientName = [self customizeLable:_lbp_patientName];
        self.lbp_phone = [self customizeLable:_lbp_phone];
        self.lbp_setAppt = [self customizeLable:_lbp_setAppt];
        self.lbp_setupTicket = [self customizeLable:_lbp_setupTicket];        
    }
    else if ([self.reuseIdentifier isEqualToString:@"NewSetups"]){
        self.lbs_serial = [self customizeLable:_lbs_serial];
        self.lbs_first = [self customizeLable:_lbs_first];
        self.lbs_last = [self customizeLable:_lbs_last];
        self.lbs_phone = [self customizeLable:_lbs_phone];
        self.lbs_setup = [self customizeLable:_lbs_setup];
        self.lbs_schedule = [self customizeLable:_lbs_schedule];

    }
    else if ([self.reuseIdentifier isEqualToString:@"SetUpTicket"]){
        self.lb_serial = [self customizeLable:_lb_serial];
        self.lb_patientID = [self customizeLable:_lb_patientID];
        self.lb_patientName = [self customizeLable:_lb_patientName];
        self.lb_facility = [self customizeLable:_lb_facility];
        self.lb_state = [self customizeLable:_lb_state];
        self.lb_doctor = [self customizeLable:_lb_doctor];
        self.lb_dateCreated = [self customizeLable:_lb_dateCreated];
    }
    else if ([self.reuseIdentifier isEqualToString:@"TicketForm"]){
        self.lbf_itemID = [self customizeLable:_lbf_itemID];
        self.lbf_itemType = [self customizeLable:_lbf_itemType];
        self.lbf_itemName = [self customizeLable:_lbf_itemName];
        self.lbf_quantity = [self customizeLable:_lbf_quantity];
        self.lbf_size = [self customizeLable:_lbf_size];
        self.lbf_notesDesc = [self customizeLable:_lbf_notesDesc];
        self.lbf_additionalItems = [self customizeLable:_lbf_additionalItems];
    }
    else if ([self.reuseIdentifier isEqualToString:@"TicketForm1"]){
        self.lbf1_itemID = [self customizeLable:_lbf1_itemID];
        self.lbf1_itemType = [self customizeLable:_lbf1_itemType];
        self.lbf1_itemName = [self customizeLable:_lbf1_itemName];
        self.lbf1_quantity = [self customizeLable:_lbf1_quantity];
        self.lbf1_size = [self customizeLable:_lbf1_size];
        self.lbf1_notesDesc = [self customizeLable:_lbf1_notesDesc];
        self.lbf1_additionalItems = [self customizeLable:_lbf1_additionalItems];
    }
    else if ([self.reuseIdentifier isEqualToString:@"TicketForm2"]){
        self.lbf2_itemID = [self customizeLable:_lbf2_itemID];
        self.lbf2_itemType = [self customizeLable:_lbf2_itemType];
        self.lbf2_itemName = [self customizeLable:_lbf2_itemName];
        self.lbf2_quantity = [self customizeLable:_lbf2_quantity];
        self.lbf2_size = [self customizeLable:_lbf2_size];
        self.lbf2_notesDesc = [self customizeLable:_lbf2_notesDesc];
        self.lbf2_additionalItems = [self customizeLable:_lbf2_additionalItems];
    }
    
    else if ([self.reuseIdentifier isEqualToString:@"NIVTicketForm"]){
        self.lbni_itemID = [self customizeLable:_lbni_itemID];
        self.lbni_itemType = [self customizeLable:_lbni_itemType];
        self.lbni_itemName = [self customizeLable:_lbni_itemName];
        self.lbni_quantity = [self customizeLable:_lbni_quantity];
        self.lbni_size = [self customizeLable:_lbni_size];
        self.lbni_notesDesc = [self customizeLable:_lbni_notesDesc];
        self.lbni_additionalItems = [self customizeLable:_lbni_additionalItems];
    }
    else if ([self.reuseIdentifier isEqualToString:@"NIVTicketForm1"]){
        self.lbni1_itemID = [self customizeLable:_lbni1_itemID];
        self.lbni1_itemType = [self customizeLable:_lbni1_itemType];
        self.lbni1_itemName = [self customizeLable:_lbni1_itemName];
        self.lbni1_quantity = [self customizeLable:_lbni1_quantity];
        self.lbni1_size = [self customizeLable:_lbni1_size];
        self.lbni1_notesDesc = [self customizeLable:_lbni1_notesDesc];
        self.lbni1_additionalItems = [self customizeLable:_lbni1_additionalItems];
    }
    else if ([self.reuseIdentifier isEqualToString:@"NIVTicketForm2"]){
        self.lbni2_itemID = [self customizeLable:_lbni2_itemID];
        self.lbni2_itemType = [self customizeLable:_lbni2_itemType];
        self.lbni2_itemName = [self customizeLable:_lbni2_itemName];
        self.lbni2_quantity = [self customizeLable:_lbni2_quantity];
        self.lbni2_size = [self customizeLable:_lbni2_size];
        self.lbni2_notesDesc = [self customizeLable:_lbni2_notesDesc];
        self.lbni2_additionalItems = [self customizeLable:_lbni2_additionalItems];
    }
    
    else if ([self.reuseIdentifier isEqualToString:@"Inventory"]){
        self.lbb_serial = [self customizeLable:_lbb_serial];
        self.lbb_itemID = [self customizeLable:_lbb_itemID];
        self.lbb_itemName = [self customizeLable:_lbb_itemName];
        self.lbb_serialNo = [self customizeLable:_lbb_serialNo];
        self.lbb_status = [self customizeLable:_lbb_status];
        self.lbb_patient = [self customizeLable:_lbb_patient];
        self.lbb_action = [self customizeLable:_lbb_action];
    }
    else if ([self.reuseIdentifier isEqualToString:@"UnserializedInventory"]){
        self.lbbu_serial = [self customizeLable:_lbbu_serial];
        self.lbbu_itemID = [self customizeLable:_lbbu_itemID];
        self.lbbu_itemName = [self customizeLable:_lbbu_itemName];
        self.lbbu_InTransit = [self customizeLable:_lbbu_InTransit];
        self.lbbu_OnHand = [self customizeLable:_lbbu_OnHand];
        self.lbbu_Commiitted = [self customizeLable:_lbbu_Commiitted];
        self.lbbu_available = [self customizeLable:_lbbu_available];
    }
    else if ([self.reuseIdentifier isEqualToString:@"OrderDetail"]){
        self.lbld_serial = [self customizeLable:_lbld_serial];
        self.lbld_itemID = [self customizeLable:_lbld_itemID];
        self.lbld_itemName = [self customizeLable:_lbld_itemName];
        self.lbld_serialNum = [self customizeLable:_lbld_serialNum];
        self.lbld_qtySent = [self customizeLable:_lbld_qtySent];
        self.lbld_qtyReceived = [self customizeLable:_lbld_qtyReceived];
        self.lbld_action = [self customizeLable:_lbld_action];
    }
    else if ([self.reuseIdentifier isEqualToString:@"EditOrderDetail"]){
        //self.lbled_serial = [self customizeLable:_lbled_serial];
        //self.lbled_itemID = [self customizeLable:_lbled_itemID];
        //self.lbled_itemName = [self customizeLable:_lbled_itemName];
        self.lbled_serialNum = [self customizeLable:_lbled_serialNum];
        //self.lbled_qtySent = [self customizeLable:_lbled_qtySent];
        self.lbled_qtyReceived = [self customizeLable:_lbled_qtyReceived];
        //self.lbled_action = [self customizeLable:_lbled_action];
        [self.btned_check setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
        [self.btned_check setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateSelected];


    }
    else if ([self.reuseIdentifier isEqualToString:@"ViewOrderDetail"]){
        //self.lbled_serial = [self customizeLable:_lbled_serial];
        //self.lbled_itemID = [self customizeLable:_lbled_itemID];
        //self.lbled_itemName = [self customizeLable:_lbled_itemName];
        self.lbledv_serialNum = [self customizeLable:_lbledv_serialNum];
        //self.lbled_qtySent = [self customizeLable:_lbled_qtySent];
        //self.lbled_qtyReceived = [self customizeLable:_lbled_qtyReceived];
        //self.lbled_action = [self customizeLable:_lbled_action];
        //[self.btned_check setImage:[UIImage imageNamed:@"chk_box.png"] forState:UIControlStateNormal];
        //[self.btned_check setImage:[UIImage imageNamed:@"chk_box_o.png"] forState:UIControlStateSelected];
        
        
    }
    
    else if ([self.reuseIdentifier isEqualToString:@"TransferDetail"]){
        self.lbltd_serial = [self customizeLable:_lbltd_serial];
        self.lbltd_itemID = [self customizeLable:_lbltd_itemID];
        self.lbltd_itemName = [self customizeLable:_lbltd_itemName];
        self.lbltd_serialNum = [self customizeLable:_lbltd_serialNum];
        self.lbltd_qtyTransferred = [self customizeLable:_lbltd_qtyTransferred];
    }
    else if ([self.reuseIdentifier isEqualToString:@"NewTransfer"]){
        self.lblnt_serial = [self customizeLable:_lblnt_serial];
        self.lblnt_itemID = [self customizeLable:_lblnt_itemID];
        self.lblnt_itemName = [self customizeLable:_lblnt_itemName];
        self.lblnt_serialNum = [self customizeLable:_lblnt_serialNum];
        self.lblnt_qtyOnHand = [self customizeLable:_lblnt_qtyOnHand];
        self.lblnt_amountTo = [self customizeLable:_lblnt_amountTo];
    }
    else if ([self.reuseIdentifier isEqualToString:@"NewTransfer2"]){
        self.lblnta_serial = [self customizeLable:_lblnta_serial];
        self.lblnta_itemID = [self customizeLable:_lblnta_itemID];
        self.lblnta_itemName = [self customizeLable:_lblnta_itemName];
        self.lblnta_sent = [self customizeLable:_lblnta_sent];
        self.lblnta_received = [self customizeLable:_lblnta_received];
        self.lblnta_acknowledge = [self customizeLable:_lblnta_acknowledge];
    }
    else if ([self.reuseIdentifier isEqualToString:@"HistoryVC"]){
        self.lblh_serial = [self customizeLable:_lblh_serial];
        self.lblh_lastName = [self customizeLable:_lblh_lastName];
        self.lblh_firstName = [self customizeLable:_lblh_firstName];
        self.lblh_appDate = [self customizeLable:_lblh_appDate];
        self.lblh_setupDate = [self customizeLable:_lblh_setupDate];
        self.lblh_doctor = [self customizeLable:_lblh_doctor];
        self.lblh_status = [self customizeLable:_lblh_status];
    }
    else
    {
        self.lbl_appDate= [self customizeLable:_lbl_appDate];
        self.lbl_denDate= [self customizeLable:_lbl_denDate];
        self.lbl_doc = [self customizeLable:_lbl_doc];
        self.lbl_firstName= [self customizeLable:_lbl_firstName];
        self.lbl_insurance= [self customizeLable:_lbl_insurance];
        self.lbl_lastName= [self customizeLable:_lbl_lastName];
        self.lbl_refDate= [self customizeLable:_lbl_refDate];
        self.lbl_serial= [self customizeLable:_lbl_serial];
        self.lbl_setupDate= [self customizeLable:_lbl_setupDate];
        self.lbl_status= [self customizeLable:_lbl_status];
        self.lbl_machine = [self customizeLable:_lbl_machine];
        self.lbl_mask =[self customizeLable:_lbl_mask];
        self.lbl_RT =[self customizeLable:_lbl_RT];
        self.lbl_secondary = [self customizeLable:_lbl_secondary];
        self.lbl_city = [self customizeLable:_lbl_city];
    }
    
}

-(UILabel*)customizeLable :(UILabel*)lbl
{
    if(![lbl isEqual:_lbl_firstName] && ![lbl isEqual:_lbl_lastName])
    {
       lbl.lineBreakMode=NSLineBreakByCharWrapping;
    }
    else
    {
        lbl.textColor = [UIColor blueColor];
    }
    
    lbl.numberOfLines= 2;
    //lbl.font= [UIFont systemFontOfSize:11.0];
    //lbl.textAlignment=NSTextAlignmentCenter;
    lbl.backgroundColor = [UIColor whiteColor];
    lbl.layer.borderWidth=1.0;
    lbl.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    return lbl;
    
}

-(UILabel*)customizeBoldLabel :(UILabel*)lbl
{
   if(![lbl isEqual:self.lbl_monthDate]) lbl.textColor = [UIColor blueColor];
    lbl.lineBreakMode=NSLineBreakByCharWrapping;
    lbl.numberOfLines= 2;
    lbl.font= [UIFont boldSystemFontOfSize:20.0];
    lbl.textAlignment=NSTextAlignmentCenter;
    
    lbl.layer.borderWidth=1.0;
    lbl.layer.borderColor=[[UIColor blackColor] CGColor];
    return lbl;
    
}


@end
