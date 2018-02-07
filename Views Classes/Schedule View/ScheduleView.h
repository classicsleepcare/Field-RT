//
//  ScheduleView.h
//  RAP APP
//
//  Created by Anil Prasad on 5/3/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduleView : NSObject
{
    NSDictionary *dictionary;
}
-(NSDictionary *)getHistoryListFromDayForID:(NSString*)str_id FromDate:(NSString *)fromDate LastDate:(NSString *)lastDate;
@end
