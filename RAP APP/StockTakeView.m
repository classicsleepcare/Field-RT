//
//  StockTakeView.m
//  RT APP
//
//  Created by Anil Prasad on 24/09/15.
//  Copyright © 2015 Anil Prasad. All rights reserved.
//

#import "StockTakeView.h"

@implementation StockTakeView

-(NSDictionary*)submitInventoryOfRT:(NSString*)rtId machinesJson:(NSString*)machine hum_modemJson:(NSString*)hum modemJson:(NSString*)modem maskJson:(NSString*)mask{
    dictionary = nil;
    
    NSString *urlString = [NSString stringWithFormat:url_submitStockTake, rtId, machine, hum, modem, mask];
    
    
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
