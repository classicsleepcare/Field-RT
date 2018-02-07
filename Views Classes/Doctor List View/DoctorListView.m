//
//  DoctorListView.m
//  RAP APP
//
//  Created by Anil Prasad on 4/12/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "DoctorListView.h"

@implementation DoctorListView


-(NSDictionary *)getDoctorListForId:(NSString *)ID
{
    dictionary=nil;
    NSString *urlString = [NSString stringWithFormat:url_refferingDoctor,ID];
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
