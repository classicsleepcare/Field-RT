//
//  ScheduleModel.m
//  RAP APP
//
//  Created by Anil Prasad on 5/3/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "ScheduleModel.h"

@implementation ScheduleModel

-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _arr_Listing = dict[@"listing"];
        _arr_scedule= dict[@"schedule"];
        _str_msg= dict[@"msg"];
    }
    return self;
}
@end
