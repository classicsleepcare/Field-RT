//
//  NewTransferView.m
//  RT APP
//
//  Created by Anil Prasad on 21/02/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import "NewTransferView.h"

@implementation NewTransferView

-(NSDictionary*)submitTransferOfRT:(NSString*)rtId to_id:(NSString*)to_id transfer_date:(NSString*)date json_request:(NSString*)json{
    dictionary = nil;
    
    NSString *urlString = [NSString stringWithFormat:url_rtNewTransfer, rtId, to_id, date, json];
    
    
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

-(NSDictionary*)getItemsOfRT:(NSString*)rtId{
    dictionary = nil;
    
    NSString *urlString = [NSString stringWithFormat:url_rtNewTransferItems, rtId];
    
    
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

-(NSDictionary*)getAcknowledgeItemsList:(NSString*)rtId{
    dictionary = nil;
    
    NSString *urlString = [NSString stringWithFormat:url_rtSendReceiveTransferList, rtId];
    
    
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

-(NSDictionary*)markAcknowledgedForRT:(NSString*)rtId forTransfer:(NSString*)transferId acknowledged:(NSString*)acknowledged{
    dictionary = nil;
    
    NSString *urlString = [NSString stringWithFormat:url_rtAcknowledge, rtId, transferId, acknowledged];
    
    
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
