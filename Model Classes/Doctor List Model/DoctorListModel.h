//
//  DoctorListModel.h
//  RAP APP
//
//  Created by Anil Prasad on 4/12/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoctorListModel : NSObject
@property(nonatomic,strong) NSArray *arr_main;
@property(nonatomic,strong)NSMutableArray* arr_Dr_Last,
                                                    *arr_Dr_First,
                                                    *arr_Dr_Phone,
                                                    *arr_Dr_Address,
                                                    *arr_Dr_City,
                                                    *arr_Dr_State,
                                                    *arr_Dr_Zip,
                                                    *arr_Dr_NP,
                                                    *arr_Dr_Nuance,
                                                    *arr_fac_full_name,
                                                    *arr_fac_phone,
                                                    *arr_Ref_Date,
                                                    *arr_Conf_Fax;

-(id)initWithDictionary:(NSDictionary*)dict;
-(NSArray*)sortedDictionariesFromArray:(NSArray*)array;

@end
