//
//  NewTransfer.h
//  RT APP
//
//  Created by Anil Prasad on 10/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTransfer : UIViewController<UIPopoverControllerDelegate, UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UIScrollView *d_scrollView;

    IBOutlet UITableView *n_transfersTable;
    IBOutlet UITableView *n_transfersTable2;
    
    IBOutlet UITextField *txt_date;
    IBOutlet UITextField *txt_rtName;
    
    IBOutlet UIButton *btn_submit;
    
    UIViewController *popoverViewCon;
    UIPopoverController *popoverCon;
    UITableViewController *dropdownsTableviewCon;
    
    UIViewController *popoverViewConDate;
    UIPopoverController *popoverConDate;
    UIDatePicker *datePicker;
    
    UITextField *universalTextField;
    CGPoint d_point;
    NSMutableArray *arryDate;

    NSMutableArray *arr_rt_listing;
    NSMutableArray *arr_rt_item_listing;
    NSMutableArray *arr_rt_transfer_listing;
    NSMutableArray *arr_added_listings;
    
    NSString *to_location;
    NSString *today_date;
}

@property (strong, nonatomic) NSMutableArray *arr_fromInventory;
@property (nonatomic) BOOL isFromTransferTicket;


@end
