//
//  StatsModel.h
//  RAP APP
//
//  Created by Anil Prasad on 5/1/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatsModel : NSObject
{
    
}
@property(nonatomic,strong)NSArray *arr_dateInfo;

+(StatsModel*)getObjectFromDictionary :(NSDictionary*)dict andDate:(NSString*)date;
+(StatsModel *)getObjectFromDictionary:(NSDictionary *)dict forMonth:(NSString*)month;
@end



@interface StatsModelKeys : NSObject

@property(nonatomic,strong)NSString* str_Total_Ref;
@property(nonatomic,strong)NSString* str_Total_App;
@property(nonatomic,strong)NSString* str_Total_Den;
@property(nonatomic,strong)NSString* str_Total_SU;



@property(nonatomic,weak) StatsModel *model;
+(StatsModelKeys*)getKeyValueFromDictionary :(NSDictionary*)dict;

@end

/*
 
 "Total_Ref_Count":21,
 "Total_App_Count":15,
 "Total_Den_Count":5,
 "Total_SU_Count":14
 
 */