//
//  SetupTicketView.m
//  RT APP
//
//  Created by Anil Prasad on 24/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "SetupTicketView.h"

@implementation SetupTicketView

-(NSDictionary*)getListOfSetupTicketWithID:(NSString*)ID andOption:(NSString*)option{
    dictionary = nil;
    
    NSString *urlString = [NSString stringWithFormat:url_setupTicketListing,ID, option];
    
    
    [WebserviceClass getParseDataFromUrl:urlString :^(id result, NSError *error)
     {
         if (error) {
             dictionary = nil;
         }
         else
         {
             dictionary = result;
         }
     }];
    
    return dictionary;
}



@end
