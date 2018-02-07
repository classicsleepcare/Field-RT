//
//  TransfersVC.h
//  RT APP
//
//  Created by Anil Prasad on 09/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransfersVC : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *transfersTable;
    
    IBOutlet UIScrollView *d_scrollView;
    NSMutableArray *arr_transferDetails;
    
    NSString *from_Id;
    NSString *transfer_id;
    
    IBOutlet UILabel *lbl_notes;
    IBOutlet UILabel *lbl_items_receiving;
    IBOutlet UILabel *lbl_date;
    IBOutlet UILabel *lbl_transfer_id;

}

@property (strong, nonatomic) NSString *transfer_ID;
@property (strong, nonatomic) NSString *notes;
@property (strong, nonatomic) NSString *items_receiving;
@property (strong, nonatomic) NSString *date;


@end
