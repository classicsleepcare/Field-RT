//
//  SearchPatientViewController.h
//  RAP APP
//
//  Created by Anil Prasad on 4/22/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchPatientViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    IBOutlet UILabel *lbl_patientCount;
}

@property(strong,nonatomic)NSArray *arr_searchedPatientList;

-(void)getTextFromTextField:(NSString*)text;

-(IBAction)backButtonMethod:(id)sender;
@end
