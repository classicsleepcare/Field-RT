//
//  StatsView.m
//  RAP APP
//
//  Created by Anil Prasad on 5/1/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "StatsView.h"

@implementation StatsView
{
    NSDictionary* dictionary;
}


-(NSDictionary *)getStatsListForSourceAndCatagory
{
    dictionary=nil;
    NSString *urlString = [NSString stringWithFormat:url_sourceAndcatagory];
    [WebserviceClass getParseDataFromUrl:urlString :^(id result, NSError *error)
     {
         if (error) {
             dictionary =nil;
         }
         else
         {
             dictionary= result;
         }
     }];
    return dictionary;
}

-(NSDictionary *)getStatsInformationForID:(NSString*)ID Month:(NSString*)month Year:(NSString*)year
{
    dictionary=nil;
    NSString *urlString = [NSString stringWithFormat:url_statMonth,month,year,ID];
    [WebserviceClass getParseDataFromUrl:urlString :^(id result, NSError *error)
     {
         if (error) {
             dictionary =nil;
         }
         else
         {
             dictionary= result;
         }
     }];
    return dictionary;
}

-(NSDictionary *)getStatsYearInformationForID:(NSString*)ID Year:(NSString*)year
{
    dictionary=nil;
    NSString *urlString = [NSString stringWithFormat:url_statYear,year,ID];
    NSLog(@"url is %@",urlString);
    [WebserviceClass getParseDataFromUrl:urlString :^(id result, NSError *error)
     {
         if (error) {
             dictionary =nil;
         }
         else
         {
             dictionary= result;
         }
     }];
    return dictionary;
}

-(NSDictionary*)getAnnualTallyUserForID:(NSString*)ID Year:(NSString*)year andMonth:(NSString*)month isTotalTally:(BOOL)isTotal
{
    dictionary=nil;
    NSString *urlString ;
    if(isTotal) urlString = [NSString stringWithFormat:url_Monthally_total,month,year,ID];
  
    
    else urlString = [NSString stringWithFormat:url_annualTallyUsers,month,year,ID];
    
    [WebserviceClass getParseDataFromUrl:urlString :^(id result, NSError *error)
     {
         if (error) {
             dictionary =nil;
         }
         else
         {
             dictionary= result;
         }
     }];
    return dictionary;
}
-(NSDictionary*)getMonthTallyUserForID:(NSString*)ID Year:(NSString*)year Month:(NSString*)month andDay:(NSString*)day
{
    dictionary=nil;
    NSString *urlString = [NSString stringWithFormat:url_monthlyTallyUsers,day,month,year,ID];
    [WebserviceClass getParseDataFromUrl:urlString :^(id result, NSError *error)
     {
         if (error) {
             dictionary =nil;
         }
         else
         {
             dictionary= result;
         }
     }];
    return dictionary;
}
-(NSDictionary*)getAnnualTallyTotalUserForID:(NSString*)ID Year:(NSString*)year
{
    dictionary=nil;
    NSString *urlString = [NSString stringWithFormat:url_Annual_total,year,ID];
    [WebserviceClass getParseDataFromUrl:urlString :^(id result, NSError *error)
     {
         if (error) {
             dictionary =nil;
         }
         else
         {
             dictionary= result;
         }
     }];
    return dictionary;
}

@end
