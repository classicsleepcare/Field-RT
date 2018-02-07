//
//  HistoryCell.h
//  RAP APP
//
//  Created by Anil Prasad on 5/30/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
//@protocol ItemCellDelegate;

@interface HistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_serial;
@property (weak, nonatomic) IBOutlet UILabel *lbl_lastName;
@property (weak, nonatomic) IBOutlet UILabel *lbl_firstName;
@property (weak, nonatomic) IBOutlet UILabel *lbl_refDate;
@property (weak, nonatomic) IBOutlet UILabel *lbl_doc;
@property (weak, nonatomic) IBOutlet UILabel *lbl_status;
@property (weak, nonatomic) IBOutlet UILabel *lbl_insurance;
@property (weak, nonatomic) IBOutlet UILabel *lbl_appDate;
@property (weak, nonatomic) IBOutlet UILabel *lbl_denDate;
@property (weak, nonatomic) IBOutlet UILabel *lbl_setupDate;
@property (weak, nonatomic) IBOutlet UILabel *lbl_city;
@property (weak, nonatomic) IBOutlet UILabel *lbl_RT;
@property (weak, nonatomic) IBOutlet UILabel *lbl_secondary;
@property (weak, nonatomic) IBOutlet UILabel *lbl_machine;
@property (weak, nonatomic) IBOutlet UILabel *lbl_mask;
@property (weak, nonatomic) IBOutlet UILabel *lbl_monthDate;
@property (weak, nonatomic) IBOutlet UILabel *lbl_totalRef;
@property (weak, nonatomic) IBOutlet UILabel *lbl_totalApp;
@property (weak, nonatomic) IBOutlet UILabel *lbl_totalDen;
@property (weak, nonatomic) IBOutlet UILabel *lbl_totalSetup;
@property (weak, nonatomic) IBOutlet UIView *view_UnderLineLastName;
@property (weak, nonatomic) IBOutlet UIView *view_underLineFirstName;
@property (weak, nonatomic) IBOutlet UIButton *btn_selectedPatient;
@property (weak, nonatomic) IBOutlet UIButton *btn_totalReferral;
@property (weak, nonatomic) IBOutlet UIButton *btn_totalApproval;
@property (weak, nonatomic) IBOutlet UIButton *btn_totalDenied;
@property (weak, nonatomic) IBOutlet UIButton *btn_totalSetup;

-(void)customizeLabelInCell;

// ScheduleViewController
@property (weak, nonatomic) IBOutlet UILabel *lbl_date;
@property (weak, nonatomic) IBOutlet UILabel *lbl_time;
@property (weak, nonatomic) IBOutlet UILabel *lbl_type;
@property (weak, nonatomic) IBOutlet UILabel *lbl_user;
@property (weak, nonatomic) IBOutlet UILabel *lbl_notes;

//PatientSearch
@property (weak, nonatomic) IBOutlet UILabel *lbp_serial;
@property (weak, nonatomic) IBOutlet UILabel *lbp_patientID;
@property (weak, nonatomic) IBOutlet UILabel *lbp_patientName;
@property (weak, nonatomic) IBOutlet UILabel *lbp_phone;
@property (weak, nonatomic) IBOutlet UILabel *lbp_setAppt;
@property (weak, nonatomic) IBOutlet UILabel *lbp_setupTicket;
@property (weak, nonatomic) IBOutlet UIButton *btp_setAppt;
@property (weak, nonatomic) IBOutlet UIButton *btp_setupTicket;
@property (weak, nonatomic) IBOutlet UIButton *btp_patientName;
@property (weak, nonatomic) IBOutlet UIButton *btp_phone;


