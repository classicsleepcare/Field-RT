//
//  InventoryView.m
//  RT APP
//
//  Created by Anil Prasad on 23/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "InventoryView.h"

@implementation InventoryView

-(NSDictionary*)getListOfInventoryWithID:(NSString*)ID page:(NSString*)page limit:(NSString*)limit{
 
    dictionary = nil;
    NSString *urlString = [NSString stringWithFormat:url_inventory,ID, page, limit];
    
    
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


-(NSDictionary*)getTicketNumOfItem:(NSString*)ID withSerial:(NSString*)num{
    dictionary = nil;
    NSString *urlString = [NSString stringWithFormat:url_viewTicket,ID,num];
    
    
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
