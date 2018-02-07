//
//  NewSetups.m
//  RT APP
//
//  Created by Farisolusa on 6/8/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "NewSetups.h"

@interface NewSetups ()

@end

@implementation NewSetups
@synthesize arr_setups;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(IBAction)actionForButton:(UIButton*)sender{
    switch (sender.tag) {
        case 50:{
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        default:
            break;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == table_newSetups) return arr_setups.count;
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"NewSetups";
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    [cell customizeLabelInCell];
    
    cell.backgroundView = nil;
    
    NSDictionary *dict          = [arr_setups objectAtIndex:indexPath.row];
    cell.lbs_serial.text        = [NSString stringWithFormat:@"%d", indexPath.row+1];
    cell.lbs_first.text         = dict[@"pt_first"];
    cell.lbs_last.text          = dict[@"pt_last"];
    cell.lbs_phone.text         = dict[@"pt_cell"];
    
//    cell.bt_patientName.tag     = indexPath.row;
//    [cell.bt_patientName addTarget:self action:@selector(showPatientInformation:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33;
}





@end
