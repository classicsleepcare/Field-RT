//
//  TicketFormModel.m
//  RT APP
//
//  Created by Anil Prasad on 30/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "TicketFormModel.h"

@implementation TicketFormModel


-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _msg                            = dict[@"msg"];
        _ticket_id                      = dict[@"ticket_id"];
        _arr_rt_item_listing            = dict[@"rt_item_listing"];
        _arr_rt_adtnl_item_listing      = dict[@"rt_adtnl_item_listing"];
        _arr_rt_discarded_item_listing  = dict[@"rt_discarded_item_listing"];
        _arr_rt_listing                 = dict[@"rt_listing"];
        _arr_rt_patient_listing         = dict[@"rt_patient_listing"];
        _serial_number                  = dict[@"serial_number"];
        _arr_rt_serial_numbers          = dict[@"serial_number"];
        
        _arr_rt_vendor_listing          = dict[@"rt_vendor_listing"];
        _arr_rt_machines_listing        = dict[@"rt_machine_listing"];      // new
        _arr_rt_humidifier_listing      = dict[@"rt_humidifier_listing"];   // new
        _arr_rt_modem_listing           = dict[@"rt_modem_listing"];        // new
        _arr_rt_supply_listing          = dict[@"item_supply_list"];        // new
        
        _arr_rt_new_machines_listing    = dict[@"rt_machine_listing"];
        _arr_rt_mask_listing            = dict[@"rt_mask_listing"];
        _arr_inventory_on_hand          = dict[@"inventory_on_hand"];

    }
    return self;
}
@end
