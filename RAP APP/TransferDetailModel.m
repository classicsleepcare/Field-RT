//
//  TransferDetailModel.m
//  RT APP
//
//  Created by Anil Prasad on 21/02/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "TransferDetailModel.h"

@implementation TransferDetailModel

-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _dict_rt_transfer_detail    = dict[@"rt_transfer_detail"];
        _arr_items_receiving        = _dict_rt_transfer_detail[@"items_receiving"];
        _from_location              = _dict_rt_transfer_detail[@"from_location"];
        _msg                        = dict[@"msg"];
        _transfer_id                = _dict_rt_transfer_detail[@"id"];
        
        
        
    }
    return self;
}


@end
