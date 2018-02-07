//
//  HistoryVC.h
//  RT APP
//
//  Created by Anil Prasad on 14/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryVC : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UITableView *table_history;
    
    NSArray *arr_patient_list;
    IBOutlet UIButton *btn_firstName;
    IBOutlet UIButton *btn_lastName;
    BOOL ascendingFirstName;
    BOOL ascendingLastName;
}

@end
