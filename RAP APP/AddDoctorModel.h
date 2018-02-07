//
//  AddDoctorModel.h
//  RAP APP
//
//  Created by Anil Prasad on 5/1/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddDoctorModel : NSObject

{
    
}

@property(nonatomic,strong)  NSString *msg;
@property(nonatomic,strong) NSArray *arr_Facilities,*arr_Doctors ,*arr_facilityDetail, *arr_doctorDetail;

+(AddDoctorModel*)allFacilitiesFromDictionary:(NSDictionary*)dict;
+(AddDoctorModel*)allDoctorsFromDictionary:(NSDictionary*)dict;
+(AddDoctorModel*)facilitieDetailFromDictionary:(NSDictionary*)dict;
+(AddDoctorModel*)doctorsDetailFromDictionary:(NSDictionary*)dict;

+(AddDoctorModel*)addingDoctorResponseFromDictionary:(NSDictionary*)dict;
+(AddDoctorModel*)addingFacilityResponseFromDictionary:(NSDictionary*)dict;
+(AddDoctorModel*)addingDoctorAndFacilityResponseFromDictionary:(NSDictionary*)dict;

-(id)initWithDictionary:(NSDictionary*)dict;
@end