//SetUpTicketVC
@property (weak, nonatomic) IBOutlet UILabel *lb_serial;
@property (weak, nonatomic) IBOutlet UILabel *lb_patientID;
@property (weak, nonatomic) IBOutlet UILabel *lb_patientName;
@property (weak, nonatomic) IBOutlet UILabel *lb_facility;
@property (weak, nonatomic) IBOutlet UILabel *lb_state;
@property (weak, nonatomic) IBOutlet UILabel *lb_doctor;
@property (weak, nonatomic) IBOutlet UILabel *lb_dateCreated;
@property (weak, nonatomic) IBOutlet UIButton *bt_patientName;
@property (weak, nonatomic) IBOutlet UIButton *bt_setAppt;
@property (weak, nonatomic) IBOutlet UIButton *bt_view_submit;

//NewSetups
@property (weak, nonatomic) IBOutlet UILabel *lbs_serial;
@property (weak, nonatomic) IBOutlet UILabel *lbs_first;
@property (weak, nonatomic) IBOutlet UILabel *lbs_last;
@property (weak, nonatomic) IBOutlet UILabel *lbs_phone;
@property (weak, nonatomic) IBOutlet UILabel *lbs_setup;
@property (weak, nonatomic) IBOutlet UILabel *lbs_schedule;
@property (weak, nonatomic) IBOutlet UIButton *bts_setup;
@property (weak, nonatomic) IBOutlet UIButton *bts_schedule;


//SetupTicketFormOne // Ticket Form
@property (weak, nonatomic) IBOutlet UILabel *lbf_itemID;
@property (weak, nonatomic) IBOutlet UILabel *lbf_itemType;
@property (weak, nonatomic) IBOutlet UILabel *lbf_itemName;
@property (weak, nonatomic) IBOutlet UILabel *lbf_quantity;
@property (weak, nonatomic) IBOutlet UITextField *txtf_quantity;
@property (weak, nonatomic) IBOutlet UILabel *lbf_additionalItems;
@property (weak, nonatomic) IBOutlet UITextField *txtf_additionalItems;
@property (weak, nonatomic) IBOutlet UILabel *lbf_size;
@property (weak, nonatomic) IBOutlet UIButton *btnf_size;
@property (weak, nonatomic) IBOutlet UIButton *btnf_Ssize;
@property (weak, nonatomic) IBOutlet UIButton *btnf_Msize;
@property (weak, nonatomic) IBOutlet UIButton *btnf_Lsize;
@property (weak, nonatomic) IBOutlet UIButton *btnf_Psize;
@property (weak, nonatomic) IBOutlet UIButton *btnf_SMsize;
@property (weak, nonatomic) IBOutlet UIButton *btnf_Wsize;
@property (weak, nonatomic) IBOutlet UIButton *btnf_XLsize;
@property (weak, nonatomic) IBOutlet UILabel *lbf_notesDesc;
@property (weak, nonatomic) IBOutlet UIView *cell_dropdownView;

//SetupTicketFormOne // Ticket Form1

@property (weak, nonatomic) IBOutlet UILabel *lbf1_itemID;
@property (weak, nonatomic) IBOutlet UILabel *lbf1_itemType;
@property (weak, nonatomic) IBOutlet UILabel *lbf1_itemName;
@property (weak, nonatomic) IBOutlet UILabel *lbf1_quantity;
@property (weak, nonatomic) IBOutlet UITextField *txtf1_quantity;
@property (weak, nonatomic) IBOutlet UILabel *lbf1_additionalItems;
@property (weak, nonatomic) IBOutlet UITextField *txtf1_additionalItems;
@property (weak, nonatomic) IBOutlet UILabel *lbf1_size;
@property (weak, nonatomic) IBOutlet UIButton *btnf1_size;
@property (weak, nonatomic) IBOutlet UIButton *btnf1_Ssize;
@property (weak, nonatomic) IBOutlet UIButton *btnf1_Msize;
@property (weak, nonatomic) IBOutlet UIButton *btnf1_Lsize;
@property (weak, nonatomic) IBOutlet UILabel *lbf1_notesDesc;
@property (weak, nonatomic) IBOutlet UIView *cell1_dropdownView;

