//
//  OrderDetailViewOnly.h
//  RT APP
//
//  Created by Anil Prasad on 12/03/16.
//  Copyright © 2016 ankit gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailViewOnly : UIViewController<UITextFieldDelegate, UIAlertViewDelegate>{
    
    
    IBOutlet UIScrollView *d_scrollView;
    UITextField *universalTextField;
    
    NSString *from_Id;
    NSString *transfer_id;
    
    IBOutlet UILabel *lbl_date_shipped;
    IBOutlet UILabel *lbl_status;
    IBOutlet UILabel *lbl_items;
    IBOutlet UILabel *lbl_order_num;
    
    __weak IBOutlet UITextView *lbl_notes;
    __weak IBOutlet UIButton *btn_receiveItems;
    
    NSMutableArray *arr_orderDetails;
    NSMutableArray *arr_orderDetailsReceived;
    UIAlertView *receiveAlert;
}

@property (strong, nonatomic) IBOutlet UITableView *orderDetailsTable;

@property (strong, nonatomic) NSArray *arr_dropdown;
@property (strong, nonatomic) NSArray *arr_serialNumbers;

@property (strong, nonatomic) NSString *order_ID;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *items_receiving;
@property (strong, nonatomic) NSString *pt_notes;

@property (nonatomic) BOOL isReadOnly;

-(void)testingvariable;

@end
