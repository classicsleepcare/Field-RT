//
//  OrdersAndTransfersVC.h
//  RT APP
//
//  Created by Anil Prasad on 02/12/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrdersAndTransfersVC : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    IBOutlet UITableView *ordersTable;
    IBOutlet UITableView *transfersTable;
    
    NSArray *arr_orders;
    NSArray *arr_transfers;
    
    IBOutlet UIButton *btn_newTransfer;
    
    IBOutlet UILabel *lbl_header;
    
    IBOutlet UIImageView *img_segment_bg;
    
    NSArray *arr_rt_transfer_listing;
    NSArray *arr_rt_order_listing;

}




@end
