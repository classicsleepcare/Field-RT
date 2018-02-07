//
//  StatsView.h
//  RAP APP
//
//  Created by Anil Prasad on 5/1/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatsView : NSObject


-(NSDictionary *)getStatsListForSourceAndCatagory;
-(NSDictionary *)getStatsInformationForID:(NSString*)ID Month:(NSString*)month Year:(NSString*)year;
-(NSDictionary *)getStatsYearInformationForID:(NSString*)ID Year:(NSString*)year;

-(NSDictionary*)getAnnualTallyUserForID:(NSString*)ID Year:(NSString*)year andMonth:(NSString*)month isTotalTally:(BOOL)isTotal;
-(NSDictionary*)getMonthTallyUserForID:(NSString*)ID Year:(NSString*)year Month:(NSString*)month andDay:(NSString*)day;
-(NSDictionary*)getAnnualTallyTotalUserForID:(NSString*)ID Year:(NSString*)year;
@end
