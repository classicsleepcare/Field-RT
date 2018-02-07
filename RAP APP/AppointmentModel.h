//
//  AppointmentModel.h
//  RT APP
//
//  Created by Anil Prasad on 6/18/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppointmentModel : NSObject

@property (strong, nonatomic) NSString *msg;
@property (strong, nonatomic) NSDictionary *dict_rt_appointment_details;
@property (strong, nonatomic) NSArray *arr_rt_listing;
@property (strong, nonatomic) NSDictionary *dict_rt_listing_details;

-(id)initWithDictionary:(NSDictionary*)dict;

@end
