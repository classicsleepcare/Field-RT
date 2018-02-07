//
//  StockTake.h
//  RT APP
//
//  Created by Anil Prasad on 21/09/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketFormView.h"
#import "TicketFormModel.h"

@interface StockTake : UIViewController<UIPopoverControllerDelegate,UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *table_stockTake;
    
    TicketFormView *object_TV;
    IBOutlet UIScrollView *d_scrollView;

    int tagNum;
    CGPoint d_point;
    UITextField *universalTextField;
    
    IBOutlet UIButton *btn_addMore;
    IBOutlet UIButton *btn_next;

    IBOutlet UITextField *txt_1_machine;
    IBOutlet UITextField *txt_1_manufacture;
    IBOutlet UITextField *txt_1_quantity;
    
    IBOutlet UITextField *txt_2_machine;
    IBOutlet UITextField *txt_2_manufacture;
    IBOutlet UITextField *txt_2_quantity;
    
    IBOutlet UITextField *txt_3_machine;
    IBOutlet UITextField *txt_3_manufacture;
    IBOutlet UITextField *txt_3_quantity;
    
    IBOutlet UITextField *txt_4_machine;
    IBOutlet UITextField *txt_4_manufacture;
    IBOutlet UITextField *txt_4_quantity;
    
    IBOutlet UITextField *txt_5_machine;
    IBOutlet UITextField *txt_5_manufacture;
    IBOutlet UITextField *txt_5_quantity;
    
    
    IBOutlet UITextField *txt_6_machine;
    IBOutlet UITextField *txt_6_manufacture;
    IBOutlet UITextField *txt_6_quantity;
    
    IBOutlet UITextField *txt_7_machine;
    IBOutlet UITextField *txt_7_manufacture;
    IBOutlet UITextField *txt_7_quantity;
    
    IBOutlet UITextField *txt_8_machine;
    IBOutlet UITextField *txt_8_manufacture;
    IBOutlet UITextField *txt_8_quantity;
    
    IBOutlet UITextField *txt_9_machine;
    IBOutlet UITextField *txt_9_manufacture;
    IBOutlet UITextField *txt_9_quantity;
    
    IBOutlet UITextField *txt_10_machine;
    IBOutlet UITextField *txt_10_manufacture;
    IBOutlet UITextField *txt_10_quantity;
    
    IBOutlet UITextField *txt_1_serial;
    IBOutlet UITextField *txt_2_serial;
    IBOutlet UITextField *txt_3_serial;
    IBOutlet UITextField *txt_4_serial;
    IBOutlet UITextField *txt_5_serial;
    IBOutlet UITextField *txt_6_serial;
    IBOutlet UITextField *txt_7_serial;
    IBOutlet UITextField *txt_8_serial;
    IBOutlet UITextField *txt_9_serial;
    IBOutlet UITextField *txt_10_serial;

    IBOutlet UIButton *btn_1_serial;
    IBOutlet UIButton *btn_2_serial;
    IBOutlet UIButton *btn_3_serial;
    IBOutlet UIButton *btn_4_serial;
    IBOutlet UIButton *btn_5_serial;
    IBOutlet UIButton *btn_6_serial;
    IBOutlet UIButton *btn_7_serial;
    IBOutlet UIButton *btn_8_serial;
    IBOutlet UIButton *btn_9_serial;
    IBOutlet UIButton *btn_10_serial;
    
    IBOutlet UIView *view6;
    IBOutlet UIView *view7;
    IBOutlet UIView *view8;
    IBOutlet UIView *view9;
    IBOutlet UIView *view10;
    
    __weak IBOutlet UILabel *lbl_onHand1;
    __weak IBOutlet UILabel *lbl_available1;
    
    __weak IBOutlet UILabel *lbl_onHand2;
    __weak IBOutlet UILabel *lbl_available2;
    
    __weak IBOutlet UILabel *lbl_onHand3;
    __weak IBOutlet UILabel *lbl_available3;
    
    __weak IBOutlet UILabel *lbl_onHand4;
    __weak IBOutlet UILabel *lbl_available4;
    
    __weak IBOutlet UILabel *lbl_onHand5;
    __weak IBOutlet UILabel *lbl_available5;
    
    __weak IBOutlet UILabel *lbl_onHand6;
    __weak IBOutlet UILabel *lbl_available6;
    
    __weak IBOutlet UILabel *lbl_onHand7;
    __weak IBOutlet UILabel *lbl_available7;
    
    __weak IBOutlet UILabel *lbl_onHand8;
    __weak IBOutlet UILabel *lbl_available8;
    
    __weak IBOutlet UILabel *lbl_onHand9;
    __weak IBOutlet UILabel *lbl_available9;
    
    __weak IBOutlet UILabel *lbl_onHand10;
    __weak IBOutlet UILabel *lbl_available10;
    
    
    UIPopoverController *popoverCon;
    UIViewController *popoverViewCon;
    UITableViewController *dropdownsTableviewCon;
    
    NSMutableDictionary *dict_1;
    NSMutableDictionary *dict_2;
    NSMutableDictionary *dict_3;
    NSMutableDictionary *dict_4;
    NSMutableDictionary *dict_5;
    NSMutableDictionary *dict_6;
    NSMutableDictionary *dict_7;
    NSMutableDictionary *dict_8;
    NSMutableDictionary *dict_9;
    NSMutableDictionary *dict_10;

    NSMutableArray *arr_addedItems;

}

@property (strong, nonatomic) NSArray *arr_dropdown;
@property (strong, nonatomic) NSArray *arr_rt_machine_listing;
@property (strong, nonatomic) NSArray *arr_rt_serial_listing1;
@property (strong, nonatomic) NSArray *arr_rt_serial_listing2;
@property (strong, nonatomic) NSArray *arr_rt_serial_listing3;
@property (strong, nonatomic) NSArray *arr_rt_serial_listing4;
@property (strong, nonatomic) NSArray *arr_rt_serial_listing5;
@property (strong, nonatomic) NSArray *arr_rt_serial_listing6;
@property (strong, nonatomic) NSArray *arr_rt_serial_listing7;
@property (strong, nonatomic) NSArray *arr_rt_serial_listing8;
@property (strong, nonatomic) NSArray *arr_rt_serial_listing9;
@property (strong, nonatomic) NSArray *arr_rt_serial_listing10;


@end
