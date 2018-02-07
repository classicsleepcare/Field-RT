//
//  StateTallyUsers.h
//  RAP APP
//
//  Created by Anil Prasad on 6/12/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StateTallyUsers : NSObject

@property(nonatomic,strong)NSArray *arr_Referral, *arr_Approved, *arr_Denied, *arr_Setup ,*arr_NSUU, *arr_NSUO;

+(StateTallyUsers*)getAnnualTallyUserInfoFromDict:(NSDictionary*)dict;
+(StateTallyUsers*)getMonthlyTallyUserInfoFromDict:(NSDictionary*)dict;

@end
