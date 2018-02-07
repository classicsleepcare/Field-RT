//
//  PatientList.h
//  RAP APP
//
//  Created by Anil Prasad on 4/14/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PatientList : NSObject
@property(nonatomic,strong) NSArray *arr_main;
@property(nonatomic,strong)NSMutableArray* Pt_ID,
*arr_Pt_First,
*arr_Pt_Last,
*arr_doctor,
*arr_ref_sorc,
*arr_Pt_City,
*arr_Pri_Ins,
*arr_Sec_Ins,
*arr_pt_machine,
*arr_pt_mask,
*arr_Bill_Cond,
*arr_Ref_Date,
*arr_status,
*arr_Stat_Date,
*arr_SU_Date,
*arr_Ship_Rep_Name,
*arr_SU_Tally_Date;

@property(nonatomic,strong) NSArray *arr_drList;
@property(nonatomic,strong) NSArray *arr_statusList;
@property(nonatomic,strong) NSArray *arr_PrimaryList;
@property(nonatomic,strong) NSArray *arr_drFacility;

-(id)initWithDictionary:(NSDictionary*)dict;
-(id)initDetailListWithDictionary:(NSDictionary *)dict;
//-(NSArray*)sortedDictionariesFromArray:(NSArray*)array;

@end
