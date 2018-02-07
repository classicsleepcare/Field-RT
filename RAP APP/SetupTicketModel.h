//
//  SetupTicketModel.h
//  RT APP
//
//  Created by Anil Prasad on 24/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetupTicketModel : NSObject

@property (strong, nonatomic) NSArray *arr_listing;
@property (strong, nonatomic) NSArray *arr_rt_item_listing;

@property (strong, nonatomic) NSString *ticket_id;
@property (strong, nonatomic) NSString *ticket_status;
@property (strong, nonatomic) NSString *rt_id;
@property (strong, nonatomic) NSString *pt_id;
@property (strong, nonatomic) NSString *pt_first;
@property (strong, nonatomic) NSString *pt_last;
@property (strong, nonatomic) NSString *pt_gender;
@property (nonatomic) BOOL pt_spanish;
@property (strong, nonatomic) NSString *pt_add;
@property (strong, nonatomic) NSString *pt_city;
@property (strong, nonatomic) NSString *pt_state;
@property (strong, nonatomic) NSString *pt_zip;
@property (strong, nonatomic) NSString *pt_home;
@property (strong, nonatomic) NSString *pt_cell;
@property (strong, nonatomic) NSString *pt_work;
@property (strong, nonatomic) NSString *pt_email;
@property (strong, nonatomic) NSString *cpap_machine;
@property (nonatomic) BOOL cpap;
@property (strong, nonatomic) NSString *bi_level;
@property (strong, nonatomic) NSString *cpap_manufacturer;
@property (strong, nonatomic) NSString *cpap_model;
@property (strong, nonatomic) NSString *cpap_serial;
@property (strong, nonatomic) NSString *cpap_cm;
@property (strong, nonatomic) NSString *cpap_ramp_time;
@property (strong, nonatomic) NSString *cpap_backup_rate;
@property (strong, nonatomic) NSString *modem;
@property (strong, nonatomic) NSString *modem_type;
@property (strong, nonatomic) NSString *modem_serial;
@property (strong, nonatomic) NSString *hum_modem;
@property (strong, nonatomic) NSString *hum_manufacturer;
@property (strong, nonatomic) NSString *hum_serial;
@property (strong, nonatomic) NSString *mask;
@property (strong, nonatomic) NSString *mask_type;
@property (strong, nonatomic) NSString *mask_name;
@property (strong, nonatomic) NSString *mask_id;
@property (strong, nonatomic) NSString *initials1;
@property (strong, nonatomic) NSString *initials2;
@property (strong, nonatomic) NSString *initials3;
@property (strong, nonatomic) NSString *signature;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *first_name;
@property (strong, nonatomic) NSString *last_name;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *zip;
@property (strong, nonatomic) NSString *home_phone;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *care_first;
@property (strong, nonatomic) NSString *care_last;
@property (strong, nonatomic) NSString *care_address;
@property (strong, nonatomic) NSString *care_city;
@property (strong, nonatomic) NSString *care_state;
@property (strong, nonatomic) NSString *care_zip;
@property (strong, nonatomic) NSString *care_phone;
@property (strong, nonatomic) NSString *care_email;
@property (strong, nonatomic) NSString *Pt_State;
@property (strong, nonatomic) NSString *Dr_First;
@property (strong, nonatomic) NSString *Dr_Last;
@property (strong, nonatomic) NSString *fac_name;

-(id)initWithDictionary:(NSDictionary*)dict;

@end
