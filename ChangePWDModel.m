//
//  ChangePWDModel.m
//  RAP APP
//
//  Created by prashant sharma on 9/4/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "ChangePWDModel.h"

@implementation ChangePWDModel

-(id)initWithDetailsOfChangePWD:(NSDictionary *)dicit
{
    self=[super init];
    if (self)
    {
        _mesg=dicit[@"msg"];
    }
    return self;
    
}


@end
