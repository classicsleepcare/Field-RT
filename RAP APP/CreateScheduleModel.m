//
//  CreateScheduleModel.m
//  RT APP
//
//  Created by Anil Prasad on 24/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "CreateScheduleModel.h"

@implementation CreateScheduleModel

-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _arr_listing = dict[@"rt_patient_listing"];
        _arr_patientListing = dict[@"listing"];
        
        _msg = dict[@"msg"];
       
    }
    return self;
}


@end
