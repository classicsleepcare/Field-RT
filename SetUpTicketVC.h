//
//  SetUpTicketVC.h
//  RT APP
//
//  Created by Anil Prasad on 02/12/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewSetups.h"
#import "SetAppointment.h"

@interface SetUpTicketVC : UIViewController{
    
    IBOutlet UIButton *btn_serial;
    IBOutlet UIButton *btn_patientID;
    IBOutlet UIButton *btn_patientName;
    IBOutlet UIButton *btn_facility;
    IBOutlet UIButton *btn_state;
    IBOutlet UIButton *btn_doctor;
    IBOutlet UIButton *btn_dateCreated;
    
    IBOutlet UITableView *table_setupTicket;
    NSArray *arr_setupTicket;
    
    IBOutlet UIImageView *img_segment_bg;
    
}



@end


@interface bbc:NSObject


@end