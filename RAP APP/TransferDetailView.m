//
//  TransferDetailView.m
//  RT APP
//
//  Created by Anil Prasad on 21/02/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "TransferDetailView.h"

@implementation TransferDetailView


-(NSDictionary*)getTransferDetailsOfRT:(NSString*)rtId transferID:(NSString*)ID
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

-(NSDictionary*)receiveTransfersOfRT:(NSString*)rtId transfer_id:(NSString*)transfer_id from_id:(NSString*)fromId json_request:(NSString*)json{
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

@end
