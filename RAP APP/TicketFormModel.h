//
//  TicketFormModel.h
//  RT APP
//
//  Created by Anil Prasad on 30/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketFormModel : NSObject

@property (strong, nonatomic) NSArray *arr_rt_item_listing, *arr_rt_adtnl_item_listing, *arr_rt_discarded_item_listing;

@property (strong, nonatomic) NSArray *arr_rt_listing;
@property (strong, nonatomic) NSArray *arr_rt_patient_listing;
@property (strong, nonatomic) NSArray *arr_rt_machines_listing;
@property (strong, nonatomic) NSArray *arr_rt_new_machines_listing;
@property (strong, nonatomic) NSArray *arr_rt_mask_listing;
@property (strong, nonatomic) NSArray *arr_rt_modem_listing;
@property (strong, nonatomic) NSArray *arr_rt_humidifier_listing;
@property (strong, nonatomic) NSArray *arr_rt_vendor_listing;
@property (strong, nonatomic) NSArray *arr_rt_supply_listing;
@property (strong, nonatomic) NSArray *arr_rt_serial_numbers;
@property (strong, nonatomic) NSArray *arr_inventory_on_hand;

@property (strong, nonatomic) NSString *serial_number;
@property (strong, nonatomic) NSString *msg;
@property (strong, nonatomic) NSString *ticket_id;



-(id)initWithDictionary:(NSDictionary *)dict;

@end
