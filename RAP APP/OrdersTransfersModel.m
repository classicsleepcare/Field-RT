//
//  OrdersTransfersModel.m
//  RT APP
//
//  Created by Anil Prasad on 11/02/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "OrdersTransfersModel.h"

@implementation OrdersTransfersModel

-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _arr_rt_transfer_listing = dict[@"rt_transfer_listing"];
        _arr_rt_order_listing = dict[@"rt_order_listing"];
        
        _msg = dict[@"msg"];
        
    }
    return self;
}

@end
