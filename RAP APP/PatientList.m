//
//  PatientList.m
//  RAP APP
//
//  Created by Anil Prasad on 4/14/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "PatientList.h"

@implementation PatientList
{}

-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _arr_main = dict[@"listing"];
    
           }
    return self;
}
-(id)initDetailListWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _arr_drList = dict[@"dr"];
        _arr_statusList = dict[@"Status"];
        _arr_PrimaryList = dict[@"Pri_Ins"];
        _arr_drFacility = dict[@"Dr_Facility"];
    }
    return self;
}
//-(NSArray*)sortedDictionariesFromArray:(NSArray*)array
//{
////    NSArray *sortedArray;
//////    NSSortDescriptor*IDDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Pt_ID" ascending:YES];
//////    NSArray* sortDescriptors = [NSArray arrayWithObject:IDDescriptor];
////    sortedArray = [array sortedArrayUsingDescriptors:sortDescriptors];
////    return sortedArray;
//}
@end
