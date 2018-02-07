//
//  DoctorListModel.m
//  RAP APP
//
//  Created by Anil Prasad on 4/12/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "DoctorListModel.h"

@implementation DoctorListModel
{
    
}


-(id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
       _arr_main = dict[@"listing"];
        _arr_main = [self sortedDictionaryByNames:_arr_main];
//        [_arr_main enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            
//        }];
    
    }
    return self;
}
-(NSArray*)sortedDictionaryByNames :(NSArray*)array
{
    NSArray *sortedArray;
    NSSortDescriptor*cityDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Dr_Last" ascending:YES];
    NSArray* sortDescriptors = [NSArray arrayWithObject:cityDescriptor];
    sortedArray = [array sortedArrayUsingDescriptors:sortDescriptors];
    return sortedArray;
    
   
}
-(NSArray*)sortedDictionariesFromArray:(NSArray*)array
{
    NSArray *sortedArray;
    NSSortDescriptor*cityDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Dr_City" ascending:YES];
   NSArray* sortDescriptors = [NSArray arrayWithObject:cityDescriptor];
    sortedArray = [array sortedArrayUsingDescriptors:sortDescriptors];
    return sortedArray;
}


@end
