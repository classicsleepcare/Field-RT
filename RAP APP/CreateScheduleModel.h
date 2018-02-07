//
//  CreateScheduleModel.h
//  RT APP
//
//  Created by Anil Prasad on 24/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreateScheduleModel : NSObject

@property (strong, nonatomic) NSArray *arr_listing;
@property (strong, nonatomic) NSArray *arr_patientListing;

@property (strong, nonatomic) NSString *msg;

-(id)initWithDictionary:(NSDictionary*)dict;

@end
