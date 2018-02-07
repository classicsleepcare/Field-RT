//
//  FormOneModel.m
//  RT APP
//
//  Created by Anil Prasad on 03/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "FormOneModel.h"

@implementation FormOneModel


-(id)initWithDictionary:(NSDictionary *)dict // TO BE CHANGED WITH ACTUAL KEYS
{
    self= [super init];
    _itemID     = dict[@"itemID"];
    _itemType   = dict[@"code"];
    _itemName   = dict[@"name"];
    _quantity   = dict[@"quantity"];
    _size       = dict[@"size"];
    _notes      = dict[@"notes"];

    return self;
}

@end
