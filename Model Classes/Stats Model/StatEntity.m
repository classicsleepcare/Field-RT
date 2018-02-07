//
//  StatEntity.m
//  RAP APP
//
//  Created by Anil Prasad on 5/1/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "StatEntity.h"

@implementation StatEntity


+(StatEntity *) getObjectUsingInfo:(NSDictionary *)dictInfo
{
    NSString *keyTitle = [[dictInfo allKeys] lastObject];
    StatEntity *entity = [[self alloc] init];
    entity.str_entityTitle = keyTitle;
    entity.arr_entityRows = [NSMutableArray array];
    
    NSDictionary *attr_dict = [dictInfo objectForKey:keyTitle];
    
    for (NSString *key in attr_dict) {
        
        NSDictionary *rowDict = @{key:[attr_dict objectForKey:key]};
        StatEntityRow *entityRow = [StatEntityRow getObjectUsingInfo:rowDict];
        
        if ([key isEqualToString:@"mtd"])
        {
            [entity.arr_entityRows insertObject:entityRow atIndex:0];
        }
        else[entity.arr_entityRows insertObject:entityRow atIndex:1];
        
        entityRow.attributeEntity = entity;
    }
    
    return entity;
}
-(id)initWithResponseUsingInfo:(NSDictionary *)dictInfo
{
    self = [super init];
    if (self)
    {
        _arr_source = dictInfo[@"ref_src"];
    }
    return self;
}

@end


@implementation StatEntityRow

+(StatEntityRow *) getObjectUsingInfo:(NSDictionary *)dictInfo
{
    NSString *titleRow = [[dictInfo allKeys] lastObject];
    NSDictionary *att_dict = [dictInfo objectForKey:titleRow];
    
    StatEntityRow *row = [[self alloc] init];
    row.str_rowTitle = titleRow;
    row.str_setup = att_dict[@"setup"];
    row.str_approved = att_dict[@"approved"];
    row.str_denied = att_dict[@"denied"];
    row.str_referred = att_dict[@"referred"];
    row.str_nsu = att_dict[@"nsu"];
    row.str_supply = att_dict[@"supplies"];
    
    return row;
}

@end