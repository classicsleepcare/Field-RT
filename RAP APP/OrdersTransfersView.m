//
//  OrdersTransfersView.m
//  RT APP
//
//  Created by Anil Prasad on 11/02/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "OrdersTransfersView.h"

@implementation OrdersTransfersView

-(NSDictionary*)getTransferListings:(NSString*)ID
{
    dictionary = nil;
    
    NSString *urlString = [NSString stringWithFormat:url_rtTransferListings, ID];
    
    
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

-(NSDictionary*)getOrderListings:(NSString*)ID
{
    dictionary = nil;
    
    NSString *urlString = [NSString stringWithFormat:url_rtOrderListings, ID];
    
    
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
