//
//  InventoryVC.h
//  RT APP
//
//  Created by Anil Prasad on 02/12/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InventoryVC : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UIButton *btn_serial;
    IBOutlet UIButton *btn_itemID;
    IBOutlet UIButton *btn_itemName;
    IBOutlet UIButton *btn_serialNo;
    IBOutlet UIButton *btn_status;
    IBOutlet UIButton *btn_patient;
    IBOutlet UIButton *btn_action;
    
    IBOutlet UITableView *table_inventory;
    IBOutlet UITableView *table_unserializedInventory;

    IBOutlet UIButton *btn_adjust;
    NSMutableArray *arr_serialized;
    NSMutableArray *arr_Unserialized;

    IBOutlet UILabel *lbl_serialNum;
    IBOutlet UILabel *lbl_status;
    IBOutlet UILabel *lbl_patient;
    IBOutlet UILabel *lbl_action;
    
    IBOutlet UIButton *refresh_btn;
    
    IBOutlet UIImageView *img_segment_bg;
    
}


@end
