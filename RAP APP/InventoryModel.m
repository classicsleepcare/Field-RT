//
//  InventoryModel.m
//  RT APP
//
//  Created by Anil Prasad on 23/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "InventoryModel.h"

@implementation InventoryModel

-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _msg                = dict[@"msg"];
        _ticket_id          = dict[@"ticket_id"];

        _dictionary         = dict[@"inventory_on_hand"];
        _arr_serialized     = _dictionary[@"serialized"];
        _arr_unSerialized   = _dictionary[@"unserialized"];
    }
    return self;
}


@end