//SetupTicketFormOne // Ticket Form2
@property (weak, nonatomic) IBOutlet UILabel *lbf2_itemID;
@property (weak, nonatomic) IBOutlet UILabel *lbf2_itemType;
@property (weak, nonatomic) IBOutlet UILabel *lbf2_itemName;
@property (weak, nonatomic) IBOutlet UILabel *lbf2_quantity;
@property (weak, nonatomic) IBOutlet UITextField *txtf2_quantity;
@property (weak, nonatomic) IBOutlet UILabel *lbf2_additionalItems;
@property (weak, nonatomic) IBOutlet UITextField *txtf2_additionalItems;
@property (weak, nonatomic) IBOutlet UILabel *lbf2_size;
@property (weak, nonatomic) IBOutlet UIButton *btnf2_size;
@property (weak, nonatomic) IBOutlet UIButton *btnf2_Ssize;
@property (weak, nonatomic) IBOutlet UIButton *btnf2_Msize;
@property (weak, nonatomic) IBOutlet UIButton *btnf2_Lsize;
@property (weak, nonatomic) IBOutlet UILabel *lbf2_notesDesc;
@property (weak, nonatomic) IBOutlet UIView *cell2_dropdownView;
//@property (weak, nonatomic) id<ItemCellDelegate> delegate;

// NIV Ticket Form
@property (weak, nonatomic) IBOutlet UILabel *lbni_itemID;
@property (weak, nonatomic) IBOutlet UILabel *lbni_itemType;
@property (weak, nonatomic) IBOutlet UILabel *lbni_itemName;
@property (weak, nonatomic) IBOutlet UILabel *lbni_quantity;
@property (weak, nonatomic) IBOutlet UITextField *txtni_quantity;
@property (weak, nonatomic) IBOutlet UILabel *lbni_additionalItems;
@property (weak, nonatomic) IBOutlet UITextField *txtni_additionalItems;
@property (weak, nonatomic) IBOutlet UILabel *lbni_size;
@property (weak, nonatomic) IBOutlet UIButton *btnni_size;
@property (weak, nonatomic) IBOutlet UIButton *btnni_Ssize;
@property (weak, nonatomic) IBOutlet UIButton *btnni_Msize;
@property (weak, nonatomic) IBOutlet UIButton *btnni_Lsize;
@property (weak, nonatomic) IBOutlet UIButton *btnni_Psize;
@property (weak, nonatomic) IBOutlet UIButton *btnni_SMsize;
@property (weak, nonatomic) IBOutlet UIButton *btnni_Wsize;
@property (weak, nonatomic) IBOutlet UIButton *btnni_XLsize;
@property (weak, nonatomic) IBOutlet UILabel *lbni_notesDesc;
@property (weak, nonatomic) IBOutlet UIView *cellni_dropdownView;

// NIV Ticket Form1

@property (weak, nonatomic) IBOutlet UILabel *lbni1_itemID;
@property (weak, nonatomic) IBOutlet UILabel *lbni1_itemType;
@property (weak, nonatomic) IBOutlet UILabel *lbni1_itemName;
@property (weak, nonatomic) IBOutlet UILabel *lbni1_quantity;
@property (weak, nonatomic) IBOutlet UITextField *txtni1_quantity;
@property (weak, nonatomic) IBOutlet UILabel *lbni1_additionalItems;
@property (weak, nonatomic) IBOutlet UITextField *txtni1_additionalItems;
@property (weak, nonatomic) IBOutlet UILabel *lbni1_size;
@property (weak, nonatomic) IBOutlet UIButton *btnni1_size;
@property (weak, nonatomic) IBOutlet UIButton *btnni1_Ssize;
@property (weak, nonatomic) IBOutlet UIButton *btnni1_Msize;
@property (weak, nonatomic) IBOutlet UIButton *btnni1_Lsize;
@property (weak, nonatomic) IBOutlet UILabel *lbni1_notesDesc;
@property (weak, nonatomic) IBOutlet UIView *cellni1_dropdownView;

