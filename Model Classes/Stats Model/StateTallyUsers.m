//
//  StateTallyUsers.m
//  RAP APP
//
//  Created by Anil Prasad on 6/12/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "StateTallyUsers.h"

@implementation StateTallyUsers

+(StateTallyUsers*)getAnnualTallyUserInfoFromDict:(NSDictionary*)dict
{
    StateTallyUsers *object = [[self alloc]init];
    
    object.arr_Approved = dict[@"App_Date"];
    object.arr_Denied = dict[@"Den_Date"];
    object.arr_Referral = dict[@"Ref_Date"];
    object.arr_Setup = dict[@"SU_Date"];
    object.arr_NSUO = dict[@"NSU_Date_O"];
    object.arr_NSUU = dict[@"NSU_Date_U"];
    
    
    return object;
}
+(StateTallyUsers *)getMonthlyTallyUserInfoFromDict:(NSDictionary *)dict
{
    
    StateTallyUsers *object = [[self alloc]init];
    
    object.arr_Approved = dict[@"App_Date"];
    object.arr_Denied = dict[@"Den_Date"];
    object.arr_Referral = dict[@"Ref_Date"];
    object.arr_Setup = dict[@"SU_Date"];
    
    return object;
}
@end
