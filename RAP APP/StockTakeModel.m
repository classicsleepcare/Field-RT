//
//  StockTakeModel.m
//  RT APP
//
//  Created by Anil Prasad on 24/09/15.
//  Copyright © 2015 Anil Prasad. All rights reserved.
//

#import "StockTakeModel.h"

@implementation StockTakeModel

-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _msg = dict[@"msg"];
        
    }
    return self;
}

@end
