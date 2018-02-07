//
//  ScheduleModel.h
//  RAP APP
//
//  Created by Anil Prasad on 5/3/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduleModel : NSObject
@property(nonatomic,strong) NSArray *arr_Listing,
                                    *arr_scedule;
@property(nonatomic,strong) NSString *str_msg;

-(id)initWithDictionary:(NSDictionary *)dict;
@end
