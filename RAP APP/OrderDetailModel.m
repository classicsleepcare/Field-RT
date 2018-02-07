//
//  OrderDetailModel.m
//  RT APP
//
//  Created by Anil Prasad on 21/02/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "OrderDetailModel.h"

@implementation OrderDetailModel

-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _dict_rt_order_detail   = dict[@"rt_order_detail"];
        _arr_items_receiving    = _dict_rt_order_detail[@"items_receiving"];
        _from_location          = _dict_rt_order_detail[@"from_location"];
        _msg                    = dict[@"msg"];
        _transfer_id            = _dict_rt_order_detail[@"id"];
        _pt_notes               = _dict_rt_order_detail[@"pt_notes"];
        
        _date_shipped           = _dict_rt_order_detail[@"date_shipped"];
        _status                 = _dict_rt_order_detail[@"status"];
        

    }
    return self;
}

@end
