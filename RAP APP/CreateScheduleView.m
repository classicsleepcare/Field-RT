//
//  CreateScheduleView.m
//  RT APP
//
//  Created by Anil Prasad on 24/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "CreateScheduleView.h"

@implementation CreateScheduleView


-(NSDictionary*)getListOfPatientWithRTID:(NSString*)ID
{
    dictionary = nil;
    
    NSString *urlString = [NSString stringWithFormat:url_rtPatientList, ID];
    
    
    [WebserviceClass getParseDataFromUrl:urlString :^(id result, NSError *error)
     {
         if (error) {
             dictionary = nil;
         }
         else
         {
             dictionary = result;
         }
     }];
    
    return dictionary;
}

-(NSDictionary*)getListingsOfPatient:(NSString*)patientID{
    
    dictionary = nil;
    
    NSString *urlString = [NSString stringWithFormat:url_scheduleDetails, patientID];
    
    
    [WebserviceClass getParseDataFromUrl:urlString :^(id result, NSError *error)
     {
         if (error) {
             dictionary = nil;
         }
         else
         {
             dictionary = result;
         }
     }];
    
    return dictionary;
}

-(NSDictionary*)updateNewRecordWithId:(NSString*)ID
                                 date:(NSString*)date
                                 hour:(NSString*)hour
                                  min:(NSString*)min
                             timeType:(NSString*)timeType
                                 type:(NSString*)type
                                notes:(NSString*)notes{
    
    dictionary = nil;
    
    NSString *urlString = [NSString stringWithFormat:url_updateSchedule, ID, date, hour, min, timeType, type, notes];
    
    
    [WebserviceClass getParseDataFromUrl:urlString :^(id result, NSError *error)
     {
         if (error) {
             dictionary = nil;
         }
         else
         {
             dictionary = result;
         }
     }];
    
    return dictionary;
}

@end
