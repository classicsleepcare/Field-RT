//
//  HistoryView.m
//  RAP APP
//
//  Created by Anil Prasad on 4/20/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "HistoryView.h"

@implementation HistoryView


-(NSDictionary *)getHistoryListForId:(NSString*)ID FromDate:(NSString*)date
{
    
    dictionary=nil;
    NSString *urlString = [NSString stringWithFormat:url_setupAndReferral,ID,date];
    NSLog(@"nsstring is %@",urlString);
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
-(NSDictionary *)getDetailListForPatientOfId:(NSString *)ID
{
    
    dictionary=nil;
    NSString *urlString = [NSString stringWithFormat:url_patientDetail,ID];
    

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

-(NSDictionary *)getAllHistroyItemsOfId:(NSString *)ID
{
    
    dictionary=nil;
    NSString *urlString = [NSString stringWithFormat:url_showHistory,ID];
    
    NSLog(@"urlString is %@",urlString);

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
