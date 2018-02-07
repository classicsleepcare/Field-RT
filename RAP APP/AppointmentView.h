//
//  AppointmentView.h
//  RT APP
//
//  Created by Farisolusa on 6/18/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppointmentView : NSObject


{
    NSDictionary *dictionary;
}

-(NSDictionary*)updateNewRecordWithRTId:(NSString*)RTID
                                  pt_id:(NSString*)pt_id
                                  notes:(NSString*)notes
                                   date:(NSString*)date
                                     hr:(NSString*)hr
                                    min:(NSString*)min
                              time_type:(NSString*)time_type;

-(NSDictionary*)updateOldRecordWithRTId:(NSString*)RTID
                                 apt_id:(NSString*)apt_id
                                  pt_id:(NSString*)pt_id
                                  notes:(NSString*)notes
                                   date:(NSString*)date
                                     hr:(NSString*)hr
                                    min:(NSString*)min
                              time_type:(NSString*)time_type;

-(NSDictionary*)viewAppointment:(NSString*)apt_id;

@end
