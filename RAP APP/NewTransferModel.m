//
//  NewTransferModel.m
//  RT APP
//
//  Created by Anil Prasad on 21/02/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "NewTransferModel.h"


@implementation NewTransferModel

-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _arr_inventory_on_hand  = dict[@"inventory_on_hand"];
        _arr_rt_transfer_listing= dict[@"rt_transfer_listing"];
        _msg                    = dict[@"msg"];
        
    }
    return self;
}

@end