// NIV Ticket Form2
@property (weak, nonatomic) IBOutlet UILabel *lbni2_itemID;
@property (weak, nonatomic) IBOutlet UILabel *lbni2_itemType;
@property (weak, nonatomic) IBOutlet UILabel *lbni2_itemName;
@property (weak, nonatomic) IBOutlet UILabel *lbni2_quantity;
@property (weak, nonatomic) IBOutlet UITextField *txtni2_quantity;
@property (weak, nonatomic) IBOutlet UILabel *lbni2_additionalItems;
@property (weak, nonatomic) IBOutlet UITextField *txtni2_additionalItems;
@property (weak, nonatomic) IBOutlet UILabel *lbni2_size;
@property (weak, nonatomic) IBOutlet UIButton *btnni2_size;
@property (weak, nonatomic) IBOutlet UIButton *btnni2_Ssize;
@property (weak, nonatomic) IBOutlet UIButton *btnni2_Msize;
@property (weak, nonatomic) IBOutlet UIButton *btnni2_Lsize;
@property (weak, nonatomic) IBOutlet UILabel *lbni2_notesDesc;
@property (weak, nonatomic) IBOutlet UIView *cellni2_dropdownView;

//Inventory
@property (weak, nonatomic) IBOutlet UILabel *lbb_serial;
@property (weak, nonatomic) IBOutlet UILabel *lbb_itemID;
@property (weak, nonatomic) IBOutlet UILabel *lbb_itemName;
@property (weak, nonatomic) IBOutlet UILabel *lbb_serialNo;
@property (weak, nonatomic) IBOutlet UILabel *lbb_status;
@property (weak, nonatomic) IBOutlet UILabel *lbb_patient;
@property (weak, nonatomic) IBOutlet UILabel *lbb_action;

@property (weak, nonatomic) IBOutlet UILabel *lbb_action0;
@property (weak, nonatomic) IBOutlet UILabel *lbb_action1;
@property (weak, nonatomic) IBOutlet UIButton *btbb_action0;
@property (weak, nonatomic) IBOutlet UIButton *btbb_action1;


// Unserialized InventoryVC
@property (weak, nonatomic) IBOutlet UILabel *lbbu_serial;
@property (weak, nonatomic) IBOutlet UILabel *lbbu_itemID;
@property (weak, nonatomic) IBOutlet UILabel *lbbu_itemName;
@property (weak, nonatomic) IBOutlet UILabel *lbbu_InTransit;
@property (weak, nonatomic) IBOutlet UILabel *lbbu_OnHand;
@property (weak, nonatomic) IBOutlet UILabel *lbbu_Commiitted;
@property (weak, nonatomic) IBOutlet UILabel *lbbu_available;

// Orders
@property (weak, nonatomic) IBOutlet UILabel *lblO_orderNum;
@property (weak, nonatomic) IBOutlet UILabel *lblO_dateShipped;
@property (weak, nonatomic) IBOutlet UILabel *lblO_status;
@property (weak, nonatomic) IBOutlet UILabel *lblO_items;

// Transfers
@property (weak, nonatomic) IBOutlet UILabel *lblt_transferTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblt_date;
@property (weak, nonatomic) IBOutlet UILabel *lblt_items;
@property (weak, nonatomic) IBOutlet UILabel *lblt_notes;

// Orders Detail
@property (weak, nonatomic) IBOutlet UILabel *lbld_serial;
@property (weak, nonatomic) IBOutlet UILabel *lbld_itemID;
@property (weak, nonatomic) IBOutlet UILabel *lbld_itemName;
@property (weak, nonatomic) IBOutlet UILabel *lbld_serialNum;
@property (weak, nonatomic) IBOutlet UILabel *lbld_qtySent;
@property (weak, nonatomic) IBOutlet UILabel *lbld_qtyReceived;
@property (weak, nonatomic) IBOutlet UILabel *lbld_action;
@property (weak, nonatomic) IBOutlet UIButton *btnd_viewSerial;


