//
//  NIVTIcketModel.h
//  RT APP
//
//  Created by Anil Prasad on 12/5/17.
//  Copyright © 2017 ankit gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NIVTIcketModel : NSObject
@property (strong, nonatomic) NSString *msg, *error;

@property (strong, nonatomic) NSArray *arr_rt_vendor_listing;
@property (strong, nonatomic) NSArray *arr_rt_machines_listing;
@property (strong, nonatomic) NSArray *arr_rt_heater_listing;
@property (strong, nonatomic) NSArray *arr_rt_modem_listing;
@property (strong, nonatomic) NSArray *arr_rt_supply_listing;
@property (strong, nonatomic) NSArray *arr_rt_mask_listing;
@property (strong, nonatomic) NSArray *arr_rt_serial_numbers;

-(id)initWithDictionary:(NSDictionary*)dict;

@end
