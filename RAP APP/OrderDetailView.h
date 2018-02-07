//
//  OrderDetailView.h
//  RT APP
//
//  Created by Anil Prasad on 21/02/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailView : NSObject{
    NSDictionary *dictionary;
}

-(NSDictionary*)getOrderDetailsOfRT:(NSString*)rtId orderID:(NSString*)ID;

-(NSDictionary*)receiveOrderOfRT:(NSString*)rtId transfer_id:(NSString*)transfer_id from_id:(NSString*)fromId json_request:(NSString*)json;

-(NSDictionary*)getTransferDetailsOfRT:(NSString*)rtId orderID:(NSString*)ID;

-(NSDictionary*)receiveOrderRT_ID:(NSString*)rtId transfer_id:(NSString*)transfer_id order_id:(NSString*)order_id from_id:(NSString*)fromId json_request:(NSString*)json;

@end