// Editable Orders Detail
@property (weak, nonatomic) IBOutlet UILabel *lbled_serial;
@property (weak, nonatomic) IBOutlet UILabel *lbled_itemID;
@property (weak, nonatomic) IBOutlet UILabel *lbled_itemName;
@property (weak, nonatomic) IBOutlet UILabel *lbled_serialNum;
@property (weak, nonatomic) IBOutlet UILabel *lbled_qtySent;
@property (weak, nonatomic) IBOutlet UILabel *lbled_qtyReceived;
@property (weak, nonatomic) IBOutlet UILabel *lbled_action;
@property (weak, nonatomic) IBOutlet UITextField *txted_qtyReceived;
@property (weak, nonatomic) IBOutlet UIButton *btned_action;
@property (weak, nonatomic) IBOutlet UIButton *btned_check;

// View Order Detail

@property (weak, nonatomic) IBOutlet UILabel *lbledv_serialNum;

// Transfer Detail
@property (weak, nonatomic) IBOutlet UILabel *lbltd_serial;
@property (weak, nonatomic) IBOutlet UILabel *lbltd_itemID;
@property (weak, nonatomic) IBOutlet UILabel *lbltd_itemName;
@property (weak, nonatomic) IBOutlet UILabel *lbltd_serialNum;
@property (weak, nonatomic) IBOutlet UILabel *lbltd_qtyTransferred;

// New Transfer
@property (weak, nonatomic) IBOutlet UILabel *lblnt_serial;
@property (weak, nonatomic) IBOutlet UILabel *lblnt_itemID;
@property (weak, nonatomic) IBOutlet UILabel *lblnt_itemName;
@property (weak, nonatomic) IBOutlet UILabel *lblnt_serialNum;
@property (weak, nonatomic) IBOutlet UILabel *lblnt_qtyOnHand;
@property (weak, nonatomic) IBOutlet UILabel *lblnt_amountTo;
@property (weak, nonatomic) IBOutlet UITextField *txtnt_amountTo;

// New Transfer-2
@property (weak, nonatomic) IBOutlet UILabel *lblnta_serial;
@property (weak, nonatomic) IBOutlet UILabel *lblnta_itemID;
@property (weak, nonatomic) IBOutlet UILabel *lblnta_itemName;
@property (weak, nonatomic) IBOutlet UILabel *lblnta_sent;
@property (weak, nonatomic) IBOutlet UILabel *lblnta_received;
@property (weak, nonatomic) IBOutlet UILabel *lblnta_acknowledge;
@property (weak, nonatomic) IBOutlet UITextField *txtnta_sent;
@property (weak, nonatomic) IBOutlet UITextField *txtnta_received;
@property (weak, nonatomic) IBOutlet UIButton *btnta_acknowledge;

// HistoryVC

@property (weak, nonatomic) IBOutlet UILabel *lblh_serial;
@property (weak, nonatomic) IBOutlet UILabel *lblh_lastName;
@property (weak, nonatomic) IBOutlet UILabel *lblh_firstName;
@property (weak, nonatomic) IBOutlet UILabel *lblh_appDate;
@property (weak, nonatomic) IBOutlet UILabel *lblh_setupDate;
@property (weak, nonatomic) IBOutlet UILabel *lblh_doctor;
@property (weak, nonatomic) IBOutlet UILabel *lblh_status;
@property (weak, nonatomic) IBOutlet UIButton *btnh_name;

// medicationProfile
@property (weak, nonatomic) IBOutlet UILabel *lbmp_medication;
@property (weak, nonatomic) IBOutlet UILabel *lbmp_date;
@property (weak, nonatomic) IBOutlet UILabel *lbmp_frequency;
@property (weak, nonatomic) IBOutlet UILabel *lbmp_route;
@property (weak, nonatomic) IBOutlet UILabel *lbmp_date_start;
@property (weak, nonatomic) IBOutlet UILabel *lbmp_date_end;

@end

//@protocol ItemCellDelegate <NSObject>
//
//- (void)itemCell:(HistoryCell*)cell didSelectCellAtIndex:(UIButton *)btnIndex;
//
//@end
