//
//  TransfersVC.m
//  RT APP
//
//  Created by Anil Prasad on 09/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "TransfersVC.h"
#import "HistoryCell.h"
#import "TransferDetailView.h"
#import "TransferDetailModel.h"


@interface TransfersVC (){
    TransferDetailView *object_OV;
}

@end

@implementation TransfersVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self callWebServiceForTransfersDetails];
}

-(void)callWebServiceForTransfersDetails{
    object_OV = [TransferDetailView new];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Orders", 0);
    
    [[AppDelegate sharedInstance] showCustomLoader:self];
    dispatch_async(myQueue, ^{
        NSDictionary *dict =[object_OV getTransferDetailsOfRT:RT_ID transferID:self.transfer_ID];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[AppDelegate sharedInstance] removeCustomLoader];
            
            
            if(dict)
            {
                TransferDetailModel *object_OM = [[TransferDetailModel alloc] initWithDictionary:dict];
                if ([object_OM.msg isEqualToString:@"records not found"]) {
                    [[AppDelegate sharedInstance] showAlertMessage:@"No Orders available yet"];
                }
                else{
                    from_Id                     = object_OM.from_location;
                    transfer_id                 = object_OM.transfer_id;
                    arr_transferDetails         = [object_OM.arr_items_receiving mutableCopy];
                    lbl_transfer_id.text        = transfer_id;
                    lbl_notes.text              = self.notes;
                    lbl_items_receiving.text    = self.items_receiving;
                    lbl_date.text               = self.date;
                    
                    [transfersTable reloadData];
                }
            }
        });
    });
}


-(IBAction)actionForButton:(UIButton*)sender{
    switch (sender.tag) {
        case 11:{
            
        }
            break;
        case 12:{
            
        }
            break;
        case 13:{
            [self.navigationController popViewControllerAnimated:NO];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UITableView Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  arr_transferDetails.count;;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"TransferDetail";
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    [cell customizeLabelInCell];
    
    
    cell.lbltd_serial.text          = [NSString stringWithFormat:@"%d", indexPath.row+1];
    cell.lbltd_itemID.text          = arr_transferDetails[indexPath.row][@"item_id"];
    cell.lbltd_itemName.text        = arr_transferDetails[indexPath.row][@"item_name"];
    cell.lbltd_serialNum.text       = arr_transferDetails[indexPath.row][@"serial_number"];
    cell.lbltd_qtyTransferred.text  = arr_transferDetails[indexPath.row][@"quantity"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33;
}


@end
