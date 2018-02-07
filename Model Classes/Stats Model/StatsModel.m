//
//  StatsModel.m
//  RAP APP
//
//  Created by Anil Prasad on 5/1/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "StatsModel.h"

@implementation StatsModel

+(StatsModel *)getObjectFromDictionary:(NSDictionary *)dict andDate:(NSString *)date
{
    StatsModel *modelObj = [[self alloc] init];
    NSMutableArray *arr_monthInfo = [NSMutableArray array];
   
    
    NSDictionary *mdict = dict[@"monthly_tally"];
    
    StatsModelKeys *modelKeys = [StatsModelKeys getKeyValueFromDictionary :mdict[date]];
    
    [arr_monthInfo addObject:modelKeys];
    modelObj.arr_dateInfo= arr_monthInfo;
    modelKeys.model=modelObj;
    
    
    
    return modelObj;
    
}
+(StatsModel *)getObjectFromDictionary:(NSDictionary *)dict forMonth:(NSString*)month
{
    NSMutableArray *arr_monthInfo = [NSMutableArray array];
    StatsModel *modelObj = [[self alloc] init];
    
    
    NSDictionary *mdict = dict[@"annual_tally"];
    
    StatsModelKeys *modelKeys = [StatsModelKeys getKeyValueFromDictionary :mdict[month]];
    
    [arr_monthInfo addObject:modelKeys];
    modelObj.arr_dateInfo= arr_monthInfo;
    modelKeys.model=modelObj;
    
    
    
    return modelObj;
    
}

@end


@implementation StatsModelKeys

+(StatsModelKeys *)getKeyValueFromDictionary:(NSDictionary *)dict
{
    StatsModelKeys *modelKeyObj = [[self alloc] init];
    modelKeyObj.str_Total_App = dict[@"Total_App"];
    modelKeyObj.str_Total_Den = dict[@"Total_Den"];
    modelKeyObj.str_Total_Ref = dict[@"Total_Ref"];
    modelKeyObj.str_Total_SU = dict[@"Total_SU"];
   
    return modelKeyObj;
}
/*
 
 "Total_App_Count" = 0;
 "Total_Den_Count" = 0;
 "Total_NSU_O_Count" = 0;
 "Total_NSU_U_Count" = 0;
 "Total_Ref_Count" = 0;
 "Total_SU_Count" = 0;
 */
@end
