//
//  NIVTIcketModel.m
//  RT APP
//
//  Created by Anil Prasad on 12/5/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import "NIVTIcketModel.h"

@implementation NIVTIcketModel

-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _msg = dict[@"msg"];
        _error = dict[@"error"];
        
        _arr_rt_vendor_listing          = dict[@"rt_vendor_listing"];
        _arr_rt_machines_listing        = dict[@"rt_machine_listing"];      
        _arr_rt_heater_listing          = dict[@"rt_humidifier_listing"]; // check correct tag name from API for heater
        _arr_rt_modem_listing           = dict[@"rt_modem_listing"];
        _arr_rt_supply_listing          = dict[@"item_supply_list"];
        _arr_rt_mask_listing            = dict[@"rt_mask_listing"];
        _arr_rt_serial_numbers          = dict[@"serial_number"];

    }
    return self;
}

@end
