//
//  MaskVC.h
//  RT APP
//
//  Created by Anil Prasad on 21/09/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketFormView.h"
#import "TicketFormModel.h"

@interface MaskVC : UIViewController<UIPopoverControllerDelegate,UITableViewDataSource,UITableViewDelegate, UIAlertViewDelegate>{
    IBOutlet UITableView *table_MaskVC;
    
    TicketFormView *object_TV;
    IBOutlet UIScrollView *d_scrollView;
    
    int tagNum;
    CGPoint d_point;
    UITextField *universalTextField;
    
    IBOutlet UIButton *btn_addMore;
    IBOutlet UIButton *btn_submit;

    IBOutlet UITextField *txt_1_mask;
    IBOutlet UITextField *txt_1_type;
    IBOutlet UITextField *txt_1_quantity;
    
    IBOutlet UITextField *txt_2_mask;
    IBOutlet UITextField *txt_2_type;
    IBOutlet UITextField *txt_2_quantity;
    
    IBOutlet UITextField *txt_3_mask;
    IBOutlet UITextField *txt_3_type;
    IBOutlet UITextField *txt_3_quantity;
    
    IBOutlet UITextField *txt_4_mask;
    IBOutlet UITextField *txt_4_type;
    IBOutlet UITextField *txt_4_quantity;
    
    IBOutlet UITextField *txt_5_mask;
    IBOutlet UITextField *txt_5_type;
    IBOutlet UITextField *txt_5_quantity;
    
    
    IBOutlet UITextField *txt_6_mask;
    IBOutlet UITextField *txt_6_type;
    IBOutlet UITextField *txt_6_quantity;
    
    IBOutlet UITextField *txt_7_mask;
    IBOutlet UITextField *txt_7_type;
    IBOutlet UITextField *txt_7_quantity;
    
    IBOutlet UITextField *txt_8_mask;
    IBOutlet UITextField *txt_8_type;
    IBOutlet UITextField *txt_8_quantity;
    
    IBOutlet UITextField *txt_9_mask;
    IBOutlet UITextField *txt_9_type;
    IBOutlet UITextField *txt_9_quantity;
    
    IBOutlet UITextField *txt_10_mask;
    IBOutlet UITextField *txt_10_type;
    IBOutlet UITextField *txt_10_quantity;
    
    IBOutlet UIView *view6;
    IBOutlet UIView *view7;
    IBOutlet UIView *view8;
    IBOutlet UIView *view9;
    IBOutlet UIView *view10;
    
    
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
@property (strong, nonatomic) NSArray *arr_rt_mask_listing;
@property (strong, nonatomic) NSString *json_humidifiers;
@property (strong, nonatomic) NSString *json_machines;
@property (strong, nonatomic) NSString *json_modem;


@end
