//
//  SetupTicketModel.m
//  RT APP
//
//  Created by Anil Prasad on 24/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "SetupTicketModel.h"

@implementation SetupTicketModel


-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _arr_listing = dict[@"rt_ticket_listing"];
        
        _arr_rt_item_listing = dict[@"rt_item_listing"];
        
        _ticket_id = dict[@"ticket_id"];
        _ticket_status = dict[@"ticket_status"];
        _rt_id = dict[@"rt_id"];
        _pt_id = dict[@"pt_id"];
        _pt_first = dict[@"pt_first"];
        _pt_last = dict[@"pt_last"];
        _pt_gender = dict[@"pt_gender"];
        _pt_spanish = [dict[@"pt_spanish"] boolValue];
        _pt_add = dict[@"pt_add"];
        _pt_city = dict[@"pt_city"];
        _pt_state = dict[@"pt_state"];
        _pt_zip = dict[@"pt_zip"];
        _pt_home = dict[@"pt_home"];
        _pt_cell = dict[@"pt_cell"];
        _pt_work = dict[@"pt_work"];
        _pt_email = dict[@"pt_email"];
        _cpap_machine = dict[@"cpap_machine"];
        _cpap = [dict[@"cpap"] boolValue];
        _bi_level = dict[@"bi_level"];
        _cpap_manufacturer = dict[@"cpap_manufacturer"];
        _cpap_model = dict[@"cpap_model"];
        _cpap_serial = dict[@"cpap_serial"];
        _cpap_cm = dict[@"cpap_cm"];
        _cpap_ramp_time = dict[@"cpap_ramp_time"];
        _cpap_backup_rate = dict[@"cpap_backup_rate"];
        _modem = dict[@"modem"];
        _modem_type = dict[@"modem_type"];
        _modem_serial = dict[@"modem_serial"];
        _hum_modem = dict[@"hum_modem"];
        _hum_manufacturer = dict[@"hum_manufacturer"];
        _hum_serial = dict[@"hum_serial"];
        _mask = dict[@"mask"];
        _mask_type = dict[@"mask_type"];
        _mask_name = dict[@"mask_name"];
        _mask_id = dict[@"mask_id"];
        _initials1 = dict[@"initials1"];
        _initials2 = dict[@"initials2"];
        _initials3 = dict[@"initials3"];
        _signature = dict[@"signature"];
        _date = [dict[@"date"] date];
        _first_name = dict[@"first_name"];
        _last_name = dict[@"last_name"];
        _address = dict[@"address"];
        _city = dict[@"city"];
        _state = dict[@"state"];
        _zip = dict[@"zip"];
        _home_phone = dict[@"home_phone"];
        _email = dict[@"email"];
        _care_first = dict[@"care_first"];
        _care_last = dict[@"care_last"];
        _care_address = dict[@"care_address"];
        _care_city = dict[@"care_city"];
        _care_state = dict[@"care_state"];
        _care_zip = dict[@"care_zip"];
        _care_phone = dict[@"care_phone"];
        _care_email = dict[@"care_email"];
        _Pt_State = dict[@"Pt_State"];
        _Dr_First = dict[@"Dr_First"];
        _Dr_Last = dict[@"Dr_Last"];
        _fac_name = dict[@"fac_name"];
    }
    return self;
}


@end
