//
//  HistoryVC.m
//  RT APP
//
//  Created by Anil Prasad on 14/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "HistoryVC.h"
#import "HistoryCell.h"
#import "HistoryView.h"
#import "HistoryModel.h"

#define BLUE_COLOR [UIColor colorWithRed:22.0/255.0 green:125.0/255.0 blue:164.0/255.0 alpha:1.0]
#define WHITE_COLOR [UIColor whiteColor]

@interface HistoryVC (){
    HistoryView *object_SV;
}

@end

@implementation HistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self callWebserviceForHistoryItems];
}

-(void)callWebserviceForHistoryItems{
    object_SV = [HistoryView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("history", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        
        NSDictionary *dict =[object_SV getAllHistroyItemsOfId:RT_ID ];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            if(dict)
            {
                HistoryModel *object_SM = [[HistoryModel alloc] initWithDictionary:dict];
                
                if ([object_SM.msg isEqualToString:@"no records"]) {
                    [[AppDelegate sharedInstance] showAlertMessage:@"No Record(s) found!"];
                }
                arr_patient_list = object_SM.arr_patient_list;
                NSMutableArray *arr_temp_patient_list = [[self sortedDictionaryByNames:arr_patient_list :@"Setup Date" ascending:NO] mutableCopy];
                arr_patient_list = arr_temp_patient_list;
                
                [table_history reloadData];
                //[self detailListResponseObject:object_SM];
            }
        });
    });
}
#pragma mark - Sorting Methods

-(IBAction)sortByFirstName{
    
    if (ascendingFirstName) {
        ascendingFirstName = NO;
        [btn_firstName setBackgroundColor:[UIColor clearColor]];
        [btn_firstName setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       
    }
    else{
        ascendingFirstName = YES;
        [btn_firstName setBackgroundColor:BLUE_COLOR];
        [btn_firstName setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    }
    
    NSMutableArray *arr_temp_patient_list = [[self sortedDictionaryByNames:arr_patient_list :@"FIRST NAME" ascending:ascendingFirstName] mutableCopy];
    arr_patient_list = arr_temp_patient_list;
    [table_history reloadData];
    
}

-(IBAction)sortByLastName{
    if (ascendingLastName) {
        ascendingLastName = NO;
        [btn_lastName setBackgroundColor:[UIColor clearColor]];
        [btn_lastName setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else{
        ascendingLastName = YES;
        [btn_lastName setBackgroundColor:BLUE_COLOR];
        [btn_lastName setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
       
    }
    
    NSMutableArray *arr_temp_patient_list = [[self sortedDictionaryByNames:arr_patient_list :@"LAST NAME" ascending:ascendingLastName] mutableCopy];
    arr_patient_list = arr_temp_patient_list;
    [table_history reloadData];
}

-(NSArray*)sortedDictionaryByNames :(NSArray*)array :(NSString*)key ascending:(BOOL)asd
{
    NSArray *sortedArray;
    NSSortDescriptor*cityDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:asd];
    NSArray* sortDescriptors = [NSArray arrayWithObject:cityDescriptor];
    sortedArray = [array sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedArray;
}

#pragma mark - UITableView Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_patient_list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"HistoryVC";
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
    [cell customizeLabelInCell];
    
    NSDictionary *cellDict              = [arr_patient_list objectAtIndex:indexPath.row];

    cell.lblh_serial.text = [NSString stringWithFormat:@"%d", indexPath.row+1];
    cell.lblh_lastName.text = cellDict[@"LAST NAME"];
    cell.lblh_firstName.text = cellDict[@"FIRST NAME"];
    cell.lblh_appDate.text = cellDict[@"App.Date"];
    cell.lblh_setupDate.text = cellDict[@"Setup Date"];
    cell.lblh_doctor.text = cellDict[@"Doctor"];
    cell.lblh_status.text = cellDict[@"Status"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33;
}

@end
