//
//  AppointmentModel.m
//  RT APP
//
//  Created by Anil Prasad on 6/18/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "AppointmentModel.h"

@implementation AppointmentModel

-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _dict_rt_appointment_details    = dict[@"rt_appointment_details"];
        _arr_rt_listing                 = dict[@"listing"];
        _dict_rt_listing_details        = _arr_rt_listing[0];
        _msg                            = dict[@"msg"];
        
    }
    return self;
}

@end
