//
//  OrdersVC.h
//  RT APP
//
//  Created by Anil Prasad on 08/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrdersVC : UIViewController<UITableViewDataSource,UITableViewDelegate, UIPopoverControllerDelegate, UIAlertViewDelegate, UITextFieldDelegate>{
    IBOutlet UITableView *orderDetailsTable;
    IBOutlet UITableView *editableOrdersTable;
    
    IBOutlet UIButton *btn_red;
    IBOutlet UIButton *btn_grey;
    
    
    IBOutlet UIScrollView *d_scrollView;
    UITextField *universalTextField;

    NSMutableArray *arr_orderDetails;
    NSMutableArray *arr_orderDetailsReceived;

    NSString *from_Id;
    NSString *transfer_id;
    
    IBOutlet UILabel *lbl_date_shipped;
    IBOutlet UILabel *lbl_status;
    IBOutlet UILabel *lbl_items;
    IBOutlet UILabel *lbl_order_num;

    UIPopoverController *popoverCon;
    UIViewController *popoverViewCon;
    UITableViewController *dropdownsTableviewCon;
}
@property (strong, nonatomic) NSArray *arr_dropdown;
@property (strong, nonatomic) NSArray *arr_serialNumbers;

@property (strong, nonatomic) NSString *order_ID;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *items_receiving;
@property BOOL isViewMode;


@end
