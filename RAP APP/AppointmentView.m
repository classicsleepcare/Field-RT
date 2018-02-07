//
//  AppointmentView.m
//  RT APP
//
//  Created by Farisolusa on 6/18/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "AppointmentView.h"

@implementation AppointmentView

-(NSDictionary*)updateNewRecordWithRTId:(NSString*)RTID
                                  pt_id:(NSString*)pt_id
                                  notes:(NSString*)notes
                                   date:(NSString*)date
                                     hr:(NSString*)hr
                                    min:(NSString*)min
                              time_type:(NSString*)time_type{
    
    dictionary = nil;
    
    NSString *urlString = [NSString stringWithFormat:url_setAppointment1, pt_id, RTID, notes, date, hr, min, time_type];
    
    
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

-(NSDictionary*)updateOldRecordWithRTId:(NSString*)RTID
                                 apt_id:(NSString*)apt_id
                                  pt_id:(NSString*)pt_id
                                  notes:(NSString*)notes
                                   date:(NSString*)date
                                     hr:(NSString*)hr
                                    min:(NSString*)min
                              time_type:(NSString*)time_type{
    
    dictionary = nil;
    
    NSString *urlString = [NSString stringWithFormat:url_setAppointment1, pt_id, RTID, notes, date, hr, min, time_type];
    
    
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

-(NSDictionary*)viewAppointment:(NSString*)apt_id{
    dictionary = nil;
    
    NSString *urlString = [NSString stringWithFormat:url_viewAppointment1, apt_id];
    
    
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
