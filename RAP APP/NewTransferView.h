//
//  NewTransferView.h
//  RT APP
//
//  Created by Anil Prasad on 21/02/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewTransferView : NSObject{
    NSDictionary *dictionary;
}

-(NSDictionary*)submitTransferOfRT:(NSString*)rtId to_id:(NSString*)to_id transfer_date:(NSString*)date json_request:(NSString*)json;

-(NSDictionary*)getItemsOfRT:(NSString*)rtId;

-(NSDictionary*)getAcknowledgeItemsList:(NSString*)rtId;

-(NSDictionary*)markAcknowledgedForRT:(NSString*)rtId forTransfer:(NSString*)transferId acknowledged:(NSString*)acknowledged;

@end
