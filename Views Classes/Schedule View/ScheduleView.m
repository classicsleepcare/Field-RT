//
//  ScheduleView.m
//  RAP APP
//
//  Created by Anil Prasad on 5/3/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "ScheduleView.h"

@implementation ScheduleView
-(NSDictionary *)getHistoryListFromDayForID:(NSString*)str_id FromDate:(NSString *)fromDate LastDate:(NSString *)lastDate
{
    
    dictionary=nil;
    
    
    NSString *urlString = [NSString stringWithFormat:url_schedule,str_id,fromDate,lastDate];
    

    [WebserviceClass getParseDataFromUrl:urlString :^(id result, NSError *error)
     {
         if (error) {
             dictionary =nil;
         }
         else
         {
             dictionary= result;
         }
     }];
    
    
    return dictionary;
    
    
}
@end
