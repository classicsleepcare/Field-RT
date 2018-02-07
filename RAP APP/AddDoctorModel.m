//
//  AddDoctorModel.m
//  RAP APP
//
//  Created by Anil Prasad on 5/1/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "AddDoctorModel.h"

@implementation AddDoctorModel

+(AddDoctorModel *)allFacilitiesFromDictionary:(NSDictionary *)dict
{
    AddDoctorModel *object = [[self alloc]init];
    object.arr_Facilities = dict[@"listing"];
    return object;
    
}
+(AddDoctorModel *)allDoctorsFromDictionary:(NSDictionary *)dict
{
    AddDoctorModel *object = [[self alloc]init];
    object.arr_Doctors = dict[@"listing"];
    return object;
}
+(AddDoctorModel *)facilitieDetailFromDictionary:(NSDictionary *)dict
{
    AddDoctorModel *object = [[self alloc]init];
    object.arr_facilityDetail = dict[@"fac_row"];
    return object;
}
+(AddDoctorModel*)doctorsDetailFromDictionary:(NSDictionary*)dict
{
    AddDoctorModel *object = [[self alloc]init];
    object.arr_doctorDetail = dict[@"dr_row"];
    return object;
}
+(AddDoctorModel *)addingDoctorResponseFromDictionary:(NSDictionary *)dict
{
    AddDoctorModel *object = [[self alloc]init];
    object.msg = dict[@"response"];
    return object;

}
+(AddDoctorModel *)addingFacilityResponseFromDictionary:(NSDictionary *)dict
{
    AddDoctorModel *object = [[self alloc]init];
    object.msg = dict[@"response"];
    return object;
}
+(AddDoctorModel *)addingDoctorAndFacilityResponseFromDictionary:(NSDictionary *)dict
{
    AddDoctorModel *object = [[self alloc]init];
    object.msg = dict[@"response"];
    return object;
}
-(id)initWithDictionary:(NSDictionary *)dict
{
    self= [super init];
   _msg = dict[@"response"];
   
    return self;
}
@end
