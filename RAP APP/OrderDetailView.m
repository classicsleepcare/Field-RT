//
//  OrderDetailView.m
//  RT APP
//
//  Created by Anil Prasad on 21/02/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "OrderDetailView.h"

@implementation OrderDetailView

-(NSDictionary*)getOrderDetailsOfRT:(NSString*)rtId orderID:(NSString*)ID
{
    dictionary = nil;
    
    NSString *urlString = [NSString stringWithFormat:url_rtOrderDetails, rtId, ID];
    
    
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

-(NSDictionary*)getTransferDetailsOfRT:(NSString*)rtId orderID:(NSString*)ID
{
    dictionary = nil;
    
    NSString *urlString = [NSString stringWithFormat:url_rtTransferDetails, rtId, ID];
    
    
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

-(NSDictionary*)receiveOrderOfRT:(NSString*)rtId transfer_id:(NSString*)transfer_id from_id:(NSString*)fromId json_request:(NSString*)json{
    dictionary = nil;
    
    NSString *urlString = [NSString stringWithFormat:url_rtReceiveOrder, rtId, transfer_id, fromId, json];
    
    
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

-(NSDictionary*)receiveOrderRT_ID:(NSString*)rtId transfer_id:(NSString*)transfer_id order_id:(NSString*)order_id from_id:(NSString*)fromId json_request:(NSString*)json{
    dictionary = nil;
    
    NSMutableString *urlString = [[NSMutableString alloc] init];
    NSString *url = [NSString stringWithFormat:url_rtReceiveItems, rtId, transfer_id, order_id, fromId, json];
    [urlString appendString:url];
    //[urlString appendString:[NSString stringWithFormat:@"&testing_emails=%@", @"0"]];
    
    
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
