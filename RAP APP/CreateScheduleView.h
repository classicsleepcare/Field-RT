//
//  CreateScheduleView.h
//  RT APP
//
//  Created by Anil Prasad on 24/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreateScheduleView : NSObject

{
    NSDictionary *dictionary;
}

-(NSDictionary*)getListOfPatientWithRTID:(NSString*)ID;

-(NSDictionary*)getListingsOfPatient:(NSString*)patientID;

-(NSDictionary*)updateNewRecordWithId:(NSString*)ID
                                 date:(NSString*)date
                                 hour:(NSString*)hour
                                  min:(NSString*)min
                             timeType:(NSString*)timeType
                                 type:(NSString*)type
                                notes:(NSString*)notes;

@end
